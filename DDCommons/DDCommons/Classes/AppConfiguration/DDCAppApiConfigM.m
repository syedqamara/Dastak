//
//  DDCAppApiConfigM.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 30/12/2019.
//

#import "DDCAppApiConfigM.h"

@implementation DDCAppApiConfigM
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    [self resetDynamicConfigurations];
    return self;
}
-(void)resetDynamicConfigurations {
    if (self.CASHLESS_CART_URL.length == 0) {
        self.CASHLESS_CART_URL = @"";
    }
}
@end
