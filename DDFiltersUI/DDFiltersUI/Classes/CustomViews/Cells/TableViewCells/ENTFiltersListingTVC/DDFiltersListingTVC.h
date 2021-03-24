//
//  DDFiltersListingTVC.h
//  The Entertainer
//
//  Created by Raheel on 22/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDFiltersBaseTVC.h"
#import "DDFiltersScreenRequestM.h"

@protocol DDFiltersListingTVCDelegate <NSObject>
-(void)refreshFilters;
@end

@interface DDFiltersListingTVC : DDFiltersBaseTVC
@property (weak, nonatomic) DDFiltersScreenRequestM *filterRequest;
@property (nonatomic, weak) id<DDFiltersListingTVCDelegate> delegate;
@end
