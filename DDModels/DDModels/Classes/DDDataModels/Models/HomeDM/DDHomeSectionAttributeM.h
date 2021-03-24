//
//  DDHomeSectionAttribute.h
//  DDModels
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDBaseModel.h"
#import "DDJSONModelProtocols.h"
#import <DDCommons.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDHomeSectionAttributeM : DDBaseModel
@property (nonatomic, strong) NSString <Optional> *type;
@property (nonatomic, strong) NSString <Optional> *value;
@property (nonatomic, strong) NSString <Optional> *title_color;
@property (nonatomic, strong) NSString <Optional> *title;
-(CGFloat)borderWidth;
-(BOOL)haveImage;
-(NSString *)titleStr;
@end

NS_ASSUME_NONNULL_END
