//
//  DDPopupOptionVM.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 06/06/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, DDPopupOptionSelectionType){
    DDPopupOptionSelectionTypeDefault,
    DDPopupOptionSelectionTypeSingle,
    DDPopupOptionSelectionTypeMultiple
};



@interface DDPopupOptionVM : NSObject
@property (strong, nonatomic) id object;
@property (strong, nonatomic) NSString *leftImageNormal;
@property (strong, nonatomic) NSString *leftImageSelected;
@property (strong, nonatomic) NSString *rightImageNormal;
@property (strong, nonatomic) NSString *rightImageSelected;

@property (strong, nonatomic) NSString *titleLabelLeft;
@property (strong, nonatomic) NSString *titleLabelRight;


/// Default Font:- Regular-15
@property (strong, nonatomic) UIFont *titleFontNormalLeft;
/// Default Font:- Regular-15
@property (strong, nonatomic) UIFont *titleFontSelectedLeft;


/// Default Font:- Regular-15
@property (strong, nonatomic) UIFont *titleFontNormalRight;
/// Default Font:- Regular-15
@property (strong, nonatomic) UIFont *titleFontSelectedRight;

/// Default Color:- Black
@property (strong, nonatomic) UIColor *titleLabelColorNormalRight;
@property (strong, nonatomic) UIColor *titleLabelColorSelectedRight;

/// Default Color:- Black
@property (strong, nonatomic) UIColor *titleLabelColorNormalLeft;
@property (strong, nonatomic) UIColor *titleLabelColorSelectedLeft;

@property (strong, nonatomic) UIColor *separatorColor;

/// Default Value:- `NO`
@property (assign, nonatomic) BOOL isSelected;

/// Default Value:- 20
@property (assign, nonatomic) CGFloat leftImageWidthHeight;
/// Default Value:- 20
@property (assign, nonatomic) CGFloat rightImageWidthHeight;

/// Default Value:- 60
@property (assign, nonatomic) CGFloat cellHeight;

-(BOOL)shouldHideLeftImage;
-(BOOL)shouldHideRightImage;
-(BOOL)shouldHideLeftTitle;
-(BOOL)shouldHideRightTitle;
-(BOOL)shouldHideSeparator;


-(UIColor *)titleColorLeft;
-(UIFont *)fontLeft;
-(UIColor *)titleColorRight;
-(UIFont *)fontRight;
-(NSString *)leftImage;
-(NSString *)rightImage;


@end

@interface DDPopupVM : NSObject
/// Default Selection:- `DDPopupOptionSelectionTypeDefault`
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *search_placeholder;
@property (assign, nonatomic) DDPopupOptionSelectionType selectionType;
@property (strong, nonatomic) NSMutableArray <DDPopupOptionVM *>* options;
@property (strong, nonatomic) NSMutableArray <DDPopupOptionVM *>* filtered_options;
-(CGFloat)panHeight;
@end

NS_ASSUME_NONNULL_END
