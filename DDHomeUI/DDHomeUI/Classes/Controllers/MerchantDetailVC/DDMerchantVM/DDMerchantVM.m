//
//  DDMerchantVM.m
//  dynamicdelivery
//
//  Created by Syed Qamar Abbas on 26/06/2020.
//  Copyright © 2020 Future Workshops. All rights reserved.
//

#import "DDMerchantVM.h"

@implementation DDMerchantVM
-(BOOL)haveImage {
    return self.imageURL.length > 0;
}
-(BOOL)haveViewButton {
    return self.viewButtonTitle.length > 0;
}
-(NSInteger)selectedIndex {
    return [self.merchant.delivery_menu indexOfObject:self.selectedMenu];
}
+(DDMerchantVM *)vmWithType:(DDMerchantDetailSectionType)type andMerchant:(DDMerchantM *)merchant {
    DDMerchantVM *vm = [DDMerchantVM new];
    vm.type = type;
    vm.merchant = merchant;
    return vm;
}
@end
