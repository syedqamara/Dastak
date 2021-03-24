//
//  DDMapBaseMarker.h
//  DDCommons
//
//  Created by Zubair Ahmad on 20/01/2020.
//  Copyright © 2020 The dynamicdelivery. All rights reserved.
//

#import <JSONModel/JSONModel.h>


NS_ASSUME_NONNULL_BEGIN



@interface DDMapMarker : JSONModel

@property (nonatomic, strong) NSNumber<Optional> * lattitude;
@property (nonatomic, strong) NSNumber<Optional> * longitude;
@property (nonatomic, strong) NSString<Optional> * pinImage;
@property (nonatomic, strong) NSString<Optional> * pinSelectedImage;
@property (nonatomic, strong) NSString<Optional> * clusterImage;
@property (nonatomic, strong) NSString<Optional> * localPinImage;
@property (nonatomic, strong) NSString<Optional> * localPinSelectedImage;
@property (nonatomic, strong) NSString<Optional> * localClusterImage;
@property (nonatomic, strong) NSString<Optional> * category;
@property (nonatomic, strong) NSNumber<Optional> * isSelected;
@property (nonatomic, strong) id<Optional> markerData;

@end

NS_ASSUME_NONNULL_END
