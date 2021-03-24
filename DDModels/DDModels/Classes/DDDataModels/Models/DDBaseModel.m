//
//  DDBaseModel.m
//  DDModels
//
//  Created by M.Jabbar on 12/02/2020.
//

#import "DDBaseModel.h"

@implementation DDBaseModel
-(BOOL)isDummy {
    if (self.is_dummy != nil) {
        return self.is_dummy.boolValue;
    }
    return NO;
}
-(id)copy {
    return [[self toDictionary] decodeTo:self.class];
}
@end
