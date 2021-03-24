//
//  DDAddCustomisationTHFV.h
//  ANStepperView
//
//  Created by Syed Qamar Abbas on 30/07/2020.
//

#import "DDBaseHFV.h"
#import "DDModels.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDOrderDetailTHFVTHFVDelegate <NSObject>

-(void)didTapExpandCollapseButtonWithSection:(DDOrderStatusSectionM *)section;

@end

@interface DDOrderDetailTHFV : DDBaseHFV
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (unsafe_unretained, nonatomic) NSString *orderNumber;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) id<DDOrderDetailTHFVTHFVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
