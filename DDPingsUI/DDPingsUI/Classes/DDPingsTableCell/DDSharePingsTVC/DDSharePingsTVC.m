//
//  DDSharePingsTVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 24/01/2020.
//

#import "DDSharePingsTVC.h"
#import <DDPings/DDPings.h>
#import "DDSahrePingAttributedCVC.h"

@interface DDSharePingsTVC () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray <DDOfferAdditionalDetail*> *additional_details;
}
@end
@implementation DDSharePingsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellWithNibNames:@[DDSharePingAttributedCollectionCell] forClass:self.class withIdentifiers:@[DDSharePingAttributedCollectionCell]];
    self.collectionView.userInteractionEnabled = NO;
}

-(void)designUI{
    self.titleLabel.textColor = DDPingsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLabel.font = [UIFont DDMediumFont:15];
    self.sepratorView.backgroundColor = DDPingsThemeManager.shared.selected_theme.separator_grey_199.colorValue;
    
}
-(void)setData:(id)data{
    DDMerchantOffersLocalDataM *model = (DDMerchantOffersLocalDataM *)data;
    self.titleLabel.text = model.offerToDisplay.name;
    if (model.offerToDisplay.additional_details != nil && model.offerToDisplay.additional_details.count > 0){
        additional_details = model.offerToDisplay.additional_details;
    }
    if ([model.offerToDisplay isSelectedForPing]){
        [self.selectionImgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icControlSelected"]];
    }else {
        [self.selectionImgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icControlUnselected"]];
    }
    
    [self.collectionView reloadData];
    [super setData:data];
}


//MARK:- Collection DataSource and Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDSahrePingAttributedCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDSharePingAttributedCollectionCell forIndexPath:indexPath];
            [cell setData:additional_details[indexPath.item]];
    [cell setData:additional_details[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return additional_details.count;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 20;
    CGFloat height = collectionView.frame.size.height;
    NSString *title = additional_details[indexPath.item].title.stringWithDot;
    width = [title getWidthwithHeight:height font:[UIFont DDRegularFont:13]] + 10;
    return CGSizeMake(width, height);
}



@end
