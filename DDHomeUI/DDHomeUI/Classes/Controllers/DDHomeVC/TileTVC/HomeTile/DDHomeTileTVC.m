//
//  DDHomeTileTVC.m
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDHomeTileTVC.h"
#import "DDHomeTileCVC.h"
#import "DDHomeThemeManager.h"
@interface DDHomeTileTVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    DDHomeSectionM *sectionObj;
}

@end

@implementation DDHomeTileTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerCellWithNibNames:@[@"DDHomeTileCVC"] forClass:self.class withIdentifiers:@[@"DDHomeTileCVC"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // Initialization code
}
-(void)designUI {
    self.titleLabel.font = [UIFont DDSemiBoldFont:20];
    self.titleLabel.textColor = HOME_THEME.text_black.colorValue;
    self.seeAllBtn.titleLabel.font = [UIFont DDSemiBoldFont:13];
    [self.seeAllBtn setTitleColor:HOME_THEME.text_theme.colorValue forState:(UIControlStateNormal)];
    [self.seeAllBtn setTitle:@"Show all".localized forState:UIControlStateNormal];
    self.separatorView.backgroundColor = HOME_THEME.text_grey_238.colorValue;
}
-(void)setData:(id)data {
    sectionObj = data;
    self.titleLabel.text = sectionObj.section_title;
    [self.collectionView reloadData];
    [super setData:data];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sectionObj.section_list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDHomeTileCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDHomeTileCVC" forIndexPath:indexPath];
    [cell setData:sectionObj.section_list[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate != nil) {
        [self.delegate didSelect:sectionObj.section_list[indexPath.row] ofSection:sectionObj];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(279, collectionView.frame.size.height);
}
- (IBAction)didTapSeeAllButton:(id)sender {
    if (self.delegate != nil) {
        
        [self.delegate didSelect:nil ofSection:sectionObj];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
