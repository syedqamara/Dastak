//
//  DDEditConfigM.h
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
#define DDEDITCONFIG_Api @"DDEDITCONFIG_Api"
#define DDEDITCONFIG_BREAK @"break_point"
#define DDEDITCONFIG_URL @"urls"

@interface DDEditConfigM : JSONModel
@property (strong, nonatomic) NSString <Optional>*title;
@property (strong, nonatomic) NSString <Optional>*data;
@property (strong, nonatomic) NSString <Optional>*key;

@property (strong, nonatomic) NSString <Ignore>*identifier;
+(DDEditConfigM *)configWithTitle:(NSString *)title andDescription:(NSString *)description andIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
