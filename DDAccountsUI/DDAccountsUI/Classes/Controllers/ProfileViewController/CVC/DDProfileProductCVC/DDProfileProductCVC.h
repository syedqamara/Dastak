//
//  DDProfileProductCVC.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 03/02/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDProfileProductCVC : DDUIThemeCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *amountLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *discountLabel;

@end

NS_ASSUME_NONNULL_END
