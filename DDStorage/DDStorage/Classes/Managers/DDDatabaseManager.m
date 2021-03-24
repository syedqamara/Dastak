//
//  DDDatabaseManager.m
//  DDCommons
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import "DDDatabaseManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import <RestKit/CoreData.h>
#import <RestKit/Support.h>
#import "NSManagedObjectContext+MagicalRecord.h"
#import "NSManagedObjectContext+MagicalObserving.h"
#import "NSManagedObjectContext+MagicalThreading.h"
#import "NSManagedObjectContext+MagicalRecord.h"
#import "NSPersistentStoreCoordinator+MagicalRecord.h"
#import "MagicalRecord+ErrorHandling.h"
#import "MagicalRecord+iCloud.h"
#import "MagicalRecordLogging.h"
#import <CoreData/CoreData.h>
#import <DDCommons/DDCommons.h>
//#import <DDModels/DDModels.h>

#define kDebugRestKit 0

@implementation DDDatabaseManager
static DDDatabaseManager *_sharedObject;
+(DDDatabaseManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDDatabaseManager alloc]init];
    });
    return _sharedObject;
}

-(void)saveDefaultContext {
    // RKManagedObjectStore has already persist store and context
    [self saveData];
    [MagicalRecord cleanUp];
}

-(void)reloadDefaultContextIntoMR {
    if (RKManagedObjectStore.defaultStore != nil) {
        [MagicalRecord cleanUp];
        [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:RKManagedObjectStore.defaultStore.persistentStoreCoordinator];
        [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:RKManagedObjectStore.defaultStore.persistentStoreCoordinator];
    }
}
-(void)loadDatabase {
//    [MagicalRecord setLoggingLevel:(MagicalRecordLoggingLevelAll)];
    
//    NSURL *directory = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
//    NSURL *existingCoreDataURL = [directory URLByAppendingPathComponent:@"Thedynamicdelivery.sqlite"];
//    if (existingCoreDataURL) {
//        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:existingCoreDataURL];
//    }else{
//        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Thedynamicdelivery"];
//    }
//    [self setup];
}
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
+ (NSURL *)urlToApplicationSupportDirectory
{
    NSString *applicationSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
                                                                                 NSUserDomainMask,
                                                                                 YES) objectAtIndex:0];
    BOOL isDir = NO;
    NSError *error = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager fileExistsAtPath:applicationSupportDirectory
                           isDirectory:&isDir] && isDir == NO) {
        [fileManager createDirectoryAtPath:applicationSupportDirectory
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:&error];
    }
    return [NSURL fileURLWithPath:applicationSupportDirectory];
}
-(NSURL*)momdFilePath{
    NSString *momPath = [[NSBundle getDBBundlePath:[self class]] pathForResource:@"Thedynamicdelivery"
                                                                          ofType:@"momd"];
    
    if (!momPath) {
        momPath = [[NSBundle getDBBundlePath:[self class]] pathForResource:@"Thedynamicdelivery"
                                                                    ofType:@"mom"];
    }
    return [NSURL fileURLWithPath:momPath];;
}
- (NSManagedObjectModel *)managedObjectModel
{
    NSURL *url = [self momdFilePath];
    if (url) {
        return [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    return nil;
}
- (BOOL)isMigrationNeeded:(NSString*)path
{
    NSError *error = nil;
    NSManagedObjectModel *managedObjectModel = [self managedObjectModel];

    // Check if we need to migrate
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:[NSURL fileURLWithPath:path] options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}  error:&error];
                                        
    BOOL isMigrationNeeded = NO;

    if (sourceMetadata != nil) {
        // Migration is needed if destinationModel is NOT compatible
        isMigrationNeeded = ![managedObjectModel isConfiguration:nil
                                   compatibleWithStoreMetadata:sourceMetadata];
    }
    NSLog(@"isMigrationNeeded: %d", isMigrationNeeded);
    return isMigrationNeeded;
}
- (void)setup {
    if(kDebugRestKit){
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    }else{
        RKLogConfigureByName("*", RKLogLevelOff);
    }
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"Thedynamicdelivery.sqlite"];

    NSError *error;
    NSManagedObjectModel *managedObjectModel = [self managedObjectModel];//[NSManagedObjectModel mergedModelFromBundles:[NSBundle allFrameworks]];
    if (managedObjectModel == nil) {
        return;
    }
    NSLog(@"Store URL: %@", path);
    
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    if (![managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]) {
        
        NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSURL *storeURL = [documentsDirectory URLByAppendingPathComponent:@"Thedynamicdelivery.sqlite"];
        NSString* storePath = [storeURL path];
    
        RKLogDebug(@"Store URL: %@", storeURL);

//                                        NSURL *modelURL = [self momdFilePath];
//                                        BOOL success = [RKManagedObjectStore migratePersistentStoreOfType:NSSQLiteStoreType atURL:storeURL toModelAtURL:modelURL error:&error configuringModelsWithBlock:^(NSManagedObjectModel *model, NSURL *sourceURL) {
//                                            NSLog(@"model===%@",model.entities);
//
//
//                                        }];

    if( [[NSFileManager defaultManager] fileExistsAtPath:storePath] ){
            // Load store metadata (this will contain information about the versions of the models this store was created with)
        NSDictionary *storeMeta = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:[NSURL fileURLWithPath:path] options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}  error:&error];

            if(storeMeta){
                // Get the current model, merging all the models in the main bundle (in their current version)
                NSManagedObjectModel* model=[NSManagedObjectModel mergedModelFromBundles:[NSBundle allFrameworks]];
                // If the persistent store is not compatible with such a model (i.e. it was created with a model obtained merging old versions of "submodels"), migrate
                if(![model isConfiguration:nil compatibleWithStoreMetadata:storeMeta]){
                    
                    
                    // Load the old model
                    NSManagedObjectModel*oldModel = self.managedObjectModel; //[NSManagedObjectModel mergedModelFromBundles:@[[NSBundle getDBBundlePath:[self class]]] forStoreMetadata:storeMeta];
                    
                    // Compute the mapping between old model and new model
                    NSMappingModel* mapping = [NSMappingModel inferredMappingModelForSourceModel:oldModel destinationModel:model error:&error];
                    if(mapping){
                        // Backup old store
                        NSURL* storeBackupURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"Thedynamicdelivery.sqlite.%@.bck", [NSDate new]]];
                        BOOL done = [[NSFileManager defaultManager] moveItemAtURL:storeURL toURL:storeBackupURL error:&error];
                        if(done){
                            // Apply the mapping
                            NSMigrationManager* migrationManager = [[NSMigrationManager alloc] initWithSourceModel:oldModel destinationModel:model];
                            BOOL done = [migrationManager migrateStoreFromURL: storeBackupURL
                                                                         type: NSSQLiteStoreType
                                                                      options: nil
                                                             withMappingModel: mapping
                                                             toDestinationURL: storeURL
                                                              destinationType: NSSQLiteStoreType
                                                           destinationOptions: nil
                                                                        error: &error];
                            if(done){
                                [DDLogs log:@"Store migration successful!!!"];
                                if (![managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:@{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES} error:&error]){
                                    RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
                                }
                            }
                        }
                    }
                }
            }
        }
        if(error){
            RKLogDebug(@"Migration error: %@", error);
        }
    }
    
    [managedObjectStore createManagedObjectContexts];
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:managedObjectStore.persistentStoreCoordinator];
    [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:managedObjectStore.persistentStoreCoordinator];
    // Set the default store shared instance

    [RKManagedObjectStore setDefaultStore:managedObjectStore];

}
- (NSDictionary *)sourceMetadataForStoreURL:(NSURL*)sourceStoreURL error:(NSError **)error
{
    return [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                      URL:sourceStoreURL
                                                                    error:error];
}

