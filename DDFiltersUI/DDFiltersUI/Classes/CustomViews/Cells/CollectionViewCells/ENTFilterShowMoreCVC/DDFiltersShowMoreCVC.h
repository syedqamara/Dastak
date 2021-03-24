//
//  DDTRShowMoreCollectionViewCell.h
//  The Entertainer
//
//  Created by Raheel on 23/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDFiltersBaseCVC.h"

@interface DDFiltersShowMoreCVC : DDFiltersBaseCVC



-(void) changeLayoutForCusines;
-(void) changeLayout;

-(void) setSelectedCellLayout:(NSString *) text;
-(void) setUnSelectedCellLayout;

@end
