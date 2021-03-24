//
//  DDEmptyViewModel.m
//  DDModels
//
//  Created by Awais Shahid on 10/02/2020.
//

#import "DDEmptyViewModel.h"

@implementation DDEmptyViewModel

+(DDEmptyViewModel*)internetVM {
    DDEmptyViewModel *modal = [DDEmptyViewModel new];
    modal.title = @"NO INTERNET CONNECTION";
    modal.sub_title = @"You need an internet connection to see something on this screen. Try again later.";
    modal.btn_title = @"Refresh";
    return modal;
}
-(instancetype)init {
    self = [super init];
    [self setDefaultTextAlignment:NSTextAlignmentLeft];
    return self;
}
-(void)setDefaultTextAlignment:(NSTextAlignment)alignment {
    self.textAlignment = @(alignment);
}
-(NSTextAlignment)defaultTextAlignment {
    return self.textAlignment.integerValue;
}
@end
