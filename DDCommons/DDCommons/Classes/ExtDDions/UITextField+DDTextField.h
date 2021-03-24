//
//  UITextField+DDTextField.h
//  DDCommons
//
//  Created by Awais Shahid on 25/02/2020.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (DDTextField)
-(void)customPlaceHolderColor:(UIColor*)color;
-(BOOL)shouldDisplayAccessoryView;
@end

NS_ASSUME_NONNULL_END
