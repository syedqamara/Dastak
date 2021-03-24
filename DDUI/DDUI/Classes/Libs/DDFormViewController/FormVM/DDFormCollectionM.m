//
//  DDFormCollectionM.m
//  AppAuth
//
//  Created by Syed Qamar Abbas on 15/10/2020.
//

#import "DDFormCollectionM.h"
@interface DDFormCollectionM ()

@property (strong, nonatomic) NSMutableArray <DDFormM *> *forms;

@end

@implementation DDFormCollectionM
-(instancetype)init {
    self = [super init];
    self.forms = [NSMutableArray new];
    return self;
}
-(NSArray <DDFormM *> *)allForms {
    return self.forms;
}
-(void)add:(DDFormM *)form {
    [self.forms addObject:form];
}
-(NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (DDFormM *form in self.forms) {
        [dict addEntriesFromDictionary:form.toKeyValueDictionary];
    }
    return dict;
}
-(BOOL)isAllRequiredInputGiven {
    BOOL isReadyToSubmit = YES;
    for (DDFormM *form in self.forms) {
        if (form.isRequired && !form.isValueProvided) {
            isReadyToSubmit = NO;
            break;
        }
    }
    return isReadyToSubmit;
}
@end
