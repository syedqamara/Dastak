//
//  DDGFPlayer+DDExtension.h
//  TheEntertainer
//
//  Created by Raheel Ahmad on 9/1/15.
//  Copyright (c) 2015 THE DDERTAINER. All rights reserved.
//

#import "DDGFPlayer.h"
#import <DDStorage/DDStorage.h>

@interface DDGFPlayer (DDExtension)

+ (RKEntityMapping *)entityMappingWithManagedObjectStore:(RKManagedObjectStore *)managedObjectStore;

@end
