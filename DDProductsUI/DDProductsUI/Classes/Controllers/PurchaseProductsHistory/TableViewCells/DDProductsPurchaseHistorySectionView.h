//
//  DDProductsPurchaseHistorySectionView.h
//  DDProductsUI
//
//  Created by M.Jabbar on 26/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDProductsPurchaseHistorySectionView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeAllButton;
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;

@property(nonatomic) DDProductPurchaseSectionM *sectionItem;

-(void)setData:(id)data;

@end

NS_ASSUME_NONNULL_END
