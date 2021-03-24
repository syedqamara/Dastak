//
//  DDMerchnatDetailTopMenuVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 16/03/2020.
//

#import "DDMerchnatDetailTopMenuVC.h"
#import "DDOutletsUIConstants.h"
#import "DDMerchantMoreMenuTVC.h"
#import "DDOutletsThemeManager.h"
#import "DDCommons.h"
#import <DDSocial/DDSocial.h>
@import MessageUI;

@interface DDMerchnatDetailTopMenuVC ()<UITableViewDelegate,UITableViewDataSource, MFMailComposeViewControllerDelegate, DDDraggableNavigationControllerDelegate>{
    NSMutableArray *menuItems;
    DDMerchantDetailM *merchantData;
}

@end

@implementation DDMerchnatDetailTopMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    merchantData = (DDMerchantDetailM*)self.navigation.routerModel.data;
    menuItems =  [NSMutableArray new];
    menuItems = merchantData.top_menu_button.mutableCopy;
    self.title = @"More".localized;
    [self setWhiteDragableNavigationBar];
    [self setUpTableView];
    
    [self addNavigationItemWithTitle:CANCEL identifier:CANCEL tintColor:DDOutletsThemeManager.shared.selected_theme.text_theme.colorValue direction:DDNavigationItemDirectionLeft];
    
    if ([self.navigationController isKindOfClass:[DDDraggableNavigationController class]]) {
           [(DDDraggableNavigationController*)self.navigationController setPanModelDelegate:self];
       }
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

- (void) setUpTableView {
    
    NSArray *tableCells = @[DDMerchantMoreMenuTVCell];
    [self.tblView registerCellWithNibNames:tableCells forClass:self.class withIdentifiers:tableCells];
    self.tblView.dataSource = self;
    self.tblView.delegate = self;
    self.tblView.estimatedRowHeight = UITableViewAutomaticDimension;
    self.tblView.rowHeight = 100.0;
    [self.tblView reloadData];
}

- (void)didTapOnNavigationItem:(DDNavigationItem *)sender {
    if ([sender.identifier isEqualToString:CANCEL]) {
        [self goBackWithCompletion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDMerchantMoreMenuTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDMerchantMoreMenuTVCell forIndexPath:indexPath];
    [cell setData:[menuItems objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return menuItems.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    DDTopMenuItem *menuItem = (DDTopMenuItem*)menuItems[indexPath.row];
    [self menuItemActionFor:menuItem];
    
}

-  (void) menuItemActionFor : (DDTopMenuItem*) menuItem {
    if ([menuItem.type isEqualToString:@"call"]){
        [self callMerchantAction:menuItem];
    }else if ([menuItem.type isEqualToString:@"email"]){
        [self emailMerchantAction:menuItem];
    }else if ([menuItem.type isEqualToString:@"share"]){
        [self shareMerchantAction:menuItem];
    }
}

-  (void) callMerchantAction : (DDTopMenuItem*) menuItem{
    [menuItem.value makeCall];
}

-  (void) emailMerchantAction : (DDTopMenuItem*) menuItem {
    if ([merchantData.category isEqualToString:kHotelsWorldwide]) {
        [self hotelBookingForm];
    }else{
        if([MFMailComposeViewController canSendMail]){
            MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
            composer.mailComposeDelegate = self;
            if ([merchantData.category isEqualToString:kHotelsWorldwide]) {
                [composer setSubject:[NSString stringWithFormat:@"%@ - %@",@"Entertainer Travel booking enquiry".localized,merchantData.name]];
            }
            [composer setToRecipients:[NSArray arrayWithObject:merchantData.email?merchantData.email:@""]];
            [self presentViewController:composer animated:YES completion:nil];
        }else{
            [DDAlertUtils showOkAlertWithTitle:@"Email" subtitle:@"There are no Email account setup on this device. Go to Settings to add one." completion:nil];
        }
    }
}

- (void) hotelBookingForm  {
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void) shareMerchantAction : (DDTopMenuItem*) menuItem {
    DDSocialShareContent *content = [[DDSocialShareContent alloc] init];
    content.text = [NSString stringWithFormat:@"Fancy going to %@ today?".localized,merchantData.name];
    [[DDSocialManager shared] shareContent:content from:self onNativeShareSheet:^(BOOL completed, NSString * _Nullable message) {
    }];
}
@end
