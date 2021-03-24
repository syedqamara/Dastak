//
//  DDHomeBaseTVC.h
//  DDHomeUI
//
//  Created by Awais Shahid on 09/03/2020.
//

#import <DDUI/DDUI.h>
#import <DDCommons/DDCommons.h>
#import <DDModels/DDModels.h>

#import "DDHomeUIConstants.h"
#import "DDHomeThemeManager.h"
#import "CustomViewFlowLayoutCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeBaseTVC : DDBaseTVC
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@end

NS_ASSUME_NONNULL_END
