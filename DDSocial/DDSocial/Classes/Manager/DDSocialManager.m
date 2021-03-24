//
//  DDLocationsManager.m
//  DDLocation
//
//  Created by Zubair Ahmad on 04/02/2020.
//  Copyright © 2020 The Entertainer. All rights reserved.
//

#import "DDSocialManager.h"

#import <MessageUI/MessageUI.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface DDSocialManager() <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, FBSDKSharingDelegate>
@property (nonatomic, copy) StatusCompletionCallBack callback;
@end

@implementation DDSocialManager

static DDSocialManager *_sharedObject;

+(DDSocialManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDSocialManager alloc]init];
    });
    return _sharedObject;
}


-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onPlatfrom:(DDSocialPlatform*)platform withCompletionCallback:(StatusCompletionCallBack)callback {

    #warning -- Analytics => trackisNewScreenWithoutFB, trackNewBranchIOEvent, googleTagManagerPushDatawithScreenName

    switch (platform.type) {
        case DDSocialPlatformTypeEmail:
            [DDSocialManager.shared shareContent:content from:controller onEmailWithCallback:callback];
            break;
            
        case DDSocialPlatformTypeSMS:
            [DDSocialManager.shared shareContent:content from:controller onSMSWithCallback:callback];
            break;
            
        case DDSocialPlatformTypeFacebook:
            [DDSocialManager.shared shareContent:content from:controller onFacebookWithCallback:callback];
            break;
            
        case DDSocialPlatformTypeWhatsApp:
            [DDSocialManager.shared shareContent:content from:controller onWhatsAppWithCallback:callback];
            break;
            
        case DDSocialPlatformTypeMessenger:
            [DDSocialManager.shared shareContent:content from:controller onMessangerWithCallback:callback];
            break;
            
        default:
            [DDSocialManager.shared shareContent:content from:controller onNativeShareSheet:callback];
            break;
    }
}

-(void)sendCallBackStatus:(BOOL)status andText:(NSString* _Nullable)text {
    if (self.callback != nil) {
        self.callback(status, text);
        self.callback = nil;
    }
}

#pragma mark --------- NAtive Control ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onNativeShareSheet:(StatusCompletionCallBack)callback {

    NSMutableArray *items = [NSMutableArray new];
    
    if (content.text.length) [items addObject:content.text];
    if (content.sub_text.length) [items addObject:content.sub_text];
    if (content.url.length) [items addObject:content.url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    //activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToVimeo, UIActivityTypePostToFlickr, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard]; //or whichever you don't need
    [controller presentViewController:activityVC animated:YES completion:nil];
    
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        callback(completed, activityError.localizedDescription);
    };
}


#pragma mark --------- EMAIL ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onEmailWithCallback:(StatusCompletionCallBack)callback {
    // Analytics => trackisNewScreenWithoutFB
    self.callback = callback;
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
        composer.mailComposeDelegate = self;
        NSString *textMessage = [NSString stringWithFormat:@"%@ %@",content.text, content.url];
        [composer setMessageBody:textMessage isHTML:NO];
        composer.modalPresentationStyle = UIModalPresentationFullScreen;
        [controller presentViewController:composer animated:YES completion:nil];
        // Analytics => trackNewBranchIOEvent
    } else {
        [self sendCallBackStatus:NO andText:@"There are no Email account setup on this device. Go to Settings to add one."];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    BOOL sent = result == MFMailComposeResultSent;
    if(sent) {
        // Analytics => googleTagManagerPushDatawithScreenName
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    [self sendCallBackStatus:sent andText:error.localizedDescription];
}


#pragma mark --------- SMS ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onSMSWithCallback:(StatusCompletionCallBack)callback {
    // Analytics => trackisNewScreenWithoutFB
    if([MFMessageComposeViewController canSendText]) {
        self.callback = callback;
        MFMessageComposeViewController *composer = [[MFMessageComposeViewController alloc] init];
        composer.messageComposeDelegate = self;
        NSString *textMessage = [NSString stringWithFormat:@"%@ %@",content.text,content.url];
        [composer setBody:textMessage];
        [controller presentViewController:composer animated:YES completion:nil];
        // Analytics => trackNewBranchIOEvent
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    BOOL sent = result == MFMailComposeResultSent;
    if(sent) {
        // Analytics => googleTagManagerPushDatawithScreenName
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
    [self sendCallBackStatus:sent andText:nil];
}

#pragma mark --------- Facebook ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onFacebookWithCallback:(StatusCompletionCallBack)callback {
    // Analytics => trackisNewScreenWithoutFB
    self.callback = callback;
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
    FBSDKShareLinkContent *fbContent = [[FBSDKShareLinkContent alloc] init];
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
        shareDialog.mode =  FBSDKShareDialogModeNative;
    }
    else {
        shareDialog.mode =  FBSDKShareDialogModeAutomatic;
    }
    fbContent.contentURL = content.url.URLValue;
    shareDialog.shareContent = fbContent;
    shareDialog.delegate = self;
    [shareDialog show];
}

