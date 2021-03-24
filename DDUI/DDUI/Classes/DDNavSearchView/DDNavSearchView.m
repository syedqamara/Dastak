//
//  DDNavSearchView.m
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import "DDNavSearchView.h"
#import <DDCommons/DDCommons.h>


@interface DDNavSearchView() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;
@property (weak, nonatomic) IBOutlet UIView *roundedView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation DDNavSearchView


- (void)designUI {

    [self.backBtn loadImageWithStringWithoutTemplate:@"icNavBack.png" forClass:self.class];
    [self.backBtn setTintColor:THEME.text_black_40.colorValue];
    [self.searchIcon loadImageWithString:@"icNavSearch.png" forClass:self.class];
            
    self.shadowView.shadow = YES;
    self.shadowView.cornerR = 12;
    self.shadowView.clipsToBounds = NO;
    
    self.roundedView.cornerR = 12;
    self.shadowView.clipsToBounds = YES;
    self.shadowView.borderW = 1;
    self.shadowView.borderColor = THEME.border_grey_227.colorValue;

    self.searchTF.returnKeyType = UIReturnKeySearch;
    self.searchTF.textColor = THEME.text_black_40.colorValue;
    self.searchTF.font = [UIFont DDRegularFont:17];
    self.searchTF.placeholder = SEARCH;

    self.superview.backgroundColor = THEME.bg_grey_248.colorValue;
    [self layoutIfNeeded];

}

-(void)setData:(id)data {
    [self setupFrame];
    [self setUpTextField];
    [super setData:data];
}

-(void)setupFrame {
    self.widthConstraint.constant = UIScreen.mainScreen.bounds.size.width;
    self.heightConstraint.constant = 67;
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        CGFloat topPadding = window.safeAreaInsets.top;
        self.topConstraint.constant = topPadding;
        for (NSLayoutConstraint *constr in self.superview.constraints) {
            if ([constr.identifier isEqualToString:@"searchBarH"]) {
                constr.constant = self.heightConstraint.constant + self.topConstraint.constant;
                break;
            }
        }
    }
}


-(void)setUpTextField {
    self.searchTF.delegate = self;
    self.searchTF.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(openSearchScreen)]) {
        [self.delegate openSearchScreen];
        return NO;
    }
    return YES;
}

- (IBAction)backBtnTapped:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navSearchViewBackButtonTapped)]) {
        [self.delegate navSearchViewBackButtonTapped];
    }
}


@end
