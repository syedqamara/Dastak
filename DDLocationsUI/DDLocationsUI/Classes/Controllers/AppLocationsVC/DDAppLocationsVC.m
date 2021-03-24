//
//  DDAppLocationsVC.m
//  DDLocationsUI
//
//  Created by Awais Shahid on 02/03/2020.
//

#import "DDAppLocationsVC.h"
#import "DDAppLocationsTVC.h"


@interface DDAppLocationsVC () <UITableViewDelegate, UITableViewDataSource, DDDraggableNavigationControllerDelegate> {
    NSInteger selectedIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSMutableArray* locations;
@end

@implementation DDAppLocationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteDragableNavigationBar];
    [self getAppSupportedLocations];
    [self setupTableView];
    
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
    }
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

-(void)getAppSupportedLocations {
    NSArray *arrLocations = [DDLocationsManager.shared.appSupportedLocations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDLocationsM  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.active isEqualToNumber:@(1)];
    }]];
    self.locations = arrLocations.mutableCopy;
    [self setupLastSelectedIndex];
    [self.tableView reloadData];
}

-(void)setupLastSelectedIndex {
    selectedIndex = -1;
    for (DDLocationsM *loc in self.locations) {
        if ([loc.location_id isEqualToNumber:DDLocationsManager.shared.appLocation.location_id]) {
            selectedIndex = [self.locations indexOfObject:loc];
            break;
        }
    }
}

- (void)designUI {
    self.title = @"Location".localized;
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDLocationsThemeManager.shared.selected_theme.text_theme.colorValue direction:DDNavigationItemDirectionLeft];
    [self addNavigationItemWithTitle:DONE identifier:DONE tintColor:DDLocationsThemeManager.shared.selected_theme.text_theme.colorValue direction:DDNavigationItemDirectionRight];
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }
    else {
        [self saveLocation];
    }
}

-(void)saveLocation {
    if (selectedIndex < 0) selectedIndex = 0;
    DDLocationsM *selectedLocation = self.locations[selectedIndex];
    if ([selectedLocation.location_id isEqualToNumber:DDLocationsManager.shared.appLocation.location_id]) {
        [self goBackWithCompletion:nil];
        return;
    }
    
    DDLocationsManager.shared.appLocation = selectedLocation;
    [[DDLocationsManager shared] saveAppLocationInDefaults];
    [UIApplication refreshAppWithParams:nil];
    [self.navigation.routerModel sendDataCallback:nil withData:DDLocationsManager.shared.appLocation withController:self];
    [self goBackWithCompletion:nil];
}

#pragma mark - UITableView

-(void)setupTableView {
    NSArray *cells = @[AppLocationsTVC];
    [self.tableView registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 63;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locations.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDAppLocationsTVC *cell = [self.tableView dequeueReusableCellWithIdentifier:AppLocationsTVC forIndexPath:indexPath];
    DDLocationsM *location = [self.locations objectAtIndex:indexPath.row];
    [cell setData:location];
    [cell setShouldSelected:indexPath.row == selectedIndex];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedIndex) return;
    selectedIndex = indexPath.row;
    [tableView reloadData];
}


+(NSArray<DDUIRouterM *> *)deeplinkRoutes {
    DDUIRouterM *location = [[DDUIRouterM alloc]init];
    location.route_link = DD_Nav_App_Location;
    location.should_embed_in_nav = YES;
    location.transition = DDUITransitionPresentWithPan2;
    return @[location];
}



@end
