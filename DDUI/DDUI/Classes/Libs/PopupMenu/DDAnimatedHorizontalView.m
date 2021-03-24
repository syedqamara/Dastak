//
//  DDAnimatedHorizontalView.m
//  dynamicdelivery_Example
//
//  Created by Syed Qamar Abbas on 06/02/2020.
//  Copyright © 2020 etDev24. All rights reserved.
//

#import "DDAnimatedHorizontalView.h"
#import "DDCollectionViewCell.h"
#import "UICollectionView+DDRegistration.h"


@interface DDAnimatedHorizontalView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation DDAnimatedHorizontalView
@synthesize collectionView;
-(instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initializeCollectionView];
    return self;
}
-(instancetype)init {
    self = [super init];
    [self initializeCollectionView];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initializeCollectionView];
    return self;
}

-(void)initializeCollectionView {
    self.layer.cornerRadius = 5;
    [self setClipsToBounds:YES];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout.alloc init];
    [layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    collectionView.backgroundColor = UIColor.clearColor;
    [self addSubview:collectionView];
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    [collectionView registerCellWithNibNames:@[@"DDCollectionViewCell"] forClass:self.class withIdentifiers:@[@"DDCollectionViewCell"]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeLeading) multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:(NSLayoutAttributeTrailing) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTrailing) multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:(NSLayoutAttributeTop) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeTop) multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:collectionView attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self attribute:(NSLayoutAttributeBottom) multiplier:1.0 constant:0]];
    [collectionView setHidden:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DDCollectionViewCell" forIndexPath:indexPath];
    cell.imageName = self.dataSource[indexPath.row].categoryImage;
    cell.index = indexPath.row;
    cell.title = self.dataSource[indexPath.row].categoryName;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didTapOnItem:)]) {
        [_delegate didTapOnItem:indexPath.row];
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = collectionView.frame.size;
    size.width = size.width/5;
    return size;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}
-(void)reload {
    [collectionView setHidden:NO];
    [collectionView reloadData];
}
-(void)reset {
    [collectionView setHidden:YES];
}
@end


