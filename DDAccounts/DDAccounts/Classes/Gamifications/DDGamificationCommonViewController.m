
//
//  DDGamificationCommonViewController.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/8/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGamificationCommonViewController.h"
#import <DDCommons/DDCommons.h>

@interface DDGamificationCommonViewController (){
    UIRefreshControl *refreshControl;
}

@end

@implementation DDGamificationCommonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRefreshControl];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initRefreshControl{
    refreshControl  = [[UIRefreshControl alloc] init];
    [refreshControl setTintColor:[UIColor DDLightGrayColor]];
    [refreshControl addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}

-(void) setRefreshControlColor:(UIColor *) color{
    [refreshControl setTintColor:color];
}


-(void)addRefreshControlInTableView:(UITableView *)tableView{
    [tableView addSubview:refreshControl];
}

-(void)addRefreshControlInCollectionView:(UICollectionView *) collectionView{
    [collectionView addSubview:refreshControl];
}

-(void)startRefresh:(UIRefreshControl *)control{
    
}

@end
