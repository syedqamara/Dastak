//
//  DDEditConfigM.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import "DDEditConfigM.h"

@implementation DDEditConfigM
+(DDEditConfigM *)configWithTitle:(NSString *)title andDescription:(NSString *)description andIdentifier:(NSString *)identifier {
    DDEditConfigM *c = [DDEditConfigM new];
    c.title = title;
    c.key = description;
    c.identifier = identifier;
    return c;
}
@end
