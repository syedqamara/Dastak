//
//  DDCashlessLocationsRequestM.m
//  Pods
//
//  Created by Awais Shahid on 25/02/2020.
//

#import "DDCashlessLocationsRequestM.h"

@implementation DDCashlessLocationsRequestM


-(BOOL)isValidRequestForDeleteLocation {
    return self.validationErrorForDeleteLocation.length == 0;
}

-(NSString *)validationErrorForDeleteLocation{
    if (self.delivery_location_id == nil) {
        return @"delivery location id is missing in request";
    }
    return nil;
}

-(BOOL)isValidRequestForAddLocation {
    return self.validationErrorForAddLocation.length == 0;

}

-(NSString *)validationErrorForAddLocation {
    if (self.custom_parameters.allKeys.count == 0) {
        return @"Params are empty while adding new cashless delivery location";
    }
    return nil;
}



@end
