// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Render Class Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRendererUnit;

interface

uses
  IMRendererTypeUnit, IMCloudDefUnit, classes;

type
  //TIM Event
  TLogEvent = procedure(ALevel: NativeInt; ALog: String) of object;
  
  TConvCreateEvent = procedure(AConveArray: TTIMConvInfoArray) of object;

  TConvDeleteEvent = procedure(AConveArray: TTIMConvInfoArray) of object;

  TConvUpdateEvent = procedure(AConveArray: TTIMConvInfoArray) of object;

  TNewMessageEvent = procedure(AMessageArray: TTIMMessageArray) of object;

  TMsgElemUploadProgressEvent = procedure(AJSONMsg: JSValue; AIndex: NativeInt; ACurSize: NativeInt; ALocalSize: NativeInt) of object;

  TMsgReceiptEvent = procedure(AMsgReceiptArray: TTIMMsgReceiptArray) of object;

  TMsgRevokeEvent = procedure(AMsgLocatorArray: TTIMMsgLocatorArray) of object;

  TUnreadMessageCountChangedEvent = procedure(AUnreadMessageCount: NativeInt) of object;

  //TIM Render
  TTIMRenderer = class (TObject)
  private
    FOnGetSDKVersion: TTIMOnGetSDKVersion;
    FOnGetSDKVersionError: TTIMOnGetSDKVersion_Error;

    FOnGetServerTime: TTIMOnGetServerTime;
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

    FOnConvCreate: TConvCreateEvent;
    FOnConvCreateError: TTIMOnConvCreate_Error;

    FOnConvDelete: TConvDeleteEvent;
    FOnConvDeleteError: TTIMOnConvDelete_Error;
  
    FNetworkStatus: NativeInt;
    FUnreadMessageCount: NativeInt;

    FAdvanceMessager: Pointer;

    FOnKickOff: TNotifyEvent;
    FOnSigExpired: TNotifyEvent;
    FOnNetworkStatusChanged: TNotifyEvent;

    FOnGetConvList: TTIMOnGetConvList;
    FOnGetConvListError: TTIMOnGetConvList_Error;

    FOnSendMessage: TTIMOnSendMessage;
    FOnSendMessageError: TTIMOnSendMessage_Error;

    FOnImportMsgList: TTIMOnImportMsgList;
    FOnImportMsgListError: TTIMOnImportMsgList_Error;

    FOnMsgReportReaded: TTIMOnMsgReportReaded;
    FOnMsgReportReadedError: TTIMOnMsgReportReaded_Error;

    FOnGetMsgList: TTIMOnGetMsgList;
    FOnGetMsgListError: TTIMOnGetMsgList_Error;

    FOnLog: TLogEvent;
    FOnConnected: TNotifyEvent;
    FOnDisconnected: TNotifyEvent;
    FOnConnecting: TNotifyEvent;
    FOnConnectFailed: TNotifyEvent;
    FOnConvUpdate: TConvUpdateEvent;
    FOnConvUpdateStart: TNotifyEvent;
    FOnConvUpdateFinish: TNotifyEvent;
    FOnNewMessage: TNewMessageEvent;
    FOnMsgElemUploadProgress: TMsgElemUploadProgressEvent;
    FOnMsgReceipt: TMsgReceiptEvent;
    FOnMsgRevoke: TMsgRevokeEvent;
    FOnUnreadMessageCountChanged: TUnreadMessageCountChangedEvent;
    FOnMsgRevokeError: TTIMOnMsgRevoke_Error;

    FSDKVersion: String;

    property OnGetSDKVersion: TTIMOnGetSDKVersion read FOnGetSDKVersion write FOnGetSDKVersion;
    property OnGetSDKVersionError: TTIMOnGetSDKVersion_Error read FOnGetSDKVersionError write FOnGetSDKVersionError;

    //????????????????????????
    procedure SetNetworkStatusListenerCallback(AProc: TTIMNetworkStatusListenerCallback; AUserData: JSValue = Nil);

    //??????????????????????????????
    procedure SetKickedOfflineCallback(AProc: TTIMKickedOfflineCallback; AUserData: JSValue = Nil);

    //??????Log??????
    procedure SetLogCallback(AProc: TTIMLogCallback; AUserData: JSValue = Nil);

    //??????Sig???????????????
    procedure SetUserSigExpiredCallback(AProc: TTIMUserSigExpiredCallback; AUserData: JSValue = Nil);

    //??????????????????
    procedure SetConvEventCallback(AProc: TTIMConvEventCallback; AUserData: JSValue = Nil);
    
    //????????????????????????????????????
    procedure SetConvTotalUnreadMessageCountChangedCallback(AProc: TTIMConvTotalUnreadMessageCountChangedCallback; AUserData: JSValue = Nil);

    //???????????????????????????
    procedure AddRecvNewMsgCallback(AProc: TTIMRecvNewMsgCallback; AUserData: JSValue = Nil);

    //???????????????????????????
    procedure RemoveRecvNewMsgCallback;

    //?????????????????????????????????????????????
    procedure SetMsgElemUploadProgressCallback(AProc: TTIMMsgElemUploadProgressCallback; AUserData: JSValue = Nil);

    //??????????????????????????????
    procedure SetMsgReadedReceiptCallback(AProc: TTIMMsgReadedReceiptCallback; AUserData: JSValue = Nil);

    //?????????????????????????????????
    procedure SetMsgRevokeCallback(AProc: TTIMMsgRevokeCallback; AUserData: JSValue = Nil);

  protected 
    function GetAdvanceMessager: Pointer;
    property AdvanceMessager: Pointer read GetAdvanceMessager;

    //TIM Callback
    procedure OnTIMLog(ALevel: NativeInt; ALog: String; AUserData: JSValue);
    procedure OnTIMNetworkStatus(AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue);
    procedure OnTIMKickedOffline(AUserData: JSValue);
    procedure OnTIMUserSigExpired(AUserData: JSValue);
    procedure OnTIMConvEvent(AConvEvent: NativeInt; AJSONConvArray: JSValue; AUserData: JSValue);
    procedure OnTIMRecvNewMsg(AJSONMsgArray: JSValue; AUserData: JSValue);
    procedure OnTIMMsgElemUploadProgress(AJSONMsg: JSValue; AIndex, ACurSize, ALocalSize: NativeInt; AUserData: String);
    procedure OnTIMMsgReadedReceipt(AJSONMsgReadedReceiptArray: JSValue; AUserData: JSValue);
    procedure OnTIMMsgRevoke(AJSONMsgLocatorArray: JSValue; AUserData: JSValue);
    procedure OnTIMConvTotalUnreadMessageCountChanged(ATotalUnreadCount: NativeInt; AUserData: JSValue);

    //???SDK?????????
    [async]function GetSDKVersion: String;

    //?????????
    procedure Init(AConfigPath: JSValue = Nil);

    //????????????
    procedure Uninit;
  public
    property SDKVersion: String read FSDKVersion;

    property OnGetServerTime: TTIMOnGetServerTime read FOnGetServerTime write FOnGetServerTime;
    property OnGetServerTimeError: TTIMOnGetServerTime_Error read FOnGetServerTimeError write FOnGetServerTimeError;
 
    property OnInit: TTIMOnInit read FOnInit write FOnInit;
    property OnInitError: TTIMOnInit_Error read FOnInitError write FOnInitError;

    property OnUninitError: TTIMOnUninit_Error read FOnUninitError write FOnUninitError;
    property OnUninit: TTIMOnUninit read FOnUninit write FOnUninit;

    property OnGetLoginStatus: TTIMOnGetLoginStatus read FOnGetLoginStatus write FOnGetLoginStatus;
    property OnGetLoginStatusError: TTIMOnGetLoginStatus_Error read FOnGetLoginStatusError write FOnGetLoginStatusError;

    property OnGetLoginUserID: TTIMOnGetLoginUserID read FOnGetLoginUserID write FOnGetLoginUserID;
    property OnGetLoginUserIDError: TTIMOnGetLoginUserID_Error read FOnGetLoginUserIDError write FOnGetLoginUserIDError;

    property OnLogin: TTIMOnLogin read FOnLogin write FOnLogin;
    property OnLoginError: TTIMOnLogin_Error read FOnLoginError write FOnLoginError;
    
    property OnLogout: TTIMOnLogout read FOnLogout write FOnLogout;
    property OnLogoutError: TTIMOnLogout_Error read FOnLogoutError write FOnLogoutError;

    property OnGetUserProfileList: TTIMOnGetUserProfileList read FOnGetUserProfileList write FOnGetUserProfileList;
    property OnGetUserProfileListError: TTIMOnGetUserProfileList_Error read FOnGetUserProfileListError write FOnGetUserProfileListError;

    property OnGetConvList: TTIMOnGetConvList read FOnGetConvList write FOnGetConvList;
    property OnGetConvListError: TTIMOnGetConvList_Error read FOnGetConvListError write FOnGetConvListError;

    property OnConvCreate: TConvCreateEvent read FOnConvCreate write FOnConvCreate;
    property OnConvCreateError: TTIMOnConvCreate_Error read FOnConvCreateError write FOnConvCreateError;

    property OnConvDelete: TConvDeleteEvent read FOnConvDelete write FOnConvDelete;
    property OnConvDeleteError: TTIMOnConvDelete_Error read FOnConvDeleteError write FOnConvDeleteError;

    property NetworkStatus: NativeInt read FNetworkStatus;
    property UnreadMessageCount: NativeInt read FUnreadMessageCount;

    property OnKickOff: TNotifyEvent read FOnKickOff write FOnKickOff;   
    property OnSigExpired: TNotifyEvent read FOnSigExpired write FOnSigExpired;
    property OnNetworkStatusChanged: TNotifyEvent read FOnNetworkStatusChanged write FOnNetworkStatusChanged;
    property OnLog: TLogEvent read FOnLog write FOnLog;
    property OnConnected: TNotifyEvent read FOnConnected write FOnConnected;
    property OnDisconnected: TNotifyEvent read FOnDisconnected write FOnDisconnected;
    property OnConnecting: TNotifyEvent read FOnConnecting write FOnConnecting;
    property OnConnectFailed: TNotifyEvent read FOnConnectFailed write FOnConnectFailed;
    property OnConvUpdate: TConvUpdateEvent read FOnConvUpdate write FOnConvUpdate;
    property OnConvUpdateStart: TNotifyEvent read FOnConvUpdateStart write FOnConvUpdateStart;
    property OnConvUpdateFinish: TNotifyEvent read FOnConvUpdateFinish write FOnConvUpdateFinish;
    property OnNewMessage: TNewMessageEvent read FOnNewMessage write FOnNewMessage;
    property OnMsgElemUploadProgress: TMsgElemUploadProgressEvent read FOnMsgElemUploadProgress write FOnMsgElemUploadProgress;
    property OnMsgReceipt: TMsgReceiptEvent read FOnMsgReceipt write FOnMsgReceipt;
    property OnMsgRevoke: TMsgRevokeEvent read FOnMsgRevoke write FOnMsgRevoke;
    property OnUnreadMessageCountChanged: TUnreadMessageCountChangedEvent read FOnUnreadMessageCountChanged write FOnUnreadMessageCountChanged;

    property OnSendMessage: TTIMOnSendMessage read FOnSendMessage write FOnSendMessage;
    property OnSendMessageError: TTIMOnSendMessage_Error read FOnSendMessageError write FOnSendMessageError;

    property OnImportMsgList: TTIMOnImportMsgList read FOnImportMsgList write FOnImportMsgList;
    property OnImportMsgListError: TTIMOnImportMsgList_Error read FOnImportMsgListError write FOnImportMsgListError;
    
    property OnMsgReportReaded: TTIMOnMsgReportReaded read FOnMsgReportReaded write FOnMsgReportReaded;
    property OnMsgReportReadedError: TTIMOnMsgReportReaded_Error read FOnMsgReportReadedError write FOnMsgReportReadedError;

    property OnMsgRevokeError: TTIMOnMsgRevoke_Error read FOnMsgRevokeError write FOnMsgRevokeError;

    property OnGetMsgList: TTIMOnGetMsgList read FOnGetMsgList write FOnGetMsgList;
    property OnGetMsgListError: TTIMOnGetMsgList_Error read FOnGetMsgListError write FOnGetMsgListError;

    constructor Create; reintroduce;
    destructor Destroy; reintroduce;

    //??????????????????
    [async]function GetServerTime: uint64;

    //???????????????
    [async]function GetLoginStatus: NativeInt;

    //?????????????????????ID
    [async]function GetLoginUserID(AUserData: JSValue = Nil): String;

    //??????
    procedure Login(AUserID, AUserSig: String; AUserData: JSValue = Nil);

    //??????
    procedure Logout(AUserData: JSValue = Nil);

    //??????????????????
    [async]function GetUserProfileList(AUserIDList: array of string; AForceUpdate: Boolean; AUserData: JSValue = Nil): TTIMUserProfileArray;

    //???????????????????????????
    [async]function GetConvList(AUserData: JSValue = Nil): TTIMConvInfoArray;

    //????????????
    procedure ConvCreate(AConvID: String; AConvType: NativeInt; AUserData: JSValue = Nil);

    //????????????
    procedure ConvDelete(AConvID: String; AConvType: NativeInt; AUserData: JSValue = Nil);

    //???????????????
    procedure SendMessage(AConvID: String; AConvType: NativeInt; AParams: TTIMMessage; AProc: TTIMSendMessageCallback; AUserData: JSValue = Nil; AMessageID: String = '');

    //???????????????????????????
    procedure ImportMsgList(AConvID: String; AConvType: NativeInt; AParams: TTIMMessageArray; AUserData: JSValue);

    //??????????????????
    procedure MsgReportReaded(AConvID: String; AConvType: NativeInt; AMessageID: String; AUserData: JSValue);

    //????????????
    procedure MsgRevoke(AConvID: String; AConvType: NativeInt; AMessageID: String; AUserData: JSValue);

    //?????????????????????????????????
    procedure GetMsgList(AConvID: String; AConvType: NativeInt; AParams: TTIMGetMsgListParam; AUserData: JSValue);

