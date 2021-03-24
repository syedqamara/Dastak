//
//  DDMunchMerchantMenuView.m
//  Munch
//
//  Created by Syed Qamar Abbas on 26/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import "DDMunchMerchantMenuView.h"
#import "DDDeliveryMenuCell.h"
#import "DDMerchantVM.h"
#import "DDHomeThemeManager.h"
@interface DDMunchMerchantMenuView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    NSString *cellIdentifier;
}
@property (weak, nonatomic) IBOutlet UILabel *selectedMenuName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
@property (weak, nonatomic) IBOutlet UIButton *allMenuBtn;
@property (weak, nonatomic) IBOutlet UIImageView *menuImg;

@end

@implementation DDMunchMerchantMenuView
-(void)setMenuTitleStr:(NSString *)menuTitleStr {
    _menuTitle.text = menuTitleStr;
}
-(void)designUI {
    self.selectedMenuName.font = [UIFont DDSemiBoldFont:20];
    self.selectedMenuName.textColor = HOME_THEME.text_black_40.colorValue;
}
-(void)setData:(id)data {
    [super setData:data];
    DDMerchantVM *vm = data;
    self.menus = vm.merchant.delivery_menu;
    self.selectedMenuIndex = vm.selectedIndex;
    self.selectedMenuName.text = vm.selectedMenu.name;
    [self reloadMenus];
}
-(void)didTapAllMenuButton {
    if (self.delegate != nil) {
        [self.delegate didSelectShowAllMenu];
    }
}
-(void)reloadMenus {
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.collectionView reloadData];
    if (_menus != nil && self.selectedMenuIndex < _menus.count) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedMenuIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:selectedIndexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.menuImg loadImageWithString:@"ic-menu.png" forClass:self.class];
    [self.allMenuBtn addTarget:self action:@selector(didTapAllMenuButton) forControlEvents:(UIControlEventTouchUpInside)];
    cellIdentifier = @"DDDeliveryMenuCell";
    [_collectionView registerCells:@[cellIdentifier] forClass:self.class];
    // Initialization code
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menus.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDDeliveryMenuCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DDMerchantDeliveryMenuM * items = _menus[indexPath.row];
    cell.titleStr = items.name;
    cell.isMenuSelected = _selectedMenuIndex == indexPath.row;
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectMenuAtIndexPath:)]) {
        [_delegate didSelectMenuAtIndexPath:indexPath];
    }
    [collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDMerchantDeliveryMenuM * item = _menus[indexPath.row];
    NSString *menuName = item.name;
    UIFont *font = [UIFont DDBoldFont:15];
    CGFloat width = [menuName getWidthwithHeight:collectionView.frame.size.height font:font];
    return CGSizeMake(width+10, collectionView.frame.size.height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

+(DDMunchMerchantMenuView *)nibInstance {
    UINib *nib = [UINib nibWithNibName:@"DDMunchMerchantMenuView" bundle:nil];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}
@end
