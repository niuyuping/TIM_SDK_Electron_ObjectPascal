unit YDProfileUnit;

interface

uses
  YDLoginTypeUnit, IMRendererTypeUnit;

type
  TYDProfile = class (TObject)
  private
    FTIM_AddPermission: NativeInt;
    FTIM_Birthday: TDate;
    FTIM_FaceURL: String;
    FTIM_Gender: NativeInt;
    FTIM_UserID: String;
    FTIM_Language: NativeInt;
    FTIM_Level: NativeInt;
    FTIM_NickName: String;
    FTIM_Location: String;
    FTIM_Role: NativeInt;
    FTIM_Signature: String;
    FTIM_PhoneNumber: String;
    FYD_AvatarURL: String;
    FYD_Company: String;
    FYD_CreateAt: String;
    FYD_Department: String;
    FYD_EMail: String;
    FYD_ID: String;
    FYD_LastLoginAt: String;
    FYD_Mobile: String;
    FYD_Name: String;
    FYD_QuickMark: String;
    FYD_Token: String;
    FYD_updatedAt: String;
    FYD_UserSig: String;
  public
    property AddPermission: NativeInt read FTIM_AddPermission write FTIM_AddPermission;
    property Birthday: TDate read FTIM_Birthday write FTIM_Birthday;
    property FaceURL: String read FTIM_FaceURL write FTIM_FaceURL;
    property Gender: NativeInt read FTIM_Gender write FTIM_Gender;
    property UserID: String read FTIM_UserID write FTIM_UserID;
    property Language: NativeInt read FTIM_Language write FTIM_Language;
    property Level: NativeInt read FTIM_Level write FTIM_Level;
    property Location: String read FTIM_Location write FTIM_Location;
    property NickName: String read FTIM_NickName write FTIM_NickName;
    property Role: NativeInt read FTIM_Role write FTIM_Role;
    property Signature: String read FTIM_Signature write FTIM_Signature;
    property PhoneNumber: String read FTIM_PhoneNumber write FTIM_PhoneNumber;
    property AvatarURL: String read FYD_AvatarURL write FYD_AvatarURL;
    property Company: String read FYD_Company write FYD_Company;
    property CreateAt: String read FYD_CreateAt write FYD_CreateAt;
    property Department: String read FYD_Department write FYD_Department;
    property EMail: String read FYD_EMail write FYD_EMail;
    property ID: String read FYD_ID write FYD_ID;
    property LastLoginAt: String read FYD_LastLoginAt write FYD_LastLoginAt;
    property Mobile: String read FYD_Mobile write FYD_Mobile;
    property Name: String read FYD_Name write FYD_Name;
    property QuickMark: String read FYD_QuickMark write FYD_QuickMark;
    property Token: String read FYD_Token write FYD_Token;
    property updatedAt: String read FYD_updatedAt write FYD_updatedAt;
    property UserSig: String read FYD_UserSig write FYD_UserSig;

    procedure LoadFromYDResponse(AResponse: TYDLoginResponse);
    procedure LoadFromTIMResponse(AResponse: TTIMUserProfile);
  end;

implementation

procedure TYDProfile.LoadFromYDResponse(AResponse: TYDLoginResponse);
begin
  FYD_AvatarURL:=AResponse.avatarUrl;
  FYD_Company:=AResponse.company;
  FYD_CreateAt:=AResponse.createdAt;
  FYD_Department:=AResponse.department;
  FYD_EMail:=AResponse.email;
  FYD_ID:=AResponse.id;
  FYD_LastLoginAt:=AResponse.lastLoginAt;
  FYD_Mobile:=AResponse.mobile;
  FYD_Name:=AResponse.name;
  FYD_QuickMark:=AResponse.quickMark;
  FYD_Token:=AResponse.token;
  FYD_updatedAt:=AResponse.updatedAt;
  FYD_UserSig:=AResponse.userSig;
end;

procedure TYDProfile.LoadFromTIMResponse(AResponse: TTIMUserProfile);
begin
  FTIM_AddPermission:=AResponse.user_profile_add_permission;
  FTIM_Birthday:=AResponse.user_profile_birthday;
  FTIM_FaceURL:=AResponse.user_profile_face_url;
  FTIM_Gender:=AResponse.user_profile_gender;
  FTIM_UserID:=AResponse.user_profile_identifier;
  FTIM_Language:=AResponse.user_profile_language;
  FTIM_Level:=AResponse.user_profile_level;
  FTIM_NickName:=AResponse.user_profile_nick_name;
  FTIM_Location:=AResponse.user_profile_location;
  FTIM_Role:=AResponse.user_profile_role;
  FTIM_Signature:=AResponse.user_profile_self_signature;
  if Length(AResponse.user_profile_custom_string_array)>0 then
    FTIM_PhoneNumber:=AResponse.user_profile_custom_string_array[0].user_profile_custom_string_info_value;
end;

end.