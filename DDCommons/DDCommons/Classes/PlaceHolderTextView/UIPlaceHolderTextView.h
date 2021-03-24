//
//  UIPlaceHolderTextView.h
//  DDCommons
//
//  Created by M.Jabbar on 21/02/2020.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
-(void)textChanged:(NSNotification*)notification;
@end

NS_ASSUME_NONNULL_END
