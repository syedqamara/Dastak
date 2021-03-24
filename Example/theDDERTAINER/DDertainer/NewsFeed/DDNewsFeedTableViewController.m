//
//  DDNewsFeedViewController.h
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 08/05/2020.
//

#import "DDNewsFeedTableViewController.h"
#include <objc/runtime.h>

@interface DDNewsFeedTableViewController () {
    UILabel *dateLable;
}

@end

@implementation DDNewsFeedTableViewController

- (instancetype)init {
  self = [super init];
  object_setClass(self, [DDNewsFeedTableViewController class]);
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    dateLable = [[UILabel alloc] initWithFrame:CGRectMake(22, 30, UIScreen.mainScreen.bounds.size.width-32, 18)];
    dateLable.backgroundColor = [UIColor clearColor];
    dateLable.textColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    dateLable.font = [UIFont DDRegularFont:13];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd MMMM"];
    NSString *reqDateString = [dateFormatter stringFromDate:[NSDate date]];
    dateLable.text = [[NSString stringWithFormat:@"Today, %@",reqDateString].localized uppercaseString];
    [self.navigationController.navigationBar addSubview:dateLable];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [dateLable removeFromSuperview];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[ABKNFBaseCardCell class]]) {
    ABKNFBaseCardCell *cardCell = (ABKNFBaseCardCell *)cell;
//    cardCell.rootView.backgroundColor = [UIColor lightGrayColor];
//    cardCell.rootView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    if ([cardCell isKindOfClass:[ABKNFCaptionedMessageCardCell class]]) {
//      ((ABKNFCaptionedMessageCardCell *)cardCell).TitleBackgroundView.backgroundColor = [UIColor darkGrayColor];
//      ((ABKNFCaptionedMessageCardCell *)cardCell).titleLabel.textColor = [UIColor brownColor];
    }
  }
  return cell;
}

- (void)handleCardClick:(ABKCard *)card {
  NSLog(@"The card %@ is clicked.", card.idString);
  
  [super handleCardClick:card];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.navigationController.navigationBar.frame.size.height <=45){
        dateLable.hidden = YES;
    }else {
        dateLable.hidden = NO;
    }
}

@end
