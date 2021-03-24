//
//  DDBaseAppConfiguration.m
//  DeepLinkKit
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDOutletsUIAppUIConfiguration.h"
#import "DDOutletsUI.h"
@implementation DDOutletsUIAppUIConfiguration


+(void)loadUIConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Listing andModuleName:@"" withClassRef:DDOutletsListingVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Detail andModuleName:@"" withClassRef:DDMerchantDetailVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Detail_Amenities andModuleName:@"" withClassRef:DDAmenitiesDetailVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Detail_TopMENU andModuleName:@"" withClassRef:DDMerchnatDetailTopMenuVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Detail_Map andModuleName:@"" withClassRef:DDMerchnatDetailMapVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Locations_List andModuleName:@"" withClassRef:DDMerchnatDetailOutletLocations.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Locked_Offers andModuleName:@"" withClassRef:DDMerchantLockedOffersVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Online_Offers_History andModuleName:@"" withClassRef:DDMerchantOnlineOffrerHistoryVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Book_A_Table_Web andModuleName:@"" withClassRef:DDBookATableWebVC.class];
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Outlets_Cinema_Web andModuleName:@"" withClassRef:DDCinemaWebVC.class];
}

@end
