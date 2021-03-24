//
//  DDFamilyInvitationView.m
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDCustomActionSheet.h"
#import "DDConstants/DDConstants.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import <DDUI/DDUI.h>

@implementation DDCustomeActionSheetM

@end




@interface DDCustomActionSheet()

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *mainImgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgContainerH;
@end

@implementation DDCustomActionSheet

+ (void)showWithData:(DDCustomeActionSheetM *)data withCompletion:(IntCompletionCallBack)completion {
    if (data == nil) return;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
    NSMutableArray *btnsArray = data.btnsArray.mutableCopy;
    [btnsArray removeLastObject];
    for(int i=0; i<btnsArray.count; i++) {
        NSString *btnText = [[btnsArray objectAtIndex:i] localized];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion != nil)
                completion(i);
        }];
        [alert addAction:action];
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:data.btnsArray.lastObject style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion != nil)
        completion(-1);
    }];
    [alert addAction:cancel];
    
    DDCustomActionSheet *view = [DDCustomActionSheet nibInstanceOfClass:DDCustomActionSheet.class];
    [view setData:data];
    [alert.view addSubview:view];
    view.dimissCallBack = ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    };
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [view.topAnchor constraintEqualToAnchor:alert.view.topAnchor constant:0].active = YES;
    [view.leftAnchor constraintEqualToAnchor:alert.view.leftAnchor constant:0].active = YES;
    [view.rightAnchor constraintEqualToAnchor:alert.view.rightAnchor constant:0].active = YES;

    float viewW = alert.view.frame.size.width - 16;
    float btnH = 60;
    float titleH = [data.title getHeightwithWidth:viewW font:[UIFont DDBoldFont:20]];
    float subtitleH = [data.subtitle getHeightwithWidth:viewW font:[UIFont DDRegularFont:15]];
    float imageH = data.Image.length ? ACTION_SHEET_MEDIA_H : 0;
    float viewH = imageH + titleH + subtitleH + 50;
    float totalH = viewH + (btnH*data.btnsArray.count);
    
    [view.heightAnchor constraintEqualToConstant:viewH].active = YES;
    [view.widthAnchor constraintEqualToConstant:viewW].active = YES;

    alert.view.translatesAutoresizingMaskIntoConstraints = NO;
    [alert.view.heightAnchor constraintEqualToConstant:totalH].active = YES;
    
    [UIApplication.topMostController presentViewController:alert animated:true completion:nil];
}


- (void)setData:(id)data {
    if (![data isKindOfClass:[DDCustomeActionSheetM class]]) return;
    
    DDCustomeActionSheetM *model = (DDCustomeActionSheetM*)data;
    [self.mainImgView loadImageWithString:model.Image forClass:self.class];
    self.imgContainerH.constant = model.Image.length ? ACTION_SHEET_MEDIA_H : 0;
    self.titleLbl.text = model.title;
    self.subtitleLbl.text = model.subtitle;
    self.closeButton.hidden = model.hideCross.boolValue;
    [super setData:data];
}

- (void)designUI {
    self.titleLbl.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLbl.font = [UIFont DDBoldFont:20];
    
    self.subtitleLbl.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subtitleLbl.font = [UIFont DDRegularFont:15];

    [self.closeButton loadImageWithStringWithoutTemplate:@"icCloseRounded.png" forClass:self.class];
    
    self.clipsToBounds = true;
    self.layer.cornerRadius = 14;
    if (@available(iOS 11.0, *)) {
        self.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner ;
    } else {
        // Fallback on earlier versions
    }
}

- (IBAction)closeBtnTapped:(UIButton*)sender {
    if (self.dimissCallBack) {
        self.dimissCallBack();
        return;
    }
    sender.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1 animations:^{
        float sheetH = weakSelf.superview.frame.size.height - ACTION_SHEET_MEDIA_H;
        float selfH = weakSelf.frame.size.height - ACTION_SHEET_MEDIA_H;
        [weakSelf.superview.heightAnchor constraintEqualToConstant:sheetH].active = YES;
        [weakSelf.heightAnchor constraintEqualToConstant:selfH].active = YES;
        weakSelf.imgContainerH.constant = 0;
    }];
}

@end










