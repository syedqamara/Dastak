//
//  DDNationalityPicker.m
//  DDUI
//
//  Created by M.Jabbar on 09/01/2020.
//

#import "DDNationalityPicker.h"
#import "UIFont+DDFont.h"

@implementation DDNationalityPicker

- (void)awakeFromNib{
    [super awakeFromNib];
}
+(void)showPicker:(NSString*)title selectedNationality:(DDCountryM*)selectedNational countries:(NSArray<DDCountryM*>*)countries selectionBlock:(DDNationalityPickerDoneBlock)doneBlock hideBlock:(DDNationalityPickerHideBlock)hideBlock
{
    DDNationalityPicker * _Nonnull nationalityPicker = (DDNationalityPicker*)[[NSBundle loadNibFromBundle:self nibName:@"DDNationalityPicker"] instantiateWithOwner:self options:nil].firstObject;
    nationalityPicker.backgroundColor = [DDUIThemeManager.shared.selected_theme.bg_black.colorValue colorWithAlphaComponent:0.8];
    
    nationalityPicker.doneButton.tintColor = DDUIThemeManager.shared.selected_theme.text_theme.colorValue;
    nationalityPicker.toolBar.tintColor = DDUIThemeManager.shared.selected_theme.bg_white.colorValue;
    
    nationalityPicker.countries = countries;
    nationalityPicker.selectedNationality = selectedNational;
    nationalityPicker.onSelection = doneBlock;
    nationalityPicker.onHide = hideBlock;
    
    [nationalityPicker setUp];

    if (selectedNational) {
        NSInteger selectedIndex = [countries indexOfObjectIdenticalTo:selectedNational];
        [nationalityPicker.pickerView selectRow:selectedIndex inComponent:0 animated:YES];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    nationalityPicker.frame = window.frame;
    nationalityPicker.alpha = 0;

    [window addSubview:nationalityPicker];

    [UIView animateKeyframesWithDuration:0.5 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
       
        nationalityPicker.alpha = 1;

    } completion:^(BOOL finished) {
        if (finished) {
            if (countries.count>0 && selectedNational == nil){
                [nationalityPicker.pickerView selectRow:0 inComponent:0 animated:YES];
                nationalityPicker.onSelection(countries[0]);
            }
        }
    }];
}
+(DDNationalityPicker*)loadPicker{
    UINib *nib = [NSBundle loadNibFromBundle:self nibName:NSStringFromClass(DDNationalityPicker.class)];
    DDNationalityPicker *picker = (DDNationalityPicker *)[nib instantiateWithOwner:self options:nil][0];
    [picker setUp];
    return picker;
}
-(void)setUp{
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneButtonTapped:)];
    [self addGestureRecognizer:tapGesture];
}
-(void)selectCountry:(NSNumber*)country_id {
    NSUInteger index = [self.countries indexOfObjectPassingTest:^BOOL(DDCountryM * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return obj.country_id.intValue == country_id.intValue;
    }];
    [self.pickerView selectRow:index inComponent:0 animated:YES];
    self.onSelection(self.countries[index]);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.countries.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
   UILabel *itemLabel = [[UILabel alloc] init];
    itemLabel.font = [UIFont DDMediumFont:23.0];
    itemLabel.numberOfLines = 0;
    itemLabel.textColor = DDUIThemeManager.shared.selected_theme.text_black_40.colorValue;
    [itemLabel sizeToFit];
    itemLabel.textAlignment = NSTextAlignmentCenter;
    itemLabel.text = self.countries[row].name;
    return itemLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedNationality = self.countries[row];
    self.onSelection(self.countries[row]);
}
-(IBAction)doneButtonTapped:(id)sender{
    [UIView animateKeyframesWithDuration:0.5 delay:0.1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    self.onHide();
}
@end
