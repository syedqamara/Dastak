//
//  UICollectionView+DDSERegistration.m
//  DDSE
//
//  Created by Syed Qamar Abbas on 11/14/18.
//

#import "UICollectionView+DDRegistration.h"
#import "NSBundle+DDNSBundle.h"

@implementation UICollectionView(DDRegistration)

-(void)registerCellWithNibNames:(NSArray <NSString *> *)nibNames forClass:(Class)cls withIdentifiers:(NSArray <NSString *> *)identifiers {
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = identifiers[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forCellWithReuseIdentifier:identifier];
    }
}
-(void)registerCells:(NSArray <NSString *> *)nibNames forClass:(Class)cls {
    for (NSInteger index = 0; index < nibNames.count; index++) {
        NSString *nibName = nibNames[index];
        NSString *identifier = nibNames[index];
        UINib *nib = [UINib nibWithNibName:nibName bundle:[NSBundle getNibBundle:cls]];
        [self registerNib:nib forCellWithReuseIdentifier:identifier];
    }
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
        [self registerCellWithNibNames:@[key] forClass:cls withIdentifiers:@[value]];
        [self registerCellAtIndex:index + 1 fromDict:dict forClass:cls];
    }
}
@end
