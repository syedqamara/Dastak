//
//  DDFilterItemCVC.h
//  The Entertainer
//
//  Created by Umair on 30/01/2020.
//

#import <UIKit/UIKit.h>
#import "DDFiltersBaseCVC.h"

@protocol DDFilterItemCVCDelegate <NSObject>
-(void)showMoreTapped;
-(void)crossTapped;
@end

@interface DDFilterItemCVC : DDFiltersBaseCVC
@property (nonatomic, weak) id<DDFilterItemCVCDelegate> delegate;
@end
