//
//  DDFamilyInvitationView.h
//  DDFamilyUI
//
//  Created by Awais Shahid on 26/03/2020.
//

#import "DDUIBaseView.h"

#define ACTION_SHEET_MEDIA_H 190

NS_ASSUME_NONNULL_BEGIN

@interface DDCustomeActionSheetM : JSONModel

@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *subtitle;
@property (nonatomic, strong) NSString<Optional> *Image;

@property (nonatomic, strong) NSNumber<Optional> *hideCross;

@property (nonatomic, strong) NSArray<Optional> *btnsArray;

@end

@interface DDCustomActionSheet : DDUIBaseView
@property (nonatomic, copy) VoidCompletionCallBack dimissCallBack;
+(void)showWithData:(DDCustomeActionSheetM*)data withCompletion:(IntCompletionCallBack)completion;
@end

NS_ASSUME_NONNULL_END
