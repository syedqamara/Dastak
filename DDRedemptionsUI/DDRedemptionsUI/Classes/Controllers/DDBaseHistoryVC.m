//
//  DDBaseHistoryVC.m
//  DDRedemptionsUI
//
//  Created by Hafiz Aziz on 12/02/2020.
//

#import "DDBaseHistoryVC.h"
#import "DDBaseHistoryMenuCollectionCell.h"
#import "DDMonthsData+DDCalendarComponent.h"
#import "DDRedemptionsThemeManager.h"
#import "DDReservationTVC.h"
#import "DDRedemptionTVC.h"

@interface DDBaseHistoryVC () {
    NSMutableArray *monthDataArray,*monthMenuArray;
    NSInteger selectedIndex;
}

@property (weak, nonatomic) IBOutlet UIView *summaryConatiner;
@property (weak, nonatomic) IBOutlet UILabel *totalNumber_label;
@property (weak, nonatomic) IBOutlet UILabel *totalDescription_label;
@property (weak, nonatomic) IBOutlet UIView *seprator_view;

@end

@implementation DDBaseHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedIndex = 0;
    [self registerCells];
    self.summaryConatiner.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setThemeNavigationBar];
}

-(void)registerCells{
    NSArray *collectionCells = @[DDRedemptionHistoryMenuCollectionCell];
    NSArray *tableCells = @[DDReservationHistoryTableCell,DDRedemptionHistoryTableCell];
    [self.mainTableView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    [self.monthCollectionView registerCellWithNibNames:collectionCells forClass:self.class withIdentifiers:collectionCells];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.monthCollectionView.dataSource = self;
    self.monthCollectionView.delegate = self;
    
    self.mainTableView.estimatedRowHeight = 100;
    self.mainTableView.rowHeight = UITableViewAutomaticDimension;
    
}
-(void)designUI{
    self.totalNumber_label.text = nil;
    self.totalDescription_label.text = nil;
    self.monthCollectionView.backgroundColor = DDRedemptionsThemeManager.shared.selected_theme.app_header_messageBG.colorValue;
    self.seprator_view.backgroundColor = DDRedemptionsThemeManager.shared.selected_theme.border_grey_227.colorValue;
    self.totalNumber_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.totalDescription_label.textColor = DDRedemptionsThemeManager.shared.selected_theme.text_black.colorValue;
    self.totalDescription_label.font = [UIFont DDRegularFont:13];
    self.totalNumber_label.font = [UIFont DDBoldFont:20];
}

-(void)setdata:(DDBaseHistoryModel*)data {
    if (data.month_wise_redemmptions.count) {
        monthDataArray = [[NSMutableArray alloc] initWithArray:data.month_wise_redemmptions];
        self.totalNumber_label.text = [NSString stringWithFormat:@"%d",(int)[data.total_redemptions integerValue]];
        self.totalDescription_label.text = [NSString stringWithFormat:@"Total redemptions in %@".localized,data.current_year];
    }
    else if (data.month_wise_reservations.count){
        monthDataArray = [[NSMutableArray alloc] initWithArray:data.month_wise_reservations];
         self.totalNumber_label.text = [NSString stringWithFormat:@"%d",(int)[data.total_reservations integerValue]];
        self.totalDescription_label.text = [NSString stringWithFormat:@"%@",data.current_year];
        self.totalDescription_label.text = [NSString stringWithFormat:@"Total reservations in %@".localized,data.current_year];
    }
    else if (data.month_wise_orders.count){
//        NSString *currentYear = data.current_year;
//        NSArray *tempArray = [data.month_wise_orders filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDOrderHistoryDataM  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//            return [evaluatedObject.month containsString:currentYear];
//        }]];
        monthDataArray = [[NSMutableArray alloc] initWithArray:data.month_wise_orders];
        NSInteger totalOrders = 0;
        for (DDOrderHistoryDataM* monthsData in monthDataArray){
            totalOrders = totalOrders + monthsData.deliveries_count.integerValue;
        }
        self.totalNumber_label.text = [NSString stringWithFormat:@"%ld",(long)totalOrders];
        self.totalDescription_label.text = [NSString stringWithFormat:@"%@",data.current_year];
        self.totalDescription_label.text = [NSString stringWithFormat:@"Total Online orders in %@".localized,data.current_year];
    }
    if (monthDataArray.count >0){
        DDMonthsData *tempData = monthDataArray.lastObject;
        monthMenuArray = [[NSMutableArray alloc]initWithArray:[tempData getCalendarMonthsArray:tempData.month]];
        [self getCurrentSelectedIndex];
        [self.monthCollectionView reloadData];
                
        NSIndexPath *indexPath = [self getSelectedIndexOfYear];
        [self.monthCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
    }
    self.summaryConatiner.hidden = monthDataArray.count == 0;
    [self.mainTableView reloadData];
}
//MARK: - Table Delegate and DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}
//MARK: - CollectionView Delegate and DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDBaseHistoryMenuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DDRedemptionHistoryMenuCollectionCell forIndexPath:indexPath];
    
    [cell setData:monthDataArray :monthMenuArray[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return monthMenuArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self resetSelectedMonthArray:[self getMonthObjFromMainArray:indexPath]];
    // get the selected month because we don't have sorted array all the time so we don't have specific object all the time
    [self.monthCollectionView reloadData];
    [self.mainTableView reloadData];
}

// MARK: - Utility Methods for Menu Collections

-(void)resetSelectedMonthArray:(DDMonthsData*)selectedMonth{
    for (DDMonthsData *monthObj in monthDataArray) {
        monthObj.is_selected = @(0);
    }
    
    if (selectedMonth) {
        selectedMonth.is_selected = @(1);
        [monthDataArray replaceObjectAtIndex:selectedIndex withObject:selectedMonth];
        if ([[monthDataArray objectAtIndex:selectedIndex] isKindOfClass:DDReservationDataModel.class]){
            DDReservationDataModel *dataObj = [monthDataArray objectAtIndex:selectedIndex];
            self.filteredArray = [[NSMutableArray alloc] initWithArray:dataObj.reservations];
        }else if ([[monthDataArray objectAtIndex:selectedIndex] isKindOfClass:DDRedemptionDataModel.class]){
            DDRedemptionDataModel *dataObj = [monthDataArray objectAtIndex:selectedIndex];
            self.filteredArray = [[NSMutableArray alloc] initWithArray:dataObj.redemptions];
        }
        else if ([[monthDataArray objectAtIndex:selectedIndex] isKindOfClass:DDOrderHistoryDataM.class]){
            DDOrderHistoryDataM *dataObj = [monthDataArray objectAtIndex:selectedIndex];
            self.filteredArray = [[NSMutableArray alloc] initWithArray:dataObj.orders];
        }
    }
    
    
}
-( DDMonthsData * _Nullable )getMonthObjFromMainArray:(NSIndexPath *)selectedIndexPath{
    NSString *monthStr = [[[monthMenuArray objectAtIndex:selectedIndexPath.item] componentsSeparatedByString:@" "] firstObject];
    NSDateComponents *dc1 = [DDExtraUtil getCalendarCopmonetFromLocale:monthStr :@"MM"];
    if (dc1 == nil){
        dc1= [DDExtraUtil getCalendarCopmonetFromLocale:[monthMenuArray objectAtIndex:selectedIndexPath.row] :@"MM yyyy"];
    }
    NSInteger month = [dc1 month];
    
    return [self getSelectedMonthObjAndIndex:month];
}
-(DDMonthsData * _Nullable)getSelectedMonthObjAndIndex:(NSInteger)month{
    for (int i = 0; i < monthDataArray.count; i++) {
        DDMonthsData * monthObj = [monthDataArray objectAtIndex:i];
        NSDateComponents *dc2 = [DDExtraUtil getCalendarCopmonetFromLocale:monthObj.month :@"yyyy MMM"];
        if (month == [dc2 month]) {
            selectedIndex = i;
            return monthObj;
        }
        
    }
    return [monthDataArray objectAtIndex:0];
}
-(void)getCurrentSelectedIndex{
    NSDate *cdate = [NSDate date];
    NSInteger currentMonth =  cdate.month;
    [self resetSelectedMonthArray:[self getSelectedMonthObjAndIndex:currentMonth]];
}


-(NSIndexPath*)getSelectedIndexOfYear {
    for (DDMonthsData *monthObj in monthDataArray) {
        if (monthObj.isSelected) {
            NSInteger index = 0;
            for (NSString *monthStr in monthMenuArray) {
                for (NSString *str in [monthObj.month componentsSeparatedByString:@" "]) {
                    if ([str containsString:monthStr])
                        return [NSIndexPath indexPathForRow:index inSection:0];
                }
                index+=1;
            }
        }
    }
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

@end
