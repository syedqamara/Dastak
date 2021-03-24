//
//  DDNationalityPicker.h
//  DDUI
//
//  Created by M.Jabbar on 09/01/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
#import "DDUIThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDNationalityPickerDoneBlock)(DDCountryM *selectedNationality); //selectedDate is NSDate or NSNumber for "UIDatePickerModeCountDownTimer"
typedef void(^DDNationalityPickerHideBlock)(void);

@interface DDNationalityPicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic) DDCountryM *selectedNationality;
@property (nonatomic) NSArray<DDCountryM*> *countries;
@property (nonatomic, copy) DDNationalityPickerDoneBlock onSelection;
@property (nonatomic, copy) DDNationalityPickerHideBlock onHide;

+(DDNationalityPicker*)loadPicker;
-(void)selectCountry:(NSNumber*)country_id;

+(void)showPicker:(NSString*)title selectedNationality:(DDCountryM*)selectedNational countries:(NSArray<DDCountryM*>*)countries selectionBlock:(DDNationalityPickerDoneBlock)doneBlock hideBlock:(DDNationalityPickerHideBlock)hideBlock;

@end

NS_ASSUME_NONNULL_END
