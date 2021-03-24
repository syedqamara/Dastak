//
//  DDReceivedPingsHFV.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 30/01/2020.
//

#import "DDReceivedPingsHFV.h"


@interface DDReceivedPingsHFV(){
    NSArray *pingsArray ;
}

@end
@implementation DDReceivedPingsHFV

- (void)setData:(id)data {
    pingsArray = [[NSArray alloc] initWithArray:(NSArray*)data];
    self.titleLabel.text = [PING_ACCEPT_ALL localized];
    
    [super setData:data];
}

- (void)designUI {
        
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.titleLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_theme.colorValue;
}


// MARK: - Accept the Ping
-(IBAction)btnAccpetAllAction:(id)sender{
    [self callPingAcceptAPI];
}

-(void)callPingAcceptAPI{
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    [pingRequestM.ping_ids addObjectsFromArray:[DDPingsManager.shared getAllPingsAcceptableIDArray:pingsArray]];
    pingRequestM.status = @(1);
    if (!pingRequestM.isValidRequestForAcceptPingCall) {
        [DDAlertUtils showOkAlertWithTitle:nil subtitle:pingRequestM.validationErrorMessageForAcceptPing completion:nil];
    }else {
        [[DDPingsUIManager shared] callPingAcceptRejectAPI:pingRequestM andCompletion:^(DDPingApiModel * _Nonnull model, BOOL success) {
            if (success){
                self.callBackAfterAcceptAll(model);
            }
        }];
    }
}

@end
