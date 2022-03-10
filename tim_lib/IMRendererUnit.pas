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
    FOnGetSDKVersion: TTIMOnGetSDKVersion;
    FOnGetSDKVersionError: TTIMOnGetSDKVersion_Error;

    FOnGetServerTimer: TTIMOnGetServerTime;
    FOnGetServerTimeError: TTIMOnGetServerTime_Error;

    FOnInit: TTIMOnInit;
    FOnInitError: TTIMOnInit_Error;

    FOnUninit: TTIMOnUninit;
    FOnUninitError: TTIMOnUninit_Error;

    FOnGetLoginStatus: TTIMOnGetLoginStatus;
    FOnGetLoginStatusError: TTIMOnGetLoginStatus_Error;

    FOnGetLoginUserID: TTIMOnGetLoginUserID;
    FOnGetLoginUserIDError: TTIMOnGetLoginUserID_Error;

    FOnLogin: TTIMOnLogin;
    FOnLoginError: TTIMOnLogin_Error;

    FOnLogout: TTIMOnLogout;
    FOnLogoutError: TTIMOnLogout_Error;

    FOnGetUserProfileList: TTIMOnGetUserProfileList;
    FOnGetUserProfileListError: TTIMOnGetUserProfileList_Error;
  protected 
  public
    constructor Create;
  
    property OnGetSDKVersion: TTIMOnGetSDKVersion read FOnGetSDKVersion write FOnGetSDKVersion;
    property OnGetSDKVersionError: TTIMOnGetSDKVersion_Error read FOnGetSDKVersionError write FOnGetSDKVersionError;

    //取SDK版本号
    procedure GetSDKVersion;

    property OnGetServerTimer: TTIMOnGetServerTime read FOnGetServerTimer write FOnGetServerTimer;
    property OnGetServerTimeError: TTIMOnGetServerTime_Error read FOnGetServerTimeError write FOnGetServerTimeError;
 
    //取服务器时间
    procedure GetServerTime;

    property OnInit: TTIMOnInit read FOnInit write FOnInit;
    property OnInitError: TTIMOnInit_Error read FOnInitError write FOnInitError;

    //初始化
    procedure Init(AConfigPath: JSValue = Nil);

    property OnUninitError: TTIMOnUninit_Error read FOnUninitError write FOnUninitError;
    property OnUninit: TTIMOnUninit read FOnUninit write FOnUninit;

    //反初始化
    procedure Uninit;

    //设置网络状态回调
    procedure SetNetworkStatusListenerCallback(AProc: TTIMNetworkStatusListenerCallback; AUserData: JSValue = Nil);

    //设置被踢下线通知回调
    procedure SetKickedOfflineCallback(AProc: TTIMKickedOfflineCallback; AUserData: JSValue = Nil);

    //设置Log回调
    procedure SetLogCallback(AProc: TTIMLogCallback; AUserData: JSValue = Nil);

    //设置Sig过期的回调
    procedure SetUserSigExpiredCallback(AProc: TTIMUserSigExpiredCallback; AUserData: JSValue = Nil);

    property OnGetLoginStatus: TTIMOnGetLoginStatus read FOnGetLoginStatus write FOnGetLoginStatus;
    property OnGetLoginStatusError: TTIMOnGetLoginStatus_Error read FOnGetLoginStatusError write FOnGetLoginStatusError;

    //取登录状态
    procedure GetLoginStatus;

    property OnGetLoginUserID: TTIMOnGetLoginUserID read FOnGetLoginUserID write FOnGetLoginUserID;
    property OnGetLoginUserIDError: TTIMOnGetLoginUserID_Error read FOnGetLoginUserIDError write FOnGetLoginUserIDError;

    //取已登录用户的ID
    procedure GetLoginUserID(AUserData: JSValue = Nil);

    property OnLogin: TTIMOnLogin read FOnLogin write FOnLogin;
    property OnLoginError: TTIMOnLogin_Error read FOnLoginError write FOnLoginError;
    
    //登录
    procedure Login(AUserID, AUserSig: String; AUserData: JSValue = Nil);

    property OnLogout: TTIMOnLogout read FOnLogout write FOnLogout;
    property OnLogoutError: TTIMOnLogout_Error read FOnLogoutError write FOnLogoutError;

    //登出
    procedure Logout(AUserData: JSValue = Nil);

    property OnGetUserProfileList: TTIMOnGetUserProfileList read FOnGetUserProfileList write FOnGetUserProfileList;
    property OnGetUserProfileListError: TTIMOnGetUserProfileList_Error read FOnGetUserProfileListError write FOnGetUserProfileListError;
    
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

procedure TTIMRenderer.SetNetworkStatusListenerCallback(AProc: TTIMNetworkStatusListenerCallback; AUserData: JSValue = Nil);
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

procedure TTIMRenderer.SetKickedOfflineCallback(AProc: TTIMKickedOfflineCallback; AUserData: JSValue = Nil);
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

procedure TTIMRenderer.SetLogCallback(AProc: TTIMLogCallback; AUserData: JSValue = Nil);
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

procedure TTIMRenderer.SetUserSigExpiredCallback(AProc: TTIMUserSigExpiredCallback; AUserData: JSValue = Nil);
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

  procedure jsOnGetLoginUserID(AResult: TTIMCommonResponse);
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

  procedure jsOnLogin(AResult: TTIMCommonResponse);
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

  procedure jsOnLogout(AResult: TTIMCommonResponse);
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

  procedure jsOnGetUserProfileList(AResult: TTIMCommonResponse);
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