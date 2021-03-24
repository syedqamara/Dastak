//
//  NSMutableAttributedString+DDEXPAttributedString.h
//  DDExpress
//
//  Created by Hafiz Aziz on 28/06/2019.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (DDAttributedString)

-(void)setColorForText:(NSString*) textToChangeColor withColor:(UIColor*) color;
-(void)addAttribute:(NSAttributedStringKey)key value:(id)value forString:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
