// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Render Class Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRendererUnit;

interface

uses
  IMRendererTypeUnit;

type
  //TIM Render
  TTIMRenderer = class (TObject)
  private
    FOnGetSDKVersion: TOnGetSDKVersion;
    FOnGetSDKVersionError: TOnGetSDKVersion_Error;

    FOnGetServerTimer: TOnGetServerTime;
    FOnGetServerTimeError: TOnGetServerTime_Error;

    FOnInit: TOnInit;
    FOnInitError: TOnInit_Error;

    FOnUninit: TOnUninit;
    FOnUninitError: TOnUninit_Error;

    FOnGetLoginStatus: TOnGetLoginStatus;
    FOnGetLoginStatusError: TOnGetLoginStatus_Error;

    FOnGetLoginUserID: TOnGetLoginUserID;
    FOnGetLoginUserIDError: TOnGetLoginUserID_Error;

    FOnLogin: TOnLogin;
    FOnLoginError: TOnLogin_Error;

    FOnLogout: TOnLogout;
    FOnLogoutError: TOnLogout_Error;

    FOnGetUserProfileList: TOnGetUserProfileList;
    FOnGetUserProfileListError: TOnGetUserProfileList_Error;
  protected 
  public
    constructor Create;
  
    property OnGetSDKVersion: TOnGetSDKVersion read FOnGetSDKVersion write FOnGetSDKVersion;
    property OnGetSDKVersionError: TOnGetSDKVersion_Error read FOnGetSDKVersionError write FOnGetSDKVersionError;

    //取SDK版本号
    procedure GetSDKVersion;

    property OnGetServerTimer: TOnGetServerTime read FOnGetServerTimer write FOnGetServerTimer;
    property OnGetServerTimeError: TOnGetServerTime_Error read FOnGetServerTimeError write FOnGetServerTimeError;
 
    //取服务器时间
    procedure GetServerTime;

    property OnInit: TOnInit read FOnInit write FOnInit;
    property OnInitError: TOnInit_Error read FOnInitError write FOnInitError;

    //初始化
    procedure Init(AConfigPath: JSValue = Nil);

    property OnUninitError: TOnUninit_Error read FOnUninitError write FOnUninitError;
    property OnUninit: TOnUninit read FOnUninit write FOnUninit;

    //反初始化
    procedure Uninit;

    //设置网络状态回调
    procedure SetNetworkStatusListenerCallback(AProc: TNetworkStatusListenerCallback; AUserData: JSValue = Nil);

    //设置被踢下线通知回调
    procedure SetKickedOfflineCallback(AProc: TKickedOfflineCallback; AUserData: JSValue = Nil);

    //设置Log回调
    procedure SetLogCallback(AProc: TLogCallback; AUserData: JSValue = Nil);

    //设置Sig过期的回调
    procedure SetUserSigExpiredCallback(AProc: TUserSigExpiredCallback; AUserData: JSValue = Nil);

    property OnGetLoginStatus: TOnGetLoginStatus read FOnGetLoginStatus write FOnGetLoginStatus;
    property OnGetLoginStatusError: TOnGetLoginStatus_Error read FOnGetLoginStatusError write FOnGetLoginStatusError;

    //取登录状态
    procedure GetLoginStatus;

    property OnGetLoginUserID: TOnGetLoginUserID read FOnGetLoginUserID write FOnGetLoginUserID;
    property OnGetLoginUserIDError: TOnGetLoginUserID_Error read FOnGetLoginUserIDError write FOnGetLoginUserIDError;

    //取已登录用户的ID
    procedure GetLoginUserID(AUserData: JSValue = Nil);

    property OnLogin: TOnLogin read FOnLogin write FOnLogin;
    property OnLoginError: TOnLogin_Error read FOnLoginError write FOnLoginError;
    
    //登录
    procedure Login(AUserID, AUserSig: String; AUserData: JSValue = Nil);

    property OnLogout: TOnLogout read FOnLogout write FOnLogout;
    property OnLogoutError: TOnLogout_Error read FOnLogoutError write FOnLogoutError;

    //登出
    procedure Logout(AUserData: JSValue = Nil);

    property OnGetUserProfileList: TOnGetUserProfileList read FOnGetUserProfileList write FOnGetUserProfileList;
    property OnGetUserProfileListError: TOnGetUserProfileList_Error read FOnGetUserProfileListError write FOnGetUserProfileListError;
    
    //获取用户资料
    procedure GetUserProfileList(AUserIDList: array of string; AForceUpdate: Boolean; AUserData: JSValue = Nil);
  end;

