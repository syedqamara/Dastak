//
//  DDExtraUtil.h
//  Thedynamicdelivery
//
//  Created by Raheel Ahmad on 10/12/15.
//  Copyright © 2015 THE dynamicdelivery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDExtraUtil : NSObject

+ (NSString *) getDefaultTimezone;
+(NSDate *) getMaxBirthdayDate;
+(NSDate *) getMinBirthdayDate;
+ (NSDate *)TC_dateByAddingCalendarUnits:(NSCalendarUnit)calendarUnit amount:(NSInteger)amount ;
+(NSString *) getDayOrNight;
+ (BOOL)validateEmail: (NSString *)value ;
+(NSString *) getTimeSting:(NSString *) date;
// MARK: - Calendar Component from Current Locale
+(NSDateComponents *)getCalendarCopmonetFromLocale: (NSString *)dateStr :(NSString*)strFormate;
//MARK: - Locale Date Formater
+(NSDateFormatter *)getLocaleDateFormater :(NSString*)strFormate;
+(NSAttributedString *)convertString:(NSString *)string toFont:(UIFont*)textFont toColor:(UIColor *)color ;
+(NSString *) formatNumber:(NSNumber *) value;
@end
