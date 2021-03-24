//
//  DDMapsManager.h
//  DDOutlets
//
//  Created by Zubair Ahmad on 21/01/2020..
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDCommons/DDCommons.h>
#import <DDNetwork/DDNetwork.h>
#import <DDModels/DDModels.h>
#import "DDMapMarker.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDMapsManager : NSObject

+ (DDMapsManager *)shared;

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

- (NSMutableArray <DDMapMarker*> *) setMarkersData : (NSMutableArray *) outlets;
- (NSMutableArray <DDMapMarker*> *) setMarkersDataFromLocations;

- (void)fetchListOfOutlets:(DDBaseRequestModel *)outletsReqModel showLoader: (BOOL)showLoader  andCompletion:(void (^)(DDBaseApiModel * _Nullable model, NSURLResponse * _Nullable, NSError * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
