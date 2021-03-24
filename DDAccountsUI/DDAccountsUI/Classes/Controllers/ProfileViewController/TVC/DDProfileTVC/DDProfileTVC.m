//
//  DDProfileTVC.m
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDProfileTVC.h"
#import "DDAccountUIThemeManager.h"
#import "UICollectionView+DDRegistration.h"
#import "DDUIThemeCollectionViewCell.h"
#import "DDModels.h"
#import <DDCommons/DDCommons.h>
#import "DDAccountUIManager.h"

@interface DDProfileTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic) DDProfileSectionM *sectionItem;
@end

@implementation DDProfileTVC
@synthesize sectionItem;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellWithNibNames:@[@"DDProfileListCVC"] forClass:self.class withIdentifiers:@[@"DDProfileListCVC"]];
    // Initialization code

}

-(void)designUI {
    self.nameLabel.font = [UIFont DDBoldFont:20];
    self.nameLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.emailLabel.font = [UIFont DDRegularFont:15];
    self.emailLabel.textColor = DDAccountUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.seperatorView.backgroundColor = DDAccountUIThemeManager.shared.selected_theme.separator_grey_227.colorValue;
    self.profileImage.contentMode = UIViewContentModeScaleAspectFill;
}


-(void)setData:(id)data {
    [super setData:data];
    self.sectionItem = (DDProfileSectionM*)data;
    [self.collectionView reloadData];
    self.profileImage.superview.placeHolder = YES;
    self.nameLabel.text = self.sectionItem.section_title;
    self.emailLabel.text = self.sectionItem.section_subtitle;
    __weak __typeof(self) weakSElf = self;
    [self.profileImage loadImageWithString:self.sectionItem.image_url withPlaceHolderImage:nil forClass:self.class completion:^(UIImage * _Nullable image) {
       
        weakSElf.profileImage.image = image;
        weakSElf.profileImage.superview.placeHolder = NO;

    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sectionItem.section_list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDUIThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDProfileListCVC" forIndexPath:indexPath];
    [cell setData:sectionItem.section_list[indexPath.item]];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat singleWidth = (collectionView.frame.size.width - 10)/2;
    return CGSizeMake(singleWidth, collectionView.frame.size.height);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
           [DDAccountUIManager showSavingsDetail:nil onController:[UIApplication topMostController]];
       }
    if (indexPath.item == 1) {
        [DDAccountUIManager showSmilesDetail:nil onController:[UIApplication topMostController]];
    }
}

@end
