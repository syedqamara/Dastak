//
//  DDGeneralVM.h
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface DDGeneralVM : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *sub_title;
@property (strong, nonatomic) NSString *image_url;
-(instancetype)initWithTitle:(NSString *)title andSubtitle:(NSString *)subTitle andImage:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
