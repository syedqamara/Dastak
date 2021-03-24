//
//  DDDraggableVC.m
//  DDUI
//
//  Created by Hafiz Aziz on 28/02/2020.
//

#import "DDDraggableVC.h"
#import "DDUIThemeManager.h"

@interface DDDraggableVC (){
    float beginDragPointY;
}
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@end
typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
    UIPanGestureRecognizerDirectionUndefined,
    UIPanGestureRecognizerDirectionUp,
    UIPanGestureRecognizerDirectionDown,
};


@implementation DDDraggableVC
- (id)awakeAfterUsingCoder:(NSCoder *)coder{
//     if(self.view.subviews.count > 0) {
//           // loading xib
//           return self;
//       }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.completionCallBack != nil) {
        self.completionCallBack();
    }
    
    self.navigationController.navigationBar.hidden = TRUE;
    if ([(NSNumber *)self.navigation.routerModel.data floatValue ] ){
        self.minimumDragableViewHeight = [(NSNumber *)self.navigation.routerModel.data floatValue ] ;
    }else
        self.minimumDragableViewHeight = 300;
    self.navigationHeightConstraint.constant = 64;
    self.dragableContainerHeightConstraint.constant =self.minimumDragableViewHeight;
    [self.panGesture addTarget:self action:@selector(pan:)];
    [self.leftBtn setTitle:[CANCEL localized] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(goBackWithCompletion:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)changeDraggableContainerHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.minimumDragableViewHeight = height;
        self.dragableContainerHeightConstraint.constant = height;
        [self.view layoutIfNeeded];
    }];
}
-(void)goBackWithCompletion:(void (^)(void))completion{
    [self dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}
-(void)designUI{
    [self setThemeNavigationBar];
    [self addBackArrowNavigtaionItemWithtitle:[CANCEL localized]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor] ,NSFontAttributeName : [UIFont DDBoldFont:17]};
    self.dragableContainerView.layer.cornerRadius = 10.0;
    self.dragableContainerView.clipsToBounds = TRUE;
    self.dragableContainerView.backgroundColor =  DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    self.customNavigationView.backgroundColor =  DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    self.dragableLineView.layer.cornerRadius = self.dragableLineView.frame.size.height/2;
    self.dragableLineView.clipsToBounds = TRUE;
    self.dragableLineView.backgroundColor = [DDUIThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.5];
    self.title_label.textColor = DDUIThemeManager.shared.selected_theme.text_black.colorValue;
    self.sepraterView.backgroundColor = DDUIThemeManager.shared.selected_theme.separator_grey_199.colorValue;
    self.leftBtn.titleLabel.textColor = DDUIThemeManager.shared.selected_theme.text_theme.colorValue;
    self.rightBtn.titleLabel.textColor = DDUIThemeManager.shared.selected_theme.text_theme.colorValue;
    
}
- (void)pan:(UIPanGestureRecognizer *)sender; {
    
    CGPoint translation = [sender translationInView:self.dragableContainerView];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"Translation began %f %f", translation.x, translation.y);
            
            beginDragPointY = translation.y;
            break;
            
        case UIGestureRecognizerStateChanged:
            NSLog(@"Translation began %f %f %f", beginDragPointY, translation.y, self.dragableContainerHeightConstraint.constant);
            self.dragableContainerHeightConstraint.constant -= translation.y - beginDragPointY;
            if (self.dragableContainerHeightConstraint.constant > ([UIScreen mainScreen].bounds.size.height * 0.75)) {
                [self handleUpwardsGesture:sender];
            }else if (self.dragableContainerHeightConstraint.constant < self.minimumDragableViewHeight){
                [self handleDownwardsGesture:sender];
            }
            beginDragPointY = translation.y;
            [self.view setNeedsLayout];
            break;
            
        default:
            break;
    }
    
}

- (void)handleUpwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Up");
    [UIView animateWithDuration:3.0 animations:^{
        self.dragableContainerHeightConstraint.constant = [UIScreen mainScreen].bounds.size.height;
    } completion:^(BOOL finished) {
        self.navigationHeightConstraint.constant = 0;
        
        self.navigationController.navigationBar.hidden = FALSE;
    }];
    
}

- (void)handleDownwardsGesture:(UIPanGestureRecognizer *)sender
{
    NSLog(@"Down");
    [self dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}




  


@end
