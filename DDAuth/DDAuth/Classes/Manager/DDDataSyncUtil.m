//
//  PPDataSyncUtil.m
//  241 Passport
//
//  Created by Raheel Ahmad on 5/28/15.
//  Copyright (c) 2015 Raheel Ahmad. All rights reserved.
//

#import "DDDataSyncUtil.h"

@interface DDDataSyncUtil(){
    NSTimer * syncTimer;
}

@end

@implementation DDDataSyncUtil

-(id)init{
    if (self=[super init]) {
        
    }
    return self;
}

+(DDDataSyncUtil *) sharedInstance {
    static DDDataSyncUtil *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DDDataSyncUtil alloc] init];
    });
    return _sharedInstance;
}

-(void)syncRedemptions{
    if(!syncTimer){
        syncTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(syncRedemptions) userInfo:nil repeats:YES];
    }
    if (![UIApplication isInternetConnected]){
        return;
    }
    
    [[DDDataSyncUtil sharedInstance] syncData:^(bool isSync) {
        [self->syncTimer invalidate];
        self->syncTimer = nil;
        if(isSync){
            [[NSNotificationCenter defaultCenter] postNotificationName:DDRefreshMerchantOffersDetail object:nil];
        }
    }];
}

-(void) syncData:(void (^)(bool isSync))completion{
    
    
}

- (NSArray *)getNonSyncedRedemptions:(NSNumber *) userId{
    NSManagedObjectContext *context = [[DDDatabaseManager shared] getDefaultMRContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"DDUserRedemptions"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(is_sync = %@) AND (user_id = %@)", [NSNumber numberWithBool:NO],userId];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    return [context executeFetchRequest:fetchRequest error:&error];
}


- (void) updateStatusSyncRedemption:(NSString *)refCode offer_Id:(NSNumber *) offerId transaction_id:(NSString *) transaction_id{
    
}

@end
