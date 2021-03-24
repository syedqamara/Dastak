//
//  DDCashlessDeliveryLocationsVM.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 20/02/2020.
//

#import "JSONModel.h"
#import "DDModels.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessDeliveryLocationsSectionVM @end

@interface DDCashlessDeliveryLocationsVM : JSONModel
@property (strong, nonatomic) NSArray <DDCashlessDeliveryLocationsSectionVM, Optional> *sections;
+(DDCashlessDeliveryLocationsVM*)setupDataFromSavedDeliveryArray:(NSArray*)adresses;
@end

@interface DDCashlessDeliveryLocationsSectionVM : JSONModel
@property (strong, nonatomic) NSNumber <Optional> *is_new_section;
@property (strong, nonatomic) NSNumber <Optional> *is_current_section;
@property (strong, nonatomic) NSNumber <Optional> *is_manual_section;
@property (strong, nonatomic) NSString <Optional> *title;
@property (strong, nonatomic) NSString <Optional> *image;
@property (strong, nonatomic) NSString <Optional> *color;
@property (strong, nonatomic) NSArray <DDDeliveryAddressM, Optional> *locations;

-(BOOL)isNewSection;
-(BOOL)isCurrentSection;
-(BOOL)isManualSection;

@end




NS_ASSUME_NONNULL_END
