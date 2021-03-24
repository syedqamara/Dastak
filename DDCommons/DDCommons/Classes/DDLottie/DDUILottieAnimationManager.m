//
//  DDUILottieAnimationManager.m
//  DDCommons
//
//  Created by Zubair Ahmad on 10/04/20.
//

#import "DDUILottieAnimationManager.h"

@implementation DDUILottieAnimationManager

static DDUILottieAnimationManager *_shared;

+(DDUILottieAnimationManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [DDUILottieAnimationManager new];
    });
    
    return _shared;
}

- (void)setupLoaderAnimationFor:(UIView *)view {
    self.progressLoading = [LOTAnimationView animationNamed:self.loaderAnimationJSONName inBundle:NSBundle.mainBundle];
    self.progressLoading.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:self.progressLoading];
    self.progressLoading.frame = view.bounds;
}


- (void)startAnimation {
    self.progressLoading.loopAnimation = YES;
    self.progressLoading.animationSpeed = 1.75;
    [self.progressLoading playFromProgress:0.0 toProgress:1.0 withCompletion:^(BOOL animationFinished) {
    }];
}

- (void)stopAnimation {
    [self.progressLoading stop];
}

@end
