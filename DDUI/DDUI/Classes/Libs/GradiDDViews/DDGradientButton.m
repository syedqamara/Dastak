//
//  DDGradientButton.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 07/06/2020.
//

#import "DDGradientButton.h"
#import "DDAuthUIThemeManager.h"

@interface DDGradientButton ()
@property (strong, nonatomic) UIView* overlayView;
@end

@implementation DDGradientButton

-(instancetype)init {
    self = [super init];
    [self initializeOverlayView];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initializeOverlayView];
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initializeOverlayView];
    return self;
}
-(void)initializeOverlayView {
    
    self.overlayView = [UIView.alloc init];
    [self addSubview:self.overlayView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setShowOverlay:(BOOL)showOverlay {
    _showOverlay = showOverlay;
    [self layoutSubviews];
}
-(void)setOverlayAlpha:(CGFloat)overlayAlpha {
    _overlayAlpha = overlayAlpha;
    [self layoutSubviews];
}
-(void)setOverlayColor:(UIColor *)overlayColor {
    _overlayColor = overlayColor;
    [self layoutSubviews];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.overlayView.frame = self.bounds;
    self.overlayView.backgroundColor = [self.overlayColor colorWithAlphaComponent:self.overlayAlpha];
    [self.overlayView setHidden:!self.showOverlay];
    self.backgroundColor = [DDAuthUIThemeManager.shared.selected_theme leftToRightAppThemeGradientForBound:self.frame];
    
}
@end
