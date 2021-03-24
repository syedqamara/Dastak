//
//  DDBaseRequestModel.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 25/02/2020.
//

#import "DDBaseRequestModel.h"

@implementation DDBaseRequestModel
-(NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [super toDictionary].mutableCopy;
    if (self.custom_parameters.count > 0) {
        [dict addEntriesFromDictionary:self.custom_parameters];
    }
    return dict;
}
-(instancetype)init {
    self = [super init];
    self.custom_parameters = [NSMutableDictionary new];
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    self.custom_parameters = [NSMutableDictionary new];
    return self;
}

- (void)addCustomParams:(NSDictionary *)dic {
    if (dic.allKeys.count == 0) return;
    if (self.custom_parameters == nil)
        self.custom_parameters = [NSMutableDictionary new];
    [self.custom_parameters addEntriesFromDictionary:dic];
}
-(void)addImage:(UIImage *)img withFileName:(NSString *)fileName {
    if (self.custom_parameters == nil){
        self.custom_parameters = [NSMutableDictionary new];
    }
    [self.custom_parameters setValue:img forKey:fileName];
}
@end
