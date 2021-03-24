//
//  DDNetworkEnums.h
//  DDNetwork
//
//  Created by Syed Qamar Abbas on 04/02/2020.
//

#ifndef DDNetworkEnums_h
#define DDNetworkEnums_h

typedef NS_ENUM(NSUInteger, DDApiMethod) {
    DDApiMethodPOST,
    DDApiMethodGET,
};
typedef NS_ENUM(NSUInteger, DDApiParamType) {
    DDParamTypeFormData,
    DDParamTypeJSON,
    DDParamTypeURL_Encoded,
};
typedef NS_ENUM(NSUInteger, DDApiAuthorizationType) {
    DDApiAuthorizationTypeJWT,
    DDApiAuthorizationTypeBasicAuth,
    DDApiAuthorizationTypeBearerToken,
};
#endif /* DDNetworkEnums_h */
