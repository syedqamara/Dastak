//
//  DDRedemptionViewController.m
//  DDRedemptionsUI
//
//  Created by Syed Qamar Abbas on 12/03/2020.
//

#import "DDRedemptionViewController.h"
#import "DDRedemptionMerchantAttributeCVC.h"
#import "DDPinEntryRedemptionTVC.h"
#import "DDPinlessRedemptionTVC.h"
#import "DDPurchaseRedemptionTVC.h"
#import "DDSwipeRedemptionTVC.h"
#import "DDRedemptionsUIManager.h"
#import "DDAuth.h"

#define MERCHANT_ATTRIBUTE_CELL_HEIGHT 100

#define MERCHANT_ATTRIBUTE_CELL_IDDDIFIER @"DDRedemptionMerchantAttributeCVC"
#define PIN_DDRY_CELL_IDDDIFIER @"DDPinEntryRedemptionTVC"
#define PIN_LESS_CELL_IDDDIFIER @"DDPinlessRedemptionTVC"
#define PURCHASE_CELL_IDDDIFIER @"DDPurchaseRedemptionTVC"
#define SWIPE_CELL_IDDDIFIER @"DDSwipeRedemptionTVC"



@interface DDRedemptionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, DDRedemptionBaseTVCDelegate> {
    DDRedemptionType type;
}
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *closeImageView;
@property (weak, nonatomic) IBOutlet UILabel *offerValidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *offerRuleOfUseLabel;
@property (weak, nonatomic) IBOutlet UIButton *offerRuleOfUseButton;

@property (strong, nonatomic) DDMerchantOffersLocalDataM *data;

@end

@implementation DDRedemptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = (DDMerchantOffersLocalDataM *)self.navigation.routerModel.data;
        
    if ([self.data.offerSection isShowPurchaseButton] && ![self.data.offerToDisplay isRedeemable]) {
        type = DDRedemptionTypePurchase;
    }else if ([self.data isPromoOrSwipeBasedRedemption]) {
        type = DDRedemptionTypeSwipe;
    }else if ([self.data.offerToDisplay isMerlinOffer]) {
        type = DDRedemptionTypePinless;
    }else {
        type = DDRedemptionTypePinEntry;
    }
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self.collectionView registerCellWithNibNames:@[MERCHANT_ATTRIBUTE_CELL_IDDDIFIER] forClass:self.class withIdentifiers:@[MERCHANT_ATTRIBUTE_CELL_IDDDIFIER]];
    [self.tableView registerCellWithNibNames:@[PIN_DDRY_CELL_IDDDIFIER, PIN_LESS_CELL_IDDDIFIER, PURCHASE_CELL_IDDDIFIER, SWIPE_CELL_IDDDIFIER] forClass:self.class withIdentifiers:@[PIN_DDRY_CELL_IDDDIFIER, PIN_LESS_CELL_IDDDIFIER, PURCHASE_CELL_IDDDIFIER, SWIPE_CELL_IDDDIFIER]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self setRedemptionAttributes];
    [self setUIData];
}

- (void)setRedemptionAttributes{
    self.data.is_reattempt = @(0);
    NSDate *date = [NSDate date];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    self.data.transaction_id = [NSString stringWithFormat:@"ios-%.0f-%d-%d-%@",timestamp,[DDUserManager.shared.currentUser.user_id intValue],[self.data.offerSection.offer_id intValue],self.data.selectedOutlet.outlet_id];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

-(void)designUI {
     self.closeImageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icClose"];
    
    self.imageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"entertainer-smile"];
    
    self.titleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLabel.font = [UIFont DDBoldFont:20];
   
    self.subtitleLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subtitleLabel.font = [UIFont DDRegularFont:15];
    
    self.offerValidityLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.offerValidityLabel.font = [UIFont DDRegularFont:13];
    
    self.offerRuleOfUseLabel.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.offerRuleOfUseLabel.font = [UIFont DDRegularFont:15];
    
    [self.offerRuleOfUseButton setTitleColor:DDRedemptionsThemeManager.shared.selected_theme.app_theme.colorValue forState:(UIControlStateNormal)];
    self.offerRuleOfUseButton.titleLabel.font = [UIFont DDBoldFont:15];
}

- (void) setUIData {
    UIImage *placeHolder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"entertainer-smile"];
    [self.imageView loadImageWithString:self.data.merchant.logo_url withPlaceHolderImage:placeHolder forClass:self.class];
    self.titleLabel.text = self.data.offerToDisplay.name;
    self.subtitleLabel.text = self.data.offerToDisplay.offer_detail;
    NSString *offerMessage = [self.data.offerToDisplay getOfferMessage];
    NSArray * items = self.data.offerToDisplay.voucher_rules_of_use;
    if (items != nil){
        for (NSString *string in items)
        {
            offerMessage = [NSString stringWithFormat:@"%@\n• %@",offerMessage,string];
        }
    }
    self.offerValidityLabel.text = offerMessage;
}

- (IBAction)didTapCloseButton:(id)sender {
    [self goBackWithCompletion:nil];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.offerToDisplay.voucher_details != nil ? self.data.offerToDisplay.voucher_details.count : 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDRedemptionMerchantAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MERCHANT_ATTRIBUTE_CELL_IDDDIFIER forIndexPath:indexPath];
    [cell setData:self.data.offerToDisplay.voucher_details[indexPath.item]];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 32;
    if (self.data.offerToDisplay.voucher_details.count <= 3) {
        width = (-(16)+UIScreen.mainScreen.bounds.size.width-(16))/self.data.offerToDisplay.voucher_details.count;
    } else {
        width = (UIScreen.mainScreen.bounds.size.width)/3;
    }
    return CGSizeMake(width,MERCHANT_ATTRIBUTE_CELL_HEIGHT);
}

