//
//  ANStepperView.h
//  ANStepperViewExample
//
//  Created by Afonso Cavaco Neto on 21/02/16.
//  Copyright © 2016 Innovation Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ANStepperType) {
    ANStepperTypeDefault,
    ANStepperTypeDefaultNotAnimated,
    ANStepperTypeMinimal,
    ANStepperTypeMinimalAnimated,
    ANStepperTypeMixed,
    ANStepperTypeMixedNotAnimated
};

@protocol ANStepperViewDelegate <NSObject>

-(void)didTapAddButton;
-(void)didTapRemoveButton;

@end

IB_DESIGNABLE
@class ANStepperView;
@interface ANStepperView : UIControl

@property (nonatomic, strong) IBInspectable UIColor* buttonBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor* labelBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor* labelTextColor;
@property (nonatomic, strong) IBInspectable UIColor* buttonTextColor;
@property (nonatomic, strong) IBInspectable UIColor* disabledButtonColor;
@property (nonatomic, assign) IBInspectable CGFloat incrementValue;
@property (nonatomic, assign) IBInspectable NSUInteger stepperType;
@property (nonatomic, assign) IBInspectable CGFloat minimumValue;
@property (nonatomic, assign) IBInspectable CGFloat maximumValue;
@property (nonatomic, strong) IBInspectable UIColor* tintColor;
@property (nonatomic, strong) IBInspectable UIColor* lineColor;
@property (nonatomic, strong) IBInspectable NSString* decreaseButtonTitle;
@property (nonatomic, strong) IBInspectable NSString* increaseButtonTitle;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat labelWidthWeight;
@property (nonatomic, assign) BOOL shouldChangeOnButtonTap;

@property (nonatomic, strong, readonly) NSString* currentTitle;
@property (nonatomic, assign) CGFloat value;
@property (nonatomic, weak) id<ANStepperViewDelegate> delegate;

-(instancetype)initWithType:(ANStepperType)type;
-(void)setNewCount:(NSInteger)count;
@end
