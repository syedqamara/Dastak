//
//  DDEmptyViewModel.h
//  DDModels
//
//  Created by Awais Shahid on 10/02/2020.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDEmptyViewModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *image;
@property (nonatomic, strong) NSString <Optional> *title;
@property (nonatomic, strong) NSString <Optional> *sub_title;
@property (nonatomic, strong) NSString <Optional> *btn_title;
@property (nonatomic, strong) NSNumber <Optional> *imageHeight;
@property (nonatomic, strong) NSNumber <Optional> *textAlignment;
+(DDEmptyViewModel*)internetVM;
-(void)setDefaultTextAlignment:(NSTextAlignment)alignment;
-(NSTextAlignment)defaultTextAlignment;

@end

NS_ASSUME_NONNULL_END
