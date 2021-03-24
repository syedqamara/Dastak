//
//  DDNavSearchView.h
//  DDUI
//
//  Created by Zubair Ahmad on 28/01/2020.
//

#import "DDUIBaseView.h"
#import "DDUIThemeManager.h"

NS_ASSUME_NONNULL_BEGIN


@protocol DDNavSearchViewDelegate <NSObject>

@required
- (void)navSearchViewBackButtonTapped;

@optional
- (void)openSearchScreen;

@end

@interface DDNavSearchView : DDUIBaseView 

@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) id <DDNavSearchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
