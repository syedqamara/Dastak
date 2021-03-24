//
//  DDGamificationCommonViewController.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/8/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDUI/DDUI.h>

@interface DDGamificationCommonViewController : DDUIBaseViewController

-(void) addRefreshControlInTableView:(UITableView *) tableView;
-(void) addRefreshControlInCollectionView:(UICollectionView *) collectionView;
-(void) startRefresh:(UIRefreshControl *) control;

@end
