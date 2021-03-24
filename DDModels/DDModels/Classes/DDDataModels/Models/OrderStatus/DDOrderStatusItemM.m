//
//  DDOrderStatusItemM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 31/07/2020.
//

#import "DDOrderStatusItemM.h"

@implementation DDOrderStatusItemM
-(NSString *)combineNameWithSeparator:(NSString *)sep {
    NSMutableArray <NSString *> *allRequiredValues = [NSMutableArray new];
    for (DDOrderStatusItemM *item in self.options) {
        [allRequiredValues addObject:item.name];
    }
    return [allRequiredValues componentsJoinedByString:sep];
}
-(NSString *)combinePriceWithSeparator:(NSString *)sep {
    NSMutableArray <NSString *> *allRequiredValues = [NSMutableArray new];
    for (DDOrderStatusItemM *item in self.options) {
        [allRequiredValues addObject:item.price];
    }
    return [allRequiredValues componentsJoinedByString:sep];
}
@end
