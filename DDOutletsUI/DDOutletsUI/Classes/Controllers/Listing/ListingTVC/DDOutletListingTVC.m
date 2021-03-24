//
//  DDOutletListingTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 30/01/2020.
//

#import "DDOutletListingTVC.h"
#import <DDCommons/DDCommons.h>
#import "DDOutletsLAttributeCVC.h"
#import "DDOutletsUIConstants.h"
#import "DDOutletsThemeManager.h"
#import "DDLocationsManager.h"

@interface DDOutletListingTVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDOutletM *thisOutlet;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *logoImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *lockImageViewContainer;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *lockImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *distanceLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tripAdvisorIcon;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *cuisinesLabel;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *ratingContainerViewWidthConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *attributesCollectionView;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *attributesCollectionViewHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *featuredViewHeightConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *featuredLabel;
@end

@implementation DDOutletListingTVC
@synthesize logoImageView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.attributesCollectionView registerCellWithNibNames:@[DDOutletsLAttributeCVCell] forClass:self.class withIdentifiers:@[DDOutletsLAttributeCVCell]];
    
    self.attributesCollectionView.delegate = self;
    self.attributesCollectionView.dataSource = self;
    
    self.lockImageViewContainer.hidden = YES;
    self.featuredViewHeightConstraint.constant = 0;
    
}
-(void)designUI {
    logoImageView.layer.cornerRadius = 12;
    logoImageView.layer.borderWidth = 1;
    logoImageView.layer.borderColor = [UIColor DDLineBorderShadowColor].CGColor;
    logoImageView.clipsToBounds = YES;
    self.lockImageViewContainer.backgroundColor = [UIColor clearColor];
    
    _lockImageView.layer.cornerRadius = 12;
    _lockImageView.clipsToBounds = YES;
    
    self.titleLabel.font = [UIFont DDBoldFont:17];
    self.subTitleLabel.font = [UIFont DDRegularFont:15];
    self.distanceLabel.font = [UIFont DDRegularFont:13];
    
    self.titleLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subTitleLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.distanceLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.cuisinesLabel.font  = [UIFont DDRegularFont:13];

    self.featuredLabel.backgroundColor = DDOutletsThemeManager.shared.selected_theme.app_theme.colorValue;
    self.featuredLabel.cornerR = 3;
    self.featuredLabel.textColor =  DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    self.featuredLabel.font = [UIFont DDBoldFont:10];
    self.featuredLabel.text = @"FEATURED".localized;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return thisOutlet.outlet_attributes.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletsLAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDOutletsLAttributeCVCell forIndexPath:indexPath];
    [cell setData:thisOutlet.outlet_attributes[indexPath.row]];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8.0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height;
    CGFloat width = height;
    DDOutletAttributes *attribs = thisOutlet.outlet_attributes[indexPath.row];
    if ([attribs.type isEqualToString:@"text"]){
        width = [attribs.value getWidthwithHeight:height font:[UIFont DDMediumFont:13]] + 10;
    }
    return CGSizeMake(width, height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(id)outlet {
    thisOutlet = (DDOutletM*)outlet;
    if (thisOutlet.is_featured != nil && thisOutlet.is_featured.boolValue){
        self.featuredViewHeightConstraint.constant = 20;
    }else{
        self.featuredViewHeightConstraint.constant = 0;
    }
    self.lockImageViewContainer.hidden = YES;
    [self.logoImageView loadImageWithString:thisOutlet.merchant.logo_url forClass:self.class];
    if (thisOutlet.locked_image_url != nil && thisOutlet.locked_image_url.length > 0){
        self.lockImageViewContainer.hidden = NO;
        [self.lockImageView sd_setImageWithURL:[NSURL URLWithString:thisOutlet.locked_image_url]];
    }
    self.titleLabel.text = thisOutlet.merchant.name_for_outlet && thisOutlet.merchant.name_for_outlet.length > 0 ? thisOutlet.merchant.name_for_outlet : thisOutlet.merchant.name;
    self.subTitleLabel.text = thisOutlet.name;
    self.distanceLabel.text = [[DDLocationsManager shared] distanceFromLatidute:thisOutlet.lat longitude:thisOutlet.lng];
    NSString *rating = [thisOutlet getTripAdvisorRating];
    if (rating == nil || [rating isEqualToString:@""] || [rating isEqualToString:@"0"] || [rating isEqualToString:@"0.0"]){
        self.ratingLabel.text = @"";
        [self.tripAdvisorIcon setImage:nil];
    }else {
        self.ratingLabel.text = rating;
        [self.tripAdvisorIcon loadImageWithString:thisOutlet.trip_advisor_small_logo forClass:self.class];
        if (thisOutlet.trip_advisor_small_logo  ==  nil){
            [self.tripAdvisorIcon setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"tripadvisor_small_logo"]];
        }
    }
    self.cuisinesLabel.text = @"";
    
    if (thisOutlet.merchant.cuisines_sub_categories != nil && thisOutlet.merchant.cuisines_sub_categories.count > 0){
        NSMutableAttributedString *cousine = [[NSMutableAttributedString alloc] initWithString:@""];
        [thisOutlet.merchant.cuisines_sub_categories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DDMerchantCuisines *cuisineObj = (DDMerchantCuisines*)obj;
            NSAttributedString *attrStr = [cuisineObj.title attributedWithFont:[UIFont DDMediumFont:13] andColor:cuisineObj.color.colorValue];
            [cousine appendAttributedString:attrStr];
            if (idx != thisOutlet.merchant.cuisines_sub_categories.count-1){
                NSAttributedString *dotString = [@"".dotString attributedWithFont:[UIFont DDMediumFont:10] andColor:cuisineObj.color.colorValue];
                [cousine appendAttributedString:dotString];
            }
        }];
        self.cuisinesLabel.attributedText = cousine;
    }else{
        self.cuisinesLabel.text = @"";
    }
    if (thisOutlet.outlet_attributes.count > 0){
        self.attributesCollectionViewHeightConstraint.constant = 20;
    }else{
        self.attributesCollectionViewHeightConstraint.constant = 0;
    }
    [self.attributesCollectionView reloadData];
    [super setData:outlet];
}
@end
