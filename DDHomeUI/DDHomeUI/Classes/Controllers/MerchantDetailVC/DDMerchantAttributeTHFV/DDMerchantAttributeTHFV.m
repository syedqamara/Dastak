//
//  DDMerchantAttributeTHFV.m
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 25/07/2020.
//

#import "DDMerchantAttributeTHFV.h"
#import "DDHomeTileAttributeCVC.h"
#import "DDMerchantVM.h"
#import "DDHomeThemeManager.h"
@interface DDMerchantAttributeTHFV () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDMerchantVM *merchantVM;
}

@end

@implementation DDMerchantAttributeTHFV
-(void)designUI {
    [self.collectionView registerCells:@[@"DDHomeTileAttributeCVC"] forClass:self.class];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.lineView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    merchantVM = data;
    [super setData:data];
    [self.collectionView reloadData];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return merchantVM.merchant.merchant_attributes.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeTileAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeTileAttributeCVC" forIndexPath:indexPath];
    [cell setData:merchantVM.merchant.merchant_attributes[indexPath.row]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height;
    DDHomeSectionAttributeM *attr = merchantVM.merchant.merchant_attributes[indexPath.row];
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
