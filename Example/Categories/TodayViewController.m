//
//  TodayViewController.m
//  Categories
//
//  Created by Zubair Ahmad on 09/05/2020.
//

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define DEVICE_OFFSET (CGRectGetWidth([UIScreen mainScreen].bounds)/320)
#define CELL_WIDTH ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)?60:(52 * DEVICE_OFFSET))
#define CELL_SPACING 10

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_GREATER (IS_IPHONE && SCREEN_MAX_LENGTH > 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_X  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_XS  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_XR  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)
#define IS_IPHONE_XS_MAX  (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)
#define IS_IPHONE_WITH_NOTCH_DEVICES (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XS || IS_IPHONE_XS_MAX)



#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>



//#import "AppboyKit.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic,retain) NSMutableArray * catagoriesArray;
@end

@implementation TodayViewController

static CGFloat padding = 25.0;


-(BOOL) isIOS10{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _catagoriesArray = [[NSMutableArray alloc]init];
    
    NSString *jsonString = @"{  \"tiles\": [    {      \"is_free\": false,      \"tile_id\": 1,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_food.png\",      \"category_id\": 4,      \"analytics_category_name\": \"FD\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/food.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_food@2x.png\",      \"display_name\": \"   FOOD  & DRINK\",      \"api_name\": \"Restaurants and Bars\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_food@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"4F99D2\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_food@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_food@2x.png\"    },    {      \"is_free\": false,      \"tile_id\": 2,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_body.png\",      \"category_id\": 1,      \"analytics_category_name\": \"BF\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/body.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_body@2x.png\",      \"display_name\": \"BEAUTY & FITNESS\",      \"api_name\": \"Body\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_body@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"C7318C\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_body@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_body@2x.png\"    },    {      \"is_free\": false,      \"tile_id\": 3,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_leisure.png\",      \"category_id\": 3,      \"analytics_category_name\": \"AL\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/leisure.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_leisure@2x.png\",      \"display_name\": \"ATTRACTIONS & LEISURE\",      \"api_name\": \"Leisure\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_leisure@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"88C867\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_leisure@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_leisure@2x.png\"    },    {      \"is_free\": false,      \"tile_id\": 7,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_retail.png\",      \"category_id\": 7,      \"analytics_category_name\": \"FR\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/retail.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_retail@2x.png\",      \"display_name\": \"FASHION & RETAIL\",      \"api_name\": \"Retail\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_retail@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"9866AC\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_retail@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_retail@2x.png\"    },    {      \"is_free\": false,      \"tile_id\": 4,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_services.png\",      \"category_id\": 5,      \"analytics_category_name\": \"ES\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/services_2.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_services@2x.png\",      \"display_name\": \"EVERYDAY SERVICES\",      \"api_name\": \"Services\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_services@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"20909A\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_services@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_services@2x.png\"    },    {      \"is_free\": false,      \"tile_id\": 5,      \"featured_merchant_icon_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/ribbons\/cat_ribbon_travel.png\",      \"category_id\": 6,      \"analytics_category_name\": \"HW\",      \"image\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/travel.png\",      \"map_pin_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_invalid_travel@2x.png\",      \"display_name\": \"TRAVEL\",      \"api_name\": \"Travel\",      \"map_pin_selected_invalid_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_invalid_travel@2x.png\",      \"banner_image\": \"\",      \"category_color\": \"B3995D\",      \"map_pin_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_travel@2x.png\",      \"map_pin_selected_url\": \"https:\/\/s3.amazonaws.com\/entertainer-app-assets\/categories\/pins\/cat_pin_selected_travel@2x.png\"    }  ],  \"section_identifier\": \"categories\",  \"identifier\": \"categories\",  \"title\": \"\"}";
    
    [self.collView setBackgroundColor:[UIColor clearColor]];
    [self.collView setDataSource:self];
    [self.collView setDelegate:self];
    
    
    if([self isIOS10]){
        if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
            [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeExpanded];
        } else{
            [self.extensionContext setWidgetLargestAvailableDisplayMode:NCWidgetDisplayModeCompact];
        }
    }
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
        CGRect frame = self.collView.frame;
        frame.size.height = frame.size.height* 2;
        self.collView.frame = frame;
    }
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    _catagoriesArray = [responseDictionary valueForKey:@"tiles"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collView reloadData];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    completionHandler(NCUpdateResultNewData);
    self.preferredContentSize = CGSizeMake(self.collView.contentSize.width, self.collView.contentSize.height );
}


- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeCompact){
        // Changed to compact mode
        self.preferredContentSize = maxSize;
    }
    else{
        // Changed to expanded mode
        self.preferredContentSize = CGSizeMake(self.collView.contentSize.width, self.collView.contentSize.height);
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _catagoriesArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return [self isIOS10] ? 10 : 0;
//}

- (NSString *)URLEncodeStringFromString:(NSString *)string
{
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString * urlString = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return urlString;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * catagoryDic = [_catagoriesArray objectAtIndex:indexPath.row];
    //    NSURL *customURL = [NSURL URLWithString:[NSString stringWithFormat:@"entertainer://?cat_id=%@",[NSNumber numberWithInt:(int)indexPath.row]]];
    
    NSString *path = [NSString stringWithFormat:@"entertainer://OpenCategory?category=%@&offer_type=AllOffers&section_id=1", [self URLEncodeStringFromString:[catagoryDic valueForKey:@"api_name"]]];
    NSURL *customURL = [NSURL URLWithString:path];
    
    //    entertainer://OpenCategory?category=FoodAndDrink
    [self.extensionContext openURL:customURL completionHandler:^(BOOL success) {
        
    }];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DDCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCell" forIndexPath:indexPath];
    NSDictionary * catagoryDic = [_catagoriesArray objectAtIndex:indexPath.row];
    cell.titleLbl.text = [catagoryDic valueForKey:@"display_name"];
    cell.imgView.image = [UIImage imageNamed:[catagoryDic valueForKey:@"icon"]];
    if(![self isIOS10]){
        [cell.titleLbl setTextColor:[UIColor whiteColor]];
    } else {
        [cell.titleLbl setTextColor:[UIColor blackColor]];
    }
    [cell.imgView sd_setImageWithURL:[catagoryDic valueForKey:@"image"]];
    return cell;
}




//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    NSInteger viewWidth = CGRectGetWidth(self.view.frame);
//    NSInteger totalCellWidth = CELL_WIDTH * _catagoriesArray.count;
//    NSInteger totalSpacingWidth = CELL_SPACING * (_catagoriesArray.count -1);
//
//    NSInteger leftInset = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2;
//    NSInteger rightInset = leftInset;
//
//    return UIEdgeInsetsMake(0, [self isIOS10] ? leftInset : 0, 0, [self isIOS10] ? rightInset : 0);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CELL_WIDTH, 112);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:section];
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
        return UIEdgeInsetsMake(0, 5, 0, 5);
        numberOfItems = 3;
    }
    
    if (numberOfItems > 6){
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    
    CGFloat combinedItemWidth = (numberOfItems * CELL_WIDTH) + ((numberOfItems - 1) * ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing);
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    //    padding = 10.0; u
    return UIEdgeInsetsMake(0, padding, 0, padding);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  IS_IPHONE_6 || IS_IPHONE_6P ? 0 : 0;
}
@end
