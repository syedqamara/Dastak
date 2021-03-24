//
//  DDGFLevelInfo+DDExtension.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/4/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFLevelInfo+DDExtension.h"

@implementation DDGFLevelInfo (DDExtension)

+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    
    static RKEntityMapping *entityMapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entityMapping = [RKEntityMapping mappingForEntityForName:@"DDGFLevelInfo" inManagedObjectStore:managedObjectStore];
        [entityMapping addAttributeMappingsFromDictionary:@{
                                                            @"definition_id" : @"definition_id",
                                                            @"name" : @"name",
                                                            @"image" : @"image",
                                                            @"type" : @"type",
                                                            @"mission_position" : @"mission_position"
                                                            ,
                                                            @"active" : @"active",
                                                            @"created_at":@"created_at"
                                                            }];
        
        [entityMapping addConnectionForRelationship:@"progression" connectedBy:@"definition_id"];
        
        entityMapping.identificationAttributes = @[@"definition_id"];
    });
    return entityMapping;
}

@end
