//
//  DDBaseHistoryVC.h
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDUIBaseViewController.h"
#import <DDModels/DDModels.h>
#import "DDRedemptionsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseHistoryVC : DDUIBaseViewController <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *filteredArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *monthCollectionView;


-(void)setdata:(DDBaseHistoryModel*)data;
-(void)registerCells;

@end

NS_ASSUME_NONNULL_END
