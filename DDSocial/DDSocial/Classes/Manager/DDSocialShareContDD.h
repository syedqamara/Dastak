//
//  DDSocialShareContent.h
//  DDSocial
//
//  Created by Awais Shahid on 19/04/2020.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSocialShareContent : JSONModel
@property (strong, nonatomic) NSString <Optional> *text;
@property (strong, nonatomic) NSString <Optional> *sub_text;
@property (strong, nonatomic) NSString <Optional> *url;
@end

NS_ASSUME_NONNULL_END
