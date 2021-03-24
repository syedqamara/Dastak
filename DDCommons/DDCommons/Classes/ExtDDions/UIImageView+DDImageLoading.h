//
//  UIImageView+DDSEImageLoading.h
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import <UIKit/UIKit.h>
//#import <SDWebImage/UIImageView+WebCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DDUIImage)
- (UIImage *)setTintColor:(UIColor *)color;
@end

@interface UIImageView(DDImageLoading)
///Non Rendering Mode as Template

-(void)loadImageWithString:(NSString * _Nullable)imageString forClass:(Class)cls;
-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder forClass:(Class)cls;

///Rendering Mode as Template
-(void)loadTemplateImageWithString:(NSString * _Nullable)imageString forClass:(Class)cls;
-(void)loadTemplateImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder forClass:(Class)cls;
-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage * _Nullable)placeholder forClass:(Class)cls completion:(void (^)(UIImage * _Nullable image))completion;
@end
@interface UIButton(DDImageLoading)
-(void)loadImageWithStringWithoutTemplate:(NSString * _Nullable)imageString forClass:(Class)cls;
-(void)loadImageWithString:(NSString * _Nullable)imageString forClass:(Class)cls;
-(void)loadImageWithString:(NSString * _Nullable)imageString forState:(UIControlState)buttonState forClass:(Class)cls;
-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder forClass:(Class)cls;
@end

NS_ASSUME_NONNULL_END
