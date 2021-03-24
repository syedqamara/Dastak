//
//  DDCustomiseHeaderView.h
//  The Entertainer
//
//  Created by apple on 5/31/18.
//  Copyright © 2018 Future Workshops. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDCustomiseOptionCell.h"
#import "DDUI.h"

@protocol DDCustomiseHeaderViewDelegate <NSObject>

- (void)didHeaderSelectedWithMode:(DDCustomiseOption)mode atIndex:(NSInteger)index;

@end

@interface DDCustomiseHeaderView : DDUIBaseView {
    BOOL headerIsSelected;
}

@property (weak, nonatomic) IBOutlet UIView *checkMarkView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnSelection;
@property (nonatomic) NSInteger index;
@property (weak, nonatomic) id<DDCustomiseHeaderViewDelegate> delegate;

@property (nonatomic) BOOL isHeaderSelected;
- (IBAction)btnSelectionAction:(id)sender;

@end
