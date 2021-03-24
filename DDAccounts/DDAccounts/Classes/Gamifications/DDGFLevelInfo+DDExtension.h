//
//  DDGFLevelInfo+DDExtension.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/4/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFLevelInfo.h"
#import <DDStorage/DDStorage.h>

@interface DDGFLevelInfo (DDExtension)

+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;

@end
