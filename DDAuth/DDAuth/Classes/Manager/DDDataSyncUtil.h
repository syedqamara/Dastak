//
//  PPDataSyncUtil.h
//  241 Passport
//
//  Created by Raheel Ahmad on 5/28/15.
//  Copyright (c) 2015 Raheel Ahmad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUserManager.h"
@interface DDDataSyncUtil : NSObject

+(DDDataSyncUtil *) sharedInstance;
-(void)syncRedemptions;
@property (nonatomic, assign) BOOL isSyncCallSent;

@end