implementation

{
******************************************************
TIMGetSDKVersion
******************************************************
}

procedure TTIMRenderer.GetSDKVersion;

  //Event for success
  procedure jsOnGetSDKVersion(AVersion: String);
  begin
    if Assigned(FOnGetSDKVersion) then
      FOnGetSDKVersion(AVersion);
  end;

  //Event for error
  procedure jsOnGetSDKVersionError(AError: JSValue);
  begin
    if Assigned(FOnGetSDKVersionError) then
      FOnGetSDKVersionError(AError);
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetSDKVersion;
  tmpOnError:=@jsOnGetSDKVersionError;
 
  asm //JavaScript
    timRendererInstance.TIMGetSDKVersion().then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
TIMGetServerTime
******************************************************
}

procedure TTIMRenderer.GetServerTime;

  procedure jsOnGetServerTimeError(AError: JSValue);
  begin
    if Assigned(FOnGetServerTimeError) then
      FOnGetServerTimeError(AError);  
  end;

  procedure jsOnGetServerTime(AServerTime: NativeUInt);
  begin
    if Assigned(FOnGetServerTimer) then
      FOnGetServerTimer(AServerTime);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetServerTime;
  tmpOnError:=@jsOnGetServerTimeError;
  
  asm //JavaScript
    timRendererInstance.TIMGetServerTime().then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.Init(AConfigPath: JSValue = Nil);

  procedure jsOnInit(AResult: NativeInt);
  begin
    if Assigned(FOnInit) then
      FOnInit(AResult);  
  end;

  procedure jsOnInitError(AError: JSValue);
  begin
    if Assigned(FOnInitError) then
      FOnInitError(AError);
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnInit;
  tmpOnError:=@jsOnInitError;

  asm //JavaScript
    timRendererInstance.TIMInit({
      config_path: AConfigPath
    }
    ).then((result) =>{
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });    
  end;
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.Uninit;

  procedure jsOnUninit(AResult: NativeInt);
  begin
    if Assigned(FOnUninit) then
      FOnUninit(AResult);    
  end;

  procedure jsOnUninitError(AError: JSValue);
  begin
    if Assigned(FOnUninitError) then
      FOnUninitError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnUninit;
  tmpOnError:=@jsOnUninitError;
  
  asm //JavaScript
    timRendererInstance.TIMUninit().then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
SetNewworkStatusListenerCallback
******************************************************
}

procedure TTIMRenderer.SetNetworkStatusListenerCallback(AProc: TNetworkStatusListenerCallback; AUserData: JSValue = Nil);
begin
  asm //JavaScript
    timRendererInstance.TIMSetNetworkStatusListenerCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1], args[0][2], args[0][3])
      },
      userData: AUserData
    })
  end;
end;

{
******************************************************
Class constructor
******************************************************
}

constructor TTIMRenderer.Create;
begin
  inherited;
  asm //JavaScript
     if (typeof timRendererInstance == 'undefined') {
      timRendererInstance = new timRenderer();
     }   
  end;
end;

{
******************************************************
SetKickedOfflineCallback
******************************************************
}

procedure TTIMRenderer.SetKickedOfflineCallback(AProc: TKickedOfflineCallback; AUserData: JSValue = Nil);
begin
  asm //JavaScript
    timRendererInstance.TIMSetKickedOfflineCallback({
      callback:(...args)=>{
        AProc(args[0][0])
      },
      userData: AUserData
    }) 
  end; 
end;

{
******************************************************
SetLogCallback
******************************************************
}

procedure TTIMRenderer.SetLogCallback(AProc: TLogCallback; AUserData: JSValue = Nil);
begin
  asm //JavaScript
    timRendererInstance.TIMSetLogCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1], args[0][2])
      },
      user_data: AUserData
    }) 
  end;   
