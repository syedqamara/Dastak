//
//  DDPingsSentVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDPingsSentVC.h"
#import "DDPingsManager.h"
#import "DDSentPingsTVC.h"
#import "DDPingsUIManager.h"

@interface DDPingsSentVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray<DDPingModel *> *pingsArray;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tblSentPings;
@end

@implementation DDPingsSentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableCells];
}

- (void)loadData {
    [self getSentHistory];
}

-(void)registerTableCells{
    NSArray *cells = @[DDSendPingsTableCell];
    [self.tblSentPings registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tblSentPings.delegate = self;
    self.tblSentPings.dataSource = self;
    self.tblSentPings.estimatedRowHeight = 156;
    self.tblSentPings.rowHeight = UITableViewAutomaticDimension;
    self.tblSentPings.allowsSelection = YES;
}

-(void)getSentHistory{
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    [DDPingsManager.shared getPingsSendHistory:pingRequestM andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self checkEmptyResponse:model];
        if (error == nil) {
            DDPingsBaseModel *apimodel = (DDPingsBaseModel *)model.data;
            self->pingsArray = [[NSArray alloc] initWithArray:apimodel.shareOffers];
            [self.tblSentPings reloadData];
            self.callBackAfterDataLoaded(apimodel.ping_section);
        }else{
            [DDAlertUtils showOkAlertWithTitle:nil subtitle:error.localizedDescription completion:nil];
        }
    }];
}

-(void)checkEmptyResponse:(DDPingApiModel*)response {
    if (response.data.shareOffers.count == 0) {
        DDEmptyViewModel *emptyVM = [DDEmptyViewModel new];
        
        NSString *title = response.title;
        if (title.length==0) title = @"It’s time to share pings with your friends.";
        emptyVM.title = title;
        
        NSString *sub_title;// = response.data.message ? response.data.message : response.message;
        if (sub_title.length==0) sub_title = @"You can send offers, to send more you can buy back offers to share.";
        emptyVM.sub_title = sub_title;
        
        emptyVM.image = @"sent_pings_empty.png";
        [DDEmptyView showInConatiner:self.view withEmptyViewModel:emptyVM completion:nil];
    }
}

 // MARK:- Table View DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDSentPingsTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDSendPingsTableCell];
    cell.callBackAfterPing = ^(DDPingApiModel * _Nonnull model) {
        if (model.success != nil && [model.success boolValue]) {
            [self getSentHistory];
            NSString *msg = model.data.message ? model.data.message : model.message;
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:msg completion:nil];
        }
    };
    [cell setData:pingsArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDPingModel*object = pingsArray[indexPath.row];
    if (object && object.merchant_id){
        DDMerchantDetailRequestM *model = [[DDMerchantDetailRequestM alloc] init];
        [model getReqParams];
        model.outlet_id = object.outlet_id ? object.outlet_id : @(0);
        model.merchant_id = object.merchant_id;
        [[DDPingsUIManager shared] showMerchantDetailsFrom:self withOutlet:model andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        }];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pingsArray.count;
}


@end
