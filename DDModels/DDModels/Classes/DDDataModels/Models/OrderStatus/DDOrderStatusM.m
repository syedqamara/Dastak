//
//  DDOrderStatusM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusM.h"

@implementation DDOrderStatusM
-(BOOL)isEnabled {
    if (self.state != nil) {
        return self.state.boolValue;
    }
    return NO;
}
-(UIColor *)colorObj {
    if (self.isEnabled) {
        return self.color.colorValue;
    }
    return [self.color.colorValue colorWithAlphaComponent:0.2];
}
-(NSDictionary *)chartDict {
    return @{@"color": [self colorObj], @"value": @(30)};
}
-(NSDictionary *)emptyChartDict {
    return @{@"color": UIColor.whiteColor, @"value": @(2.5)};
}
@end