end;

implementation

uses
  Web, js, sysutils;

{
******************************************************
TIMGetSDKVersion
******************************************************
}

function TTIMRenderer.GetSDKVersion: String;

  //Event for success
  procedure jsOnGetSDKVersion(AVersion: String);
  begin
    Result:=AVersion;

    FSDKVersion:=AVersion;
  
    if Assigned(FOnGetSDKVersion) then
      FOnGetSDKVersion(AVersion);
  end;

  //Event for error
  procedure jsOnGetSDKVersionError(AError: JSValue);
  begin
    Result:='';

    FSDKVersion:='';

    if Assigned(FOnGetSDKVersionError) then
      FOnGetSDKVersionError(AError);
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetSDKVersion;
  tmpOnError:=@jsOnGetSDKVersionError;
 
  asm //JavaScript
    await timRendererInstance.TIMGetSDKVersion().then((result) => {
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

function TTIMRenderer.GetServerTime: uint64;

  procedure jsOnGetServerTimeError(AError: JSValue);
  begin
    Result:=0;

    if Assigned(FOnGetServerTimeError) then
      FOnGetServerTimeError(AError);  
  end;

  procedure jsOnGetServerTime(AServerTime: NativeUInt);
  begin
    Result:=AServerTime;

    if Assigned(FOnGetServerTime) then
      FOnGetServerTime(AServerTime);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetServerTime;
  tmpOnError:=@jsOnGetServerTimeError;
  
  asm //JavaScript
    await timRendererInstance.TIMGetServerTime().then((result) => {
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
  //???SDK?????????
  GetSDKVersion;
  //??????????????????
  SetLogCallback(@OnTIMLog);
  //????????????????????????
  SetNetworkStatusListenerCallback(@OnTIMNetworkStatus);
  //???????????????????????????
  SetKickedOfflineCallback(@OnTIMKickedOffline);
  //??????Sig????????????
  SetUserSigExpiredCallback(@OnTIMUserSigExpired);
  //????????????????????????
  SetConvEventCallback(@OnTIMConvEvent);
  //??????????????????????????????
  AddRecvNewMsgCallback(@OnTIMRecvNewMsg);
  //??????????????????????????????????????????
  SetMsgElemUploadProgressCallback(@OnTIMMsgElemUploadProgress);
  //?????????????????????????????????
  SetMsgReadedReceiptCallback(@OnTIMMsgReadedReceipt);
  //???????????????????????????
  SetMsgRevokeCallback(@OnTIMMsgRevoke);
  //???????????????????????????????????????
  SetConvTotalUnreadMessageCountChangedCallback(@OnTIMConvTotalUnreadMessageCountChanged);
  //?????????
  Init;
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

function TTIMRenderer.GetLoginStatus: NativeInt;

  procedure jsOnGetLoginStatus(ALoginStatus: NativeInt);
  begin
    Result:=ALoginStatus;
 
    if Assigned(FOnGetLoginStatus) then
      FOnGetLoginStatus(ALoginStatus);    
  end;

  procedure jsOnGetLoginStatusError(AError: JSValue);
  begin
    Result:=-1;

    if Assigned(FOnGetLoginStatusError) then
      FOnGetLoginStatusError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetLoginStatus;
  tmpOnError:=@jsOnGetLoginStatusError;
  
  asm //JavaScript
    await timRendererInstance.TIMGetLoginStatus().then((result) => {
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

function TTIMRenderer.GetLoginUserID(AUserData: JSValue = Nil): String;

  procedure jsOnGetLoginUserID(AResult: TTIMCommonResponse);
  begin
    Result:=String(AResult.json_param);

    if Assigned(FOnGetLoginUserID) then
      FOnGetLoginUserID(AResult);    
  end;

  procedure jsOnGetLoginUserIDError(AError: JSValue);
  begin
    Result:='';

    if Assigned(FOnGetLoginUserIDError) then
      FOnGetLoginUserIDError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetLoginUserID;
  tmpOnError:=@jsOnGetLoginUserIDError;
  
  asm //JavaScript
    await timRendererInstance.TIMGetLoginUserID({
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

function TTIMRenderer.GetUserProfileList(AUserIDList: array of string; AForceUpdate: Boolean; AUserData: JSValue = Nil): TTIMUserProfileArray;

  procedure jsOnGetUserProfileList(AResult: TTIMCommonResponse);
  var
    TmpResponse: TTIMUserProfileArray;
  begin
    case AResult.code of
      0: begin
        TmpResponse:=TTIMUserProfileArray(TJSJSON.parse(String(AResult.json_param)));
      end;
    end;

    Result:=TmpResponse;
  end;

  procedure jsOnGetUserProfileListError(AError: JSValue);
  begin
    Result:=Nil;
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetUserProfileList;
  tmpOnError:=@jsOnGetUserProfileListError;
  
  asm //JavaScript
    await timRendererInstance.TIMProfileGetUserProfileList({
      json_get_user_profile_list_param: {
        friendship_getprofilelist_param_identifier_array: AUserIDList,
        friendship_getprofilelist_param_force_update: AForceUpdate
      },
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
  
end;

{
******************************************************
SetConvEventCallback
******************************************************
}

procedure TTIMRenderer.SetConvEventCallback(AProc: TTIMConvEventCallback; AUserData: JSValue);
begin
  asm //JavaScript
    timRendererInstance.TIMSetConvEventCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1], args[0][2])
      },
      user_data: AUserData
    }) 
  end;     
end;

{
******************************************************
SetConvTotalUnreadMessageCountChangedCallback
******************************************************
}

procedure TTIMRenderer.SetConvTotalUnreadMessageCountChangedCallback(AProc: TTIMConvTotalUnreadMessageCountChangedCallback; AUserData: JSValue = Nil);
begin
  asm //JavaScript
    timRendererInstance.TIMSetConvTotalUnreadMessageCountChangedCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1])
      },
      user_data: AUserData
    })
  end;       
