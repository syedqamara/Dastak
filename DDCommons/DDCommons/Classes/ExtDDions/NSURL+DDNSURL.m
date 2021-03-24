//
//  NSURL+DDSENSURL.m
//  DDSE
//
//  Created by Raheel on 07/11/2018.
//  Copyright © 2018 TR. All rights reserved.
//

#import "NSURL+DDNSURL.h"

@implementation NSURL (DDNSURL)
-(void)openURL {
    [UIApplication.sharedApplication openURL:self options:@{} completionHandler:nil];
}
@end
