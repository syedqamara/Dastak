//
//  DDBaseModel.h
//  DDModels
//
//  Created by M.Jabbar on 12/02/2020.
//

#import "JSONModel.h"
#import "DDCommons.h"
#import "DDJSONModelProtocols.h"
NS_ASSUME_NONNULL_BEGIN

@interface DDBaseModel : JSONModel
@property (strong, nonatomic) NSNumber <Ignore> *is_dummy;
-(BOOL)isDummy;
@end

NS_ASSUME_NONNULL_END
