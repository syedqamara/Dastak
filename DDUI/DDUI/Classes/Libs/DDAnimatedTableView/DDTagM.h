//
//  DDTagM.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 11/02/2020.
//

#import <Foundation/Foundation.h>
#define Space 5.0
NS_ASSUME_NONNULL_BEGIN

@interface DDTagM : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIColor *background_color;
@property (strong, nonatomic) UIColor *title_color_normal;
@property (strong, nonatomic) UIColor *title_color_selected;
@property (assign, nonatomic) BOOL is_enabled;
@property (assign, nonatomic) BOOL is_fix_width;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) CGFloat corner_radius;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) BOOL is_selected;
@property (strong, nonatomic) UIFont *font_selected;
@property (strong, nonatomic) UIFont *font_normal;
@property (assign, nonatomic) CGRect frame;
@property (weak, nonatomic) UIView *view;
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) id object;

-(CGFloat)space;
-(UIFont *)font;
-(void)calculateWidth;
- (CGFloat)widthOfString:(NSString *)text withFont:(UIFont *)textFont;
-(void)toggleOffSelection;
-(void)toggleOnSelection;
-(void)layoutSubView;
-(void)animateWithIndex:(NSInteger)index withInitialScale:(CGFloat) scale;
-(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
