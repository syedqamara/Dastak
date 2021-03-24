//
//  DDMerchantHeroImgCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDMerchantHeroImgCVC.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
@implementation DDMerchantHeroImgCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)designUI{
    [super designUI];
}

-(void)setData:(id)data {
    NSString *imgUrl = (NSString*)data;
    [self.imgView loadImageWithString:imgUrl forClass:self.class];
    [super setData:data];
}
@end
