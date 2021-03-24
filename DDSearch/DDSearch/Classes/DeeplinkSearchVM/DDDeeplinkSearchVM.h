//
//  DDDeeplinkSearchVM.h
//  DDSearch
//
//  Created by Syed Qamar Abbas on 14/01/2020.
//

#import "DDModels.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, DDDeeplinkSearchSectionType){
    DDDeeplinkSearchSectionTypeSearchResults,
    DDDeeplinkSearchSectionTypeOutlets,
};

@interface DDDeeplinkSearchVM : NSObject
//@property (strong, nonatomic) NSArray <DDOutletM> *outlets;
//@property (strong, nonatomic) NSArray <DDOutletSearchResultsM>*search_results;
@property (strong, nonatomic) NSString  *sectionTitle;
@property (assign) DDDeeplinkSearchSectionType type;
@end

NS_ASSUME_NONNULL_END
