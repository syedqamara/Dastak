//
//  DDDatePicker.m
//  DDUI
//
//  Created by M.Jabbar on 15/04/2020.
//

#import "DDDatePicker.h"

@interface DDDatePicker()

@property (nonatomic, copy) NSDateFormatter *dateFormator;

@end
@implementation DDDatePicker
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dateFormat = @"";
        self.dateFormator = [[NSDateFormatter alloc] init];
        [self.dateFormator setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];

    }
    return self;
}
-(void)setupDateOfBirth:(NSString*)dateOfBirth dateFormate:(NSString*)dateFormate{

    self.dateFormator.dateFormat = dateFormate;

    if (dateOfBirth) {
        self.date = [self.dateFormator dateFromString:dateOfBirth];
    }else{
        self.selectedDateBlock([self.dateFormator stringFromDate:self.date]);
    }
    self.datePickerMode = NSDateIntervalFormatterShortStyle;
    [self addTarget:self action:@selector(valueChanged) forControlEvents: UIControlEventValueChanged];
}
-(void)valueChanged{
    self.dateFormator.dateFormat = self.dateFormat;
    self.selectedDateBlock([self.dateFormator stringFromDate:self.date]);
}
@end
