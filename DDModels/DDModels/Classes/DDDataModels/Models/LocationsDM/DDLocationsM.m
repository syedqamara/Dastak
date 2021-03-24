//
//  DDLocationsM.m
//  DDModels
//
//  Created by Zubair Ahmad on 04/02/2020.
//

#import "DDLocationsM.h"

@implementation DDLocationsM

+(JSONKeyMapper*)keyMapper{
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"location_id"}];
}

+(DDLocationsM*)defaultLocation{
    DDLocationsM*location = [[DDLocationsM alloc] init];
    location.lat = @(25.2048);
    location.lng = @(55.2708);
    location.name = @"Dubai & N. Emirates";
    location.flag = @"AE";
    location.active = @(1);
    location.savings_small_image_url = @"https://s3.amazonaws.com/-app-assets/savings_image_small.png";
    location.savings_image_url = @"https://s3.amazonaws.com/-app-assets/savings_image.png";
    location.location_id = @(1);
    location.background = @"https://s3-us-west-2.amazonaws.com/product-locations/backgrounds/loc_1.jpg";
    location.language = @"ar";
    location.is_show_category = @(0);
    location.reload_background = @(0);
    location.snack_bar_title = @"Your location is set to LOCATION_NAME";
    location.snack_bar_des = @"Need to change? Go to your Profile page.";

    return location;
}
@end
