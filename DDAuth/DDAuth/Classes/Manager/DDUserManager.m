//
//  DDCUserManager.m
//  DDCommons
//
//  Created by M.Jabbar on 08/01/2020.
//

#import "DDUserManager.h"
#import "DDApiClasses.h"
#import "DDNetworkManager.h"
#import <DDLocations/DDLocations.h>
#import "DDAuthManager.h"
#import "DDRegistrationDemographicsVC.h"
#import "AppboyKit.h"

#define K_APPLIED_KEY_DF @"applied_key"

@interface DDUserManager()

@property (nonatomic, strong) DDUserM <Optional> *user;

@end


@implementation DDUserManager
    

static DDUserManager *_sharedObject;

+(DDUserManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDUserManager alloc]init];
    });
    return _sharedObject;
}
-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}
-(void)logout {
    if (self.isLoggedIn == NO) return;
    [self logoutWithoutUIUpdate];
}
-(void)logoutWithoutUIUpdate {
    self.currentUser = nil;
    self.isSkipped = NO;
    DDLocationsManager.shared.cashlessDeliveryLocationTags = nil;
    DDLocationsManager.shared.cashlessDeliveryLocations = nil;
    [[DDCCommonParamManager shared] reset];
    [DDSharedPreferences.shared setObjectDF:nil forKey:DD_LOCATION_SELECTED_OBJECT];
    [DDSharedPreferences.shared setObjectDF:nil forKey:@"user"];
    [DDSharedPreferences.shared saveUserSessionTokenAndEmail:nil token:nil name:nil profileImg:nil];
}
-(BOOL)shouldProceedInApp {
    return self.isLoggedIn || self.isSkipped;
}
-(void)setCurrentUser:(DDUserM<Optional> *)currentUser{
    self.user = currentUser;
    [DDSharedPreferences.shared setObjectDF:currentUser.toJSONString forKey:@"user"];
    [self setSessionInCommonParams];
}
-(void)setSessionInCommonParams {
    DDCCommonParamManager.shared.default_api_parameters.user_id = self.user.user_id;
    DDCCommonParamManager.shared.default_api_parameters.api_token = self.user.session_token;
    DDCCommonParamManager.shared.default_web_parameters.__t = self.user.session_token;
}
-(DDUserM<Optional> *)currentUser{
    if (self.user == nil) {
        self.currentUser = [((NSString *)[DDSharedPreferences.shared objectforKeyDF:@"user"]) decodeTo:DDUserM.class];
    }
    return self.user;
}

-(BOOL)isLoggedIn {
    return [self currentUser] != nil;
}
+(NSArray<DDCountryM*>*)countries{
    return [DDCountryM countries];
}
+(NSArray<DDCountryM*>*)countriesListWithFileName:(NSString*)fileName{
    
  return  [DDCountryM getCountriesData:fileName];
}
+(DDCountryM *)country:(NSString *)code countries:(NSArray<DDCountryM *> *)countries{
   return [countries filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
       DDCountryM *country = (DDCountryM*)evaluatedObject;
       return [country.shortname isEqualToString:code];
   }]].firstObject;
}
@end
