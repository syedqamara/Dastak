//
//  DDGeneralVM.m
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import "DDGeneralVM.h"


@implementation DDGeneralVM
-(instancetype)initWithTitle:(NSString *)title andSubtitle:(NSString *)subTitle andImage:(NSString *)imageName {
    self = [super init];
    self.title = title;
    self.sub_title = subTitle;
    self.image_url = imageName;
    return self;
}

@end
