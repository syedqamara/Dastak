//
//  DDCountryM.m
//  DDCommons
//
//  Created by M.Jabbar on 07/01/2020.
//

#import "DDCountryM.h"

@implementation DDCountrySectionM

@end

@implementation DDCountryM
-(NSString *)titleWithImage {
    return [NSString stringWithFormat:@"%@", self.name];
}
-(NSString *)codeWithImage {
    return [NSString stringWithFormat:@"%@", self.code];
}
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"country_id", @"phone_code":@"code"}];
}

+(NSArray<DDCountryM*>*)countries {
    return [DDCountryM getCountriesData:@"countries"];
}
+(NSArray<DDCountryM*>*)countriesPhones {
    return [DDCountryM getCountriesData:@"country_phones"];
}


+(NSArray<DDCountryM*>*)getCountriesData:(NSString*)fileLocation {
    
    NSDictionary *countriesDic = [DDCountryM dictionaryWithContentsOfJSONString:[NSString stringWithFormat:@"%@.json",fileLocation]];
    NSError *error;
    NSArray *countriesList = [[countriesDic valueForKey:@"data"] valueForKey:@"countries"];
    NSMutableArray <DDCountryM*>*array = [NSMutableArray<DDCountryM*> new];
    for (NSDictionary *country in countriesList) {
        DDCountryM *data = [[DDCountryM alloc] initWithDictionary:country error:&error];
        if ([data.code containsString:@"-"]) {
            data.code = [data.code componentsSeparatedByString:@"-"].firstObject;
        }
        if (![data.code containsString:@"+"]) {
            data.code = [NSString stringWithFormat:@"+%@",data.code];
        }
        [array addObject:data];
    }
    
    return [self sortByCode:array];
}
+(NSArray<DDCountryM *> *)sortByCode:(NSArray *)arr {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"code"
                                               ascending:YES];
    NSArray *sortedArray = [arr sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedArray;
}
+(NSDictionary *)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension] ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    // Be careful here. You add this as a category to NSDictionary
    // but you get an id back, which means that result
    // might be an NSArray as well!
    if (error != nil) return nil;
    return result;
}

@end
