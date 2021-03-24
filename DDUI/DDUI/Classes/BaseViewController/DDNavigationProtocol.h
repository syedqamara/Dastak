//
//  DDNavigationProtocol.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 02/01/2020.
//

#import <Foundation/Foundation.h>
#import "DDUIRouterM.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DDNavigationProtocol <NSObject>

@property (strong, nonatomic) DDUIRouterInfoM *navigation;
-(void)didAddedToWindow;
@end

NS_ASSUME_NONNULL_END
