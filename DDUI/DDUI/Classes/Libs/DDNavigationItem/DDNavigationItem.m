//
//  DDNavigationItem.m
//  DDUI
//
//  Created by Awais Shahid on 14/02/2020.
//

#import "DDNavigationItem.h"
#import "DDCommons.h"

@interface DDNavigationItem()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewW;

@end


@implementation DDNavigationItem

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initViews];
}

-(void)initViews {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = NO;
    self.clipsToBounds = NO;
    self.textLbl.font = [UIFont DDMediumFont:17];
}

- (void)setText:(NSString *)text {
    self.textLbl.text = text.localized;
    [self.textLbl setHidden:text.length == 0];
}
-(NSString *)text {
    return self.textLbl.text;
}
- (void)setImage:(NSString *)image {
    if ([self.identifier isEqualToString:BACK_BTN_IDDDIFIER]) {
        self.imageViewW.constant = 12;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }

    self.imageView.hidden = image.length == 0;
    if (self.tintColor != nil) {
        [self.imageView loadTemplateImageWithString:image forClass:self.class];
    }else {
        [self.imageView loadImageWithString:image forClass:self.class];
    }
    [self layoutIfNeeded];
    
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.textLbl.textColor = tintColor;
    self.imageView.tintColor = tintColor;
}

- (IBAction)btnAction:(UIButton*)sender {
    if (self.completion!=nil) {
        self.completion(self);
    }
}


@end
