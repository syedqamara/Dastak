//
//  DDCategoryTVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDCategoryTVC.h"
#import "DDCategoryCVC.h"
@interface DDCategoryTVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    DDHomeSectionM *sectionObj;
}

@end

@implementation DDCategoryTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerCellWithNibNames:@[@"DDCategoryCVC"] forClass:self.class withIdentifiers:@[@"DDCategoryCVC"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // Initialization code
}
-(void)designUI {
   // self.titleLabel.font = [UIFont DDSemiBoldFont:20];
   // self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
    self.separatorView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    sectionObj = data;
   // self.titleLabel.text = sectionObj.section_title;
    [super setData:data];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sectionObj.section_list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCategoryCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCategoryCVC" forIndexPath:indexPath];
    [cell setData:sectionObj.section_list[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeSectionListM *list = sectionObj.section_list[indexPath.row];
    if (self.delegate != nil) {
        [self.delegate didSelect:list ofSection:sectionObj];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat viewHeight = (self.frame.size.width - 3) / 3;
    return CGSizeMake(viewHeight, viewHeight);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
