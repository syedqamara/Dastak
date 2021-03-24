//
//  UITableView+DDSERegistration.h
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(DDRegistration)
-(void)registerCells:(NSArray <NSString *> *)nibNames forClass:(Class)cls;
-(void)registerCellWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers;
-(void)registerHeaderFooterWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers;
-(void)registerTHFV:(NSArray <NSString *> *)nibNames forClass:(Class)cls;
-(void)registerCell:(NSDictionary <NSString *, NSString *>*)cellInfo forClass:(Class)cls;
- (NSArray *)indexesOfVisibleSections;
- (NSArray *)visibleSections;
-(void)showLoadMore;
-(void)hideLoadMode;
@end

NS_ASSUME_NONNULL_END
