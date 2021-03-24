//
//  DDFormM.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDFormM.h"


@implementation DDFormM
-(BOOL)isRequired {
    return self.is_required.boolValue;
}
-(BOOL)isValueProvided {
    NSString *str = [NSString stringWithFormat:@"Override `isValueProvided` method in class %@",NSStringFromClass(self.class)];
    NSAssert(false, str);
    return nil;
}
-(NSMutableDictionary *)toKeyValueDictionary {
    NSString *str = [NSString stringWithFormat:@"Override `toKeyValueDictionary` method in class %@",NSStringFromClass(self.class)];
    NSAssert(false, str);
    return nil;
}
-(void)updateValue {
    NSString *str = [NSString stringWithFormat:@"Override `updateValue` method in class %@",NSStringFromClass(self.class)];
    NSAssert(false, str);
}
+(DDFormM *)formWithTitle:(NSString *)title andValueKey:(NSString *)key withImage:(NSString *)image classType:(Class)cls isRequired:(BOOL)isRequired withValue:(id _Nullable)value {
    return [cls formWithTitle:title andValueKey:key withImage:image classType:cls isRequired:isRequired withValue:value];
}

@end


@implementation DDTextFormM
+(DDFormM *)formWithTitle:(NSString *)title andValueKey:(NSString *)key withImage:(NSString *)image classType:(Class)cls isRequired:(BOOL)isRequired withValue:(id _Nullable)value {
    DDTextFormM *form = [DDTextFormM new];
    form.title = title;
    form.key = key;
    form.image = image;
    form.type = cls;
    form.is_required = @(isRequired);
    form.value = value;
    return form;
}
-(NSMutableDictionary *)toKeyValueDictionary {
    if (self.value.length > 0) {
        return @{self.key: self.value}.mutableCopy;
    }
    return nil;
}
-(BOOL)isValueProvided {
    return self.value.length > 0 || self.edit_value.length > 0;
}
-(void)updateValue {
    self.value = self.edit_value;
}
@end
