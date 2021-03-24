//
//  DDAlertUtils.m
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import "DDAlertUtils.h"
#import <DDCommons/DDCommons.h>
#import <DDConstants/DDConstants.h>
#import <UIKit/UIKit.h>

@interface DDAlertUtils() {
    UIAlertAction *textfieldSaveAction;
    UIAlertController *alertController;
}

@end

@implementation DDAlertUtils

#pragma mark - Alert

static DDAlertUtils *_sharedObject;
+(DDAlertUtils *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[DDAlertUtils alloc]init];
    });
    return _sharedObject;
}


+(void)showOkAlertWithTitle:(NSString* _Nullable)title subtitle:(NSString* _Nullable)subtitle completion:(VoidCompletionCallBack)completion {
    [DDAlertUtils showAlertWithTitle:title subtitle:subtitle buttonNames:@[OK] highlightedAt:100 onClick:^(int index) {
        if (completion) completion();
    }];
}

+(void)showAlertWithTitle:(NSString *_Nullable)title subtitle:(NSString *_Nullable)subtitle buttonNames:(NSArray <NSString *>*)buttons onClick:(IntCompletionCallBack)completion {
    [DDAlertUtils showAlertWithTitle:title subtitle:subtitle buttonNames:buttons highlightedAt:100 onClick:completion];
}

+(void)showAlertWithTitle:(NSString *_Nullable)title subtitle:(NSString *_Nullable)subtitle buttonNames:(NSArray <NSString *>*)buttons highlightedAt:(NSUInteger)index onClick:(IntCompletionCallBack)completion {
    if (title.length == 0 && subtitle.length == 0) return;
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:title.localized message:subtitle.localized preferredStyle:UIAlertControllerStyleAlert];
    for(int i=0; i<buttons.count; i++) {
        NSString *txt = [buttons objectAtIndex:i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:txt.localized style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion != nil)
                completion(i);
        }];
        [alert addAction:action];
        if (i == index) [alert setPreferredAction:action];
    }
    [UIApplication.topMostController presentViewController:alert animated:true completion:nil];
}

+(UIAlertController*)addPreferredAlert:(NSString *)title subtitle:(NSString *)subtitle preferredIndex:(NSUInteger) highlightedIndex shouldHighlight:(BOOL)shouldHighlight buttonNames:(NSArray<NSString *> *)buttons onClick:(void (^)(NSInteger))completion{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:[title localized] message:[subtitle localized] preferredStyle:UIAlertControllerStyleAlert];
    for(int i=0; i<buttons.count; i++) {
        NSString *btnText = [[buttons objectAtIndex:i] localized];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion != nil)
                completion(i);
        }];
        
        [alert addAction:action];
        if ((buttons.count > 0) && shouldHighlight) { // if you want to bold the button text , just preferred that action
            if (i == highlightedIndex){
                [alert setPreferredAction:action];
            }
        }
    }
    return alert;
}


#pragma mark - ActionSheet

+(void)showCancelActionSheetWithTitle:(NSString* _Nullable)title message:(NSString* _Nullable)message buttonTexts:(NSArray* _Nullable)buttonTexts completion:(void (^ _Nullable)(int))completion {
    [self showActionSheetWithTitle:title message:message buttonTexts:buttonTexts completion:completion cancelBtnText:@"Cancel" cancelButtonAction:nil];
}


+(void)showActionSheetWithTitle:(NSString* _Nullable)title message:(NSString* _Nullable)message buttonTexts:(NSArray* _Nullable)buttonTexts completion:(void (^ _Nullable)(int))completion cancelBtnText:(NSString *_Nullable)cancelBtnText cancelButtonAction:(void (^ __nullable)(void))cancelButtonAction {
    
    if (buttonTexts.count == 0)
        return;
    
    UIAlertControllerStyle style = IS_IPAD ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[title localized] message:[message localized] preferredStyle:style];
    for(int i=0; i<buttonTexts.count; i++) {
        NSString *btnText = [[buttonTexts objectAtIndex:i] localized];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (completion != nil)
                completion(i);
        }];
        [alert addAction:action];
    }
    
    if (cancelBtnText.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[cancelBtnText localized] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelButtonAction != nil)
                cancelButtonAction();
        }];
        [alert addAction:action];
    }
    
    [UIApplication.topMostController presentViewController:alert animated:true completion:nil];
}

