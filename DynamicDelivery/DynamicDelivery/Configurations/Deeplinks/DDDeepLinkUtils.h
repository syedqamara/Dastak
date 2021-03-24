//
//  DDDeepLinkUtils.h
//  Thedynamicdelivery
//
//  Created by Raheel Ahmad on 5/2/16.
//  Copyright © 2016 Future Workshops. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <DeepLinkKit/DeepLinkKit.h>
#import <DDUI.h>
#import <DDConstants.h>

#define IS_BRANCH_KEY @"IS_BRANCH_KEY"

@interface DDDeepLinkUtils : NSObject
@property (strong, nonatomic) NSDictionary <NSString *, NSArray <DDUIRouterM *>*> *configurations;
-(void)registerSchemes;
-(DPLDeepLinkRouter *) getRouter;
+(DDDeepLinkUtils *) sharedInstance;
@end
