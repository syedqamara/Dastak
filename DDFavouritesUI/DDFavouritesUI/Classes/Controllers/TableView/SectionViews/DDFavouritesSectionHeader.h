//
//  DDFavouritesSectionHeader.h
//  DDFavouritesUI
//
//  Created by M.Jabbar on 06/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDFavouritesSectionHeader : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeAllButton;
@property(nonatomic) DDFavouritesSectionM *sectionItem;

@property (nonatomic, copy) void (^expandColapsedButtonTapped)(NSInteger sectionTag);

-(void)setData:(id)data;

@end

NS_ASSUME_NONNULL_END
