//
//  DDExtraUtil.m
//  Thedynamicdelivery
//
//  Created by Raheel Ahmad on 10/12/15.
//  Copyright © 2015 THE dynamicdelivery. All rights reserved.
//

#import "DDExtraUtil.h"
#import "DDCommons.h"

@implementation DDExtraUtil

+ (NSString *) getDefaultTimezone{
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSString *tzName = [timeZone name];
    return tzName;
}


+(NSDate *) getMaxBirthdayDate{
    
    NSDate *maxDate = [self TC_dateByAddingCalendarUnits:NSCalendarUnitYear amount:-10];
    return maxDate;
}

+(NSDate *) getMinBirthdayDate{
    NSDate *minDate = [self TC_dateByAddingCalendarUnits:NSCalendarUnitYear amount:-116];
    return minDate;
}

+ (NSDate *)TC_dateByAddingCalendarUnits:(NSCalendarUnit)calendarUnit amount:(NSInteger)amount {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *newDate;
    
    switch (calendarUnit) {
        case NSCalendarUnitSecond:
            [components setSecond:amount];
            break;
        case NSCalendarUnitMinute:
            [components setMinute:amount];
            break;
        case NSCalendarUnitHour:
            [components setHour:amount];
            break;
        case NSCalendarUnitDay:
            [components setDay:amount];
            break;
        case NSCalendarUnitWeekOfMonth:
            [components setWeekOfMonth:amount];
            break;
        case NSCalendarUnitMonth:
            [components setMonth:amount];
            break;
        case NSCalendarUnitYear:
            [components setYear:amount];
            break;
        default:
            [DDLogs log:@"addCalendar does not support that calendarUnit!"];
            break;
    }
    
    newDate = [gregorian dateByAddingComponents:components toDate:[NSDate date] options:0];
    return newDate;
}


+(NSString *) getDayOrNight{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger hour = [components hour];
    
    if(hour >= 7 && hour < 12){
        return @"day";
    }
    else if(hour >= 12 && hour <= 19){
        return @"day";
    }
    else {//if(hour >= 17){
        return @"night";
    }
}

+ (BOOL)validateEmail: (NSString *)value {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:value];
}

+(NSString *) getTimeSting:(NSString *) date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate * dateTemp = [formatter dateFromString:date];
    return [dateTemp timeAgo];
    
}

+(NSString *) formatNumber:(NSNumber *) value{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    [nf setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    return [nf stringFromNumber:value];
}

// MARK: - Calendar Component from Current Locale
+(NSDateComponents *)getCalendarCopmonetFromLocale: (NSString *)dateStr :(NSString*)strFormate{
    
    NSDate *dateFromString = [[self getLocaleDateFormater:NSLocalizedString(strFormate, nil) ] dateFromString:NSLocalizedString(dateStr, nil)];
    NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components =
    [gregorian components:(NSCalendarUnitMonth |
                           NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitCalendar) fromDate:dateFromString];
    return components;
}
//MARK: - Locale Date Formater
+(NSDateFormatter *)getLocaleDateFormater :(NSString*)strFormate{
    NSLocale *locale = NSLocale.currentLocale;
     NSString *formateStr = NSLocalizedString(strFormate, nil) ;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [NSDateFormatter dateFormatFromTemplate:formateStr options:0 locale:locale];
    [dateFormatter setDateFormat:formateStr];
    return dateFormatter;
}

+(NSAttributedString *)convertString:(NSString *)string toFont:(UIFont*)textFont toColor:(UIColor *)color {
    NSDictionary *attrs = @{ NSForegroundColorAttributeName : color, NSFontAttributeName: textFont };
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attrStr;
}
@end
