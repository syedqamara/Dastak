//
//  DDUIThemeCollectionViewCell.h
//  DDUI
//
//  Created by Syed Qamar Abbas on 01/01/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import <DDConstants/DDConstants.h>
#import "UIFont+DDFont.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDUIThemeCollectionViewCell : UICollectionViewCell
-(void)designUI;
-(void)setData:(id)data;
@end

NS_ASSUME_NONNULL_END
