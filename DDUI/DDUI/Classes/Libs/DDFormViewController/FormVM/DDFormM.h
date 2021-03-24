//
//  DDFormM.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * DDFormType NS_STRING_ENUM;
static DDFormType const DDFormTypeText = @"DDFormTypeText";


@interface DDFormM : NSObject
@property (strong, nonatomic) NSNumber *is_required;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *image;
@property (assign, nonatomic) Class type;
-(BOOL)isRequired;
-(BOOL)isValueProvided;
-(NSMutableDictionary *)toKeyValueDictionary;
-(void)updateValue;
+(DDFormM *)formWithTitle:(NSString *)title andValueKey:(NSString *)key withImage:(NSString *)image classType:(Class)cls isRequired:(BOOL)isRequired withValue:(id _Nullable)value;
@end

@interface DDTextFormM : DDFormM
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *edit_value;
@end

NS_ASSUME_NONNULL_END
