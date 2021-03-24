//
//  DDCashlessOutletTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 16/03/2020.
//

#import "DDCashlessOutletTVC.h"
#import "DDCashlessOutletTextAttributeCVC.h"
#import "DDCashlessOutletImageAttributeCVC.h"


@interface DDCashlessOutletTVC()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
@property (weak, nonatomic) IBOutlet UICollectionView *attributescollectionView;
@property (weak, nonatomic) IBOutlet UIView *verticleSeparatorLine;
@property (weak, nonatomic) IBOutlet UIView *statusDotView;
@property (weak, nonatomic) IBOutlet UILabel *timingsLbl;
@property (weak, nonatomic) IBOutlet UILabel *trackingLbl;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *cuisinesLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attributeCollectionViewW;


@property (nonatomic, copy) DDOutletM *outlet;

@end

@implementation DDCashlessOutletTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setData:(id)data {
    if (![data isKindOfClass:[DDOutletM class]]) return;
    self.outlet = (DDOutletM*)data;
    NSString *name = self.outlet.merchant.name_for_outlet.length ? self.outlet.merchant.name_for_outlet : self.outlet.merchant.name;
    self.titleLbl.text = name;
    self.subtitleLbl.text = self.outlet.name;
    [self.mainImageView loadImageWithString:self.outlet.merchant.logo_url forClass:self.class];
    self.distanceLbl.text = [[DDLocationsManager shared] distanceFromLatidute:self.outlet.lat longitude:self.outlet.lng];
    self.timingsLbl.text = self.outlet.opening_hours;
    self.statusDotView.hidden = self.outlet.is_open == nil;
    self.trackingLbl.text = self.outlet.tracking_info.title;
    self.trackingLbl.textColor = self.outlet.tracking_info.title_color.colorValue;
    self.cuisinesLbl.attributedText = [self.outlet.merchant dotAttributedStringWithFont:[UIFont DDMediumFont:13]];
    if (self.outlet.is_open != nil) {
        self.overlayView.hidden = self.outlet.is_open.boolValue;
        if (self.outlet.is_open.boolValue) {
            self.statusDotView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.outlet_online_dot.colorValue;
        }
        else {
            self.statusDotView.backgroundColor = DDCashlessThemeManager.shared.selected_theme.outlet_offline_dot.colorValue;
        }
    }
    
    [self setupCollectionView];
    #warning Need to work on indexing for spot light search
    //[DDOutletsUtil indexItem:outlet image:cell.imgLogo.image];
    [super setData:data];
    self.distanceW.constant = [self.distanceLbl.text getWidthwithHeight:self.distanceLbl.frame.size.height font:self.distanceLbl.font] + 2;
}

- (void)designUI {
    self.titleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.titleLbl.font = [UIFont DDBoldFont:17];
    
    self.subtitleLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.subtitleLbl.font = [UIFont DDRegularFont:13];
    
    self.distanceLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.distanceLbl.font = [UIFont DDRegularFont:13];
        
    self.timingsLbl.textColor = DDCashlessThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.timingsLbl.font = [UIFont DDLightFont:11];
    
    self.trackingLbl.font = [UIFont DDMediumFont:11];
    
    self.statusDotView.circle = YES;
    self.statusDotView.clipsToBounds = YES;
    
    self.mainImageView.borderW = 0.5;
    self.mainImageView.borderColor = DDCashlessThemeManager.shared.selected_theme.border_grey_199.colorValue;
    self.mainImageView.cornerR = 12;
    self.mainImageView.clipsToBounds = YES;
}

#pragma mark - CollectionViews

-(void)setupCollectionView {
    NSArray *cells = @[CashlessOutletTextAttributeCVC, CashlessOutletImageAttributeCVC];
    [self.attributescollectionView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.attributescollectionView.delegate = self;
    self.attributescollectionView.dataSource = self;
    [self.attributescollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.outlet.outlet_attributes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDOutletAttributes *attribute = [self.outlet.outlet_attributes objectAtIndex:indexPath.item];
    if (attribute.isText) {
        DDCashlessOutletTextAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessOutletTextAttributeCVC forIndexPath:indexPath];
        [cell setData:attribute];
        return cell;
    }
    else {
        DDCashlessOutletImageAttributeCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CashlessOutletImageAttributeCVC forIndexPath:indexPath];
        [cell setData:attribute];
        return cell;
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = collectionView.frame.size.height;
    DDOutletAttributes *attr = [self.outlet.outlet_attributes objectAtIndex:indexPath.item];
    if (attr.isText) {
        CGFloat width = [attr.value getWidthwithHeight:height font:[UIFont DDMediumFont:13]] + 10;
        self.attributeCollectionViewW.constant = width - 10;
        return CGSizeMake(width, height);
    }
    return CGSizeMake(height, height);
}


@end
