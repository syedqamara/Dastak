//
//  DDUILottieAnimationManager.h
//  DDCommons
//
//  Created by Zubair Ahmad on 10/04/20.
//

#import <Foundation/Foundation.h>
#import <Lottie/Lottie.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUILottieAnimationManager : NSObject

@property (nonatomic, strong) LOTAnimationView *progressLoading;
@property (nonatomic, strong) NSString *loaderAnimationJSONName;
@property (nonatomic, strong) UIWindow *applicationWindow;

+ (DDUILottieAnimationManager *)shared;

- (void)setupLoaderAnimationFor:(UIView *)view;
- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
