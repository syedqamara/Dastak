//
//  DDRedemptionBaseTVC.h
//  DDRedemptionsUI
//
//  Created by Umair on 22/04/2020.
//

#import "DDBaseTVC.h"
#import <DDAuth/DDAuth.h>
#import "DDRedemptionsUIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDRedemptionBaseTVCDelegate <NSObject>

- (void)didRedemptionActionPerformed:(NSString * _Nullable)entered_pin : (DDRedemptionType)type;

@end

@interface DDRedemptionBaseTVC : DDBaseTVC

@property (weak, nonatomic) id <DDRedemptionBaseTVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
