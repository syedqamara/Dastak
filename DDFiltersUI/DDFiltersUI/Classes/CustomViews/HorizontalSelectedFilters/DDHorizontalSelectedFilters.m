//
//  DDHorizontalSelectedFilters.m
//  DDFiltersUI
//
//  Created by Awais Shahid on 02/04/2020.
//

#import "DDHorizontalSelectedFilters.h"
#import "DDFiltersUIConstants.h"
#import "DDFilterOptionCVC.h"

@interface DDHorizontalSelectedFilters () <UICollectionViewDelegate, UICollectionViewDataSource, DDFilterOptionCVCDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, copy) IntCompletionCallBack crossedAt;

@end


@implementation DDHorizontalSelectedFilters

+ (DDHorizontalSelectedFilters*)showAndReturnInConatiner:(UIView *)container withDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt{
    DDHorizontalSelectedFilters *view = [DDHorizontalSelectedFilters nibInstanceOfClass:DDHorizontalSelectedFilters.class];
    view.frame = container.bounds;
    [container addSubview:view];
    [view setDataSource:dataSource crossedAt:crossedAt];
    [view layoutIfNeeded];
    return view;
}

+ (void)showInConatiner:(UIView *)container withDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt{
    DDHorizontalSelectedFilters *view = [DDHorizontalSelectedFilters nibInstanceOfClass:DDHorizontalSelectedFilters.class];
    view.frame = container.bounds;
    [container addSubview:view];
    [view setDataSource:dataSource crossedAt:crossedAt];
    [view layoutIfNeeded];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCollectionView];
}

- (void)setDataSource:(NSArray*)dataSource crossedAt:(IntCompletionCallBack)crossedAt {
    self.itemList = dataSource.mutableCopy;
    [self.collectionView reloadData];
    self.crossedAt = crossedAt;
}

- (void)designUI {
    
}


#pragma mark - CollectionView
-(void)setupCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerCellWithNibNames:@[FilterOptionCVC] forClass:DDFilterOptionCVC.class withIdentifiers:@[FilterOptionCVC]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDFilterOptionCVC *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:FilterOptionCVC forIndexPath:indexPath];
    DDFiltersOptionM *filterOption = [self.itemList objectAtIndex:indexPath.item];
    [cell setData:filterOption];
    [cell setIndexPath:indexPath];
    [cell setDelegate:self];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDFiltersOptionM *filterOption = [self.itemList objectAtIndex:indexPath.item];
    CGFloat w = filterOption.title.getWidt + 34;
    return  CGSizeMake(w, self.collectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 16, 0, 16);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.01;
}


#pragma makr - DDFilterOptionCVCDelegate

- (void)crossedAtIndex:(NSIndexPath *)indexPath {
    DDFiltersOptionM *option = [self.itemList objectAtIndex:indexPath.item];
    [option toggleSelection];
    [self.itemList removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
    if (self.crossedAt) {
        self.crossedAt((int)indexPath.item);
    }
}

@end
