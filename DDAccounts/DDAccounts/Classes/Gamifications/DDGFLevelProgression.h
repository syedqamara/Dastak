//
//  DDGFLevelProgression.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/5/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DDGFLevelInfo,DDGFBadgesInfo;

@interface DDGFLevelProgression : NSManagedObject

@property (nonatomic, retain) NSNumber * earned;
@property (nonatomic, retain) NSNumber * possible;
@property (nonatomic, retain) NSNumber * percent;
@property (nonatomic, retain) NSString * definition_id;
@property (nonatomic, retain) DDGFLevelInfo *levelInfo;

@end
