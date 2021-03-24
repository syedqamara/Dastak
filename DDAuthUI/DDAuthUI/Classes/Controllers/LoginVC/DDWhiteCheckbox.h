//
//  DDWhiteCheckbox.h
//  Thedynamicdelivery
//
//  Created by Kamil Kocemba on 13/06/2013.
//  Copyright (c) 2013 Future Workshops. All rights reserved.
//


@protocol DDWhiteCheckboxBlueDelegate  <NSObject>

-(void) didTapOnCheckBox:(BOOL) isOnOff checkBox:(id)checkBox;

@end


@interface DDWhiteCheckboxBlue : UIButton

@property (nonatomic, assign) BOOL on;
@property (nonatomic, weak) id<DDWhiteCheckboxBlueDelegate> delegate;


- (void)setOn:(BOOL)on;
- (void)setOnWithoutCallback:(BOOL)on;

@end



@interface DDWhiteCheckbox : UIButton

@property (nonatomic, assign) BOOL on;

- (void)setOn:(BOOL)on;

@end
