//
//  DDMerchantSectionManusHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantDeliveryInfoHFV.h"
#import "DDCashlessUIConstants.h"

@interface DDCashlessMerchantDeliveryInfoHFV() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *menuItems;
}
@end


@implementation DDCashlessMerchantDeliveryInfoHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.menuCollection registerCellWithNibNames:@[CashlessDeliveryInfoCVC] forClass:self.class withIdentifiers:@[CashlessDeliveryInfoCVC]];
    self.menuCollection.dataSource = self;
    self.menuCollection.delegate = self;
    menuItems = [NSMutableArray new];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    menuItems = sectionModel.delivery_rules.mutableCopy;
    [self.menuCollection reloadData];
    
    [super setData:data];
}

- (void)designUI {
    self.separator.backgroundColor = DDCashlessThemeManager.shared.selected_theme.border_grey_199.colorValue;
    
}

#pragma mark - COllection View

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  menuItems.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessDeliveryInfoCVC *cell = [self.menuCollection dequeueReusableCellWithReuseIdentifier:CashlessDeliveryInfoCVC forIndexPath:indexPath];
    DDMerchantMenuButtonM *menu = menuItems[indexPath.item];
    [cell setData:menu];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.menuCollection deselectItemAtIndexPath:indexPath animated:NO];
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width;
    CGFloat height = collectionView.frame.size.height;
    CGFloat collectionWidth = (-(16)+UIScreen.mainScreen.bounds.size.width-(16));
    if (menuItems.count <= 2) {
        width = collectionWidth/menuItems.count;
    }else {
        width = collectionWidth/2;
    }
    return CGSizeMake(width, height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

@end

