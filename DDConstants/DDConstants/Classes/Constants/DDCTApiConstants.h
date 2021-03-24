//
//  DDCTApiConstants.h
//  DDConstants
//
//  Created by Syed Qamar Abbas on 31/12/2019.
//

#import <Foundation/Foundation.h>


typedef NSString * DDApisType NS_STRING_ENUM;
static DDApisType const TrafficRed = @"Red";

static DDApisType const DDApisType_Auth_Verify_OTP = @"DDApisType_Auth_Verify_OTP";
static DDApisType const DDApisType_Auth_Send_OTP = @"DDApisType_Auth_Send_OTP";
static DDApisType const DDApisType_Auth_Login = @"DDApisType_Auth_Login";
static DDApisType const DDApisType_Auth_SignUp = @"DDApisType_Auth_SignUp";
static DDApisType const DDApisType_Auth_SignUp_Third_Party = @"DDApisType_Auth_SignUp_Third_Party";
static DDApisType const DDApisType_Auth_SignUpEmail_Validateion = @"DDApisType_Auth_SignUp_Email_Validateion";
static DDApisType const DDApisType_Auth_Forgot_Password = @"DDApisType_Auth_Forgot_Password";
static DDApisType const DDApisType_Auth_User_Profile = @"DDApisType_Auth_User_Profile";
static DDApisType const DDApisType_Auth_ResendEmail = @"DDApisType_Auth_ResendEmail";
static DDApisType const DDApisType_Auth_UpdateProfile = @"DDApisType_Auth_UpdateProfile";
static DDApisType const DDApisType_Auth_UpdateDemographics = @"DDApisType_Auth_UpdateDemographics";
static DDApisType const DDApisType_Auth_Update_Password = @"DDApisType_Auth_Update_Password";
static DDApisType const DDApisType_Auth_Change_Email = @"DDApisType_Auth_Change_Email";
static DDApisType const DDApisType_Auth_Change_Password = @"DDApisType_Auth_Change_Password";

static DDApisType const DDApisType_Auth_Logout = @"DDApisType_Auth_Logout";
static DDApisType const DDApisType_Auth_Verify_Key = @"DDApisType_Auth_Verify_Key";
static DDApisType const DDApisType_Auth_User_profile_with_id = @"DDApisType_Auth_User_profile_with_id";
static DDApisType const DDApisType_Auth_Redemption_Sync = @"DDApisType_Auth_Redemption_Sync";

static DDApisType const DDApisType_Home_Home = @"DDApisType_Home_Home";
static DDApisType const DDApisType_Home_Trial_Info = @"DDApisType_Home_Trial_Info";
static DDApisType const DDApisType_Google_Direction = @"DDApisType_Google_Direction";
static DDApisType const DDApisType_C2C_FAIRS = @"DDApisType_C2C_FAIRS";
static DDApisType const DDApisType_App_Configs = @"DDApisType_App_Configs";
static DDApisType const DDApisType_App_Destination_Country = @"DDApisType_App_Destination_Country";
static DDApisType const DDApisType_App_Password_Rules = @"DDApisType_App_Password_Rules";
static DDApisType const DDApisType_App_PendingNotifications = @"DDApisType_App_PendingNotifications";
static DDApisType const DDApisType_App_Cheers_confirmation = @"DDApisType_App_Cheers_confirmation";

static DDApisType const DDApisType_Pings_Send = @"DDApisType_Pings_Send";
static DDApisType const DDApisType_Pings_ReceivedHistory = @"DDApisType_Pings_ReceivedHistory";
static DDApisType const DDApisType_Pings_SendHistory = @"DDApisType_Pings_SendHistory";
static DDApisType const DDApisType_Pings_AcceptPings = @"DDApisType_Pings_AcceptPings";
static DDApisType const DDApisType_Pings_RecallPing = @"DDApisType_Pings_RecallPing";

static DDApisType const DDApisType_Redemption_History = @"DDApisType_Redemption_History";
static DDApisType const DDApisType_Redemption_BuyBack = @"DDApisType_Redemption_BuyBack";
static DDApisType const DDApisType_Reservations_History = @"DDApisType_Reservations_History";
static DDApisType const DDApisType_Redemption_Redemptions = @"DDApisType_Redemption_Redemptions";
static DDApisType const DDApisType_Redemption_NETWORK_CHECK = @"DDApisType_Redemption_NETWORK_CHECK";

static DDApisType const DDApisType_Filter_Get_Filters = @"DDApisType_Filter_Get_Filters";
static DDApisType const DDApisType_Filter_Get_Delivery_Filters = @"DDApisType_Filter_Get_Delivery_Filters";
static DDApisType const DDApisType_Filter_Get_Count = @"DDApisType_Filter_Get_Count";

static DDApisType const DDApisType_Search_Auto_Suggest = @"DDApisType_Search_Auto_Suggest";
static DDApisType const DDApisType_Search_Places = @"DDApisType_Search_Places";
static DDApisType const DDApisType_Outlet_Search = @"DDApisType_Outlet_Search";

