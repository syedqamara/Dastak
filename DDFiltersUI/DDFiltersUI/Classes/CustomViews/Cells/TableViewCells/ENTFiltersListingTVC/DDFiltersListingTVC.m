//
//  DDFiltersListingTVC.m
//  The Entertainer
//
//  Created by Raheel on 22/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDFiltersListingTVC.h"
#import "DDFiltersOptionsVC.h"
#import "DDFiltersShowMoreCVC.h"
#import "DDFilterItemCVC.h"
#import "DDFilterRadioItemCVC.h"


@interface DDCustomViewFlowLayout : UICollectionViewFlowLayout
@end

@implementation DDCustomViewFlowLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    CGFloat leftMargin = self.sectionInset.left;
    CGFloat maxY = -1.0f;
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        if (attribute.frame.origin.y >= maxY) {
            leftMargin = self.sectionInset.left;
        }
        attribute.frame = CGRectMake(leftMargin, attribute.frame.origin.y, attribute.frame.size.width, attribute.frame.size.height);
        leftMargin += attribute.frame.size.width + self.minimumInteritemSpacing;
        maxY = MAX(CGRectGetMaxY(attribute.frame), maxY);
    }
    return attributes;
}
@end


@interface DDFiltersListingTVC()<DDFilterItemCVCDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    int selectedFiltersCount;
}

@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *sectionImg;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewH;

@property (nonatomic, strong) DDFiltersSectionM *filterSection;

@end

@implementation DDFiltersListingTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupCollectionView];
}

#pragma mark - Other

- (void)setData:(id)data{
    if (![data isKindOfClass:[DDFiltersSectionM class]]) return;
    self.filterSection = data;
    [self.sectionImg loadImageWithString:self.filterSection.image_url forClass:self.class];
    self.sectionImg.hidden = self.filterSection.image_url.length == 0;
    self.sectionTitleLbl.text = self.filterSection.section_title;
    self.separatorView.hidden = self.filterSection.type != DDFilterTypeRadio;
    [self.collectionView reloadData];
    self.collectionViewH.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    [super setData:data];
    
}

- (void)designUI{
    self.sectionTitleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.sectionTitleLbl.font = [UIFont DDBoldFont:20];
}


#pragma mark - CollectionView

-(void)setupCollectionView {
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSArray *identifiers = @[FilterRadioItemCVC, FilterItemCVC, FiltersShowMoreCVC];
    [self.collectionView registerCellWithNibNames:identifiers forClass:self.class withIdentifiers:identifiers];
    
    DDCustomViewFlowLayout *layout = (DDCustomViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.scrollEnabled = false;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.filterSection.itemsToDisplayCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DDFiltersOptionM* option = [self optionAtIndexPath:indexPath];
    if (self.filterSection.type == DDFilterTypeRadio) {
        DDFilterRadioItemCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterRadioItemCVC forIndexPath:indexPath];
        [cell setData:option];
        return cell;
    }
    else if (self.filterSection.type == DDFilterTypeTags) {
        DDFilterItemCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterItemCVC forIndexPath:indexPath];
        if (!option.isShowMoreCell) option.image_url = @"filter_cross.png";
        [cell setData:option];
        [cell setDelegate:self];
        return cell;
    }
    return [UICollectionViewCell new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat h = 40;
    CGFloat w = 40;
    
    DDFiltersOptionM *option = [self optionAtIndexPath:indexPath];
    if (self.filterSection.type == DDFilterTypeRadio) {
        w = [option.title getWidthwithHeight:h font:[UIFont DDRegularFont:17]];
        CGFloat icon_space = 20 + 10;
        w = w + icon_space + 15;
    }
    else {
        w = [option.title getWidthwithHeight:h font:[UIFont DDMediumFont:15]] + 25;
        if (option.isShowMoreCell) {
            if (option.title.length == 0) {
                w = 40;
            }
        }
        else {
            if (option.isSelected) {
                CGFloat space_icon = 8 + 10;
                w = w + space_icon;
            }
        }
    }
    return  CGSizeMake(w, h);
}

-(DDFiltersOptionM*)optionAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.filterSection showMoreButtonIndex:indexPath.item]) {
        return [self.filterRequest getShowMoreOptionFor:self.filterSection];
    }
    return  [self.filterSection.options objectAtIndex:indexPath.item];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDFiltersOptionM *option = [self optionAtIndexPath:indexPath];
    if (self.filterSection.type == DDFilterTypeRadio) {
        [self.filterSection resetSelectedRadioOption];
        [option toggleSelection];
    }
    else if (self.filterSection.type == DDFilterTypeTags) {
        if ([self.filterSection showMoreButtonIndex:indexPath.item]) {
            [self showMoreTapped];
            return;
        }
        if (option.isSelected) {
            return;
        }
        [option toggleSelection];
    }
    [self reloadCollectionView];
}



-(void)didSelectFilters:(NSMutableArray *)dataArray{
//    [self updateMoreCount];
}

-(void) updateMoreCount{
//    selectedFiltersCount = [DDFiltersManager getSelectedFiltersCountInList:self.filtersObject.options itemToShow:self.numberOfItemsToShow];
//    [self.collectionView reloadData];
//    [self updateSuperViewCellHeight];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.collectionView reloadData];
//    });
}

-(void)updateSuperViewCellHeight {
//    [UIView performWithoutAnimation:^{
//        UITableView *tbl = (UITableView *)self.superview;
//        [tbl beginUpdates];
//        self.constCollectionViewHeight.constant = CGFLOAT_MAX;
//        [self.collectionView reloadData];
//        [self.collectionView layoutIfNeeded];
//        [self layoutIfNeeded];
//
//
//        self.constCollectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
//        [self layoutIfNeeded];
//        [tbl endUpdates];
//    }];
}

#pragma mark - other
- (void)showMoreTapped {
    __weak typeof(self) weakSelf = self;
    [DDFilterUIManager.shared showFilterOptionsVCFrom:[UIApplication topMostController] withData:self.filterSection andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        [weakSelf reloadCollectionView];
    }];
}

- (void)crossTapped {
    [self reloadCollectionView];
}

-(void)reloadCollectionView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshFilters)]) {
        [self.delegate refreshFilters];
        return;
    }
    
    
    // Reason: when collection rows changing form 2->3 or vice versa height is not being adjusted
    if ([self.superview isKindOfClass:[UITableView class]]) {
        [(UITableView*)self.superview reloadData];
    }
    else {
        [self.collectionView reloadData];
        self.collectionViewH.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    }
}

@end
