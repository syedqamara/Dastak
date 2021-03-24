//
//  DDHomeTileCVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDHomeTileCVC.h"
#import "DDHomeThemeManager.h"
#import "DDHomeSectionM.h"
#import "DDHomeTileAttributeCVC.h"
@interface DDHomeTileCVC()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDHomeSectionListM *listM;
}

@end

@implementation DDHomeTileCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.tileAttributeCollectionView registerCellWithNibNames:@[@"DDHomeTileAttributeCVC"] forClass:self.class withIdentifiers:@[@"DDHomeTileAttributeCVC"]];
    [self.attributeCollectionView registerCellWithNibNames:@[@"DDHomeTileAttributeCVC"] forClass:self.class withIdentifiers:@[@"DDHomeTileAttributeCVC"]];
    self.tileAttributeCollectionView.delegate = self;
    self.tileAttributeCollectionView.dataSource = self;
    self.attributeCollectionView.delegate = self;
    self.attributeCollectionView.dataSource = self;
    
    // Initialization code
}
-(void)designUI {
    self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
    self.titleLabel.font = [UIFont DDSemiBoldFont:15];
    
    self.timeLabel.textColor = HOME_THEME.text_white.colorValue;
    self.timeLabel.font = [UIFont DDMediumFont:11];
    
    self.timeUnitLabel.textColor = HOME_THEME.text_grey_199.colorValue;
    self.timeUnitLabel.font = [UIFont DDMediumFont:8];
    
    self.timeContainerView.backgroundColor = [HOME_THEME.bg_black.colorValue colorWithAlphaComponent:0.2];
    
}
-(void)setData:(id)data {
    listM = data;
    self.titleLabel.text = listM.title;
    self.timeLabel.text = listM.delivery_time;
    self.timeUnitLabel.text = listM.delivery_time_unit;
    [self.bgImageView loadImageWithString:listM.image_url forClass:self.class];
    [self.tileAttributeCollectionView reloadData];
    [self.attributeCollectionView reloadData];
    [super setData:data];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.attributeCollectionView) {
        return listM.attributes.count;
    }
    return listM.tile_attribute.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeTileAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeTileAttributeCVC" forIndexPath:indexPath];
    if (collectionView == self.attributeCollectionView) {
        
        [cell setData:listM.attributes[indexPath.row]];
    }else {
        [cell setData:listM.tile_attribute[indexPath.row]];
    }
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height;
    DDHomeSectionAttributeM *attr;
    if (collectionView == self.attributeCollectionView) {
        attr = listM.attributes[indexPath.row];
    }else {
        attr = listM.tile_attribute[indexPath.row];
    }
    if (attr.haveImage) {
        return CGSizeMake(collectionView.frame.size.height, collectionView.frame.size.height);
    }
    CGFloat width = [attr.titleStr getWidthwithHeight:height font:DDHomeTileAttributeCVC.titleFont];
    return CGSizeMake(width + 7, collectionView.frame.size.height);
}
@end