end;

{
******************************************************
SetUserSigExpiredCallback
******************************************************
}

procedure TTIMRenderer.SetUserSigExpiredCallback(AProc: TUserSigExpiredCallback; AUserData: JSValue = Nil);
begin
  asm //JavaScript
    timRendererInstance.TIMSetUserSigExpiredCallback({
      callback:(...args)=>{
        AProc(args[0][0])
      },
      userData: AUserData
    }) 
  end;   
end;

{
******************************************************
GetLoginStatus
******************************************************
}

procedure TTIMRenderer.GetLoginStatus;

  procedure jsOnGetLoginStatus(ALoginStatus: NativeInt);
  begin
    if Assigned(FOnGetLoginStatus) then
      FOnGetLoginStatus(ALoginStatus);    
  end;

  procedure jsOnGetLoginStatusError(AError: JSValue);
  begin
    if Assigned(FOnGetLoginStatusError) then
      FOnGetLoginStatusError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetLoginStatus;
  tmpOnError:=@jsOnGetLoginStatusError;
  
  asm //JavaScript
    timRendererInstance.TIMGetLoginStatus().then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
GetLoginUserID
******************************************************
}

procedure TTIMRenderer.GetLoginUserID(AUserData: JSValue = Nil);

  procedure jsOnGetLoginUserID(AResult: TCommonResponse);
  begin
    if Assigned(FOnGetLoginUserID) then
      FOnGetLoginUserID(AResult);    
  end;

  procedure jsOnGetLoginUserIDError(AError: JSValue);
  begin
    if Assigned(FOnGetLoginUserIDError) then
      FOnGetLoginUserIDError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetLoginUserID;
  tmpOnError:=@jsOnGetLoginUserIDError;
  
  asm //JavaScript
    timRendererInstance.TIMGetLoginUserID({
      userData: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
       tmpOnError(err)
    });   
  end;
end;

{
******************************************************
Login
******************************************************
}

procedure TTIMRenderer.Login(AUserID, AUserSig: String; AUserData: JSValue = Nil);

  procedure jsOnLogin(AResult: TCommonResponse);
  begin
    if Assigned(FOnLogin) then
      FOnLogin(AResult);    
  end;

  procedure jsOnLoginError(AError: JSValue);
  begin
    if Assigned(FOnLoginError) then
      FOnLoginError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnLogin;
  tmpOnError:=@jsOnLoginError;
  
  asm //JavaScript
    timRendererInstance.TIMLogin({
      userData: AUserData,
      userID: AUserID,
      userSig: AUserSig
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
Logout
******************************************************
}

procedure TTIMRenderer.Logout(AUserData: JSValue = Nil);

  procedure jsOnLogout(AResult: TCommonResponse);
  begin
    if Assigned(FOnLogout) then
      FOnLogout(AResult);    
  end;

  procedure jsOnLogoutError(AError: JSValue);
  begin
    if Assigned(FOnLogoutError) then
      FOnLogoutError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnLogout;
  tmpOnError:=@jsOnLogoutError;
  
  asm //JavaScript
    timRendererInstance.TIMLogout({
      userData: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
GetUserProfileList
******************************************************
}

procedure TTIMRenderer.GetUserProfileList(AUserIDList: array of string; AForceUpdate: Boolean; AUserData: JSValue = Nil);

  procedure jsOnGetUserProfileList(AResult: TCommonResponse);
  begin
    if Assigned(FOnGetUserProfileList) then
      FOnGetUserProfileList(AResult);    
  end;

  procedure jsOnGetUserProfileListError(AError: JSValue);
  begin
    if Assigned(FOnGetUserProfileListError) then
      FOnGetUserProfileListError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetUserProfileList;
  tmpOnError:=@jsOnGetUserProfileListError;
  
  asm //JavaScript
    timRendererInstance.TIMProfileGetUserProfileList({
      json_get_user_profile_list_param: {
        friendship_getprofilelist_param_identifier_array: AUserIDList,
        friendship_getprofilelist_param_force_update: AForceUpdate
      },
      userData: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
  
end;

end.