//
//  DDCheckbox.m
//  DDUI
//
//  Created by Awais Shahid on 04/02/2020.
//

#import "DDCheckbox.h"
#import "NSBundle+DDNSBundle.h"

@interface DDCheckbox() {
    BOOL on;
    UIImage *checkedIcon;;
    UIImage *unCheckedIcon;
}
@end

@implementation DDCheckbox

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitials];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInitials];
}

-(void)setupInitials {
    checkedIcon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"checked"];
    unCheckedIcon = [NSBundle loadImageFromResourceBundlePNG:self.class imageName:@"un_checked"];
    [self addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    [self setChecked:NO];
}

- (BOOL)checked {
    return on;
}


- (void)setChecked:(BOOL)checked {
    on = checked;
    [self updateCurrentStateIcon];
}

- (UIImage *)checkedIcon {
    return checkedIcon;
}

- (UIImage *)unCheckedIcon {
    return unCheckedIcon;
}

- (void)setCheckedIcon:(UIImage *)checkedIcon {
    checkedIcon = checkedIcon;
}

- (void)setUnCheckedIcon:(UIImage *)unCheckedIcon {
    unCheckedIcon = unCheckedIcon;
}

- (void)toggle {
    on = !on;
    [self updateCurrentStateIcon];
    if (self.stateChanged != nil) {
        self.stateChanged(on, self);
    }
}

-(void)updateCurrentStateIcon {
    UIImage *img = on ? checkedIcon : unCheckedIcon;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setBackgroundImage:img forState:UIControlStateNormal];
    });
}



@end



