//
//  DDMerchantDetailTblHeaderView.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 02/03/2020.
//

#import "DDMerchantDetailTblHeaderView.h"
#import "UIView+DDView.h"
#import "DDOutletsThemeManager.h"
#import "DDMerchantHeroImgCVC.h"
#import "DDOutletsUIConstants.h"

@interface DDMerchantDetailTblHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    DDMerchantDetailTblHeaderViewModel *headerModel;
    NSMutableArray *heroImages;
    CAGradientLayer *gradiantMask;
}
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@end

@implementation DDMerchantDetailTblHeaderView


-(void)awakeFromNib {
    [super awakeFromNib];
    heroImages = [NSMutableArray new];
    [self.heroImagesCollection registerCellWithNibNames:@[DDMerchantHeroImgCVCell] forClass:self.class withIdentifiers:@[DDMerchantHeroImgCVCell]];
    self.heroImagesCollection.dataSource = self;
    self.heroImagesCollection.delegate = self;
    self.ratingViewContainerHeight.constant = 0;
}

-(void)designUI {
    self.lblMerchantTitle.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblMerchantCuisines.textColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    self.lblReviews.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    
    self.lblMerchantTitle.font = [UIFont DDBoldFont:20];
    self.lblMerchantCuisines.font = [UIFont DDMediumFont:13];
    self.lblReviews.font = [UIFont DDMediumFont:11];
    
    self.ratingViewContainer.backgroundColor = [DDOutletsThemeManager.shared.selected_theme.bg_white.colorValue colorWithAlphaComponent:0.8];
    self.ratingViewContainer.cornerR = 4;
    
    
    
    [super designUI];
}

-(void)setData:(id)data {
    headerModel = (DDMerchantDetailTblHeaderViewModel*)data;
    if (headerModel){
        if (headerModel.is_deliveryView.boolValue){
            heroImages = headerModel.merchant.delivery_section.delivery_tutorials_info.mutableCopy;
        }else  {
            heroImages = headerModel.merchant.hero_urls.mutableCopy;
        }
        [self.heroImagesCollection reloadData];
        self.lblMerchantTitle.text = [NSString stringWithFormat:@"%@ - %@",headerModel.merchant.name, headerModel.outlet.name];
        self.lblMerchantCuisines.text = [headerModel cuisinesAndSubCategoriesWithDot];
        self.ratingViewContainerHeight.constant = 0;
        [self checkAndShowRatingView];
        [self updateGradientView];
    }
    self.overlayView.userInteractionEnabled = NO;
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
    gradiantMask.colors = [NSArray arrayWithObjects:(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.1].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.2].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.3].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.4].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.5].CGColor,(id)[DDOutletsThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.5].CGColor, nil];
    gradiantMask.startPoint = CGPointMake(1.0, 0.0);
    gradiantMask.endPoint = CGPointMake(1.0, 1.0);
    [self.gradientView.layer addSublayer:gradiantMask];
}

-(void) checkAndShowRatingView {
    
    NSString *tripAdvURL = headerModel.outlet.trip_adv_rating_image;
    NSString *reviewCount = headerModel.outlet.trip_adv_rating_reviews_count;
    if (tripAdvURL != nil && tripAdvURL.length > 0){
        if ([tripAdvURL.lowercaseString hasPrefix:@"http://"]) {
            tripAdvURL = [tripAdvURL stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
        }
    }
    NSURL *url = [NSURL URLWithString:tripAdvURL];
    if (url == nil || reviewCount == nil || [reviewCount isEqualToString:@""] || [reviewCount isEqualToString:@"0"]){
        self.ratingViewContainerHeight.constant = 0;
    }else {
        self.ratingViewContainerHeight.constant = 21;
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
    }
    [self bringSubviewToFront:self.btnReviews];
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
    
    DDMerchantHeroImgCVC *cell = [self.heroImagesCollection dequeueReusableCellWithReuseIdentifier:DDMerchantHeroImgCVCell forIndexPath:indexPath];
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
-(void)changeOverlayColorByAlpha:(CGFloat)alpha {
    if (alpha == 0) {
        self.overlayView.backgroundColor = UIColor.clearColor;
    }else {
        self.overlayView.backgroundColor = [OUTLETS_THEME.app_theme.colorValue colorWithAlphaComponent:alpha];
    }
}

@end
