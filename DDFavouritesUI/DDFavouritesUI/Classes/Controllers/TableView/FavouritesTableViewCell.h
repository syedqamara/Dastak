//
//  FavouritesTableViewCell.h
//  DDFavourites
//
//  Created by M.Jabbar on 03/03/2020.
//

#import <UIKit/UIKit.h>
#import "DDFavouritesBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavouritesTableViewCell : DDFavouritesBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cousinesLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (nonatomic, copy) void (^callBackFavourite)(FavouritesTableViewCell *cell);
@property (nonatomic, copy) void (^callBackShare)(FavouritesTableViewCell *cell);

-(void)setData:(id)data;


@end

NS_ASSUME_NONNULL_END
