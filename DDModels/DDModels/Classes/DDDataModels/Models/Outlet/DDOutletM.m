//
//  DDOutletM.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 07/08/2020.
//
#import "DDCommons.h"
#import "DDOutletM.h"

@implementation DDOutletM
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"outlet_id":@"id"}];
}
-(NSAttributedString *)timeAttributedTextWithFont:(UIFont *)font withStaticColor:(UIColor *)color {
    NSMutableAttributedString *str = [NSMutableAttributedString.alloc initWithString:@""];
    if (self.status_text.length > 0) {
        [str appendAttributedString:[self.status_text attributedWithFont:font andColor:self.status_color.colorValue]];
    }
    
    if (self.opening_time.length > 0) {
        
        NSString *timeText = [NSString stringWithFormat:@" - %@",self.opening_time];
        [str appendAttributedString:[timeText attributedWithFont:font andColor:color]];
    }
    
    return str;
}

@end
