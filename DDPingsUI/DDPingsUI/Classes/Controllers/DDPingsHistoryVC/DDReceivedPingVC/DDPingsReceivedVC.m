//
//  DDPingsReceivedVC.m
//  DDPingsUI
//
//  Created by Hafiz Aziz on 29/01/2020.
//

#import "DDPingsReceivedVC.h"
#import "DDPingsManager.h"
#import "DDReceivedPingsTVC.h"
#import "DDReceivedPingsHFV.h"

@interface DDPingsReceivedVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray<DDPingModel *> *pingsArray;
    BOOL hasAnyAcceptableOffer;
}
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *tblReceivedPings;

@end

@implementation DDPingsReceivedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableCells];
    hasAnyAcceptableOffer = NO;
}

- (void)loadData {
    [self getReceivedHistory];
}

-(void)registerTableCells{
    NSArray *header = @[DDReceivedPingsHeaderCell];
    NSArray *cells = @[DDReceivedPingsTableCell];
    [self.tblReceivedPings registerHeaderFooterWithNibNames:header forClass:self.class withIdentifiers:header];
    [self.tblReceivedPings registerCellWithNibNames:cells forClass:self.class withIdentifiers:cells];
    self.tblReceivedPings.delegate = self;
    self.tblReceivedPings.dataSource = self;
    self.tblReceivedPings.estimatedRowHeight = 156;
    self.tblReceivedPings.rowHeight = UITableViewAutomaticDimension;
    self.tblReceivedPings.estimatedSectionHeaderHeight = 30;
    self.tblReceivedPings.sectionHeaderHeight = UITableViewAutomaticDimension;
}

-(void)getReceivedHistory{
    DDPingRequestM *pingRequestM = [[DDPingRequestM alloc] init];
    pingRequestM.customer_id = DDUserManager.shared.currentUser.user_id;
    [DDPingsManager.shared getPingsReceivedHistory:pingRequestM andCompletion:^(DDPingApiModel * _Nullable model, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self checkEmptyResponse:model];
        if (error == nil) {
            DDPingsBaseModel *apimodel = (DDPingsBaseModel *)model.data;
            self->pingsArray = [[NSArray alloc] initWithArray:apimodel.shareOffers];
            self->hasAnyAcceptableOffer = NO;
            for (DDPingModel *model in self->pingsArray){
                if (!model.isAccepted) {
                    self->hasAnyAcceptableOffer = YES;
                    break;
                }
            }
            [self.tblReceivedPings reloadData];
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
        if (title.length==0) title = @"You have not received any ping(s) yet.";
        emptyVM.title = title;
        
        NSString *sub_title; //= response.data.message ? response.data.message : response.message;
        if (sub_title.length==0) sub_title = @"You can receive unlimited offers now ";
        emptyVM.sub_title = sub_title;

        emptyVM.image = @"received_pings_empty.png";
        [DDEmptyView showInConatiner:self.view withEmptyViewModel:emptyVM completion:nil];
    }
}

 // MARK:- Table View DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DDReceivedPingsTVC *cell = [tableView dequeueReusableCellWithIdentifier:DDReceivedPingsTableCell];
    cell.callBackAfterPing = ^(DDPingApiModel * _Nonnull model) {
        if ([model.data.status boolValue]) {
            [self getReceivedHistory];
            NSString *msg = model.data.message ? model.data.message : model.message;
            [DDAlertUtils showOkAlertWithTitle:model.title subtitle:msg completion:nil];
        }
    };
    [cell setData:pingsArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return pingsArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (hasAnyAcceptableOffer)
        return UITableViewAutomaticDimension;
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (hasAnyAcceptableOffer){
        DDReceivedPingsHFV *view = [self.tblReceivedPings dequeueReusableHeaderFooterViewWithIdentifier:DDReceivedPingsHeaderCell];
        view.callBackAfterAcceptAll = ^(DDPingApiModel * _Nonnull model) {
            if ([model.data.status boolValue]) {
                [self getReceivedHistory];
            }
        };
        [view setData:pingsArray];
        return view;
    } else {
        return [UIView new];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDPingModel*object = pingsArray[indexPath.row];
    if (object && object.outlet_id && object.merchant_id){
       DDMerchantDetailRequestM *model = [[DDMerchantDetailRequestM alloc] init];
        [model getReqParams];
        model.outlet_id = object.outlet_id;
        model.merchant_id = object.merchant_id;
        [[DDPingsUIManager shared] showMerchantDetailsFrom:self withOutlet:model andControllerCallBack:^(NSString * _Nullable identifier, id  _Nullable data, UIViewController * _Nonnull controller) {
        }];
    }
}

@end
