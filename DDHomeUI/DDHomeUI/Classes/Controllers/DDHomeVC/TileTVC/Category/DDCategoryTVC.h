//
//  DDCategoryTVC.h
//  DDHomeUI
//
//  Created by Syed Qamar Abbas on 28/06/2020.
//

#import "DDBaseTVC.h"
#import "DDHomeThemeManager.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDCategoryTVCDelegate <NSObject>
-(void)didSelect:(DDHomeSectionListM *)category ofSection:(DDHomeSectionM *)sectionM;
@end

@interface DDCategoryTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) id<DDCategoryTVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
