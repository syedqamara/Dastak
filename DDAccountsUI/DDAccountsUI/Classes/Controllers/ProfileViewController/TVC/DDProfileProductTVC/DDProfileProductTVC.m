//
//  DDProfileProductTVC.m
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDProfileProductTVC.h"
#import "DDAccountUIThemeManager.h"
#import "DDModels.h"
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>

@interface DDProfileProductTVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic) DDProfileSectionM *sectionModel;
@end

@implementation DDProfileProductTVC
@synthesize sectionModel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupCollectionView];
   
}
-(void)designUI {

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupCollectionView{
    [self.collectionView registerCellWithNibNames:@[@"DDProfileProductCVC"] forClass:self.class withIdentifiers:@[@"DDProfileProductCVC"]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)setCollectionViewLayout {
    if (sectionModel == nil) return;
    CustomViewFlowLayoutCollectionView *layout = [[CustomViewFlowLayoutCollectionView alloc] init];
    layout.itemSize = CGSizeMake(self.collectionView.frame.size.width - 32, self.collectionView.frame.size.height);
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 10.0;
    layout.offSet = 16;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.pagingEnabled = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView reloadData];
}

-(void)setData:(id)data {
    [super setData:data];
    sectionModel = (DDProfileSectionM*)data;
    [self setCollectionViewLayout];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sectionModel.section_list.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDUIThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDProfileProductCVC" forIndexPath:indexPath];
    [cell setData:sectionModel.section_list[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTapProductItem:)]) {
        [_delegate didTapProductItem:sectionModel.section_list[indexPath.item]];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

@end
