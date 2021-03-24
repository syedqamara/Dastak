//
//  DDEmptyView.m
//  DDUI
//
//  Created by Awais Shahid on 07/02/2020.
//

#import "DDEmptyView.h"
#import "DDUIThemeManager.h"

@interface DDEmptyView()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonBottomConstraint;

@property (nonatomic, copy) DDEmptyViewModel *modal;
@property (nonatomic, copy) void(^ _Nullable completion)(void);

@end

@implementation DDEmptyView

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (void)showInConatiner:(UIView *)container withEmptyViewModel:(DDEmptyViewModel *)modal completion:(void (^ _Nullable)(void))completion{
    DDEmptyView *view = [DDEmptyView nibInstanceOfClass:DDEmptyView.class];
    view.shouldDismissItself = YES;
    view.frame = container.bounds;
    [container addSubview:view];
    [view setdata:modal withcompletion:completion];
}

+ (DDEmptyView *)showAndReturnInConatiner:(UIView *)container withEmptyViewModel:(DDEmptyViewModel *)modal completion:(void (^ _Nullable)(void))completion {
    DDEmptyView *view = [DDEmptyView nibInstanceOfClass:DDEmptyView.class];
    view.frame = container.bounds;
    [container addSubview:view];
    [view setdata:modal withcompletion:completion];
    return view;
}

+ (void)showInternetNotAvailableWithcompletion:(void (^ _Nullable)(void))completion {
    DDEmptyView *view = [DDEmptyView nibInstanceOfClass:DDEmptyView.class];
    UIView *container = UIApplication.topMostController.view;
    if (container != nil) {
        view.frame = container.frame;
        [container addSubview:view];
        view.shouldDismissItself = YES;
        [view setdata:DDEmptyViewModel.internetVM withcompletion:completion];
    }
}


-(void)setdata:(id)data withcompletion:(void (^ _Nullable)(void))completion {
    DDEmptyViewModel *temp = (DDEmptyViewModel*)data;
    if (temp == nil)  return;
    self.modal = temp;
    self.completion = completion;
    self.titleLbl.text = self.modal.title;
    self.subtitleLbl.textAlignment = self.modal.defaultTextAlignment;
    if (self.modal.imageHeight){
        self.imageViewHeightConstraint.constant = self.modal.imageHeight.floatValue;
        self.imageViewTopConstraint.constant = 0;
        self.titleLbl.textAlignment = NSTextAlignmentCenter;
        [self layoutSubviews];
    }
    [_mainImageView loadImageWithString:self.modal.image forClass:self.class];
    self.titleLbl.textAlignment = self.modal.defaultTextAlignment;
    self.subtitleLbl.text = self.modal.sub_title;
    [self.bottomButton setTitle:self.modal.btn_title forState:UIControlStateNormal];
    
    self.mainImageView.hidden = self.modal.image.length == 0;
    self.titleLbl.hidden = self.modal.title.length == 0;
    self.subtitleLbl.hidden = self.modal.sub_title.length == 0;
    self.bottomButton.hidden = self.modal.btn_title.length == 0;
    if (self.bottomButton.hidden == YES){
        self.bottomButtonBottomConstraint.constant = 0;
        self.bottomButtonHeightConstraint.constant = 0;
    }
    [self designUI];
}

- (void)designUI {
    self.mainImageView.contentMode = UIViewContentModeCenter;
    
    self.titleLbl.font = [UIFont DDBoldFont:28];
    self.titleLbl.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDLightFont:15];
    self.subtitleLbl.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.bottomButton.titleLabel.font = [UIFont DDBoldFont:17];
    self.bottomButton.cornerR = 12.0;
    self.bottomButton.clipsToBounds = YES;
    [self.bottomButton setTitleColor:DDUIThemeManager.shared.selected_theme.text_white.colorValue forState:UIControlStateNormal];
}

-(IBAction)bottomBtnTapped:(id)sender {
    if (self.completion != nil) {
        self.completion();
    }
    if (self.shouldDismissItself)
        [self removeFromSuperview];
}


@end