-(NSDictionary *)loggedInUserInfo {
    /*
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [NSManagedObjectContext MR_context];

    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DDFavouriteMerchants"  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    if (error == nil) {
//        DDUser *userObj = fetchedObjects.firstObject;
        
        NSNumber *userID = [NSNumber numberWithInt:userObj.userId];
        NSMutableArray *favMerchantsData = [[NSMutableArray alloc] init];
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(user_id = %@)",userID];
        //NSArray *favMerchants = [DDFavouriteMerchants MR_findAllWithPredicate:predicate];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DDFavouriteMerchants"];
        [fetchRequest setPredicate:predicate];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DDFavouriteMerchants" inManagedObjectContext:[NSManagedObjectContext MR_context]];
        
        // Required! Unless you set the resultType to NSDictionaryResultType, distinct can't work.
        // All objects in the backing store are implicitly distinct, but two dictionaries can be duplicates.
        // Since you only want distinct names, only ask for the 'name' property.
        fetchRequest.resultType = NSDictionaryResultType;
        fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"merchant_id"]];
//        fetchRequest.returnsDistinctResults = YES;
        
        // Now it should yield an NSArray of distinct values in dictionaries.
        NSArray *dictionaries = [[NSManagedObjectContext MR_context] executeFetchRequest:fetchRequest error:nil];
        return userObj.dict;
    }
    */
    return nil;
}
- (void) saveData {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError * _Nullable error) {
        
    }];
}

-(NSManagedObjectContext*)getDefaultMRContext {
    return [NSManagedObjectContext MR_defaultContext];
}

@end
