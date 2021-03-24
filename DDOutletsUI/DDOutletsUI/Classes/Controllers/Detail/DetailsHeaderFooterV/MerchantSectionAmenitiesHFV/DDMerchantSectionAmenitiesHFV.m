//
//  DDMerchantSectionAmenitiesHFV.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 06/03/2020.
//

#import "DDMerchantSectionAmenitiesHFV.h"
#import "DDOutletsThemeManager.h"
#import "DDMerchantDetailAmenitiesCVC.h"
#import "DDOutletsConstants.h"

@interface DDMerchantSectionAmenitiesHFV() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    NSArray *collectionArray;
}

@end


@implementation DDMerchantSectionAmenitiesHFV

-(void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerCellWithNibNames:@[DDMerchantDetailAmenitiesCVCell] forClass:self.class withIdentifiers:@[DDMerchantDetailAmenitiesCVCell]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

-(void)designUI {
    
    self.title.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.title.font = [UIFont DDBoldFont:20];
    self.btnShowAll.titleLabel.textColor = DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue;
    if (collectionArray.count <= 4){
        self.btnShowAll.titleLabel.textColor = [DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue colorWithAlphaComponent:0.5];
    }
    [super designUI];
}

-(void)setData:(id)data {
    DDMerchantDetailSectionM *sectionModel = (DDMerchantDetailSectionM*)data;
    self.title.text = sectionModel.section_name;
    NSMutableArray*amentiesSectionArray = sectionModel.attributes.mutableCopy;
    if (amentiesSectionArray){
        collectionArray = [[NSArray alloc] initWithArray:amentiesSectionArray];
        [self.collectionView reloadData];
    }
    if (collectionArray.count <= 4){
        self.btnShowAll.enabled = NO;
    }
    [super setData:data];
}
//MARK:- Collection DataSource and Delegate
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDMerchantDetailAmenitiesCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDMerchantDetailAmenitiesCVCell forIndexPath:indexPath];
    [cell setData:collectionArray[indexPath.item]];
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionArray.count;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = UIScreen.mainScreen.bounds.size.width-32;
    CGFloat singleWidth = (w-40)/4;
    return CGSizeMake(singleWidth, collectionView.frame.size.height);
}
//MARK:- Button Action
-(IBAction)btnShowAllAction:(id)sender{
    self.callBackShowAll(collectionArray);
}

@end

