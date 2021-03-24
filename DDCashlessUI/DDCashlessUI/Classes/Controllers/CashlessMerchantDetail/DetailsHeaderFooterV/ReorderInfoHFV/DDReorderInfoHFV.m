//
//  DDMerchantSectionManusHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDReorderInfoHFV.h"
#import "DDCashlessUIConstants.h"
#import "DDReorderInfoCVC.h"

@interface DDReorderInfoHFV() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *menuItems;
}
@end


@implementation DDReorderInfoHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.menuCollection registerCellWithNibNames:@[CashlessDeliveryInfoCVC, ReorderInfoCVC] forClass:self.class withIdentifiers:@[CashlessDeliveryInfoCVC, ReorderInfoCVC]];
    self.menuCollection.dataSource = self;
    self.menuCollection.delegate = self;
    menuItems = [NSMutableArray new];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.menuCollection reloadData];
}
- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    menuItems = sectionModel.reorders.mutableCopy;
    [self.menuCollection reloadData];
    
    [super setData:data];
}

- (void)designUI {
    
    
}

#pragma mark - COllection View

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  menuItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDReorderInfoCVC *cell = [self.menuCollection dequeueReusableCellWithReuseIdentifier:ReorderInfoCVC forIndexPath:indexPath];
    DDOrderM *order = menuItems[indexPath.item];
    [cell setData:order];
    cell.reorderButton.tag = indexPath.item;
    [cell.reorderButton addTarget:self action:@selector(didSelectReorderAtIndex:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
-(void)didSelectReorderAtIndex:(UIButton *)reorderButton {
    if (self.delegate != nil) {
        DDOrderM *order = menuItems[reorderButton.tag];
        [self.delegate didTapReorderButtonForOrder:order];
    }
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.menuCollection deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width;
    CGFloat height = 82;
    CGFloat collectionWidth = (-(16)+UIScreen.mainScreen.bounds.size.width-(16));
    if (menuItems.count <= 2) {
        width = collectionWidth/menuItems.count;
    }else {
        width = collectionWidth/2;
    }
    return CGSizeMake(204, height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

@end

