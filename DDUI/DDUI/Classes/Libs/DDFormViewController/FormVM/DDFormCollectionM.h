//
//  DDFormCollectionM.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDFormM.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDFormCollectionM : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *submitButtonTitle;
-(void)add:(DDFormM *)form;
-(NSDictionary *)toDictionary;
-(BOOL)isAllRequiredInputGiven;
-(NSArray <DDFormM *> *)allForms;
@end

NS_ASSUME_NONNULL_END
