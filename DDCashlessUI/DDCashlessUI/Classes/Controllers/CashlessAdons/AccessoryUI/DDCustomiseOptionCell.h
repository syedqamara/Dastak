//
//  DDCustomiseOptionCell.h
//  The Entertainer
//
//  Created by apple on 5/31/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDModels.h"
#import "DDUI.h"

@class DDCustomiseOptionCell;

typedef NS_ENUM(NSUInteger, DDCustomiseType)  {
    DDCustomiseTypeAdOns = 0,
    DDCustomiseTypeUpgrade = 1,
};
typedef NS_ENUM(NSUInteger, DDCustomiseOption)  {
    DDCustomiseOptionAdd = 0,
    DDCustomiseOptionRemove = 1,
};

@protocol DDCustomiseOptionCellDelegate <NSObject>
-(void)cellSelectedTheCustomizationOption:(DDCustomiseOption)option withType:(DDCustomiseOption)type atIndexPath: (NSIndexPath *)indexPath withSubItem:(DDCashlessItemCustomizationOptionItemM *)subItem isMultipleSelectionAllowed:(BOOL)allowMultipleSelection;
@end

@interface DDCustomiseOptionCell : DDBaseTVC
@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImageView;

@property (weak, nonatomic) IBOutlet UIView *checkMarkView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (nonatomic) DDCashlessItemCustomizationOptionItemM *optionItem;
@property (strong,nonatomic) DDCashlessCustomizationOptionM *option;
@property (nonatomic, weak) NSString *productName;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL allowMultipleSelection;
@property (assign, nonatomic) DDCustomiseType type;
@property (nonatomic, weak) NSString *productPrice;
@property (nonatomic, weak) NSIndexPath *indexPath;
@property (weak, nonatomic) id<DDCustomiseOptionCellDelegate> delegate;

- (void)setupData;

@end
