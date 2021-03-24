//
//  DDSmilesHeaderTableViewCell.h
//  DDAccountsUI
//
//  Created by M.Jabbar on 20/03/2020.
//

#import <UIKit/UIKit.h>
#import <DDUI/DDUI.h>


NS_ASSUME_NONNULL_BEGIN

@interface DDSmilesHeaderTableViewCell : DDBaseTVC
@property (nonatomic, weak) IBOutlet UILabel *currentSmilesCountLbl;
@property (nonatomic, weak) IBOutlet UILabel *expiredSmilesCountLbl;
@property (nonatomic, weak) IBOutlet UILabel *currentSmilesCountLblTitle;
@property (nonatomic, weak) IBOutlet UILabel *messsageLabel;

@end

NS_ASSUME_NONNULL_END
