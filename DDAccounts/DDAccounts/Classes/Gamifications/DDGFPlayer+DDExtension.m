//
//  DDGFPlayer+DDExtension.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/1/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFPlayer+DDExtension.h"
#import <DDStorage/DDStorage.h>

@implementation DDGFPlayer (DDExtension)


+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    
    static RKEntityMapping *entityMapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entityMapping = [RKEntityMapping mappingForEntityForName:@"DDGFPlayer" inManagedObjectStore:managedObjectStore];
        [entityMapping addAttributeMappingsFromDictionary:@{
                                                            @"id" : @"player_id",
                                                            @"name" : @"name",
                                                            @"display_name" : @"display_name",
                                                            @"first_name" : @"first_name",
                                                            @"last_name" : @"last_name"
                                                            }];
        
        entityMapping.identificationAttributes = @[@"player_id"];
    });
    return entityMapping;
}


@end
