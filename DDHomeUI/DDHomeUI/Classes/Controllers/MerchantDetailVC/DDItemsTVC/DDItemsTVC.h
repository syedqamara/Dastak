//
//  DDItemsTVC.h
//  Appboy-iOS-SDK
//
//  Created by Syed Qamar Abbas on 27/07/2020.
//

#import "DDBaseTVC.h"
#import "ANStepperView.h"
#import "DDMerchantDeliveryMenuItemM.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, DDItemModification){
    DDItemModificationAdd,
    DDItemModificationRemove,
    DDItemModificationAddNone,
};
@class DDItemsTVC;

@protocol DDItemsTVCDelegate <NSObject>
-(void)didSelectItem:(DDMerchantDeliveryMenuItemM *)item withModificationType:(DDItemModification)type  forCell:(DDItemsTVC *)cell;
@end

@interface DDItemsTVC : DDBaseTVC <ANStepperViewDelegate>
@property (weak, nonatomic) IBOutlet ANStepperView *stepper;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageURL;
@property (weak, nonatomic) id<DDItemsTVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
