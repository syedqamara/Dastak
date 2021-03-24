//
//  DDDraggableVC.h
//  DDUI
//
//  Created by Hafiz Aziz on 28/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIBaseViewController.h"
#import "DDUIBaseViewController+Navigation.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDDraggableVC : DDUIBaseViewController
@property (weak, nonatomic) IBOutlet UIView *dragableContentView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *dragableContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *customNavigationView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *dragableLineView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *title_label;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *sepraterView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *leftBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *rightBtn;

@property (unsafe_unretained, nonatomic) CGFloat minimumDragableViewHeight;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *navigationHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *dragableContainerHeightConstraint;

@property (nonatomic, copy) VoidCompletionCallBack completionCallBack;
@end

NS_ASSUME_NONNULL_END
