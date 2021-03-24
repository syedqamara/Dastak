//
//  DDFavouritesApiManager.m
//  DDFavourites
//
//  Created by M.Jabbar on 04/03/2020.
//

#import "DDFavouritesApiManager.h"
#import "DDFavouritesConstants.h"
#import <DDModels/DDModels.h>

@implementation DDFavouritesApiManager

-(void)favourites {
//    self.base_url = @"https://entqacart.etenvbiz.com/temp/jsons/";
}
-(void)markFavourite {}
-(void)removeFavourite {}

+(void)registerApiConfiguration {
    
    [DDApisConfiguration registerConfigurations:DDApisType_Favourites_Favourites classObj:self responseClassObj:DDFavouritesApiM.class selector:@selector(favourites) endPoint:DDFAVOURITES_EP_FAVOURITES isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
     [DDApisConfiguration registerConfigurations:DDApisType_Favourites_Mark_Favourites classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(markFavourite) endPoint:DDFAVOURITES_EP_MARK_FAVOURITE isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
    
    [DDApisConfiguration registerConfigurations:DDApisType_Favourites_Remove_Favourites classObj:self responseClassObj:DDBaseApiModel.class selector:@selector(removeFavourite) endPoint:DDFAVOURITES_EP_REMOVE_FAVOURITE isEncryptedEnabled:YES isSSLPinningEnabled:NO authorizationType:DDApiAuthorizationTypeBasicAuth];
}
@end