- (void)showLoginWithThirdPartyResult:(NSString *)emailStr andFirstName:(NSString *)firstName andLastName:(NSString *)lastName withCompletion:(void (^ _Nullable)(NSString * _Nullable email,NSString * _Nullable firstName,NSString * _Nullable lastName))completion {
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Login details".localized message:@"Please provide following details to proceed" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email".localized;
        if (emailStr.length > 0) {
            textField.text = emailStr;
        }
        textField.textColor = UIColor.blackColor;
        textField.tag = 1;
        [textField addTarget:self action:@selector(textChangedInAlert:) forControlEvents:UIControlEventEditingChanged];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"First Name".localized;
        if (firstName.length > 0) {
            textField.text = firstName;
        }
        textField.textColor = UIColor.blackColor;
        textField.tag = 1;
        [textField addTarget:self action:@selector(textChangedInAlert:) forControlEvents:UIControlEventEditingChanged];
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Last Name".localized;
        [textField addTarget:self action:@selector(textChangedInAlert:) forControlEvents:UIControlEventEditingChanged];
        if (lastName.length > 0) {
            textField.text = lastName;
        }
        textField.textColor = UIColor.blackColor;
        textField.tag = 0;
    }];
    
    textfieldSaveAction = [UIAlertAction actionWithTitle:SUBMIT.localized style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *email = alert.textFields[0].text.trimmedString;
        NSString *firstName = alert.textFields[1].text.trimmedString;
        NSString *lastName = alert.textFields[2].text.trimmedString;
        if (email.length == 0 || !email.isValidEmail){
            alert.textFields[0].textColor = UIColor.redColor;
            [UIApplication.topMostController presentViewController:alert animated:YES completion:nil];
        }
        else if (firstName.length == 0){
            alert.textFields[1].textColor = UIColor.redColor;
            [UIApplication.topMostController presentViewController:alert animated:YES completion:nil];
        }
        else if (completion != nil) {
            if (completion) {
                completion(email, firstName, lastName);
            }
            
        }
    }];
        self->textfieldSaveAction = nil;
    [alert addAction:textfieldSaveAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL.localized style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(nil,nil,nil);
    }];
    [alert addAction:cancel];
    
    [UIApplication.topMostController presentViewController:alert animated:YES completion:nil];
}

- (void)showNameInputAlertWithCompletion:(void (^ _Nullable)(NSString * _Nullable))completion {
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"Add Name".localized message:@"Enter Details".localized preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name".localized;
        [textField addTarget:self action:@selector(textChangedInAlert:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    textfieldSaveAction = [UIAlertAction actionWithTitle:SAVE.localized style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alert.textFields.firstObject.text.trimmedString;
        if (name.length == 0 ){
            [alert.textFields.firstObject customPlaceHolderColor:UIColor.redColor];
        }
        else if (completion != nil) {
            completion(name);
            self->textfieldSaveAction = nil;
        }
    }];
    textfieldSaveAction.enabled = NO;
    [alert addAction:textfieldSaveAction];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:CANCEL.localized style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completion(nil);
    }];
    [alert addAction:cancel];
    
    [UIApplication.topMostController presentViewController:alert animated:YES completion:nil];
}

-(void)textChangedInAlert:(UITextField*)textFiled {
        textFiled.textColor = UIColor.blackColor;
    textfieldSaveAction.enabled = textFiled.text.trimmedString.length > 0;
}

@end
