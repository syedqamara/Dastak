//
//  DDDotView.h
//  AppAuth
//
//  Created by Syed Qamar Abbas on 13/10/2020.
//

#import "DDUIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, DDDotViewDirection){
    DDDotViewDirectionHorizontal,
    DDDotViewDirectionVertical,
};

@interface DDDotView : DDUIBaseView
@property (strong, nonatomic) UIColor *dotColor;
@property (assign, nonatomic) DDDotViewDirection direction;
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) CGFloat size;
@end

NS_ASSUME_NONNULL_END
