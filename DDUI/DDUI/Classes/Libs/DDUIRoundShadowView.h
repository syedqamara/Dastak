//
//  DDSERoundShadowView.h
//  The dynamicdelivery
//
//  Created by Syed Qamar Abbas on 4/30/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDUIShadowView.h"
@interface DDUIRoundShadowView : DDUIShadowView

@property (nonatomic)IBInspectable BOOL shouldAddSubLayer;
@property (nonatomic)IBInspectable CGFloat cornerRadius;

@property (nonatomic)IBInspectable CGFloat borderWidth;

@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@end

@interface DDUIRoundButton : UIButton
@property (nonatomic)IBInspectable BOOL shouldAddSubLayer;
@property (nonatomic)IBInspectable CGFloat cornerRadius;

@property (nonatomic)IBInspectable CGFloat borderWidth;

@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@end
