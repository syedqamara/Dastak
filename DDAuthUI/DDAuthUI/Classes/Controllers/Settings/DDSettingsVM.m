//
//  DDSettingsVM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import "DDSettingsVM.h"
#import "DDCommons.h"
@implementation DDSettingsVM
-(BOOL)haveImage {
    return self.image.length > 0;
}
-(NSString *)url {
    if (self.type == DDSettingsTypeHelp) {
        return DDCAppConfigManager.shared.app_config.HELP_PAGE;
    }
    if (self.type == DDSettingsTypeContactUs) {
        return DDCAppConfigManager.shared.app_config.HELP_PAGE;
    }
    if (self.type == DDSettingsTypePayment) {
        return DDCAppConfigManager.shared.app_config.cashless_cart_url;
    }
    return @"";
}
@end
@implementation DDSettingsSectionVM

@end