end;

{
******************************************************
GetConvList
******************************************************
}

function TTIMRenderer.GetConvList(AUserData: JSValue): TTIMConvInfoArray;

  procedure jsOnGetConvList(AResult: TTIMCommonResponse);
  var
    TmpConvInfoArray: TTIMConvInfoArray;
  begin
    if AResult.code = 0 then
    begin
      TmpConvInfoArray:= TTIMConvInfoArray(TJSJSON.parse(String(AResult.json_param)));
    end;
    
    Result:=TmpConvInfoArray;

    if Assigned(FOnGetConvList) then
      FOnGetConvList(AResult);    
  end;

  procedure jsOnGetConvListError(AError: JSValue);
  begin
    Result:=Nil;

    if Assigned(FOnGetConvListError) then
      FOnGetConvListError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetConvList;
  tmpOnError:=@jsOnGetConvListError;
  
  asm //JavaScript
    await timRendererInstance.TIMConvGetConvList({
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
ConvCreate
******************************************************
}

procedure TTIMRenderer.ConvCreate(AConvID: String; AConvType: NativeInt; AUserData: JSValue);

  procedure jsOnConvCreate(AResult: TTIMCommonResponse);
  begin
    // if Assigned(FOnConvCreate) then
    //   FOnConvCreate(AResult);    
  end;

  procedure jsOnConvCreateError(AError: JSValue);
  begin
    if Assigned(FOnConvCreateError) then
      FOnConvCreateError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnConvCreate;
  tmpOnError:=@jsOnConvCreateError;
  
  asm //JavaScript
    timRendererInstance.TIMConvCreate({
      convId: AConvID,
      convType: AConvType,
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
ConvDelete
******************************************************
}

procedure TTIMRenderer.ConvDelete(AConvID: String; AConvType: NativeInt; AUserData: JSValue);

  procedure jsOnConvDelete(AResult: TTIMCommonResponse);
  begin
    // if Assigned(FOnConvDelete) then
    //   FOnConvDelete(AResult);    
  end;

  procedure jsOnConvDeleteError(AError: JSValue);
  begin
    if Assigned(FOnConvDeleteError) then
      FOnConvDeleteError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnConvDelete;
  tmpOnError:=@jsOnConvDeleteError;
  
  asm //JavaScript
    timRendererInstance.TIMConvDelete({
      convId: AConvID,
      convType: AConvType,
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
AddRecvNewMsgCallback
******************************************************
}

procedure TTIMRenderer.AddRecvNewMsgCallback(AProc: TTIMRecvNewMsgCallback; AUserData: JSValue);
begin
  asm //JavaScript
    timRendererInstance.TIMAddRecvNewMsgCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1])
      },
      user_data: AUserData
    })
  end;         
