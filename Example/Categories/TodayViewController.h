//
//  TodayViewController.h
//  Categories
//
//  Created by Zubair Ahmad on 09/05/2020.
//

#import <UIKit/UIKit.h>
#import "DDCategoryCell.h"

@interface TodayViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) IBOutlet UICollectionView *collView;

@end
