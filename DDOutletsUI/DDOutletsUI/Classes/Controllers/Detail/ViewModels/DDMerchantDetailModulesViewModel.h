//
//  DDMerchantDetailModulesViewModel.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 05/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DDMerchantDetailModulesViewModel @end

@interface DDMerchantDetailModulesViewModel : JSONModel

@property (unsafe_unretained,nonatomic) DDMerchantModuleNavigation * _Nullable leftItem;
@property (unsafe_unretained,nonatomic) DDMerchantModuleNavigation  * _Nullable rightItem;

+(NSMutableArray *)getAccumulatedOutletServicesArray : (NSMutableArray <DDMerchantModuleNavigation, Optional> *)array;
@end


NS_ASSUME_NONNULL_END
