//
//  DDMerchantHeroImgCVC.m
//  DDOutletsUI
//
//  Created by Zubair Ahmad on 05/03/2020.
//

#import "DDCashlessMerchantHeroImgCVC.h"
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>
@implementation DDCashlessMerchantHeroImgCVC

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
