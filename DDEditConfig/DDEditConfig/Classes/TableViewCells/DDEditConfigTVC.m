//
//  DDEditConfigTVC.m
//  DDEditConfig
//
//  Created by Syed Qamar Abbas on 06/04/2020.
//

#import "DDEditConfigTVC.h"
#import "DDEditConfigM.h"
@interface DDEditConfigTVC(){
    DDEditConfigM *config;
}

@end
@implementation DDEditConfigTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.dataTextField addTarget:self action:@selector(didChangeText) forControlEvents:(UIControlEventEditingChanged)];
    // Initialization code
}
-(void)setData:(id)data {
    config = (DDEditConfigM *)data;
    self.titleLabel.text = config.title;
    self.dataTextField.text = config.data;
}
-(void)didChangeText {
    config.data = self.dataTextField.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
