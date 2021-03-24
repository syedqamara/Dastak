//
//  DDMDProductTVC.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 20/03/2020.
//

#import "DDBaseTVC.h"
#import <DDModels/DDModels.h>
#import "DDOutletsUIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMDProductTVC : DDBaseTVC

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *lblOfferTitle;
@property (nonatomic, weak) IBOutlet UIView *lineView;

@end

NS_ASSUME_NONNULL_END
