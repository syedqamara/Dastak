//
//  DDFilterOptionsTVC.m
//  The Entertainer
//
//  Created by Raheel on 23/01/2018.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import "DDFilterOptionsTVC.h"

@interface DDFilterOptionsTVC()

@property (nonatomic, weak) IBOutlet UILabel *titleLbl;
@property (nonatomic, weak) IBOutlet UIImageView *tickImgView;

@end

@implementation DDFilterOptionsTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
-(void)setData:(id)data {
    DDFiltersOptionM* filters = data;
    self.titleLbl.text = filters.title;

    if (filters.selected.intValue == 1){
        [self.tickImgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"filter_selected"]];
    } else {
        [self.tickImgView setImage:[NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"filter_un_selected"]];
    }
    
    [super setData:data];
}

-(void)designUI {
    self.titleLbl.font = [UIFont DDRegularFont:17];
    self.titleLbl.textColor = DDFiltersThemeManager.shared.selected_theme.text_black_40.colorValue;
}


@end
