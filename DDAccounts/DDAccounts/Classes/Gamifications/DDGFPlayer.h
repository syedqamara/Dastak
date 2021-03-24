//
//  DDGFPlayer.h
//  Pods
//
//  Created by Raheel Ahmad on 9/1/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DDUser;

@interface DDGFPlayer : NSManagedObject

@property (nonatomic, retain) NSString * player_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * display_name;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) DDUser * user;

@end
