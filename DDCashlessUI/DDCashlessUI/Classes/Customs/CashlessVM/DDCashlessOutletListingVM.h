//
//  DDCashlessOutletListingVM.h
//  DDCashlessUI
//
//  Created by Awais Shahid on 24/03/2020.
//

#import "JSONModel.h"
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDCashlessOutletListingSectionVM <NSObject> @end
@protocol DDCashlessOutletListingVM <NSObject> @end

typedef NS_ENUM(NSInteger, DDCOListingSectionVMType) {
    DDCOListingSectionVMTypeUnknow     = 0,
    DDCOListingSectionVMTypeFilters    = 1,
    DDCOListingSectionVMTypeOutlets    = 2,
};


@interface DDCashlessOutletListingSectionVM : JSONModel

@property (nonatomic, strong) NSString<Optional> *section_identifier;
@property (nonatomic, strong) NSString<Optional> *section_title;
@property (nonatomic, strong) NSString<Optional> *section_subtitle;

@property (nonatomic, strong) DDFiltersDataM *filtersData;
@property (nonatomic, strong) NSMutableArray<DDOutletM, Optional> *outlets;
-(DDCOListingSectionVMType)type;
@end


@interface DDCashlessOutletListingVM : JSONModel
@property (nonatomic, strong) NSMutableArray<DDCashlessOutletListingSectionVM, Optional> *sections;
-(void)setUpApiDataIntoVM:(id)apiData;
@end

NS_ASSUME_NONNULL_END
