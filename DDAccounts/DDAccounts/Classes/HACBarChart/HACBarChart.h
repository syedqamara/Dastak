//
//  HACLineChart.h
//  Chart
//
//  Created by Hipolito Arias on 2/6/15.
//  Copyright (c) 2015 Hipolito Arias. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HACBarLayer.h"
#import <DDCommons/UIView+DDView.h>

#define kHACPercentage      @"percentage"
#define kHACColor           @"color"
#define kHACCustomText      @"customText"
#define kHACSelected      @"selected"

enum {
    HACBarType1,
    HACBarType2,
    HACBarType3,
    HACBarType4
};

enum {
    HACAxisFormatInt,
    HACAxisFormatFloat
};


typedef int HACBarType;
typedef int HACAxisFormat;


@interface HACBarChart : UIView

@property(nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic) IBOutlet UIView *containerView;
@property(nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property(nonatomic) IBOutlet NSLayoutConstraint *scrollwidthConstraint;

@property (nonatomic) HACBarType typeBar;

@property (nonatomic) BOOL vertical;
@property (nonatomic) BOOL reverse;
@property (nonatomic) BOOL showProgressLabel;
@property (nonatomic) BOOL showDataValue;
@property (nonatomic) BOOL showCustomText;
@property (nonatomic) BOOL showAxis;
@property (nonatomic) BOOL showAxisZeroValue;
@property (nonatomic) HACAxisFormat axisFormat;

@property (nonatomic) int sizeLabelProgress;
@property (nonatomic) int axisMaxValue;
@property (nonatomic) int barsMargin;
@property (nonatomic) int barWidth;
@property (nonatomic) int animationDuration;
@property (nonatomic) int numberDividersAxisY;
@property (nonatomic) CGFloat mAxis;
@property (nonatomic) NSTextAlignment alignmentText;

@property (strong, nonatomic) UIColor *progressTextColor;
@property (strong, nonatomic) UIColor *axisYTextColor;
@property (strong, nonatomic) UIColor *dashedLineColor;
@property (strong, nonatomic) UIColor *axisXColor;
@property (strong, nonatomic) UIColor *axisYColor;
@property (strong, nonatomic) UIFont *progressTextFont;

@property (strong, nonatomic) NSArray *data;

- (void)clearChart;
- (void)draw;

@end
