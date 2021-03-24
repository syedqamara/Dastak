//
//  DDHomeSectionAttribute.m
//  DDModels
//
//  Created by Syed Qamar Abbas on 01/07/2020.
//

#import "DDHomeSectionAttributeM.h"

@implementation DDHomeSectionAttributeM
-(CGFloat)borderWidth {
    if (self.title.length > 0) {
        return 1;
    }
    return 0;
}
-(NSString *)titleStr {
    if(self.borderWidth > 0) {
        return [NSString stringWithFormat:@" %@ ",[self checkAndReturnTitle]];
    }
    return [self checkAndReturnTitle];
}
-(NSString *)checkAndReturnTitle {
    if(self.value.length > 0) {
        return self.value;
    }
    return self.title;
}
-(BOOL)haveImage {
    return [self.type.lowercaseString isEqualToString:@"image"];
}
@end
