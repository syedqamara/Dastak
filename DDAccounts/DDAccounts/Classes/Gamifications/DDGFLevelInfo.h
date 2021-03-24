//
//  DDGFLevelInfo.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/4/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import <CoreData/CoreData.h>

@class DDGFLevelProgression;

@interface DDGFLevelInfo : NSManagedObject

@property (nonatomic, retain) NSString * definition_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * mission_position;
@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, strong) DDGFLevelProgression *progression;
@property (nonatomic, strong) NSDate * created_at;

@end
