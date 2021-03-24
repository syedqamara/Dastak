//
//  DDEdiConfigBreakPointM.h
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DDBreakPointM <NSObject> @end
@interface DDBreakPointM : JSONModel
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSString <Optional> *sub_title;
@property (strong,nonatomic) NSString <Optional> *api_identifier;
@property (strong,nonatomic) NSNumber <Optional> *is_selected_for_response;
@property (strong,nonatomic) NSNumber <Optional> *is_selected_for_request;
-(BOOL)isResponseSelected;
-(void)setResponseSelected:(BOOL)selected;
-(BOOL)isRequestSelected;
-(void)setRequestSelected:(BOOL)selected;
@end


@interface DDEditConfigBreakPointM : JSONModel

@property (strong,nonatomic) NSMutableArray <DDBreakPointM,Optional> *break_points;
-(NSMutableArray *)arrayWithText:(NSString *)text;
+(BOOL)isRequestBreakPointEnabledForApi:(NSString *)apiType;
+(BOOL)isResponseBreakPointEnabledForApi:(NSString *)apiType;
+(void)setApiBreakPoints:(DDEditConfigBreakPointM *)apiBreakPoints;
+(DDEditConfigBreakPointM *)apiBreakPoints;
@end

NS_ASSUME_NONNULL_END
