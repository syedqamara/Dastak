//
//  DDAmenitiesDetailVC.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 10/03/2020.
//

#import "DDUIBaseViewController.h"
#import <DDUI/DDUI.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAmenitiesDetailVC : DDUIBaseViewController

@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong)  NSArray *amenitiesArray;

@end

NS_ASSUME_NONNULL_END
