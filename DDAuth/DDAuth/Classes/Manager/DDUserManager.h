//
//  DDCUserManager.h
//  DDCommons
//
//  Created by M.Jabbar on 08/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDCountryM.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import "DDAuthConstants.h"
#import "DDLocationsManager.h"
#import "DDAuthManager.h"
#import <DDStorage/DDStorage.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUserManager : JSONModel

//@property (nonatomic, strong) NSNumber <Optional> *locationId;
@property (nonatomic, strong) DDUserM <Optional> *currentUser;
@property (nonatomic, assign) BOOL isGamificationOn;
@property (nonatomic, assign) BOOL isCustomAnalyticsEnabled;
@property (nonatomic, assign) BOOL isSkipped;
@property (nonatomic, assign) BOOL isDemographicScreenShownOnce;

+(DDUserManager *)shared;

+(NSArray<DDCountryM*>*)countries;

+(NSArray<DDCountryM*>*)countriesListWithFileName:(NSString*)fileName;
+(DDCountryM *)country:(NSString *)code countries:(NSArray<DDCountryM *> *)countries;
-(BOOL)isLoggedIn;
-(void)logout;
-(void)logoutWithoutUIUpdate;
-(BOOL)shouldProceedInApp;

@end

NS_ASSUME_NONNULL_END