#pragma - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (type == DDRedemptionTypePinEntry) {
        return [self pinEntryCellAtIndexPath:indexPath];
    }
    if (type == DDRedemptionTypePinless) {
        return [self pinLessCellAtIndexPath:indexPath];
    }
    if (type == DDRedemptionTypePurchase) {
        return [self purchaseCellAtIndexPath:indexPath];
    }
    if (type == DDRedemptionTypeSwipe){
        return [self swipeCellAtIndexPath:indexPath];
    }else {
        return [UITableViewCell new];
    }
}
-(UITableViewCell *)swipeCellAtIndexPath:(NSIndexPath *)indexPath {
    DDSwipeRedemptionTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:SWIPE_CELL_IDDDIFIER];
    [cell setData:self.data];
    cell.delegate = self;
    return cell;
}
-(UITableViewCell *)pinEntryCellAtIndexPath:(NSIndexPath *)indexPath {
    DDPinEntryRedemptionTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:PIN_DDRY_CELL_IDDDIFIER];
    [cell setData:self.data];
    cell.delegate = self;
    return cell;
}
-(UITableViewCell *)pinLessCellAtIndexPath:(NSIndexPath *)indexPath {
    DDPinlessRedemptionTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:PIN_LESS_CELL_IDDDIFIER];
    [cell setData:self.data];
    cell.delegate = self;
    return cell;
}
-(UITableViewCell *)purchaseCellAtIndexPath:(NSIndexPath *)indexPath {
    DDPurchaseRedemptionTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:PURCHASE_CELL_IDDDIFIER];
    [cell setData:self.data];
    cell.delegate = self;
    return cell;
}

- (IBAction)didTapRuleOfUseButton:(id)sender {
    NSString *urlString = @"";
    if ([self.data.merchant.category isEqualToString:kHotelsWorldwide]){
        urlString = [NSString stringWithFormat:DDCAppConfigManager.shared.app_config.HOTEL_RULE_OF_USE,NSString.deviceLanguage];
    }else{
        urlString = [NSString stringWithFormat:DDCAppConfigManager.shared.app_config.RULE_OF_USE,NSString.deviceLanguage];
    }
    [[DDWebManager shared] openURL:urlString title:[@"End User License Agreement" localized] onController:self];
}

- (void)didRedemptionActionPerformed:(NSString *)entered_pin : (DDRedemptionType)type {
    if (type == DDRedemptionTypePinless){
        [self didTapPinlessRedeemButton];
        return;
    }
    else if (type == DDRedemptionTypePurchase){
        [self didTapPurchaseButton];
        return;
    }
    else if (type == DDRedemptionTypePinEntry){
        if (entered_pin.length > 0){
            self.data.merchant_pin = entered_pin;
            self.data.isMerchantPinDecryptionRequired = @(0);
        }
        else{
            return;
        }
    }
    else if (type == DDRedemptionTypeSwipe){
        self.data.isMerchantPinDecryptionRequired = @(1);
    }else{
#warning for now return from here, as no condition meet, payless redemption will be handle from here
        return;
    }
    
    [DDRedemptionsManager.shared performRedemption:self.data andCompletion:^(DDRedemptionAPIModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.data.is_reattempt = @(1);
        [self.tableView reloadData];
        if (error != nil){
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }else{
            if (model && model.data) {
                if (model.data.referenceNo.redemption_code){
                    self.data.offerToDisplay.redemptionCode = model.data.referenceNo.redemption_code;
                }
                if (model.data.referenceNo.redemption_id){
                    self.data.offerToDisplay.redemptionId = model.data.referenceNo.redemption_id;
                }
                [[DDRedemptionsManager shared] sendRedemptionAnalytics:self.data];
                [[DDRedemptionsUIManager shared] openRedemptionCompletedVCFrom:self withOfferViewModel:self.data andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
                    [self goBackWithCompletion:nil];
                }];
                [self sendCallBackToMerchantDetailToRefresh];
            } else {
                [DDAlertUtils showOkAlertWithTitle:nil subtitle:model.message completion:nil];
            }
        }
    }];
}

-(void)didTapPurchaseButton {
    NSNumber *productId = self.data.offerSection.purchase_product_id;
    NSString *deepLink = [NSString stringWithFormat:@"entertainer://ProductDetail?product_id=%@",productId.stringValue];
    [DDWebManager.shared openURL:deepLink.noRequireRefreshGlobally title:@"" onController:self];
}

-(void)didTapPinlessRedeemButton {
    [self goBackWithCompletion:^{
        [DDWebManager.shared openURL:[self.data.offerToDisplay getMerlinUrl:self.data.selectedOutlet.outlet_id] title:self.data.offerToDisplay.merlin_title onController:self];
    }];
}

- (void) sendCallBackToMerchantDetailToRefresh {
    [self.navigation.routerModel sendDataCallback:REDEMPTION_PROCESS_CALLBACK_MESSAGE withData:nil withController:self];
}

@end


