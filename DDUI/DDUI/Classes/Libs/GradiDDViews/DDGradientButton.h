//
//  DDGradientButton.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 07/06/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDGradientButton : UIButton
@property (strong, nonatomic) IBInspectable UIColor *overlayColor;
@property (assign, nonatomic) IBInspectable CGFloat overlayAlpha;
@property (assign, nonatomic) IBInspectable BOOL showOverlay;
@end

NS_ASSUME_NONNULL_END
