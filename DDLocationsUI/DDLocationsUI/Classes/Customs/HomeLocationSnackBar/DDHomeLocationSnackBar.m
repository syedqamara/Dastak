//
//  DDHomeLocationSnackBar.m
//  DDHomeUI
//
//  Created by Awais Shahid on 28/02/2020.
//

#import "DDHomeLocationSnackBar.h"
#import "DDLocationsThemeManager.h"
#import "NimbusKitAttributedLabel.h"
#import "DDLocationsManager.h"

@interface DDHomeLocationSnackBar() <NIAttributedLabelDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet NIAttributedLabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *descLbl;

@property (nonatomic, copy) DDLocationsM *model;
@property (nonatomic, copy) void(^ _Nullable completion)(void);

@end

@implementation DDHomeLocationSnackBar

+ (void)showInConatiner:(UIView *)container withLocation:(DDLocationsM * _Nullable)model onChangeTapped:(void (^ _Nullable)(void))completion {
    if (DDLocationsManager.shared.isLocationServicesEnable) return;
    DDHomeLocationSnackBar *view = [DDHomeLocationSnackBar nibInstanceOfClass:DDHomeLocationSnackBar.class];
    view.frame = container.bounds;
    [container addSubview:view];
    [view setdata:model withcompletion:completion];
}


- (void)isShowSnackbar:(BOOL)isShow {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *container = self.superview;
        for (NSLayoutConstraint *constr in container.constraints) {
            if ([constr.identifier isEqualToString:@"ent"]) {
                constr.constant = isShow ? 68 : 0;
                break;
            }
        }
        [container.superview layoutIfNeeded];
    }];
}

-(void)setdata:(id)data withcompletion:(void (^ _Nullable)(void))completion {
    DDLocationsM *temp = (DDLocationsM*)data;
    if (temp == nil)  return;
    self.model = temp;
    self.completion = completion;
    
    NSString *title = [self.model.snack_bar_title stringByReplacingOccurrencesOfString:@"LOCATION_NAME" withString:self.model.name];
    NSRange range = [title rangeOfString:self.model.name];
    
    self.titleLbl.delegate = self;
    
    self.titleLbl.text = title;
    self.titleLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_white.colorValue;
    self.titleLbl.font = [UIFont DDMediumFont:17];
    
    [self.titleLbl addLink:nil range:range];
    [self.titleLbl setLinkColor:DDLocationsThemeManager.shared.selected_theme.text_white.colorValue];
    [self.titleLbl setFont:[UIFont DDBoldFont:17] range:range];
    [self.titleLbl setUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternSolid range:range];
    
    self.descLbl.text = self.model.snack_bar_des;
    self.descLbl.textColor = DDLocationsThemeManager.shared.selected_theme.text_white.colorValue;
    self.descLbl.font = [UIFont DDMediumFont:15];

    self.backgroundColor = DDLocationsThemeManager.shared.selected_theme.snack_bar_40.colorValue;
    
    
    [self isShowSnackbar:YES];
    
    if (self.model.snack_bar_duration == nil) {
        self.model.snack_bar_duration = @(6);
    }
    
    __weak typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.model.snack_bar_duration.integerValue * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf isShowSnackbar:NO];
    });

}


#pragma mark - Nimbus kit lable

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    if (self.completion!= nil) {
        self.completion();
        [self isShowSnackbar:NO];
    }
}

@end


