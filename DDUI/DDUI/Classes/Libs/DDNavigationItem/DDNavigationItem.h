//
//  DDNavigationItem.h
//  DDUI
//
//  Created by Awais Shahid on 14/02/2020.
//

#import <UIKit/UIKit.h>
#import "DDUIBaseView.h"

#define BACK_BTN_IDDDIFIER @"BACK_BTN_IDDDIFIER"
#define BACK_BTN_IDDDIFIER_CUSTOM @"BACK_BTN_IDDDIFIER_CUSTOM"

typedef NS_ENUM(NSInteger, DDNavigationItemDirection) {
    DDNavigationItemDirectionLeft    = 0,
    DDNavigationItemDirectionRight   = 1,
    DDNavigationItemDirectionCenter   = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface DDNavigationItem : DDUIBaseView

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *textLbl;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) DDNavigationItemDirection direction;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) UIColor *tintColor;
@property (nonatomic, copy) void(^completion)(DDNavigationItem*);


@end

NS_ASSUME_NONNULL_END
