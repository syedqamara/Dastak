//
//  UICollectionView+DDSERegistration.h
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView(DDRegistration)
-(void)registerCells:(NSArray <NSString *> *)nibNames forClass:(Class)cls;
-(void)registerCellWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers ;
-(void)registerCell:(NSDictionary <NSString *, NSString *>*)cellInfo forClass:(Class)cls;
@end

NS_ASSUME_NONNULL_END
