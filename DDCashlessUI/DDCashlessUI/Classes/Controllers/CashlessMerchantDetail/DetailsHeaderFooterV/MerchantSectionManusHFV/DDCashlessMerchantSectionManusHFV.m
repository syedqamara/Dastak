//
//  DDMerchantSectionManusHFV.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 12/03/2020.
//

#import "DDCashlessMerchantSectionManusHFV.h"
#import "DDCashlessUIConstants.h"

@interface DDCashlessMerchantSectionManusHFV() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *menuItems;
}
@end


@implementation DDCashlessMerchantSectionManusHFV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.menuCollection registerCellWithNibNames:@[CashlessMerchantMenuItemCVC] forClass:self.class withIdentifiers:@[CashlessMerchantMenuItemCVC]];
    self.menuCollection.dataSource = self;
    self.menuCollection.delegate = self;
    menuItems = [NSMutableArray new];
}

- (void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    menuItems = sectionModel.menu_buttons.mutableCopy;
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
    DDCashlessMerchantMenuItemCVC *cell = [self.menuCollection dequeueReusableCellWithReuseIdentifier:CashlessMerchantMenuItemCVC forIndexPath:indexPath];
    DDMerchantMenuButtonM *menu = menuItems[indexPath.item];
    [cell setData:menu];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.menuCollection deselectItemAtIndexPath:indexPath animated:NO];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTapMenuItem:)]) {
        DDMerchantMenuButtonM *button = menuItems[indexPath.item];
        [_delegate didTapMenuItem:button];
    }
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width;
    CGFloat height = collectionView.frame.size.height;
    if (menuItems.count <= 3) {
        width = (-(16)+UIScreen.mainScreen.bounds.size.width-(16))/menuItems.count;
    }else {
        width = (UIScreen.mainScreen.bounds.size.width)/3;
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

