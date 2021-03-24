//
//  DDBaseApiBreakPointManager.m
//  DDNetwork
//
//  Created by Syed Qamar Abbas on 26/04/2020.
//

#import "DDBaseApiBreakPointManager.h"
#import "DDCommons/DDCommons.h"
#import "DDCAppConfigManager.h"
#import "DDEditConfig.h"
#import "DDNetworkManager.h"

@interface DDBaseApiBreakPointManager ()<NSURLSessionDelegate>
@property (strong, nonatomic) NSURLSessionDataTask *task;
@end

@implementation DDBaseApiBreakPointManager
-(void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:DD_EDIT_BREAK_POINT_REQUEST_COMPLETION object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:DD_EDIT_BREAK_POINT_RESPONSE_COMPLETION object:nil];
}
-(void)returnResponseToUI:(NSData * _Nullable)data andResponse:(NSURLResponse * _Nullable)response andError:(NSError * _Nullable)error {
    
}
-(void)didRecieveResponse:(NSData * _Nullable)data andResponse:(NSURLResponse * _Nullable)response andError:(NSError * _Nullable)error {
    __weak typeof(self) weakSelf = self;
    if (weakSelf.showHUD) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideProgressHUD];
        });
    }
    if (DDCAppConfigManager.shared.isEditConfigAllowed && [DDEditConfigBreakPointM isResponseBreakPointEnabledForApi:weakSelf.identifier] && data != nil) {
        weakSelf.response = response;
        NSData *responseData = data;
        if (weakSelf.isEncrypted) {
            if (weakSelf.e_iv.length > 0 && weakSelf.e_key.length > 0) {
                DDEncryptionManager.shared.key = weakSelf.e_key;
                DDEncryptionManager.shared.iv = weakSelf.e_iv;
            }
            responseData = [DDEncryptionManager.shared decryptData:responseData];
            if (responseData == nil) {
                responseData = data;
            }
        }
        [NSNotificationCenter.defaultCenter addObserver:weakSelf selector:@selector(didCompleteReesponseChange:) name:DD_EDIT_BREAK_POINT_RESPONSE_COMPLETION object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            DDNetworkManager.shared.editApiBreakPoint(responseData, NO);
        });
    }else {
        [weakSelf returnResponseToUI:data andResponse:response andError:error];
    }
}
-(void)didCompleteReesponseChange:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    id data = [dict bv_jsonDataWithPrettyPrint:YES];
    if ([data isKindOfClass:NSData.class]) {
        [self returnResponseToUI:data andResponse:self.response andError:nil];
    }
}
-(void)printApiLogsWith:(NSData*)data error:(NSError*)error {
    [DDLogs log:@"------------------------------------------"];
    [DDLogs log:@"URL: %@", self.base_url];
    [DDLogs log:@"END POINT: %@", self.api_end_point];
    NSDictionary *dict = self.params;
    if (self.non_encrypted_param.count > 0) {
        dict = self.non_encrypted_param;
        //[DDLogs log:@"Encrypted REQUEST PARAMS: %@", [self.params bv_jsonStringWithPrettyPrint:YES]];
    }
    [DDLogs log:@"REQUEST PARAMS: %@", [dict bv_jsonStringWithPrettyPrint:YES]];
    NSString *response = [data stringValue];
    [DDLogs log:@"RESPONSE: %@", response];
    
}
-(void)addRequestChangeObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didCompleteRequestChange:) name:DD_EDIT_BREAK_POINT_REQUEST_COMPLETION object:nil];
}
-(void)didCompleteRequestChange:(NSNotification *)notification {
    self.params = notification.userInfo.mutableCopy;
    [self loadWithRequest:[self createRequestWithForceSendNetworkCall:YES]];
}
-(NSMutableURLRequest *)createRequestWithForceSendNetworkCall:(BOOL)forceSend {
    return nil;
}
-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {

    // Get remote certificate
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, 0);

    // Set SSL policies for domain name check
    NSMutableArray *policies = [NSMutableArray array];
    [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)challenge.protectionSpace.host)];
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);

    // Evaluate server certificate
    SecTrustResultType result;
    SecTrustEvaluate(serverTrust, &result);
    BOOL certificateIsValid = (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);

    // Get local and remote cert data
    NSData *remoteCertificateData = CFBridgingRelease(SecCertificateCopyData(certificate));
    NSString *pathToCert = [[NSBundle mainBundle]pathForResource:DDCAppConfigManager.shared.SSL_CERTIFICATE_NAME ofType:DDCAppConfigManager.shared.SSL_CERTIFICATE_EXTENSION];
    NSData *localCertificate = [NSData dataWithContentsOfFile:pathToCert];

    // The pinnning check
    if ([remoteCertificateData isEqualToData:localCertificate] && certificateIsValid) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, NULL);
    }
}
-(void)loadWithRequest:(NSMutableURLRequest *)request {
    __weak typeof(self) weakSelf = self;
    if (request != nil) {
        if (weakSelf.showHUD) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showProgressHUD];
            });
        }
        if (weakSelf.isSSLPinningEnabled) {
            [weakSelf loadRequestWithSSLPinning:request];
        }else {
            [weakSelf loadRequestWithoutSSLPinning:request];
        }
    }
}
-(void)loadRequestWithSSLPinning:(NSMutableURLRequest *)request {
    __weak typeof(self) weakSelf = self;
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    __block NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    self.task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf didRecieveResponse:data andResponse:response andError:error];
    }];
    [self.task resume];
}
-(void)streamRequestWithoutSSLPinning:(NSMutableURLRequest *)request {
    __weak typeof(self) weakSelf = self;
    NSData *formData = request.HTTPBody;
    [[NSURLSession.sharedSession uploadTaskWithRequest:request fromData:formData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf didRecieveResponse:data andResponse:response andError:error];
    }] resume];
}
-(void)loadRequestWithoutSSLPinning:(NSMutableURLRequest *)request {
    __weak typeof(self) weakSelf = self;
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf.task cancel];
        weakSelf.task = nil;
        if (weakSelf.response == nil) {
            [weakSelf didRecieveResponse:data andResponse:response andError:error];
        }
    }] resume];
}
-(void)showProgressHUD {
    [UIApplication showDDLoaderAnimation];
}
-(void)hideProgressHUD {
    [UIApplication dismissDDLoaderAnimation];
}
@end
