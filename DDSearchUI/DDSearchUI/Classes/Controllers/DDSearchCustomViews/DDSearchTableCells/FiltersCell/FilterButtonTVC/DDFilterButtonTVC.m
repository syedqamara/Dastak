//
//  DDFilterButtonTVC.m
//  DDSearchUI
//
//  Created by Syed Qamar Abbas on 20/07/2020.
//

#import "DDFilterButtonTVC.h"
#import "DDFilterButtonCVC.h"
#define CVCID_DDFilterButtonCVC @"DDFilterButtonCVC"

@interface DDFilterButtonTVC()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    DDFilterSectionM *sectionM;
}

@end

@implementation DDFilterButtonTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerCells:@[CVCID_DDFilterButtonCVC] forClass:self.class];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    // Initialization code
}
-(void)setData:(id)data {
    sectionM = data;
    [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
    [self.collectionView reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sectionM.section_list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDFilterButtonCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CVCID_DDFilterButtonCVC forIndexPath:indexPath];
    DDFilterSectionListM *rowM = sectionM.section_list[indexPath.row];
    [cell setData:rowM];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDFilterSectionListM *rowM = sectionM.section_list[indexPath.row];
    [rowM toggleSelection];
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(109, collectionView.frame.size.height - 16);
    return size;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
