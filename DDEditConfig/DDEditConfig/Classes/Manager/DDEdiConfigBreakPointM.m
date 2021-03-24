//
//  DDEdiConfigBreakPointM.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDEdiConfigBreakPointM.h"
#import "DDCommons.h"

#define DF_API_BREAK_POINT_KEY @"api_break_points"

@implementation DDBreakPointM
-(BOOL)isRequestSelected {
    if (self.is_selected_for_request) {
        return self.is_selected_for_request.boolValue;
    }
    return NO;
}
-(BOOL)isResponseSelected {
    if (self.is_selected_for_response) {
        return self.is_selected_for_response.boolValue;
    }
    return NO;
}
-(void)setRequestSelected:(BOOL)selected {
    self.is_selected_for_request = @(selected);
}
-(void)setResponseSelected:(BOOL)selected {
    self.is_selected_for_response = @(selected);
}
@end

@implementation DDEditConfigBreakPointM
+(BOOL)isRequestBreakPointEnabledForApi:(NSString *)apiType {
    DDEditConfigBreakPointM *breakPoint = DDEditConfigBreakPointM.apiBreakPoints;
    for (DDBreakPointM *brk in breakPoint.break_points) {
        if ([brk.api_identifier isEqualToString:apiType] && brk.isRequestSelected) {
            return YES;
        }
    }
    return NO;
}
+(BOOL)isResponseBreakPointEnabledForApi:(NSString *)apiType {
    DDEditConfigBreakPointM *breakPoint = DDEditConfigBreakPointM.apiBreakPoints;
    for (DDBreakPointM *brk in breakPoint.break_points) {
        if ([brk.api_identifier isEqualToString:apiType] && brk.isResponseSelected) {
            return YES;
        }
    }
    return NO;
}
-(NSMutableArray *)arrayWithText:(NSString *)text {
    if (text.length > 0) {
        NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(DDBreakPointM   * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            if ([evaluatedObject.api_identifier.lowercaseString containsString:text.lowercaseString] || [evaluatedObject.title.lowercaseString containsString:text.lowercaseString] || [evaluatedObject.sub_title.lowercaseString containsString:text.lowercaseString]) {
                return YES;
            }
            return NO;
        }];
        return [self.break_points filteredArrayUsingPredicate:pred].mutableCopy;
    }
    return self.break_points;
}
+(void)setApiBreakPoints:(DDEditConfigBreakPointM *)apiBreakPoints
{
    [NSUserDefaults.standardUserDefaults setObject:apiBreakPoints.toDictionary forKey:DF_API_BREAK_POINT_KEY];
}
+(DDEditConfigBreakPointM *)apiBreakPoints {
    NSDictionary *dict = [NSUserDefaults.standardUserDefaults objectForKey:DF_API_BREAK_POINT_KEY];
    if (dict.count > 0) {
        return [dict decodeTo:DDEditConfigBreakPointM.class];
    }
    return nil;
}
@end
