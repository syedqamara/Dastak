//
//  DDRedemptionsUIManager.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import <Foundation/Foundation.h>
#import <DDRedemptions/DDRedemptions.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDRedemptionsUIManager : NSObject

typedef NS_ENUM(NSUInteger, DDRedemptionType) {
    DDRedemptionTypePinEntry,
    DDRedemptionTypePinless,
    DDRedemptionTypePurchase,
    DDRedemptionTypeSwipe
};

+(DDRedemptionsUIManager *)shared;
-(void)goToAnotherViewController:(UIViewController *)controller routeLink :(NSString*)routeLink onCompletion: (void (^)(void))completion;

-(void) openRedemptionCompletedVCFrom:(UIViewController*)controller withOfferViewModel : (DDMerchantOffersLocalDataM*) viewModel andControllerCallBack:(ControllerCallBack)controllerCallBack;

@end

NS_ASSUME_NONNULL_END
