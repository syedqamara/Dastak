//
//  DDMerchantSectionAmenitiesHFV.h
//  DDOutletsUI
//
//  Created by Hafiz Aziz on 06/03/2020.
//


#import "DDMerchantBaseHFV.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantSectionAmenitiesHFV : DDMerchantBaseHFV

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAll;

@property (nonatomic, copy) void (^callBackShowAll)(NSArray * attributesArray);

@end

NS_ASSUME_NONNULL_END
