//
//  DDTravelDestinationsVC.m
//  theDDERTAINER_Example
//
//  Created by Zubair Ahmad on 31/03/2020.
//

#import "DDTravelDestinationsVC.h"
#import "DDTravelDestinationsTHFV.h"
#import "DDTravelDestinationsTVC.h"
#import "DDAuth/DDAuth.h"

@interface DDTravelDestinationsVC () <UITableViewDelegate, UITableViewDataSource, DDDraggableNavigationControllerDelegate>
{
    NSIndexPath *selectedIndex;
    NSMutableArray* countries;
    NSMutableOrderedSet *headers;
}
@end

@implementation DDTravelDestinationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteDragableNavigationBar];
    countries = [NSMutableArray new];
    headers = [NSMutableOrderedSet orderedSet];
    [self setUpTableView];
    
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDUIThemeManager.shared.selected_theme.app_theme.colorValue direction:DDNavigationItemDirectionLeft];
    
    [self addNavigationItemWithTitle:DONE identifier:DONE tintColor:DDUIThemeManager.shared.selected_theme.app_theme.colorValue direction:DDNavigationItemDirectionRight];
    
    self.title = @"Destinations".localized;
    
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
    }
}

- (void)  viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (countries.count <= 0){
        [self loadData];
    }
    [self.tblView reloadData];
}

-(void)isdragableViewPresentedInFullScreen:(BOOL)fullScreen {
    DDNavigationItem *cencel = [self navigationItemWithIdentifier:CANCEL];
    DDNavigationItem *done = [self navigationItemWithIdentifier:DONE];
    if (fullScreen){
        [self setThemeNavigationBar];
        cencel.tintColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
        done.tintColor = DDUIThemeManager.shared.selected_theme.text_white.colorValue;
    }else{
        [self setWhiteDragableNavigationBar];
        cencel.tintColor = DDUIThemeManager.shared.selected_theme.text_theme.colorValue;
        done.tintColor = DDUIThemeManager.shared.selected_theme.text_theme.colorValue;
    }
}


- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }
    if ([sender.identifier isEqualToString:DONE]) {
        if (selectedIndex) {
            [self goBackWithCompletion:^{
                NSDictionary * locationDic = [countries objectAtIndex:selectedIndex.section];
                DDCountryM* location=[[locationDic valueForKey:@"countries"] objectAtIndex:selectedIndex.row];
                self.navigation.routerModel.callback(location.shortname, nil, self);
            }];
        }
    }
}

- (void) setUpTableView {
    
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"DDTravelDestinationsTHFV" bundle:nil] forHeaderFooterViewReuseIdentifier:@"DDTravelDestinationsTHFV"];
    [self.tblView registerNib:[UINib nibWithNibName:@"DDTravelDestinationsTVC" bundle:nil] forCellReuseIdentifier:@"DDTravelDestinationsTVC"];
   
    self.tblView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    self.tblView.sectionHeaderHeight = 50;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 150.0;
}


-  (void) loadData {
    DDBaseRequestModel *mdl = [[DDBaseRequestModel alloc] init];
    mdl.custom_parameters = @{@"istravel":@"true"}.mutableCopy;
    [[DDUserManager shared] loadDestinationCountryListForTravel:mdl showLoader:YES andCompletion:^(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        DDTravelCountryAPIM * countryM  =  (DDTravelCountryAPIM*)model;
        if (countryM.data.countries != nil){
            [self processData:countryM.data.countries];
        }
    }];
}

-(void) processData : (NSArray*) array {
    [countries removeAllObjects];
    [headers removeAllObjects];
    
    if (array && array.count){
        for (DDCountryM *location in array) {
            [headers addObject:location.region];
        }
        for (NSString *header in headers) {
            NSMutableArray* tempArray = [NSMutableArray array];
            
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
            NSArray *results = [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
            
            
            for (DDCountryM *location in results) {
                if([location.region isEqualToString:header])
                    [tempArray addObject:location];
#warning add deeplink handling with below method
//                [self goDeeplink:location];
            }
            [countries addObject:@{@"headerTitle":header,@"countries":tempArray}];
        }
    }
    [self.tblView reloadData];
}

#pragma mark - UI-TABLE-VIEW

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return countries.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!countries)
        return 0;

    NSDictionary * locationDic = [countries objectAtIndex:section];
    return [[locationDic valueForKey:@"countries"]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary * locationDic = [countries objectAtIndex:section];
    DDTravelDestinationsTHFV *view = [self.tblView dequeueReusableHeaderFooterViewWithIdentifier:@"DDTravelDestinationsTHFV"];
    [view setData:[locationDic valueForKey:@"headerTitle"]];
    return view;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DDTravelDestinationsTVC *cell = [tableView dequeueReusableCellWithIdentifier:@"DDTravelDestinationsTVC"];
    
    NSDictionary * locationDic = [countries objectAtIndex:indexPath.section];
    DDCountryM* location=[[locationDic valueForKey:@"countries"] objectAtIndex:indexPath.row];
    [cell setData:location];
    if (selectedIndex == indexPath){
        [cell.selectionImgV setImage:[UIImage imageNamed:@"tickedCircle"]];
    }else{
        [cell.selectionImgV setImage:[UIImage imageNamed:@"blankCircle"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = indexPath;
    [self.tblView reloadData];
}
@end