end;

{
******************************************************
RemoveRecvNewMsgCallback
******************************************************
}

procedure TTIMRenderer.RemoveRecvNewMsgCallback;
begin
  asm //JavaScript
    timRendererInstance.TIMRemoveRecvNewMsgCallback()
  end;           
end;

{
******************************************************
SetMsgElemUploadProgressCallback
******************************************************
}

procedure TTIMRenderer.SetMsgElemUploadProgressCallback(AProc: TTIMMsgElemUploadProgressCallback; AUserData: JSValue);
begin
  asm //JavaScript
    timRendererInstance.TIMSetMsgElemUploadProgressCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1], args[0][2], args[0][3], args[0][4])
      },
      user_data: AUserData
    })
  end;           
end;

{
******************************************************
SetMsgReadedReceiptCallback
******************************************************
}

procedure TTIMRenderer.SetMsgReadedReceiptCallback(AProc: TTIMMsgReadedReceiptCallback; AUserData: JSValue);
begin
  asm //JavaScript
    timRendererInstance.TIMSetMsgReadedReceiptCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1])
      },
      user_data: AUserData
    })
  end;             
end;

{
******************************************************
SetMsgRevokeCallback
******************************************************
}

procedure TTIMRenderer.SetMsgRevokeCallback(AProc: TTIMMsgRevokeCallback; AUserData: JSValue);
begin
  asm //JavaScript
    timRendererInstance.TIMSetMsgRevokeCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1])
      },
      user_data: AUserData
    })
  end;               
