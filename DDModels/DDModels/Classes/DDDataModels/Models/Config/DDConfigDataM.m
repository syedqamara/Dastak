//
//  DDConfigDataM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 05/09/2020.
//

#import "DDConfigDataM.h"


@implementation DDPaymentMethod

@end


@implementation DDConfigDataM
-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
//    [self loadDummyData];
    return self;
}
-(void)loadDummyData {
    DDPaymentMethod *method = [DDPaymentMethod new];
    method.identifier = @"card";
    method.image_url = @"https://i.ibb.co/xXrmffT/ic-card.png";
    method.title = @"Credit or Debit Card";
    
    self.c_2_c_payment_method = @[method];
    self.delivery_payment_method = @[method];
}
@end
