//
//  DDMerchantDetailModulesTVC.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 04/03/2020.
//

#import "DDBaseTVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMerchantDetailModulesTVCDelegate  <NSObject>

-(void)didTapOnModuleItem : (NSInteger)index;
@end

@interface DDMerchantDetailModulesTVC : DDBaseTVC

@property (weak, nonatomic) id<DDMerchantDetailModulesTVCDelegate> delegate;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *contentView1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *categoryImage1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *accessoryIcon1;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contentViewBtn1;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *contentView2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *categoryImage2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *titleLabel2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *accessoryIcon2;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *contentViewBtn2;



@end

NS_ASSUME_NONNULL_END
