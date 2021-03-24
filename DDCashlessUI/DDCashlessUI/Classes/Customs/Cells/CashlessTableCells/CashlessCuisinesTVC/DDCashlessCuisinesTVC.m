//
//  DDCashlessCuisinesTVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 24/03/2020.
//

#import "DDCashlessCuisinesTVC.h"
#import "DDCashlessCuisineFilterCVC.h"
#import "DDCashlessOutletListingVM.h"
#import "DDCashlessUIManager.h"
#import <DDFiltersUI/DDFiltersUI.h>

#define CELL_W 16+50+16
#define CELL_H 50+8+17 //for single line

@interface DDCashlessCuisinesTVC()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    BOOL layoutSet;
    CGFloat h;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedFiltersContainerH;
@property (weak, nonatomic) IBOutlet UIView *selectedFiltersContainer;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;

@property (strong, nonatomic) DDCashlessOutletListingSectionVM *sectionData;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation DDCashlessCuisinesTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    h = CELL_H;
    [self setupCollectionView];
}


-(void)setData:(id)data {
    if (![data isKindOfClass:[DDCashlessOutletListingSectionVM class]]) return;
    self.sectionData = (DDCashlessOutletListingSectionVM*)data;
    
    for (DDFiltersSectionM *section in self.sectionData.filtersData.filter_sections) {
        if ([section.section_identifier isEqualToString:@"visible cuisines"])
            self.dataArray = section.options;
    }
    
    [self calculateH];
    [self setupSelectedFilters];
    [self.collectionView reloadData];
    
    [super setData:data];
}

- (void)designUI {

}

-(void)calculateH {
    for (DDFiltersOptionM *option in self.dataArray) {
        if (option.title.length>13) {
            h = CELL_H + 18;
            break;
        }
    }
}

#pragma mark - CollectionView

-(void)setupCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellWithNibNames:@[CashlessCuisineFilterCVC] forClass:DDCashlessCuisineFilterCVC.class withIdentifiers:@[CashlessCuisineFilterCVC]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCashlessCuisineFilterCVC *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CashlessCuisineFilterCVC forIndexPath:indexPath];
    DDFiltersOptionM *filterOption = [self.dataArray objectAtIndex:indexPath.item];
    [cell setData:filterOption];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDFiltersOptionM *filterOption = [self.dataArray objectAtIndex:indexPath.item];
    [filterOption toggleSelection];
    for (DDFiltersOptionM *option in self.sectionData.filtersData.options) {
        if ([option.uid isEqualToString:filterOption.uid]) {
            [option toggleSelection];
        }
    }
    [self invokeDelegate];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(CELL_W, h);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 16);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}


#pragma mark - Horizon selected Filters 

-(void)setupSelectedFilters {
    
    if (self.selectedFiltersContainer.subviews.count)
        [self.selectedFiltersContainer.subviews.firstObject removeFromSuperview];
    
    NSMutableArray *ary = DDFiltersManager.shared.getSelectedDeliveryFilters;
    self.selectedFiltersContainerH.constant = ary.count > 0 ? 60 : 0;
    self.collectionViewH.constant = ary.count > 0 ? 0 : h;
    self.collectionView.hidden = self.collectionViewH.constant == 0;
    self.topSpace.constant = ary.count > 0 ? 0 : 12;
    [self layoutIfNeeded];
    
    __weak typeof(self) weakSelf = self;
    [DDHorizontalSelectedFilters showInConatiner:self.selectedFiltersContainer withDataSource:ary crossedAt:^(int index) {
        [weakSelf setupSelectedFilters];
        [weakSelf invokeDelegate];
    }];
}


-(void)invokeDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cuisineSelected)]) {
        [self.delegate cuisineSelected];
    }
}

@end