end;

{
******************************************************
Getter of property 'AdvanceMessager' ---- ignore
******************************************************
}

function TTIMRenderer.GetAdvanceMessager: Pointer;
var
  TmpObj: Pointer;
begin
  asm  //JavaScript
    if (typeof(timAdvanceMessagerInstance) == "undefined") {
      timAdvanceMessagerInstance = new timAdvanceMessager()
    }
    TmpObj = timAdVanceMessagerInstance
  end;
  FAdvanceMessager:=TmpObj;
  Result:=FAdvanceMessager;
end;

{
******************************************************
SendMessage
******************************************************
}

procedure TTIMRenderer.SendMessage(AConvID: String; AConvType: NativeInt; AParams: TTIMMessage; AProc: TTIMSendMessageCallback; AUserData: JSValue; AMessageID: String);

  procedure jsOnSendMessage(AMessageID: String);
  begin
    if Assigned(FOnSendMessage) then
      FOnSendMessage(AMessageID);    
  end;

  procedure jsOnSendMessageError(AError: JSValue);
  begin
    if Assigned(FOnSendMessageError) then
      FOnSendMessageError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnSendMessage;
  tmpOnError:=@jsOnSendMessageError;
  
  asm //JavaScript
    timRendererInstance.TIMMsgSendMessageV2({
      conv_id: AConvID,
      conv_type: AConvType,
      params: AParams,
      message_id: AMessageID,
      callback: (...args) => {
        AProc(args[0][0], args[0][1], args[0][2] ,args[0][3])
      },
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
  
end;

{
******************************************************
ImportMsgList
******************************************************
}

procedure TTIMRenderer.ImportMsgList(AConvID: String; AConvType: NativeInt; AParams: TTIMMessageArray; AUserData: JSValue);

  procedure jsOnImportMsgList(AResult: TTIMCommonResponse);
  begin
    if Assigned(FOnImportMsgList) then
      FOnImportMsgList(AResult);    
  end;

  procedure jsOnImportMsgListError(AError: JSValue);
  begin
    if Assigned(FOnImportMsgListError) then
      FOnImportMsgListError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnImportMsgList;
  tmpOnError:=@jsOnImportMsgListError;
  
  asm //JavaScript
    timRendererInstance.TIMMsgImportMsgList({
      conv_id: AConvID,
      conv_type: AConvType,
      params: AParams,
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
  
end;

{
******************************************************
GetMsgList
******************************************************
}

procedure TTIMRenderer.GetMsgList(AConvID: String; AConvType: NativeInt; AParams: TTIMGetMsgListParam; AUserData: JSValue);

  procedure jsOnGetMsgList(AResult: TTIMCommonResponse);
  begin
    if Assigned(FOnGetMsgList) then
      FOnGetMsgList(AResult);    
  end;

  procedure jsOnGetMsgListError(AError: JSValue);
  begin
    if Assigned(FOnGetMsgListError) then
      FOnGetMsgListError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetMsgList;
  tmpOnError:=@jsOnGetMsgListError;
  
  asm //JavaScript
    timRendererInstance.TIMMsgGetMsgList({
      conv_id: AConvID,
      conv_type: AConvType,
      params: AParams,
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
MsgRevoke
******************************************************
}

procedure TTIMRenderer.MsgRevoke(AConvID: String; AConvType: NativeInt; AMessageID: String; AUserData: JSValue);

  procedure jsOnMsgRevoke(AResult: TTIMCommonResponse);
  begin
{    if Assigned(FOnMsgRevoke) then
      FOnMsgRevoke(AResult);  }  
  end;

  procedure jsOnMsgRevokeError(AError: JSValue);
  begin
    if Assigned(FOnMsgRevokeError) then
      FOnMsgRevokeError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnMsgRevoke;
  tmpOnError:=@jsOnMsgRevokeError;
  
  asm //JavaScript
    timRendererInstance.TIMMsgRevoke({
      conv_id: AConvID,
      conv_type: AConvType,
      message_id: AParams,
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

{
******************************************************
MsgReportReaded
******************************************************
}

procedure TTIMRenderer.MsgReportReaded(AConvID: String; AConvType: NativeInt; AMessageID: String; AUserData: JSValue);

  procedure jsOnMsgReportReaded(AResult: TTIMCommonResponse);
  begin
    if Assigned(FOnMsgReportReaded) then
      FOnMsgReportReaded(AResult);    
  end;

  procedure jsOnMsgReportReadedError(AError: JSValue);
  begin
    if Assigned(FOnMsgReportReadedError) then
      FOnMsgReportReadedError(AError);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnMsgReportReaded;
  tmpOnError:=@jsOnMsgReportReadedError;
  
  asm //JavaScript
    timRendererInstance.TIMMsgReportReaded({
      conv_id: AConvID,
      conv_type: AConvType,
      message_id: AParams,
      user_data: AUserData
    }).then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(err)
    });   
  end;
end;

//Log??????
procedure TTIMRenderer.OnTIMLog(ALevel: NativeInt; ALog: String; AUserData: JSValue);
begin
//  console.log('TIM Log: ', ALevel, ALog);  
  if Assigned(FOnLog) then
    FOnLog(ALevel, ALog);
end;

//??????????????????
procedure TTIMRenderer.OnTIMNetworkStatus(AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue);
begin
  FNetworkStatus:=AStatus;
  case AStatus of
    kTIMConnected: begin
      if Assigned(FOnConnected) then
        FOnConnected(Self);
    end; 
    kTIMDisconnected: begin
      if Assigned(FOnDisconnected) then
        FOnDisconnected(Self);
    end;
    kTIMConnecting: begin
      if Assigned(FOnConnecting) then
        FOnConnecting(Self);
    end;
    kTIMConnectFailed: begin
      if Assigned(FOnConnectFailed) then
        FOnConnectFailed(Self);
    end;
  end;
end;

//??????????????????
procedure TTIMRenderer.OnTIMKickedOffline(AUserData: JSValue);
begin
  if Assigned(FOnKickOff) then
    FOnKickOff(Self);
end;

//Sig????????????
procedure TTIMRenderer.OnTIMUserSigExpired(AUserData: JSValue);
begin
  if Assigned(FOnSigExpired) then
    FOnSigExpired(Self);
end;

//??????????????????
procedure TTIMRenderer.OnTIMConvEvent(AConvEvent: NativeInt; AJSONConvArray: JSValue; AUserData: JSValue);
var
  TmpConvInfoArray: TTIMConvInfoArray;
begin
  if AJSONConvArray<>'' then
    TmpConvInfoArray:=TTIMConvInfoArray(TJSJSON.parse(String(AJSONConvArray)));
//  console.log('Conv Event: ',AConvEvent, TmpConvInfoArray);

  case AConvEvent of
    kTIMConvEvent_Add: begin
      //????????????,???????????????????????????,???????????????????????????????????????
      if Assigned(FOnConvCreate) then
        FOnConvCreate(TmpConvInfoArray);
    end;
    kTIMConvEvent_Del: begin
      //????????????,???????????????????????????????????????
      if Assigned(FOnConvDelete) then
        FOnConvDelete(TmpConvInfoArray);
    end;   
    kTIMConvEvent_Update: begin
      //????????????,???????????????????????????????????????????????????????????????
      if Assigned(FOnConvUpdate) then
        FOnConvUpdate(TmpConvInfoArray);
    end;
    kTIMConvEvent_Start: begin
      //??????????????????
      if Assigned(FOnConvUpdateStart) then
        FOnConvUpdateStart(Self);
    end; 
    kTIMConvEvent_Finish: begin
      //??????????????????
      if Assigned(FOnConvUpdateFinish) then
        FOnConvUpdateFinish(Self);
    end;
  end;
end;

//?????????????????????
procedure TTIMRenderer.OnTIMRecvNewMsg(AJSONMsgArray: JSValue; AUserData: JSValue);
var
  TmpMessageArray: TTIMMessageArray;
begin
  //???????????????
  if AJSONMsgArray<>'' then
  begin
    TmpMessageArray:=TTIMMessageArray(TJSJSON.parse(String(AJSONMsgArray)));
    if Assigned(FOnNewMessage) then
      FOnNewMessage(TmpMessageArray);
  end;
end;

//?????????????????????????????????
procedure TTIMRenderer.OnTIMMsgElemUploadProgress(AJSONMsg: JSValue; AIndex: NativeInt; ACurSize: NativeInt; ALocalSize: NativeInt; AUserData: String);
var
  TmpMessage: TTIMMessage;
begin
  if AJSONMsg<>'' then
  begin
    TmpMessage:=TTIMMessage(TJSJSON.parse(String(AJSONMsg)));
    if Assigned(FOnMsgElemUploadProgress) then
      FOnMsgElemUploadProgress(TmpMessage, AIndex, ACurSize, ALocalSize);
  end;
//  console.log(AJSONMsg, AIndex, ACurSize, ALocalSize);
end;

//????????????????????????
procedure TTIMRenderer.OnTIMMsgReadedReceipt(AJSONMsgReadedReceiptArray: JSValue; AUserData: JSValue);
var
  TmpMessageReceiptArray: TTIMMsgReceiptArray;
begin
  if AJSONMsgReadedReceiptArray<>'' then
  begin
    TmpMessageReceiptArray:=TTIMMsgReceiptArray(TJSJSON.parse(String(AJSONMsgReadedReceiptArray)));
    if Assigned(FOnMsgReceipt) then
      FOnMsgReceipt(TmpMessageReceiptArray);
  end;
end;

//??????????????????
procedure TTIMRenderer.OnTIMMsgRevoke(AJSONMsgLocatorArray: JSValue; AUserData: JSValue);
var
  TmpMessageLocatorArray: TTIMMsgLocatorArray;
begin
  if AJSONMsgLocatorArray<>'' then
  begin
    TmpMessageLocatorArray:=TTIMMsgLocatorArray(TJSJSON.parse(String(AJSONMsgLocatorArray)));
    if Assigned(FOnMsgRevoke) then
      FOnMsgRevoke(TmpMessageLocatorArray);
  end;
//  console.log(AJSONMsgLocatorArray);
end;

//??????????????????????????????????????????
procedure TTIMRenderer.OnTIMConvTotalUnreadMessageCountChanged(ATotalUnreadCount: NativeInt; AUserData: JSValue);
begin
  FUnreadMessageCount:=ATotalUnreadCount;
  if Assigned(FOnUnreadMessageCountChanged) then
    FOnUnreadMessageCountChanged(ATotalUnreadCount);
end;

destructor TTIMRenderer.Destroy;
begin
  //??????????????????
  Logout;
  //????????????
  Uninit;
  inherited;
end;

end.