//
//  DDMerchantRatingVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 04/09/2020.
//

#import "DDMerchantRatingVC.h"
#import "HCSStarRatingView.h"
#import "DDHomeUIManager.h"
#import "DDMerchantReviewTVC.h"
@interface DDMerchantRatingVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingInfoLabel;

@end

@implementation DDMerchantRatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ratingView.maximumValue = self.merchant.rating.maxRate;
    self.ratingView.value = self.merchant.rating.rate.floatValue;
    self.ratingLabel.text = [NSString stringWithFormat:@"%.1f", self.merchant.rating.rate.floatValue];
    self.ratingInfoLabel.text = self.merchant.rating.review_subtitle;
    [self.tableView registerCells:@[@"DDMerchantReviewTVC"] forClass:self.class];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 99;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)designUI {
    self.ratingLabel.font = [UIFont DDSemiBoldFont:32];
    self.ratingInfoLabel.font = [UIFont DDMediumFont:13];
    
    self.ratingLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.ratingInfoLabel.textColor = HOME_THEME.text_black_40.colorValue;
    
    self.ratingView.minimumValue = 0;
    self.ratingView.maximumValue = 7;
    self.ratingView.tintColor = HOME_THEME.app_theme.colorValue;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.merchant.rating.reviews.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantReviewTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDMerchantReviewTVC"];
    [cell setData:self.merchant.rating.reviews[indexPath.row]];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
