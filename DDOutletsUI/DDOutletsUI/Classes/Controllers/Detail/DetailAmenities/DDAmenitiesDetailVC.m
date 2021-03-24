//
//  DDAmenitiesDetailVC.m
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 10/03/2020.
//

#import "DDAmenitiesDetailVC.h"
#import "DDAmenitiesDetailTVC.h"
#import "DDOutletsUIConstants.h"

@interface DDAmenitiesDetailVC ()<UITableViewDelegate,UITableViewDataSource>{
   
}

@end

@implementation DDAmenitiesDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Amenities".localized;
    [self setThemeNavigationBar];
    _amenitiesArray = [[NSArray alloc] initWithArray:(NSArray*)self.navigation.routerModel.data];
    [self setUpTableView];
}

- (void) setUpTableView {
    
    NSArray *tableCells = @[DDAmenitiesDetailTableViewCell];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 100.0;
    [self.tblView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDAmenitiesDetailTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDAmenitiesDetailTableViewCell forIndexPath:indexPath];
    [cell setData:[self.amenitiesArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.amenitiesArray.count;
}



@end
