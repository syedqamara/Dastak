//
//  DDNormalDeliveryMenuTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 21/04/20.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>

@interface DDNormalDeliveryMenuTVC : DDBaseTVC

@property (weak, nonatomic) IBOutlet UIImageView *category_icon;
@property (weak, nonatomic) IBOutlet UILabel *menu_title;
@property (weak, nonatomic) IBOutlet UILabel *menu_description;
@property (weak, nonatomic) IBOutlet UILabel *menu_price;
@end
