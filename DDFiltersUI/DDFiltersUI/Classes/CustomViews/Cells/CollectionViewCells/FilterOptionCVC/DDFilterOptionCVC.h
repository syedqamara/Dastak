//
//  DDFilterOptionCVC.h
//  DDFiltersUI
//
//  Created by Awais Shahid on 02/04/2020.
//

#import "DDFiltersBaseCVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDFilterOptionCVCDelegate <NSObject>
-(void)crossedAtIndex:(NSIndexPath*)indexPath;
@end

@interface DDFilterOptionCVC : DDFiltersBaseCVC
@property (weak, nonatomic) id<DDFilterOptionCVCDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
