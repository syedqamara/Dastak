//
//  DDDatabaseManager.h
//  DDCommons
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDDatabaseManager : NSObject
+(DDDatabaseManager *)shared;
-(void)loadDatabase;
-(void)saveData;
-(NSDictionary *)loggedInUserInfo;
-(void)saveDefaultContext;
-(void)reloadDefaultContextIntoMR;
-(NSManagedObjectContext*)getDefaultMRContext;
@end

NS_ASSUME_NONNULL_END
