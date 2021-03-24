//
//  DDCashlessMerchantDetailTblHeaderView.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 02/03/2020.
//

#import "DDCashlessMerchantDetailTblHeaderView.h"
#import "UIView+DDView.h"
#import "DDCashlessThemeManager.h"
#import "DDCashlessMerchantHeroImgCVC.h"
#import "DDCashlessUIConstants.h"

@interface DDCashlessMerchantDetailTblHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    DDCashlessMerchantDetailTblHeaderViewModel *headerModel;
    NSMutableArray *heroImages;
    CAGradientLayer *gradiantMask;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratingHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ratingBottomConstraint;
@end

@implementation DDCashlessMerchantDetailTblHeaderView


-(void)awakeFromNib {
    [super awakeFromNib];
    heroImages = [NSMutableArray new];
    [self.heroImagesCollection registerCellWithNibNames:@[CashlessMerchantHeroImgCVC] forClass:self.class withIdentifiers:@[CashlessMerchantHeroImgCVC]];
    self.heroImagesCollection.dataSource = self;
    self.heroImagesCollection.delegate = self;
}

-(void)designUI {
    self.lblMerchantTitle.textColor = DDCashlessThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblMerchantCuisines.textColor = DDCashlessThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblReviews.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.lblMerchantTitle.font = [UIFont DDBoldFont:20];
    self.lblMerchantCuisines.font = [UIFont DDMediumFont:13];
    self.lblReviews.font = [UIFont DDMediumFont:11];
    
    self.ratingViewContainer.backgroundColor = [DDCashlessThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.8];
    self.ratingViewContainer.cornerR = 4;
    
    [self setClipsToBounds:YES];
    
    [super designUI];
}

-(void)setData:(id)data {
    headerModel = (DDCashlessMerchantDetailTblHeaderViewModel*)data;
    if (headerModel){
        
        heroImages = headerModel.merchant.hero_urls.mutableCopy;
        [self.heroImagesCollection reloadData];
        self.lblMerchantTitle.text = [NSString stringWithFormat:@"%@ - %@",headerModel.merchant.name, headerModel.outlet.name];
        self.lblMerchantCuisines.text = [headerModel cuisinesAndSubCategoriesWithDot];
        
        [self checkAndShowRatingView];
        [self updateGradientView];
    }
    [super setData:data];
}

-(void)updateGradientView {
    [UIView performWithoutAnimation:^{
        [self layoutIfNeeded];
        [self addGradientLayer];
        [self layoutIfNeeded];
    }];
}

- (void) addGradientLayer {
    [gradiantMask removeFromSuperlayer];
    gradiantMask = [CAGradientLayer layer];
    gradiantMask.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.gradientView.frame), CGRectGetHeight(self.gradientView.frame));
    gradiantMask.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.gradientView.frame), CGRectGetHeight(self.gradientView.frame));
    gradiantMask.colors = [NSArray arrayWithObjects:(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.5].CGColor,(id)[DDCashlessThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.5].CGColor, nil];
    gradiantMask.startPoint = CGPointMake(1.0, 0.0);
    gradiantMask.endPoint = CGPointMake(1.0, 1.0);
    [self.gradientView.layer addSublayer:gradiantMask];
}

-(void) checkAndShowRatingView {
    
    NSString *tripAdvURL = headerModel.outlet.tripAdvisorImageURL.absoluteString;
    if(headerModel.outlet.shouldDisplayTripAdvisor){
        [self ratingViewShouldHide:NO];
        [[self.ratingViewContainer viewWithTag:20000] removeFromSuperview];
        if([tripAdvURL.lowercaseString hasSuffix:@".svg"]){
            NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

            WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            WKUserContentController *wkUController = [[WKUserContentController alloc] init];
            [wkUController addUserScript:wkUScript];

            WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
            wkWebConfig.userContentController = wkUController;

            CGRect frame = self.ratingImageView.frame;
            frame.size.height = 20;
            WKWebView *webView = [[WKWebView alloc] initWithFrame:frame configuration:wkWebConfig];
            
            NSString *html = [NSString stringWithFormat:@"<html><body><img src=\"%@\" alt=\"Smiley face\" height=\"20\" width=\"119\" style=\"margin-left:-8px;margin-top:-9px\"></body></html>", tripAdvURL];
            [webView loadHTMLString:html baseURL:nil];
            [webView setBackgroundColor:[UIColor clearColor]];
            [webView setOpaque:NO];
            webView.tag = 20000;
            webView.userInteractionEnabled = false;
            [self.ratingViewContainer addSubview:webView];
            
        } else {
            [self.ratingImageView sd_setImageWithURL:[NSURL URLWithString:tripAdvURL]];
        }
        self.lblReviews.text = [NSString stringWithFormat:@"%@ Reviews",headerModel.outlet.trip_adv_rating_reviews_count?headerModel.outlet.trip_adv_rating_reviews_count:@"0"].localized;
        [self bringSubviewToFront:self.btnReviews];
    }else{
        [self ratingViewShouldHide:YES];
    }
}

- (IBAction)didTapRatingView:(id)sender {
    if ([headerModel.outlet getTripAvisorWebUrl]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:([headerModel.outlet getTripAvisorWebUrl])]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:([headerModel.outlet getTripAvisorWebUrl])] options:@{} completionHandler:nil];
        }
    }
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  heroImages.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDCashlessMerchantHeroImgCVC *cell = [self.heroImagesCollection dequeueReusableCellWithReuseIdentifier:CashlessMerchantHeroImgCVC forIndexPath:indexPath];
    [cell setData:heroImages[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width, self.heroImagesCollection.frame.size.height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
-(void)ratingViewShouldHide:(BOOL)shouldHide {
    CGFloat height = 21;
    CGFloat bottom = 16;
    if (shouldHide) {
        height = 0;
        bottom = 8;
    }
    self.ratingHeightConstraint.constant = height;
    self.ratingBottomConstraint.constant = height;
    [self layoutIfNeeded];
}
-(void)changeOverlayColorByAlpha:(CGFloat)alpha {
    if (alpha == 0) {
        self.overlayView.backgroundColor = UIColor.clearColor;
    }else {
        self.overlayView.backgroundColor = [CASHLESS_THEME.app_theme.colorValue colorWithAlphaComponent:alpha];
    }
}
@end
