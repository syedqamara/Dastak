//
//  DDAuthUINativePickerVC.m
//  DDExpress
//
//  Created by Syed Qamar Abbas on 02/07/2019.
//

#import "DDAuthUINativePickerVC.h"

@interface DDAuthUINativePickerVC ()<UIPickerViewDelegate, UIPickerViewDataSource>{
    BOOL isGenderPicker;
     NSInteger selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *datasourceArray;


@end

@implementation DDAuthUINativePickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datasourceArray = self.navigation.routerModel.data;
    if ([self.datasourceArray containsObject:@"Female"] && [self.datasourceArray containsObject:@"Male"]){
        isGenderPicker = YES;
    }
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.tintColor = UIColor.redColor;
    [self.pickerView reloadAllComponents];
    // Do any additional setup after loading the view from its nib.
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    return self;
}
-(UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (IBAction)btnDoneAction:(id)sender {
    [self goBackWithCompletion:^{
        [self.navigation.routerModel sendDataCallback:nil withData:self.datasourceArray[[self.pickerView selectedRowInComponent:0]] withController:self];
    }];
}

- (IBAction)btnCloseAction:(id)sender {
    
    [self goBackWithCompletion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.datasourceArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (isGenderPicker){
        return [self.datasourceArray objectAtIndex:row];
    }else{
        DDCountryM *country = [self.datasourceArray objectAtIndex:row];
        return country.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//
//
//    if (self.completion != nil) {
//        self.completion([self.pickerView selectedRowInComponent:0], self);
//    }
}
+(void)setRouteConfiguration {
    [DDUIRouterConfigurationM configureWithRouteName:DD_Nav_Auth_Native_Picker andModuleName:@"DDAuthUI" withClassRef:self.class];
}
@end
