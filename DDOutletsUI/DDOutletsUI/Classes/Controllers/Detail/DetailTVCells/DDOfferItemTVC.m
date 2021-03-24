//
//  DDOfferItemTVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDOfferItemTVC.h"
#import "DDOutletsThemeManager.h"
#import "DDOfferDetailDaysValidityCVC.h"
#import "DDOfferDetailAttributesCVC.h"

@interface DDOfferItemTVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDMerchantOffersLocalDataM *offerViewModel;
    NSArray <DDMerchantOfferDayValidity*> *offer_day_validity;
}

@end

@implementation DDOfferItemTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.daysValidityCollection registerCellWithNibNames:@[DDOfferDetailDaysValidityCVCell] forClass:self.class withIdentifiers:@[DDOfferDetailDaysValidityCVCell]];
    self.daysValidityCollection.dataSource = self;
    self.daysValidityCollection.delegate = self;
    
//    [self.attributesCollection registerCellWithNibNames:@[DDOfferDetailAttributesCVCell] forClass:self.class withIdentifiers:@[DDOfferDetailAttributesCVCell]];
//    self.attributesCollection.dataSource = self;
//    self.attributesCollection.delegate = self;
//
    self.containerView.clipsToBounds  = YES;
}

-(void)designUI{
    self.containerView.cornerR = 12;
    self.containerView.layer.borderColor = DDOutletsThemeManager.shared.selected_theme.border_grey_199.colorValue.CGColor;
    self.containerView.layer.borderWidth = 1;
    
    self.lblOfferTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.lblOfferTitle.font = [UIFont DDMediumFont:17];
    
    self.lblOfferDetail.font = [UIFont DDRegularFont:13];
    
    self.attributesCollectionLabel.font  = [UIFont DDRegularFont:13];
    
    self.lblTagInfo.font = [UIFont DDBoldFont:11];

    self.topLockedView.backgroundColor = [DDOutletsThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.6];
    
    self.lockIconImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icLockIcon"];
    
    self.imgBuyBackView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"buyBackRentangle"];
    self.lblBuyBackMessage.font = [UIFont DDMediumFont:13];
    self.lblBuyBackSmilesRequired.font = [UIFont DDBoldFont:19];
    
    self.lblBuyBackMessage.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblBuyBackSmilesRequired.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setData:(id)data{
    
    self.topLockedView.hidden = YES;
    self.lockIconContainerView.hidden = YES;
    self.buyBackContainerViewWidth.constant = 0;
    self.buyBackContainerTop.constant = 6;
    self.daysValidityCollectionHeight.constant = 0;
    self.stackViewBottomSpace.constant = 12;
    self.attributesCollectionLabel.text = @"";
    self.lblTagInfo.hidden = YES;
    
    offerViewModel = (DDMerchantOffersLocalDataM*)data;
    DDMerchantOfferToDisplay *offerToDisplay = offerViewModel.offerToDisplay;
    self.lblOfferDetail.textColor = DDOutletsThemeManager.shared.selected_theme.text_grey_199.colorValue;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:offerToDisplay.voucher_type_image]];
    self.lblOfferTitle.text = offerToDisplay.name;
    
    if (offerToDisplay.tag_info != nil && offerToDisplay.tag_info.tag_title.length > 0){
        self.lblTagInfo.font = [UIFont DDBoldFont:11];
        self.lblTagInfo.hidden = NO;
        self.lblTagInfo.backgroundColor = offerToDisplay.tag_info.tag_bg_color.colorValue;
        self.lblTagInfo.text  = [NSString stringWithFormat:@"   %@   ",offerToDisplay.tag_info.tag_title];
        self.lblTagInfo.textColor = offerToDisplay.tag_info.tag_title_color.colorValue;
        
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.lblTagInfo.bounds byRoundingCorners: UIRectCornerBottomLeft cornerRadii: (CGSize){12.0, 12.0}].CGPath;
        self.lblTagInfo.layer.mask = maskLayer;
    }
    
    if (offerToDisplay.offer_day_validity != nil && offerToDisplay.offer_day_validity.count > 0){
        self.daysValidityCollectionHeight.constant = 20;
        offer_day_validity = offerToDisplay.offer_day_validity;
    }
    
    if (offerToDisplay.additional_details != nil && offerToDisplay.additional_details.count > 0){
        NSMutableAttributedString *cousine = [[NSMutableAttributedString alloc] initWithString:@""];
        [offerToDisplay.additional_details enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DDOfferAdditionalDetail *cuisineObj = (DDOfferAdditionalDetail*)obj;
            NSAttributedString *attrStr = [cuisineObj.title attributedWithFont:[UIFont DDMediumFont:13] andColor:cuisineObj.color.colorValue];
            [cousine appendAttributedString:attrStr];
            if (idx != offerToDisplay.additional_details.count-1){
                NSAttributedString *dotString = [@"".dotString attributedWithFont:[UIFont DDMediumFont:10] andColor:cuisineObj.color.colorValue];
                [cousine appendAttributedString:dotString];
            }
        }];
        self.attributesCollectionLabel.attributedText = cousine;
    }else{
        self.attributesCollectionLabel.text = @"";
    }
    
     self.lblOfferDetail.text = [offerToDisplay getOfferMessage];
    
    [self.daysValidityCollection reloadData];
    
    __block typeof(self) weakSelf = self;
    
    [offerToDisplay checkRedemibilityStatus:^(BOOL isRedeemable) {
        if([offerToDisplay isShowSmiles]){
            //                [self changeTitleFrame:CGRectGetWidth(self.smilesView.frame)];
            //                [weakSelf.smilesView setHidden:NO];
        }
        if(![offerToDisplay isOutletExistInOffer:self->offerViewModel.selectedOutlet.outlet_id]){
            weakSelf.lblOfferDetail.text = @"NOT VALID AT THIS LOCATION".localized;
            weakSelf.lblOfferDetail.textColor = DDOutletsThemeManager.shared.selected_theme.text_red_39.colorValue;
            weakSelf.lblOfferDetail.hidden = NO;
            weakSelf.attributesCollectionLabel.text = @"";
            weakSelf.topLockedView.hidden = NO;
        }
    } isRedeemed:^(BOOL isRedeemed) {
        if([offerToDisplay isTopupOfferAllowed]){
            [weakSelf.lblBuyBackSmilesRequired setText:[NSString stringWithFormat:@"%@",offerToDisplay.smiles_burn_value]];
            weakSelf.buyBackContainerViewWidth.constant = 85;
            weakSelf.stackViewBottomSpace.constant = 20;
            if (offerToDisplay.tag_info != nil && offerToDisplay.tag_info.tag_title.length > 0){
                weakSelf.buyBackContainerTop.constant = 20;
                weakSelf.stackViewBottomSpace.constant = 34;
            }
        } else {
            weakSelf.topLockedView.hidden = NO;
        }
        weakSelf.lblOfferDetail.hidden = YES;
    } isNotRedeemed:^(BOOL isNotRedeemed) {
        if([offerToDisplay isPinged]){
        } else{
            weakSelf.lockIconContainerView.hidden = NO;
            weakSelf.topLockedView.hidden = NO;
        }
        weakSelf.lblOfferDetail.hidden = YES;
    }];
    [super setData:data];
}

//MARK:- Collection DataSource and Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
   DDOfferDetailDaysValidityCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDOfferDetailDaysValidityCVCell forIndexPath:indexPath];
    [cell setData:offer_day_validity[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return offer_day_validity.count;
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
    width = height;
    return CGSizeMake(width, height);
}
@end
