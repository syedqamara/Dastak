//
//  DDUIShadowView.h
//  The dynamicdelivery
//
//  Created by mac on 4/16/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DDUIShadowView : UIView
@property (strong, nonatomic) IBInspectable UIColor *shadowColor;
@property (nonatomic) IBInspectable CGSize offset;
@property (nonatomic) IBInspectable CGFloat radius; //spread
@property (nonatomic) IBInspectable CGFloat opacity;

@end
