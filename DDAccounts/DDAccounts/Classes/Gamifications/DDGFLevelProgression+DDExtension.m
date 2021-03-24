//
//  DDGFLevelProgression+DDExtension.m
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/5/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFLevelProgression+DDExtension.h"

@implementation DDGFLevelProgression (DDExtension)


+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore {
    
    static RKEntityMapping *entityMapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entityMapping = [RKEntityMapping mappingForEntityForName:@"DDGFLevelProgression" inManagedObjectStore:managedObjectStore];
        [entityMapping addAttributeMappingsFromDictionary:@{
                                                            @"earned" : @"earned",
                                                            @"possible" : @"possible",
                                                            @"percent" : @"percent",
                                                           @"definition_id":@"definition_id"
                                                            }];
        
        entityMapping.identificationAttributes = @[@"definition_id"];
    });
    return entityMapping;
}


@end
