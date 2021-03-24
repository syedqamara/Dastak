//
//  DDOutletsTVC.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 06/08/2020.
//

#import "DDOutletsTVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeTileAttributeCVC.h"
#import "DDModels.h"

@interface DDOutletsTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDOutletM *outlet;
}

@end

@implementation DDOutletsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    [self.outletAttributeCV registerCells:@[@"DDHomeTileAttributeCVC"] forClass:self.class];
    self.outletNameLabel.font = [UIFont DDSemiBoldFont:17];
    self.outletTimingLabel.font = [UIFont DDRegularFont:11];
    self.outletNameLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.separatoor.backgroundColor = HOME_THEME.text_grey_238.colorValue;
    self.outletAttributeCV.delegate = self;
    self.outletAttributeCV.dataSource = self;
}
-(void)setData:(id)data {
    [super setData:data];
    outlet = data;
    self.outletNameLabel.text = outlet.name;
    self.outletTimingLabel.attributedText = [outlet timeAttributedTextWithFont:self.outletTimingLabel.font withStaticColor:HOME_THEME.bg_grey_199.colorValue];
    [self.outletImageView loadImageWithString:outlet.logo forClass:self.class];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return outlet.outlet_attribute.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeTileAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeTileAttributeCVC" forIndexPath:indexPath];
    [cell setData:outlet.outlet_attribute[indexPath.row]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height;
    DDHomeSectionAttributeM *attr = outlet.outlet_attribute[indexPath.row];
    if (attr.haveImage) {
        return CGSizeMake(collectionView.frame.size.height, collectionView.frame.size.height);
    }
    CGFloat width = [attr.titleStr getWidthwithHeight:height font:DDHomeTileAttributeCVC.titleFont];
    return CGSizeMake(width + 7, collectionView.frame.size.height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
