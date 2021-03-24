//
//  DDCashlessOrderInfoTHFV.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 09/04/2020.
//

#import "DDCashlessOrderInfoTHFV.h"
#import "DDCashlessOrderStatusGradientCVC.h"

@interface DDCashlessOrderInfoTHFV () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (unsafe_unretained, nonatomic) IBOutlet UIView *imageConatiner;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *imageConatinerH;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *statusLbl;

@property (strong, nonatomic) DDOrderStatusData *orderStatusData;

@end



@implementation DDCashlessOrderInfoTHFV

- (void)setData:(id)data {
    self.orderStatusData = data;
    self.titleLbl.text = self.orderStatusData.order.estimated_delivery_time;
    self.statusLbl.text = self.orderStatusData.getSelectModel.order_status_text;
    self.subtitleLbl.text = self.orderStatusData.order.estimated_delivery_title;
    [self setupCollectionView];
    [self.imageView loadImageWithString:self.orderStatusData.getSelectModel.order_status_image_url forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    self.contentView.backgroundColor = CASHLESS_THEME.bg_white.colorValue;
    
    self.titleLbl.font = [UIFont DDBoldFont:20];
    self.titleLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
    
    self.subtitleLbl.font = [UIFont DDMediumFont:13];
    self.subtitleLbl.textColor = CASHLESS_THEME.text_grey_199.colorValue;
    
    self.statusLbl.font = [UIFont DDBoldFont:15];
    self.statusLbl.textColor = CASHLESS_THEME.text_black_40.colorValue;
}

#pragma mark - CollectionView
-(void)setupCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellWithNibNames:@[CashlessOrderStatusGradientCVC] forClass:DDCashlessOrderStatusGradientCVC.class withIdentifiers:@[CashlessOrderStatusGradientCVC]];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.orderStatusData.order_statuses.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessOrderStatusGradientCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessOrderStatusGradientCVC forIndexPath:indexPath];
    DDOrderStatusM *orderStatus = [self.orderStatusData.order_statuses objectAtIndex:indexPath.item];
    [cell setData:orderStatus];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView layoutIfNeeded];
    DDOrderStatusM *orderStatus = [self.orderStatusData.order_statuses objectAtIndex:indexPath.item];
    float percentage = orderStatus.progress_percentage.doubleValue * 0.01;
    float w = (collectionView.frame.size.width-self.orderStatusData.order_statuses.count) * percentage;
    return  CGSizeMake(w, collectionView.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}

@end
