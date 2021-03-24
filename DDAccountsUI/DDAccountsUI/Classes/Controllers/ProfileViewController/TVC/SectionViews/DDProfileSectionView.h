//
//  DDProfileSectionView.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 06/02/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDProfileSectionView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeAllButton;

@property (nonatomic, copy) void (^callBackAfterSwitchStateChange)(DDSettingsSectionListM *item, BOOL switchState);

@property(nonatomic) DDProfileSectionM *sectionItem;

-(void)setData:(id)data;

@end

NS_ASSUME_NONNULL_END
