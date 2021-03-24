//
//  UITableView+DDSERegistration.m
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import "UITableView+DDRegistration.h"
#import "NSBundle+DDNSBundle.h"
@implementation UITableView(DDRegistration)

-(void)registerCellWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers {
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = identifiers[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }
}
-(void)registerCells:(NSArray <NSString *> *)nibNames forClass:(Class)cls {
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = nibNames[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forCellReuseIdentifier:identifier];
    }
}
-(void)registerHeaderFooterWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers {
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = identifiers[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    }
}
-(void)registerTHFV:(NSArray <NSString *> *)nibNames forClass:(Class)cls{
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = nibNames[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (NSArray *)indexesOfVisibleSections {
    // Note: We can't just use indexPathsForVisibleRows, since it won't return index paths for empty sections.
    NSMutableArray *visibleSectionIndexes = [NSMutableArray arrayWithCapacity:self.numberOfSections];
    for (int i = 0; i < self.numberOfSections; i++) {
        CGRect headerRect;
        // In plain style, the section headers are floating on the top, so the section header is visible if any part of the section's rect is still visible.
        // In grouped style, the section headers are not floating, so the section header is only visible if it's actualy rect is visible.
//        if (self.style == UITableViewStylePlain) {
            headerRect = [self rectForSection:i];
//        } else {
//            headerRect = [self rectForHeaderInSection:i];
//        }
        
//        if (headerRect.size.height == 0) {
//            headerRect.size.height = 10;
//        }
        // The "visible part" of the tableView is based on the content offset and the tableView's size.
        CGRect visiblePartOfTableView = CGRectMake(self.contentOffset.x, self.contentOffset.y + 15, self.bounds.size.width, self.bounds.size.height);
        if (CGRectIntersectsRect(visiblePartOfTableView, headerRect)) {
            [visibleSectionIndexes addObject:@(i)];
        }
        if (headerRect.origin.y > visiblePartOfTableView.origin.y) {
            [visibleSectionIndexes addObject:@(i-1)];
            return visibleSectionIndexes;
        }
    }
    return visibleSectionIndexes;
}

- (NSArray *)visibleSections {
    NSMutableArray *visibleSects = [NSMutableArray arrayWithCapacity:self.numberOfSections];
    for (NSNumber *sectionIndex in self.indexesOfVisibleSections) {
        UITableViewHeaderFooterView *sectionHeader = [self headerViewForSection:sectionIndex.intValue];
        [visibleSects addObject:sectionHeader];
    }

    return visibleSects;
}
-(void)showLoadMore {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60)];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
    activityIndicator.hidesWhenStopped = TRUE;
    [activityIndicator startAnimating];
    activityIndicator.center = footerView.center;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityIndicator.color = UIColor.darkGrayColor;
    [footerView addSubview:activityIndicator];
    self.tableFooterView = footerView;
}

-(void)hideLoadMode{
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}
-(void)registerCell:(NSDictionary <NSString *, NSString *>*)cellInfo forClass:(Class)cls {
    if (cellInfo.allKeys.count > 0) {
        [self registerCellAtIndex:0 fromDict:cellInfo forClass:cls];
    }
}
-(void)registerCellAtIndex:(NSInteger)index fromDict:(NSDictionary *)dict forClass:(Class)cls{
    if (index < dict.allKeys.count) {
        NSString *key = dict.allKeys[index];
        NSString *value = dict[key];
        [self registerCellWithNibNames:@[value] forClass:cls withIdentifiers:@[key]];
        [self registerCellAtIndex:index + 1 fromDict:dict forClass:cls];
    }
}
@end
