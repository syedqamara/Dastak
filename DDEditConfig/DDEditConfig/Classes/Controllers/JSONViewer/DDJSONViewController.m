//
//  DDJSONViewController.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 24/04/2020.
//

#import "DDJSONViewController.h"
#import "DDStorage.h"

@interface DDJSONViewController ()<UITextViewDelegate> {
    NSInteger currentIndex;
    NSMutableArray <NSValue *>*ranges;
}
@property (strong, nonatomic) NSString *jsonString;
@property (strong, nonatomic) NSString *initialJSON;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *textView;
@property (assign, nonatomic) BOOL isDataSent;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation DDJSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setThemeNavigationBar];
    NSDictionary *dict = self.navigation.routerModel.data;
    if ([dict.allKeys containsObject:@"title"]) {
        self.navigationItem.title = dict[@"title"];
    }
    if ([dict.allKeys containsObject:@"json"]) {
        self.jsonString = dict[@"json"];
        self.initialJSON = self.jsonString;
    }
    [self.textField addTarget:self action:@selector(didChangeText) forControlEvents:(UIControlEventEditingChanged)];
    self.textView.delegate = self;
    [self addNavigationItemWithTitle:@"Save" identifier:@"save" tintColor:UIColor.whiteColor direction:(DDNavigationItemDirectionRight)];
    [self addNavigationItemWithImage:@"icShareWithInactive.png" identifier:@"share" tintColor:UIColor.whiteColor direction:(DDNavigationItemDirectionRight)];
    [self addNavigationItemWithTitle:@"Close" identifier:@"close" tintColor:UIColor.whiteColor direction:(DDNavigationItemDirectionLeft)];
    [self updateViews];
    // Do any additional setup after loading the view from its nib.
}
-(void)checkAndHideSearchAccessories {
    BOOL shouldHide = self.textField.text.length == 0;
    [self.countLabel.superview setHidden:shouldHide];
    [self.leftButton.superview setHidden:shouldHide];
    [self.rightButton.superview setHidden:shouldHide];
    [self checkAndChangeSearchAccessoryColors];
}
-(void)checkAndChangeSearchAccessoryColors {
    BOOL shouldDisableLeft = currentIndex == 0;
    BOOL shouldDisableRight = currentIndex == (ranges.count - 1);
    [self.leftButton setUserInteractionEnabled:!shouldDisableLeft];
    [self.rightButton setUserInteractionEnabled:!shouldDisableRight];
    if (shouldDisableLeft) {
        [self.leftButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateNormal)];
    }else {
        [self.leftButton setTitleColor:UIColor.darkGrayColor forState:(UIControlStateNormal)];
    }
    if (shouldDisableRight) {
        [self.rightButton setTitleColor:UIColor.lightGrayColor forState:(UIControlStateNormal)];
    }else {
        [self.rightButton setTitleColor:UIColor.darkGrayColor forState:(UIControlStateNormal)];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex + 1,ranges.count];
    if (currentIndex < ranges.count) {
        NSValue *value = ranges[currentIndex];
//        [self.textView scrollRangeToVisible:value.rangeValue];
    }
}
-(void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:@"save"] || sender.direction == DDNavigationItemDirectionLeft) {
        
        NSDictionary *dict = [[self.jsonString dataUsingEncoding:NSUTF8StringEncoding] decodeTo:NSDictionary.class];
        if (sender.direction == DDNavigationItemDirectionLeft) {
            dict = [[self.initialJSON dataUsingEncoding:NSUTF8StringEncoding] decodeTo:NSDictionary.class];
        }
        if (dict != nil) {
            if (!self.isDataSent) {
                self.isDataSent = YES;
                __weak typeof(self) weakSelf = self;
                [self goBackWithCompletion:^{
                    [weakSelf.navigation.routerModel sendDataCallback:nil withData:dict withController:weakSelf];
                }];
            }
        }else {
            [DDAlertUtils showOkAlertWithTitle:@"Failed" subtitle:@"Invalid JSON" completion:^{}];
        }
        
    }else {
        NSDictionary *dict = [[self.jsonString dataUsingEncoding:NSUTF8StringEncoding] decodeTo:NSDictionary.class];
        NSString *filePath = [DDJSONManager saveJSON:dict withFileName:@"ios_web_break_point_json" withExtension:@"json" isEncrypted:NO];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:@[url] applicationActivities:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
-(void)designUI {
    
    self.textField.font = [UIFont DDMediumFont:15];
    
    self.navigationController.navigationBar.barTintColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    [self.navigationController setNavigationBarHidden:NO];
}
-(NSAttributedString *)jsonTextWithFindingText:(NSString *)findingText {
    
    UIFont *hFont = [UIFont DDRegularFont:12];
    UIFont *nFont = [UIFont DDMediumFont:12];
    
    UIColor *hTColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    __block UIColor *hBColor = DDUIThemeManager.shared.selected_theme.app_theme.colorValue;
    
    
    UIColor *nTColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    UIColor *nBColor = DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    
    NSMutableAttributedString *attrJSON = [NSMutableAttributedString.alloc initWithString:self.jsonString attributes:@{NSBackgroundColorAttributeName: nBColor, NSForegroundColorAttributeName: nTColor, NSFontAttributeName: nFont}];
    ranges = [NSMutableArray new];
    __block NSInteger count = 0;
    [self.jsonString enumerateSubstringsInRange:NSMakeRange(0, self.jsonString.length) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if ([substring containsString:findingText]) {
            UIColor *color = hBColor;
            if (count == self->currentIndex) {
                color = @"f9d961".colorValue;
            }
            [attrJSON addAttributes:@{NSBackgroundColorAttributeName: color, NSForegroundColorAttributeName: hTColor, NSFontAttributeName: hFont} range:substringRange];
            [self->ranges addObject:[NSValue valueWithRange:substringRange]];
            count = count + 1;
        }
        
    }];
    [self checkAndHideSearchAccessories];
    return attrJSON;
}

-(void)didChangeText {
    currentIndex = 0;
    [self updateViews];
}
-(void)updateViews {
    self.textView.attributedText = [self jsonTextWithFindingText:self.textField.text];
}
-(void)textViewDidChange:(UITextView *)textView {
    self.jsonString = textView.attributedText.string;
    self.jsonString = [self.jsonString stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    self.jsonString = [self.jsonString stringByReplacingOccurrencesOfString:@"‘" withString:@"\'"];
    
    [self updateViews];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTapLeftButton:(id)sender {
    currentIndex -= 1;
    [self updateViews];
    [self checkAndHideSearchAccessories];
}
- (IBAction)didTapRightButton:(id)sender {
    currentIndex += 1;
    [self updateViews];
    [self checkAndHideSearchAccessories];
}

@end
