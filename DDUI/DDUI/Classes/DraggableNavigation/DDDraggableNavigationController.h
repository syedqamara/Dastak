//
//  DDDraggableNavigationController.h
//  DDUI
//
//  Created by Awais Shahid on 02/03/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDDraggableNavigationControllerDelegate <NSObject>
@optional
-(void)dragableViewTopOffset:(CGFloat)topOffset;
-(void)isdragableViewPresentedInFullScreen:(BOOL)fullScreen;
@end

@interface DDDraggableNavigationController : UINavigationController
@property (assign, nonatomic) BOOL isFullScreen;
@property (assign, nonatomic) BOOL panDraggableInFullScreen;
@property (assign, nonatomic) BOOL disableUpwardPan;
@property (assign, nonatomic) CGFloat panModelHeight;
@property (weak, nonatomic) id<DDDraggableNavigationControllerDelegate> panModelDelegate;
-(void)panTransiotionToFullScreen;
@end

NS_ASSUME_NONNULL_END
