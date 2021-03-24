//
//  DDProfileProductTVC.h
//  DDAccountsUI
//
//  Created by Syed Qamar Abbas on 27/01/2020.
//

#import "DDUIThemeTableViewCell.h"
#import "DDProfileSectionListM.h"

NS_ASSUME_NONNULL_BEGIN


@protocol DDProfileProductTVCDelegate <NSObject>
-(void)didTapProductItem : (DDProfileSectionListM*)item;
@end


@interface DDProfileProductTVC : DDUIThemeTableViewCell
@property (weak, nonatomic) id<DDProfileProductTVCDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
