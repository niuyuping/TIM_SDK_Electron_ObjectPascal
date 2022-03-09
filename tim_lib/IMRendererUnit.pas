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

    procedure SetNetworkStatusListenerCallback(const AProc: TNetworkStatusListenerCallback);
    function GetNetworkStatusListenerCallback: TNetworkStatusListenerCallback;
    procedure SetKickedOfflineCallback(const Value: TKickedOfflineCallback);
    function GetKickedOfflineCallback: TKickedOfflineCallback;
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
    procedure Init;

    property OnUninitError: TOnUninit_Error read FOnUninitError write FOnUninitError;
    property OnUninit: TOnUninit read FOnUninit write FOnUninit;

    //反初始化
    procedure Uninit;

    //设置网络状态回调
    property NetworkStatusListenerCallback: TNetworkStatusListenerCallback read GetNetworkStatusListenerCallback write SetNetworkStatusListenerCallback;

    //设置被踢下线通知回调
    property KickedOfflineCallback: TKickedOfflineCallback read GetKickedOfflineCallback write SetKickedOfflineCallback;
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
  procedure jsOnGetSDKVersionError(AErrorCode: Integer; AErrorMessage: String);
  begin
    if Assigned(FOnGetSDKVersionError) then
      FOnGetSDKVersionError(AErrorCode, AErrorMessage);
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetSDKVersion;
  tmpOnError:=@jsOnGetSDKVersionError;
 
  asm //JavaScript
    timRendererInstance.TIMGetSDKVersion().then((result) => {
      // console.log('SDK Version: ', result.data)
      tmpOnSucc(result.data)
    }).catch((err) => {
      // console.log(err);
      tmpOnError(-1, err)
    });   
  end;
end;

{
******************************************************
TIMGetServerTime
******************************************************
}

procedure TTIMRenderer.GetServerTime;

  procedure jsOnGetServerTimeError(AErrorCode: Integer; AErrorMessage: String);
  begin
    if Assigned(FOnGetServerTimeError) then
      FOnGetServerTimeError(AErrorCode, AErrorMessage);  
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
      tmpOnError(-1, err)
    });   
  end;
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.Init;

  procedure jsOnInit;
  begin
    if Assigned(FOnInit) then
      FOnInit;  
  end;

  procedure jsOnInitError(AErrorCode: Integer; AErrorMessage: String);
  begin
    if Assigned(FOnInitError) then
      FOnInitError(AErrorCode, AErrorMessage);
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnInit;
  tmpOnError:=@jsOnInitError;

  asm //JavaScript
    timRendererInstance.TIMInit().then((result) =>{
      tmpOnSucc()
    }).catch((err) => {
      tmpOnError(result.data, err)
    });    
  end;
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.Uninit;

  procedure jsOnUninit;
  begin
    if Assigned(FOnUninit) then
      FOnUninit;    
  end;

  procedure jsOnUninitError(AErrorCode: Integer; AErrorMessage: String);
  begin
    if Assigned(FOnUninitError) then
      FOnUninitError(AErrorCode, AErrorMessage);  
  end;

var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnUninit;
  tmpOnError:=@jsOnUninitError;
  
  asm //JavaScript
    timRendererInstance.TIMUninit().then((result) => {
      tmpOnSucc()
    }).catch((err) => {
      tmpOnError(result.data, err)
    });   
  end;
end;

{
******************************************************
SetNewworkStatusListenerCallback
******************************************************
}

procedure TTIMRenderer.SetNetworkStatusListenerCallback(const AProc: TNetworkStatusListenerCallback);
begin
  asm //JavaScript
    timRendererInstance.TIMSetNetworkStatusListenerCallback({
      callback:(...args)=>{
        AProc(args[0][0], args[0][1], args[0][2], args[0][3])
      },
    })
  end;
end;

function TTIMRenderer.GetNetworkStatusListenerCallback: TNetworkStatusListenerCallback;
begin
  
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

procedure TTIMRenderer.SetKickedOfflineCallback(const Value: TKickedOfflineCallback);
begin
  asm //JavaScript
    timRendererInstance.TIMSetKickedOfflineCallback({
      callback:(...args)=>{
        AProc(args[0][0])
      },
    }) 
  end; 
end;

function TTIMRenderer.GetKickedOfflineCallback: TKickedOfflineCallback;
begin
  
end;

end.