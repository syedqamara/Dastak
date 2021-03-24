//
//  DDUIRefreshControl.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 24/02/2020.
//

#import "DDUIRefreshControl.h"
#import "Lottie.h"

#define MAX_PULL_DISTANCE 150.0
#define ANIMATION_VIEW_WIDTH 100.0
#define ANIMATION_VIEW_HEIGHT 100.0
#define REFERSH_ANIMATION_NAME @"refresh_control"

@interface DDUIRefreshControl()
@property (strong, nonatomic) LOTAnimationView *animationView;
@property (assign, nonatomic) BOOL isRefreshAnimating;

@end

@implementation DDUIRefreshControl
-(instancetype)init {
    self = [super init];
    [self setupView];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupView];
    return self;
}

-(void)endRefreshing {
    self.isRefreshAnimating = NO;
    [self.animationView stop];
    [super endRefreshing];
}

-(void)beginRefreshing {
    [super beginRefreshing];
    self.isRefreshAnimating = YES;
    self.animationView.animationProgress = 0;
    [self.animationView play];
}

-(void)setScrollViewVerticalContentOffset:(CGFloat)yOffset {
    if (!self.isRefreshAnimating) {
        CGFloat progress = MIN(fabs(yOffset / MAX_PULL_DISTANCE), 1);
        self.animationView.animationProgress = progress;
    }
}

-(void)setupView {
    self.tintColor = UIColor.clearColor;
    self.animationView = [LOTAnimationView animationNamed:REFERSH_ANIMATION_NAME inBundle:NSBundle.mainBundle];
    self.animationView.loopAnimation = YES;
    [self addSubview:self.animationView];
    [self addTarget:self action:@selector(shouldStartAnimation) forControlEvents:(UIControlEventValueChanged)];
    [self setupConstraints];
}

-(void)setupConstraints {
    self.animationView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.animationView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.animationView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [self.animationView.widthAnchor constraintEqualToConstant:ANIMATION_VIEW_WIDTH],
        [self.animationView.heightAnchor constraintEqualToConstant:ANIMATION_VIEW_HEIGHT]
    ]];
}

-(void)shouldStartAnimation {
    [self beginRefreshing];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
