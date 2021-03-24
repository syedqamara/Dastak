//
//  DDGFLevelProgression+DDExtension.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/5/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFLevelProgression.h"
#import <DDStorage/DDStorage.h>

@interface DDGFLevelProgression (DDExtension)

+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;

@end
