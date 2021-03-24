//
//  DDOutletsLAttributeCVC.m
//  DDHomeUI
//
//  Created by Zubair Ahmad on 30/01/2020.
//

#import "DDOutletsLAttributeCVC.h"
#import <DDCommons/DDCommons.h>
#import "UIFont+DDFont.h"
#import "SDWebImage.h"
#import <DDModels/DDModels.h>
#import "DDOutletsThemeManager.h"

@implementation DDOutletsLAttributeCVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)designUI {
    self.label.font = [UIFont DDMediumFont:13];
    [super designUI];
}
-(void)setData:(id)attribs {
    DDOutletAttributes *attribute =  (DDOutletAttributes*)attribs;
    self.imgView.hidden = true;
    self.featuredLabel.hidden = true;
    self.label.hidden = true;
    
    self.label.text = @"";
    self.featuredLabel.text = @"FEATURED".localized;
    
    if(attribute && attribute.is_featured && [attribute.is_featured boolValue]){
        self.featuredLabel.hidden = false;
    }
    
    if([attribute.type isEqualToString:@"text"]){
        self.label.hidden = false;
        self.label.text = attribute.value;
    } else {
        self.label.hidden = false;
        self.imgView.hidden = false;
        [self.imgView setImage:nil];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:attribute.value]];
    }
    [super setData:attribute];
}
@end

