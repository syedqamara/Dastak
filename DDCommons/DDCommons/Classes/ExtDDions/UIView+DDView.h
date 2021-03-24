//
//  UIView+DDSEView.h
//  AFNetworking
//
//  Created by Adnan Ahmad Janjua on 11/29/18.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIView (DDView)

- (void)DDTRViewRadius:(float)radius andColor:(UIColor *)color;
-(void)rotateViewUpward:(BOOL)isOpen withDuration:(NSTimeInterval)duration;
-(void)startAnimating;
-(void)endAnimation;
-(void)endAnimationForViews:(NSArray<UIView*>*)views;

-(void)clearConstraints;
-(void)centerInSuperview;
-(void)equalAndCenterToSupper;
-(void)equalToView:(CGFloat)constant;
-(void)centerHorizontallyInSuperview:(CGFloat)constant;
-(void)centerVerticallyInSuperview:(CGFloat)constant;
-(void)leadingInSuperview:(CGFloat)constant;
-(void)trailingInSuperview:(CGFloat)constant;
-(void)topInSuperview:(CGFloat)constant;
-(void)bottomInSuperview:(CGFloat)constant;
-(void)heightConstraint:(CGFloat)constant;
-(void)widthConstraint:(CGFloat)constant;

@property (nonatomic)IBInspectable CGFloat cornerR;
@property (nonatomic)IBInspectable CGFloat borderW;
@property (nonatomic)IBInspectable UIColor* borderColor;
@property (nonatomic)IBInspectable BOOL circle;
@property (nonatomic)IBInspectable CGFloat shadowRadius;
@property (nonatomic)IBInspectable CGFloat shadowOpacity;
@property (nonatomic)IBInspectable CGSize shadowSize;
@property (nonatomic)IBInspectable UIColor *shadowColor;
@property (nonatomic) BOOL shadow;
//For Skelton
@property (nonatomic)IBInspectable BOOL placeHolder;
@property (nonatomic,retain) NSNumber *holder;
@property (nonatomic,retain)NSMutableArray <NSNumber*>*startLocations;
@property (nonatomic,retain)NSMutableArray <NSNumber*>*endLocations;
@property (nonatomic, retain)IBInspectable UIColor *gradientBackgroundColor;
@property (nonatomic, retain)IBInspectable UIColor *gradientMovingColor;
@property (nonatomic) CFTimeInterval movingAnimationDuration;
@property (nonatomic) CFTimeInterval delayBetweenAnimationLoops;
@property (nonatomic, retain) CAGradientLayer *gradientLayer;
-(void)roundCorners: (UIRectCorner) corners radius:(CGFloat)radius;

-(void)rotateBy90;
-(void)rotateBy180:(NSTimeInterval)duration;
-(void)resetRotation:(NSTimeInterval)duration;
-(void)reset;

@end

NS_ASSUME_NONNULL_END