static DDApisType const DDApisType_Outlet_Listing = @"DDApisType_Outlet_Listing";
static DDApisType const DDApisType_Outlet_Detail = @"DDApisType_Outlet_Detail";
static DDApisType const DDApisType_Outlet_Online_Offer_History = @"DDApisType_Outlet_Online_Offer_History";

static DDApisType const DDApisType_Family_My_Family = @"DDApisType_Family_My_Family";
static DDApisType const DDApisType_Family_Leave_Family = @"DDApisType_Family_Leave_Family";
static DDApisType const DDApisType_Family_Remove_Member = @"DDApisType_Family_Remove_Member";
static DDApisType const DDApisType_Family_Re_Activate_Family = @"DDApisType_Family_Re_Activate_Family";
static DDApisType const DDApisType_Family_Edit_Family_Member_Cheers = @"DDApisType_Family_Edit_Family_Member_Cheers";
static DDApisType const DDApisType_Family_Resend_Invitation = @"DDApisType_Family_Resend_Invitation";
static DDApisType const DDApisType_Family_Cancel_Invitation = @"DDApisType_Family_Cancel_Invitation";
static DDApisType const DDApisType_Family_Accept_Invitation = @"DDApisType_Family_Accept_Invitation";
static DDApisType const DDApisType_Family_Edit_Member = @"DDApisType_Family_Edit_Member";
static DDApisType const DDApisType_Family_Add_Member = @"DDApisType_Family_Add_Member";
static DDApisType const DDApisType_Family_Member_Details = @"DDApisType_Family_Member_Details";
static DDApisType const DDApisType_Family_Pending_Invites = @"DDApisType_Family_Pending_Invites";

static DDApisType const DDApisType_Friends_Ranking = @"DDApisType_Friends_Ranking";
static DDApisType const DDApisType_Friends_Remove = @"DDApisType_Friends_Remove";

static DDApisType const DDApisType_Account_Settings = @"DDApisType_Account_Settings";
static DDApisType const DDApisType_Account_Submit_Feed_Back = @"DDApisType_Account_Submit_Feed_Back";
static DDApisType const DDApisType_Account_Buy_Smiles_Pack = @"DDApisType_Account_Buy_Smiles_Pack";
static DDApisType const DDApisType_Account_Savings = @"DDApisType_Account_Savings";

static DDApisType const DDApisType_Products_Profile_Section = @"DDApisType_Products_Profile_Section";
static DDApisType const DDApisType_Products_Merchant_Detail = @"DDApisType_Products_Merchant_Detail";
static DDApisType const DDApisType_Products_Purchase_History = @"DDApisType_Products_Purchase_History";

static DDApisType const DDApisType_Locations_Locations = @"DDApisType_Locations_Locations";

static DDApisType const DDApisType_Cashless_Locations = @"DDApisType_Cashless_Locations";
static DDApisType const DDApisType_Cashless_Add_Location = @"DDApisType_Cashless_Add_Location";
static DDApisType const DDApisType_Cashless_Update_Location = @"DDApisType_Cashless_Update_Location";
static DDApisType const DDApisType_Cashless_Delete_Location = @"DDApisType_Cashless_Delete_Location";
static DDApisType const DDApisType_Cashless_Merchant_Detail = @"DDApisType_Cashless_Merchant_Detail";
static DDApisType const DDApisType_Cashless_Reorder_Validation = @"DDApisType_Cashless_Reorder_Validation";
static DDApisType const DDApisType_Cashless_Order_History = @"DDApisType_Cashless_Order_History";
static DDApisType const DDApisType_Cashless_Order_Detail = @"DDApisType_Cashless_Order_Detail";
static DDApisType const DDApisType_Cashless_Current_Order_Status = @"DDApisType_Cashless_Current_Order_Status";
static DDApisType const DDApisType_Cashless_Pending_Order_Status = @"DDApisType_Cashless_Pending_Order_Status";
static DDApisType const DDApisType_Cashless_Outlet_Online_Status = @"DDApisType_Cashless_Outlet_Online_Status";
static DDApisType const DDApisType_Cashless_Order_Reorder = @"DDApisType_Cashless_Order_Reorder";
static DDApisType const DDApisType_Cashless_Current_Order_Picked_Up = @"DDApisType_Cashless_Current_Order_Picked_Up";
static DDApisType const DDApisType_Cashless_Current_Cancel_Order = @"DDApisType_Cashless_Current_Cancel_Order";
static DDApisType const DDApisType_Cashless_Current_Edit_Order = @"DDApisType_Cashless_Current_Edit_Order";
static DDApisType const DDApisType_Cashless_Current_Check_Edit_Order = @"DDApisType_Cashless_Current_Check_Edit_Order";

static DDApisType const DDApisType_Favourites_Favourites = @"DDApisType_Favourites_Favourites";
static DDApisType const DDApisType_Favourites_Mark_Favourites = @"DDApisType_Favourites_Mark_Favourites";
static DDApisType const DDApisType_Favourites_Remove_Favourites = @"DDApisType_Favourites_Remove_Favourites";

static DDApisType const DDApisType_Analytics_Post_App_Analytics = @"DDApisType_Analytics_Post_App_Analytics";


static DDApisType const DDApisType_Submit_Rating = @"DDApisType_Submit_Rating";
