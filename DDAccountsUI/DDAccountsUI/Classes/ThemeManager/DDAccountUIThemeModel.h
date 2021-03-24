//
//  DDAccountUIThemeModel.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <JSONModel/JSONModel.h>
#import <DDUI.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDAccountUIThemeModel : DDUIThemeModel

@property (strong, nonatomic) NSString <Optional> *app_smiles_color;
@property (strong, nonatomic) NSString <Optional> *app_saving_color;
@property (strong, nonatomic) NSString <Optional> *settings_header_color;

@end

NS_ASSUME_NONNULL_END