-(void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    // Analytics => googleTagManagerPushDatawithScreenName
    [self sendCallBackStatus:(results.allKeys.count > 0) andText:nil];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    [self sendCallBackStatus:NO andText:error.localizedDescription];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    [self sendCallBackStatus:NO andText:nil];
}


#pragma mark --------- WhatsApp ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onWhatsAppWithCallback:(StatusCompletionCallBack)callback {
    self.callback = callback;
    
    NSString *textMessage = @"";
    if (content.url && content.url.length){
        textMessage = content.url;
    }
    NSString *urlContent = @"";
    if ([textMessage containsString:@"?"]) {
        urlContent = [textMessage componentsSeparatedByString:@"?"][1];
        urlContent = [urlContent urlencoding];
        urlContent = [NSString stringWithFormat:@"%@?%@",[textMessage componentsSeparatedByString:@"?"][0],urlContent];
    }else {
        urlContent = textMessage;
    }
    
    textMessage = [NSString stringWithFormat:@"%@",urlContent];
    textMessage = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",content.text]],urlContent];
    

    NSString * deeplink = [NSString stringWithFormat:@"whatsapp://send?text=%@",textMessage];
    NSURL *deeplinkURL = [NSURL URLWithString:[deeplink stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    if ([UIApplication.sharedApplication canOpenURL:deeplinkURL]) {
        [UIApplication.sharedApplication openURL:deeplinkURL options:@{} completionHandler:nil];
        [self sendCallBackStatus:YES andText:nil];
    }
    else {
        [self sendCallBackStatus:NO andText:@"WhatsApp is not currently installed on this device."];
    }
}


#pragma mark --------- Messanger ---------

-(void)shareContent:(DDSocialShareContent*)content from:(UIViewController*)controller onMessangerWithCallback:(StatusCompletionCallBack)callback {
    self.callback = callback;
    FBSDKShareLinkContent *fbContent = [[FBSDKShareLinkContent alloc] init];
    fbContent.contentURL = content.url.URLValue;
    FBSDKMessageDialog *messageDialog = [[FBSDKMessageDialog alloc] init];
    messageDialog.delegate = self;
    [messageDialog setShareContent:fbContent];
    if ([messageDialog canShow]) {
        [messageDialog show];
    } else {
        [self sendCallBackStatus:NO andText:@"Messenger is not currently installed on this device."];
    }
}




#pragma mark - Others

-(NSString *) getShareText:(DDShareType) shareType text:(NSString *) text merchantNameInCasePostRedemption:(NSString *)merchantName{
    switch (shareType) {
        case DDShareSavings: {
            return [NSString stringWithFormat:@"Awesome! %@ saved so far with the #EntertainerApp!".localized,text];
            break;
        }
        case DDSharePostRedemptionSavings: {
            return [NSString stringWithFormat:@"2-4-1 awesomeness and %@ saved at %@! #EntertainerApp".localized,text,merchantName];
            break;
        }
        case DDShareBadge: {
            return @"Check out my new badge! #SaveMore and #LiveMore with the #EntertainerApp".localized;//[NSString stringWithFormat:,text];
            break;
        }
        case DDShareLevel: {
            return [NSString stringWithFormat:@"Boom, %@ just earned!  #EntertainerApp".localized,text];
            break;
        }
        case DDShareInviteOutlet: {
            return [NSString stringWithFormat:@"Fancy going to %@ today?".localized,text];
            break;
        }
        case DDShareRedemptionSaving: {
            return [NSString stringWithFormat:@"I've saved approx. %@ at %@".localized,text,merchantName];
            break;
        }
        case DDShareRedemptionHistory:{
            break;
        }
        
        
        
    }
    
    return @"";
}


@end
