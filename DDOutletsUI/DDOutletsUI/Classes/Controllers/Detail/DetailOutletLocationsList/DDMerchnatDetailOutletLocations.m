//
//  DDMerchnatDetailOutletLocations.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDMerchnatDetailOutletLocations.h"
#import "DDOutletsUIConstants.h"
#import "DDOutletsThemeManager.h"
#import "DDMerchantDetailOutletLocationTVC.h"
#import "DDLocationsManager.h"

@interface DDMerchnatDetailOutletLocations ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, DDDraggableNavigationControllerDelegate> {
   
    __weak IBOutlet UIView *selectedView;
    NSMutableArray *filteredArray;
    NSMutableArray *sortedArray;
    
}
@property (strong, nonatomic) DDMerchantOutletLocationViewM *OutletLocationObj;

@end

@implementation DDMerchnatDetailOutletLocations


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Are you here?".localized;
    filteredArray = [[NSMutableArray alloc] init];
    sortedArray = [[NSMutableArray alloc] init];
    self.OutletLocationObj = self.navigation.routerModel.data;
    [self setWhiteDragableNavigationBar];
    [self setUpTableView];
    [self setupSelectedOutlet];
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
        [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
    }
}

- (void)designUI{
    selectedView.backgroundColor = [DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue colorWithAlphaComponent:0.10];
    self.outletLocation.font = [UIFont DDBoldFont:15];
    self.outletLocation.textColor = DDOutletsThemeManager.shared.selected_theme.text_black_40.colorValue;
    self.cuisineType.font = [UIFont DDMediumFont:13];
    self.cuisineType.textColor = DDOutletsThemeManager.shared.selected_theme.text_cuisineType.colorValue;
    self.merchantLogo.layer.cornerRadius = 12.0;
    self.merchantLogo.clipsToBounds = TRUE;
    self.merchantLogo.contentMode = UIViewContentModeScaleAspectFill;
    self.searchBGView.layer.cornerRadius = 12.0;
    self.searchBGView.layer.borderWidth = 1.0;
    self.searchBGView.layer.borderColor = [DDOutletsThemeManager.shared.selected_theme.bg_grey_199.colorValue CGColor];
    self.searchBGView.clipsToBounds = TRUE;
    self.search_imageView.image = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"icSearch"];
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue direction:DDNavigationItemDirectionLeft];
}


-(void)isdragableViewPresentedInFullScreen:(BOOL)fullScreen {
     DDNavigationItem *item = [self navigationItemWithIdentifier:CANCEL];
    if (fullScreen){
        [self setThemeNavigationBar];
        item.tintColor = DDOutletsThemeManager.shared.selected_theme.text_white.colorValue;
    }else{
        [self setWhiteDragableNavigationBar];
        item.tintColor = DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue;
    }
}


- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }
}

-(void)setupSelectedOutlet {
    NSUInteger count = self.OutletLocationObj.outletArray.count;
    NSMutableArray<DDOutletM> *temp = self.OutletLocationObj.outletArray.mutableCopy;
    for (NSUInteger i=0; i<count; i++) {
        DDOutletM *this = [self.OutletLocationObj.outletArray objectAtIndex:i];
        if (this.outlet_id == self.preSelected.outlet_id) {
            [temp removeObjectAtIndex:i];
            break;
        }
    }
    self.OutletLocationObj.outletArray = temp;
    UIImage *placeholder = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"placeholder.png"];
    [self.merchantLogo loadImageWithString:self.OutletLocationObj.merchant.logo_url withPlaceHolderImage:placeholder forClass:self.class];
    self.outletLocation.text = [NSString stringWithFormat:@"%@ - %@",self.OutletLocationObj.merchant.name, self.OutletLocationObj.selectedOutlet.name];
    self.cuisineType.text =  self.OutletLocationObj.merchant.digital_section;
    filteredArray = self.OutletLocationObj.outletArray;
    [self sortOutlets];
    [self.tblView reloadData];

}
//MARK:- Table View Utilities
- (void) setUpTableView {
    NSArray *tableCells = @[DDMerchantDetailOuletLocationCell];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.rowHeight = 64.0;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDMerchantDetailOutletLocationTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantDetailOuletLocationCell];
    [cell setData:[filteredArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filteredArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.navigation.routerModel.callback(nil, [filteredArray objectAtIndex:indexPath.row], self);
}

// MARK:- Filter Array
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.text length] + [string length] - range.length){
        [self filertTable:[NSString stringWithFormat:@"%@%@",textField.text,string.lowercaseString]];
    }else{
        [self filertTable:@""];
    }
    return YES;
}
-(void)filertTable :(NSString*)str{
    filteredArray = [self.OutletLocationObj.outletArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(DDOutletM  * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.name.lowercaseString containsString:str];
    }]];
    if (filteredArray.count == 0) {
        filteredArray = self.OutletLocationObj.outletArray;
    }
    [self sortOutlets];
    [self.tblView reloadData];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self panTransiotionToFullScreen];
}


- (void)sortOutlets {
    if (![[DDLocationsManager shared] isLocationServicesEnable]) {
        [filteredArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    }else{
        [sortedArray removeAllObjects];
        for (DDOutletM *outlet in filteredArray){
            outlet.distance_from_user = [[DDLocationsManager shared] distanceFromLatidute:outlet.lat longitude:outlet.lng];
            [sortedArray addObject:outlet];
        }
        filteredArray = sortedArray;
        [filteredArray sortUsingDescriptors:@[[[NSSortDescriptor alloc]initWithKey:@"distance_from_user"  ascending:YES selector:@selector(localizedStandardCompare:)]]];
    }
}

@end
