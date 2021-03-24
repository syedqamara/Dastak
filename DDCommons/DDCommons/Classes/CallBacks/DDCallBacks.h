//
//  DDCommonCallBack.h
//  DDCommons
//
//  Created by Awais Shahid on 17/02/2020.
//

#ifndef DDCallBacks_h
#define DDCallBacks_h


#endif /* DDCommonCallBack_h */

typedef void(^ _Nullable ControllerCallBack)(NSString * _Nullable identifier, id _Nullable data, UIViewController * _Nonnull controller);
typedef void(^ _Nullable DataCompletionCallBack)(id _Nullable);
typedef void(^ _Nullable VoidCompletionCallBack)(void);
typedef void(^ _Nullable BoolCompletionCallBack)(BOOL);
typedef void(^ _Nullable IntCompletionCallBack)(int);
typedef void(^ _Nullable StringCompletionCallBack)(NSString* _Nullable);
typedef void(^ _Nullable StatusCompletionCallBack)(BOOL, NSString* _Nullable);
typedef void(^ _Nullable DeeplinkInvokingCallback)(id _Nullable data, UIViewController * _Nullable controller);
