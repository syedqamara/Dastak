//
//  UIImageView+DDSEImageLoading.m
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import "UIImageView+DDImageLoading.h"
#import <SDWebImage/SDWebImage.h>
#import "NSBundle+DDNSBundle.h"
#import "UIView+DDView.h"
#import "NSString+DDString.h"
@implementation UIImage(DDUIImage)

-(UIImage *)setTintColor:(UIColor *)color {
    UIImage *image = self;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);

    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, image.CGImage);
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [color setFill];
    CGContextFillRect(context, rect);


    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return coloredImage;
}

@end

@implementation UIImageView(DDImageLoading)

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}
-(void)loadImageWithString:(NSString * _Nullable)imageString forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        __weak typeof(self) weakSelf = self;
        [self sd_cancelCurrentImageLoad];
        self.image = nil;
        [self sd_setImageWithURL:imageUrl placeholderImage:nil options:(SDWebImageScaleDownLargeImages) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.image = image;
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    
//                });
            });
        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        self.image = image;
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        self.image = image;
    }else {
        self.image = [UIImage.alloc init];
    }
}
-(void)loadTemplateImageWithString:(NSString * _Nullable)imageString  forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [self sd_setImageWithURL:imageUrl placeholderImage:nil options:(SDWebImageRefreshCached) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            });
        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        self.image = image;
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        self.image = image;
    }else {
        self.image = [UIImage.alloc init];
    }
}
-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder forClass:(Class)cls {
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        
        [self sd_setImageWithURL:imageUrl placeholderImage:placeholder options:(SDWebImageRefreshCached) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                self.image = placeholder;
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            }
        }];
        //[self sd_setImageWithURL:imageUrl placeholderImage:placeholder];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        self.image = image;
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        self.image = image;
    }else {
        self.image = placeholder;
    }
}
-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage * _Nullable)placeholder forClass:(Class)cls completion:(void (^)(UIImage * _Nullable image))completion {
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        
        [self sd_setImageWithURL:imageUrl placeholderImage:placeholder options:(SDWebImageRefreshCached) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                self.image = placeholder;
            } else {
                completion(image);
            }
        }];
        //[self sd_setImageWithURL:imageUrl placeholderImage:placeholder];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        completion(image);

    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        completion(image);
    }else {
        self.image = placeholder;
    }
}
-(void)loadTemplateImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        
        [self sd_setImageWithURL:imageUrl placeholderImage:placeholder options:(SDWebImageRefreshCached) completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            });
        }];
        //[self sd_setImageWithURL:imageUrl placeholderImage:placeholder];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        self.image = image;
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        self.image = image;
    }else {
        self.image = placeholder;
    }
}
@end

@implementation UIButton(DDImageLoading)
-(void)loadImageWithStringWithoutTemplate:(NSString * _Nullable)imageString forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [self sd_setImageWithURL:imageUrl forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:image forState:(UIControlStateNormal)];
            });

        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        [self setImage:image forState:(UIControlStateNormal)];
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        [self setImage:image forState:(UIControlStateNormal)];
    }else {
        [self setImage:UIImage.new forState:(UIControlStateNormal)];
    }
}
-(void)loadImageWithString:(NSString * _Nullable)imageString forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [self sd_setImageWithURL:imageUrl forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UIImage *newImage = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:newImage forState:(UIControlStateNormal)];
            });

        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        [self setImage:image forState:(UIControlStateNormal)];
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        [self setImage:image forState:(UIControlStateNormal)];
    }else {
        [self setImage:UIImage.new forState:(UIControlStateNormal)];
    }
}
-(void)loadImageWithString:(NSString * _Nullable)imageString forState:(UIControlState)buttonState forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [self sd_setImageWithURL:imageUrl forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UIImage *newImage = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:newImage forState:(buttonState)];
            });

        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        [self setImage:image forState:(buttonState)];
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        [self setImage:image forState:(buttonState)];
    }else {
        [self setImage:UIImage.new forState:(buttonState)];
    }
}

-(void)loadImageWithString:(NSString * _Nullable)imageString withPlaceHolderImage:(UIImage *)placeholder  forClass:(Class)cls{
    if ([imageString containsString:@"http"]) {
        NSURL *imageUrl = [NSURL URLWithString:imageString];
        [self sd_setImageWithURL:imageUrl forState:(UIControlStateNormal) placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            UIImage *newImage = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:newImage forState:(UIControlStateNormal)];
            });
        }];
    }else if ([imageString.lowercaseString containsString:@".png"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".png" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundlePNG:cls imageName:str];
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
        [self setImage:image forState:(UIControlStateNormal)];
        
    }else if ([imageString.lowercaseString containsString:@".jpg"]){
        NSString *str = [imageString stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        UIImage *image = [NSBundle loadImageFromResourceBundleJPG:cls imageName:str];
        [self setImage:image forState:(UIControlStateNormal)];
    }else {
        [self setImage:UIImage.new forState:(UIControlStateNormal)];
    }
}
@end
