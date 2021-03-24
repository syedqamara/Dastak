//
//  NSMutableAttributedString+DDEXPAttributedString.m
//  DDExpress
//
//  Created by Hafiz Aziz on 28/06/2019.
//

#import "NSMutableAttributedString+DDAttributedString.h"

@implementation NSMutableAttributedString (DDEXPAttributedString)


-(void)setColorForText:(NSString*) textToChangeColor withColor:(UIColor*) color
{
    NSRange range = [self.mutableString rangeOfString:textToChangeColor options:NSCaseInsensitiveSearch];
    
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
}
-(void)addAttribute:(NSAttributedStringKey)key value:(id)value forString:(NSString*)string{
    NSRange range = [self.mutableString rangeOfString:string options:NSCaseInsensitiveSearch];
       if (range.location != NSNotFound) {
           [self addAttribute:key value:value range:range];
       }
}

@end
