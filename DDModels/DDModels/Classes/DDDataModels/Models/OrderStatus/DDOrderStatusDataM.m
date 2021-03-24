//
//  DDOrderStatusDataM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusDataM.h"

@implementation DDOrderStatusDataM
-(void)markAnOtherStatusTrue {
    for (DDOrderStatusSectionM *sect in self.sections) {
        if (sect.statuses.count > 0) {
            for (DDOrderStatusM *state in sect.statuses) {
                if (!state.isEnabled) {
                    state.state = @(YES);
                    return;
                }
            }
            break;
        }
    }
    return;
}
-(BOOL)canMarkAnotherTrue {
    for (DDOrderStatusSectionM *sect in self.sections) {
        if (sect.statuses.count > 0) {
            for (DDOrderStatusM *state in sect.statuses) {
                if (!state.isEnabled) {
                    return YES;
                }
            }
            break;
        }
    }
    return NO;
}
-(NSInteger)refreshTimeInterval {
    if (self.refresh_time_interval != nil) {
        return self.refresh_time_interval.integerValue;
    }
    return 15;
}
-(BOOL)isOrderComplete {
    return self.is_order_complete.boolValue;
}
-(BOOL)showRating {
    return self.show_rating.boolValue;
}
-(BOOL)canCancelOrder {
    return self.is_cancellable.boolValue;
}
@end
