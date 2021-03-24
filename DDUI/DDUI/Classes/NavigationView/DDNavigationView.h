//
//  DDNavigationView.h
//  DDUI
//
//  Created by M.Jabbar on 03/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDModels/DDModels.h>
#import "DDUIBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDNavigationView : DDUIBaseView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) NSLayoutConstraint *viewHeight;
@property (nonatomic) CGPoint currentOffSet;

+ (DDNavigationView *)loadNavigationView:(UIView*)container;

@end

NS_ASSUME_NONNULL_END
