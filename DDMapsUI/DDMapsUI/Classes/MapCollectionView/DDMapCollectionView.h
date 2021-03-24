//
//  DDMapCollectionView.h
//  DDMapsUI
//
//  Created by Zubair Ahmad on 11/02/2020.
//

#import <UIKit/UIKit.h>
#import <DDCommons/DDCommons.h>
#import "DDMapCVC.h"
#import "DDMapsThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDMapCollectionViewDelegate  <NSObject>

-(void)didSelectCollectionViewCellWithOutlet:(id)outlet;
-(void)didHiglightMapPinWithOutlet:(id)outlet;
@end

@interface DDMapCollectionView : UICollectionView

@property (weak, nonatomic, nullable) id<DDMapCollectionViewDelegate> mapDelegate;

@property (nonatomic, strong) NSMutableArray *outlets;

-(void)selectOutlet:(id)outlet;

@end

NS_ASSUME_NONNULL_END
