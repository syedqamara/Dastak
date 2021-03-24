//
//  DDMunchMerchantDetailHeaderView.m
//  Munch
//
//  Created by Syed Qamar Abbas on 25/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import "DDMunchMerchantDetailHeaderView.h"
#import "DDMunchMerchantDetailHeaderImageCVC.h"

#define DEFAULT_HEADER_HEIGHT 230.0


@interface DDMunchMerchantDetailHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    CGFloat currentHeaderHeight;
}
@property (weak, nonatomic) IBOutlet UILabel *onlineTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *openNowLabel;
@property (weak, nonatomic) IBOutlet UIImageView *merchantInfoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *merchantFavImageView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray <NSString *> *images;
@end

@implementation DDMunchMerchantDetailHeaderView

-(void)awakeFromNib {
    [super awakeFromNib];
    currentHeaderHeight = DEFAULT_HEADER_HEIGHT;
    [self.collectionView registerCells:@[@"DDMunchMerchantDetailHeaderImageCVC"] forClass:self.class];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self designUI];
}
-(void)reloadInputViews {
    if (self.merchant.isFav) {
        [self.merchantFavImageView loadImageWithString:@"ic-like-filled.png" forClass:self.class];
    }else {
        [self.merchantFavImageView loadImageWithString:@"ic-like.png" forClass:self.class];
    }
}
-(void)designUI {
    
    self.overlayView.backgroundColor = HOME_THEME.app_theme.colorValue;
    self.merchantNameLabel.textColor = HOME_THEME.text_black_40.colorValue;
    self.merchantNameLabel.font = [UIFont DDSemiBoldFont:20];
    [self.merchantInfoImageView loadImageWithString:@"ic-info.png" forClass:self.class];
    [self.collectionView reloadData];
    self.onlineTimeLabel.font = [UIFont DDRegularFont:13];
    self.onlineTimeLabel.textColor = HOME_THEME.text_grey_111.colorValue;
    self.openNowLabel.font = [UIFont DDRegularFont:13];
    self.openNowLabel.textColor = HOME_THEME.text_grey_111.colorValue;
}
-(void)setMerchant:(DDMerchantM *)merchant {
    _merchant = merchant;
    [self reloadInputViews];
    self.images = merchant.image_urls;
    self.merchantNameLabel.text = merchant.name;
    [self.collectionView reloadData];
    self.openNowLabel.textColor = merchant.onlineColor;
    self.openNowLabel.text = merchant.onlineTitle;
    self.onlineTimeLabel.text = [NSString stringWithFormat:@"- %@",merchant.online_time];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.pageControl.numberOfPages = self.images.count;
    return self.images.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDMunchMerchantDetailHeaderImageCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDMunchMerchantDetailHeaderImageCVC" forIndexPath:indexPath];
    NSString *img = self.images[indexPath.row];
    [cell.imageView loadImageWithString:img forClass:self.class];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}
-(NSInteger)getPage {
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat pading = 0.0;
    NSInteger page = (self.collectionView.contentOffset.x - width/2)/(width + pading) + 1;
    return page;
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat width = self.collectionView.frame.size.width;
    CGFloat pading = 0.0;
    
    NSInteger page = [self getPage];
    if (velocity.x > 0) {
        page++;
    }else {
        page--;
    }
    page = MAX(page, 0);
    targetContentOffset->x = page * (width + pading);
    self.pageControl.currentPage = page;
}
-(void)setSelectedImage {
    [self.imageView loadImageWithString:self.images[[self getPage]] forClass:self.class];
}
-(void)superScrollViewDidScroll:(UIScrollView *)scrollView {
    [self setSelectedImage];
    if (scrollView.contentOffset.y < 0) {
        [self.collectionView setHidden:YES];
        [self.imageView setHidden:NO];
        CGFloat yOffset = scrollView.contentOffset.y * -1.5;
        [self changeHeaderHeight:DEFAULT_HEADER_HEIGHT + yOffset];
    }else {
        [self.collectionView setHidden:NO];
        [self.imageView setHidden:YES];
        [self changeHeaderHeight:DEFAULT_HEADER_HEIGHT];
    }
    if (scrollView.contentOffset.y <= 0) {
        self.overlayView.alpha = 0.0;
    }else {
        CGFloat alpha = scrollView.contentOffset.y/self.navHeight;
        self.overlayView.alpha = alpha;
    }
}
-(void)changeHeaderHeight:(CGFloat)height {
    if (height >= DEFAULT_HEADER_HEIGHT) {
        [UIView animateWithDuration:0.0 animations:^{
            self.heightConstraint.constant = height;
            [self layoutIfNeeded];
        }];
    }
}
//-(void)setFrame:(CGRect)frame {
//    if (frame.size.height >= DEFAULT_HEADER_HEIGHT) {
//        [super setFrame:frame];
//    }
//}
-(void)updateSelectedLocationTitle {
//    self.locationLbl.text = DDBasket.shared.selectedUserDeliveryLocation.getTitle;
}
- (IBAction)didTapFavButton:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didTapFavouriteButton];
    }
}
- (IBAction)didTapInfoIcon:(id)sender {
    if (self.delegate != nil) {
        [self.delegate didTapInfoButton];
    }
}

@end
