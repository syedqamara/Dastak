//
//  DDSettingsVM.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 23/07/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, DDSettingsType) {
    DDSettingsTypeChangeEmail,
    DDSettingsTypeChangePassword,
    DDSettingsTypeNotification,
    DDSettingsTypeLanguage,
    DDSettingsTypePersonal,
    DDSettingsTypePayment,
    DDSettingsTypeAddress,
    DDSettingsTypeSettings,
    DDSettingsTypeHelp,
    DDSettingsTypeContactUs,
    DDSettingsTypeLogout,
};
@interface DDSettingsVM : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *link;
@property (assign, nonatomic) DDSettingsType type;
-(BOOL)haveImage;
-(NSString *)url;
@end

@interface DDSettingsSectionVM: NSObject
@property (strong, nonatomic) NSString *section_title;
@property (strong, nonatomic) NSArray <DDSettingsVM *> *rows;
@end

NS_ASSUME_NONNULL_END
