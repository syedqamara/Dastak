//
//  DDUIBaseView.m
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import "DDUIBaseView.h"
#import "DDCommons.h"

@implementation DDUIBaseView

+ (id)nibInstanceOfClass:(Class) className {
    UINib *nib = [NSBundle loadNibFromBundle:self nibName:NSStringFromClass(className)];
    DDUIBaseView *view = (DDUIBaseView *)[nib instantiateWithOwner:self options:nil][0];
    return view;
}
+(id)nibInstanceOfClass:(Class)className atIndex:(NSInteger)index {
    UINib *nib = [NSBundle loadNibFromBundle:self nibName:NSStringFromClass(className)];
    DDUIBaseView *view = (DDUIBaseView *)[nib instantiateWithOwner:self options:nil][index];
    return view;
}
@end
