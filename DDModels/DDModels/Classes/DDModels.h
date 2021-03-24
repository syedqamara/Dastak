//
//  DDModels.h
//  DDModels
//
//  Created by Awais Shahid on 24/01/2020.
//

#ifndef DDModels_h
#define DDModels_h


#endif /* DDModels_h */
// MARK:- Neccessory Imports
#import "DDConfigApiM.h"
#import "DDJSONModelProtocols.h"
#import "DDEmptyViewModel.h"

// MARK:- DeliveryLocations
#import "DDDeliveryAddressM.h"
#import "DDDeliveryLocationsData.h"
#import "DDCashlessLocationsRequestM.h"
#import "DDCountryM.h"
#import "DDLocationsAPIM.h"


// MARK:- Auth
#import "DDAuthSignupResponseM.h"
#import "DDAuthLoginM.h"
#import "DDAuthEmailValidationM.h"
#import "DDAuthEmailValidationApiM.h"
#import "DDLoginRequestM.h"
#import "DDSignupRequestM.h"
#import "DDUserM.h"

// MARK:- Home
#import "DDHomeApiM.h"
#import "DDMerchantApiM.h"
#import "DDOrderStatusApiM.h"
#import "DDSearchRM.h"

// MARK:- SEARCH
#import "DDSearchApiM.h"
#import "DDFiltersApiM.h"

// MARK:- Order
#import "DDOrderHistoryApiM.h"
#import "DDOutletApiM.h"
#import "DDConfigApiM.h"
#import "DDC2CFairsApiM.h"
#import "DDC2CFairsRM.h"
#import "DDCashlessCart.h"
#import "DDMerchantRM.h"
#import "DDRatingRM.h"
#import "DDOrderRM.h"
#import "DDSendParcelRM.h"

typedef void(^ _Nullable DefaultApiCompletionCallback)(DDBaseApiModel * _Nullable model, NSError * _Nullable error);
typedef void(^ _Nullable HomeCompletionCallback)(DDHomeApiM * _Nullable model, NSError * _Nullable error);
typedef void(^ _Nullable MerchantDetailCompletionCallback)(DDMerchantApiM * _Nullable model, NSError * _Nullable error);
typedef void(^ _Nullable OrderDetailCompletionCallback)(DDOrderStatusApiM * _Nullable model, NSError * _Nullable error);

typedef void(^ _Nullable OrderHistoryCompletionCallback)(DDOrderHistoryApiM * _Nullable model, NSError * _Nullable error);
typedef void(^ _Nullable OuletListingCompletion)(DDOutletApiM * _Nullable model, NSError * _Nullable error);
