//
//  DDDatePicker.h
//  DDUI
//
//  Created by M.Jabbar on 15/04/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import "DDUIThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDDateSelectBlock)(NSString *selectedDate); //selectedDate is NSDate or NSNumber for "UIDatePickerModeCountDownTimer"


@interface DDDatePicker : UIDatePicker

@property (nonatomic, copy) NSString *dateFormat;
@property (nonatomic, copy) DDDateSelectBlock selectedDateBlock;


-(void)setupDateOfBirth:(NSString*)dateOfBirth dateFormate:(NSString*)dateFormate;

@end

NS_ASSUME_NONNULL_END
