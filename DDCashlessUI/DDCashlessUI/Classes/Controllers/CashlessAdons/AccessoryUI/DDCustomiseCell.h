//
//  DDCustomiseCell.h
//  The Entertainer
//
//  Created by mac on 4/2/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDModels.h"
#import "DDUI.h"

@class DDCustomiseCell;

@protocol DDCustomiseCellDelegate <NSObject>

@end

@interface DDCustomiseCell : DDBaseTVC

@property (nonatomic) NSArray<DDCashlessCustomizationOptionM> *datasource;
@property (weak, nonatomic) IBOutlet UIView *viewOverlay;
@property (nonatomic) DDCashlessItemCustomizationM *cust;
@property (nonatomic, strong) DDCashlessItemM *product;
-(void)reloadTableView;
-(CGFloat)getTableViewContentHeight;

-(UITableView *) getChildTableView;

@end
