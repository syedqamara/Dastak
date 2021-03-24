//
//  DDCashlessOutletImageAttributeCVC.m
//  DDCashlessUI
//
//  Created by Awais Shahid on 17/03/2020.
//

#import "DDCashlessOutletImageAttributeCVC.h"

@interface DDCashlessOutletImageAttributeCVC()
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DDCashlessOutletImageAttributeCVC

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setData:(id)data {
    DDOutletAttributes *attribute = (DDOutletAttributes*)data;
    if (attribute==nil) return;
    [self.imageView loadImageWithString:attribute.value forClass:self.class];
    [super setData:data];
}

- (void)designUI {
    
}

@end
