//
//  DDMerchantOutletLocationViewM.h
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 13/03/2020.
//

#import <Foundation/Foundation.h>
#import <DDModels/DDModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDMerchantOutletLocationViewM : JSONModel

@property (nonatomic, strong) DDOutletM<Ignore>*selectedOutlet;
@property (nonatomic, strong) NSMutableArray<DDOutletM,Ignore>*outletArray;
@property (nonatomic, strong) DDMerchantDetailM<Ignore> * merchant;


@end

NS_ASSUME_NONNULL_END
