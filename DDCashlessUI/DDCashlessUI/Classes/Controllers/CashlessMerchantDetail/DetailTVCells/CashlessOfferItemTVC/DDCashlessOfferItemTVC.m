//
//  DDOfferItemTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDCashlessOfferItemTVC.h"
#import "DDCashlessThemeManager.h"
#import "DDCashlessOfferDetailDaysValidityCVC.h"
#import "DDCashlessOfferDetailAttributesCVC.h"
#import "DDCashlessUIConstants.h"

@interface DDCashlessOfferItemTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDCashlessMerchantOffersCellViewModel *offerViewModel;
    NSArray <DDMerchantOfferDayValidity*> *offer_day_validity;
    NSArray <DDOfferAdditionalDetail*> *additional_details;
}

@end

@implementation DDCashlessOfferItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.daysValidityCollection registerCellWithNibNames:@[CashlessOfferDetailDaysValidityCVCell] forClass:self.class withIdentifiers:@[CashlessOfferDetailDaysValidityCVCell]];
    self.daysValidityCollection.dataSource = self;
    self.daysValidityCollection.delegate = self;
    
    [self.attributesCollection registerCellWithNibNames:@[CashlessOfferDetailAttributesCVCell] forClass:self.class withIdentifiers:@[CashlessOfferDetailAttributesCVCell]];
    self.attributesCollection.dataSource = self;
    self.attributesCollection.delegate = self;
    
    self.containerView.clipsToBounds  = YES;
}

-(void)designUI{
    self.containerView.cornerR = 12;
    self.containerView.layer.borderColor = DDCashlessThemeManager.shared.selected_theme.border_grey_199.colorValue.CGColor;
    self.containerView.layer.borderWidth = 1;
    
    self.lblOfferTitle.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lblOfferTitle.font = [UIFont DDMediumFont:17];
    
    self.lblOfferDetail.textColor = DDCashlessThemeManager.shared.selected_theme.text_grey_199.colorValue;
    self.lblOfferDetail.font = [UIFont DDRegularFont:13];
    
    self.lblTagInfo.font = [UIFont DDBoldFont:11];

    self.topLockedView.backgroundColor = [DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.6];
    
    self.lockIconImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icLockIcon"];
    
    self.imgBuyBackView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"buyBackRentangle"];
    self.lblBuyBackMessage.font = [UIFont DDMediumFont:13];
    self.lblBuyBackSmilesRequired.font = [UIFont DDBoldFont:19];
    
    self.lblBuyBackMessage.textColor = DDCashlessThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblBuyBackSmilesRequired.textColor = DDCashlessThemeManager.shared.selected_theme.text_white.colorValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setData:(id)data{
    
    self.topLockedView.hidden = YES;
    self.lockIconContainerView.hidden = YES;
    self.buyBackContainerViewWidth.constant = 0;
    self.daysValidityCollectionHeight.constant = 0;
    self.attributesCollectionHeight.constant = 0;
    self.lblTagInfo.hidden = YES;
    
    offerViewModel = (DDCashlessMerchantOffersCellViewModel*)data;
    DDMerchantOfferToDisplay *offerToDisplay = offerViewModel.offerToDisplay;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:offerToDisplay.voucher_type_image]];
    self.lblOfferTitle.text = offerToDisplay.name;
    
    if (offerToDisplay.tag_info != nil && offerToDisplay.tag_info.tag_title.length > 0){
        self.lblTagInfo.hidden = NO;
        self.lblTagInfo.backgroundColor = offerToDisplay.tag_info.tag_bg_color.colorValue;
        self.lblTagInfo.text  = [NSString stringWithFormat:@"   %@   ",offerToDisplay.tag_info.tag_title];
        self.lblTagInfo.textColor = offerToDisplay.tag_info.tag_title_color.colorValue;
        
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.lblTagInfo.bounds byRoundingCorners: UIRectCornerBottomLeft cornerRadii: CGSizeMake(10, 10)].CGPath;
        self.lblTagInfo.layer.mask = maskLayer;
    }
    
    if (offerToDisplay.offer_day_validity != nil && offerToDisplay.offer_day_validity.count > 0){
        self.daysValidityCollectionHeight.constant = 20;
        offer_day_validity = offerToDisplay.offer_day_validity;
    }
    
    if (offerToDisplay.additional_details != nil && offerToDisplay.additional_details.count > 0){
        self.attributesCollectionHeight.constant = 18;
        additional_details = offerToDisplay.additional_details;
    }
    
     self.lblOfferDetail.text = [offerToDisplay getOfferMessage];
    
    [self.daysValidityCollection reloadData];
    [self.attributesCollection reloadData];
    
    __block typeof(self) weakSelf = self;
    
    [offerToDisplay checkRedemibilityStatus:^(BOOL isRedeemable) {
        
        weakSelf.lockIconContainerView.hidden = YES;
        weakSelf.topLockedView.hidden = YES;
        
    } isRedeemed:^(BOOL isRedeemed) {
//        [self changeCategoryIconToBlackColor:YES];
        if([offerToDisplay isTopupOfferAllowed]){
            [weakSelf.lblBuyBackSmilesRequired setText:[NSString stringWithFormat:@"%@",offerToDisplay.smiles_burn_value]];
            self.buyBackContainerViewWidth.constant = 85;
        } else {
            weakSelf.topLockedView.hidden = NO;
        }
    } isNotRedeemed:^(BOOL isNotRedeemed) {
        if([offerToDisplay isPinged]){
//            [self changeCategoryIconToBlackColor:YES];
        } else{
            weakSelf.lockIconContainerView.hidden = NO;
            weakSelf.topLockedView.hidden = NO;
        }
    }];
    [super setData:data];
}

//MARK:- Collection DataSource and Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (collectionView == self.daysValidityCollection) {
        DDCashlessOfferDetailDaysValidityCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessOfferDetailDaysValidityCVCell forIndexPath:indexPath];
        [cell setData:offer_day_validity[indexPath.item]];
        return cell;
    }else if (collectionView == self.attributesCollection){
        DDCashlessOfferDetailAttributesCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessOfferDetailAttributesCVCell forIndexPath:indexPath];
                [cell setData:additional_details[indexPath.item]];
        return cell;
    }else {
        return  [UICollectionViewCell new];
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.daysValidityCollection){
        return offer_day_validity.count;
    }else if (collectionView == self.attributesCollection){
        return additional_details.count;
    }
    return 0;
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
    if (collectionView == self.daysValidityCollection){
        width = height;
    }else if (collectionView == self.attributesCollection){
        NSString *title = additional_details[indexPath.item].title.stringWithDot;
        width = [title getWidthwithHeight:height font:[UIFont DDRegularFont:13]] + 10;
    }
    return CGSizeMake(width, height);
}
@end
