//
//  DDUIRefreshControl.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 24/02/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDUIRefreshControl : UIRefreshControl

-(void)setScrollViewVerticalContentOffset:(CGFloat)yOffset;

@end

NS_ASSUME_NONNULL_END
