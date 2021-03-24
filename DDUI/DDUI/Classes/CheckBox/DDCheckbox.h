//
//  DDCheckbox.h
//  DDUI
//
//  Created by Awais Shahid on 04/02/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDCheckbox : UIButton

@property (nonatomic) IBInspectable UIImage *checkedIcon;
@property (nonatomic) IBInspectable UIImage *unCheckedIcon;
@property (nonatomic) IBInspectable BOOL checked;

@property (nonatomic, copy) void(^stateChanged)(BOOL,DDCheckbox*);
-(void)toggle;

@end

NS_ASSUME_NONNULL_END

