// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
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
    procedure jsOnGetSDKVersion(AVersion: String);
    procedure jsOnGetSDKVersionError(AErrorCode: Integer; AErrorMessage: String);

    FOnGetServerTimer: TOnGetServerTime;
    FOnGetServerTimeError: TOnGetServerTime_Error;
    procedure jsOnGetServerTime(AServerTime: NativeUInt);
    procedure jsOnGetServerTimeError(AErrorCode: Integer; AErrorMessage: String);

    FOnInit: TOnInit;
    FOnInitError: TOnInit_Error;
    procedure jsOnInit;
    procedure jsOnInitError(AErrorCode: Integer; AErrorMessage: String);

    FOnUninit: TOnUninit;
    FOnUninitError: TOnUninit_Error;
    procedure jsOnUninit;
    procedure jsOnUninitError(AErrorCode: Integer; AErrorMessage: String);
  public
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
  end;

implementation

{
******************************************************
TIMGetSDKVersion
******************************************************
}

//Event for success
procedure TTIMRenderer.jsOnGetSDKVersion(AVersion: String);
begin
  if Assigned(FOnGetSDKVersion) then
    FOnGetSDKVersion(AVersion);
end;

//Event for error
procedure TTIMRenderer.jsOnGetSDKVersionError(AErrorCode: Integer; AErrorMessage: String);
begin
  if Assigned(FOnGetSDKVersionError) then
    FOnGetSDKVersionError(AErrorCode, AErrorMessage);
end;

procedure TTIMRenderer.GetSDKVersion;
var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetSDKVersion;
  tmpOnError:=@jsOnGetSDKVersionError;
 
  Init;

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
var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetServerTime;
  tmpOnError:=@jsOnGetServerTimeError;
  
  Init;

  asm //JavaScript
    timRendererInstance.TIMGetServerTime().then((result) => {
      tmpOnSucc(result.data)
    }).catch((err) => {
      tmpOnError(-1, err)
    });   
  end;
end;

procedure TTIMRenderer.jsOnGetServerTimeError(AErrorCode: Integer; AErrorMessage: String);
begin
  if Assigned(FOnGetServerTimeError) then
    FOnGetServerTimeError(AErrorCode, AErrorMessage);  
end;

procedure TTIMRenderer.jsOnGetServerTime(AServerTime: NativeUInt);
begin
  if Assigned(FOnGetServerTimer) then
    FOnGetServerTimer(AServerTime);  
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.jsOnInit;
begin
  if Assigned(FOnInit) then
    FOnInit;  
end;

procedure TTIMRenderer.jsOnInitError(AErrorCode: Integer; AErrorMessage: String);
begin
  if Assigned(FOnInitError) then
    FOnInitError(AErrorCode, AErrorMessage);
end;

procedure TTIMRenderer.Init;
var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnInit;
  tmpOnError:=@jsOnInitError;

  asm //JavaScript
    if (typeof timRendererInstance == 'undefined') {
      timRendererInstance = new timRenderer();
      timRendererInstance.TIMInit().then((result) =>{
        tmpOnSucc()
      }).catch((err) => {
         tmpOnError(result.data, err)
      });
    }
  end;
end;

{
******************************************************
TIMInit
******************************************************
}

procedure TTIMRenderer.jsOnUninit;
begin
  if Assigned(FOnUninit) then
    FOnUninit;    
end;

procedure TTIMRenderer.jsOnUninitError(AErrorCode: Integer; AErrorMessage: String);
begin
  if Assigned(FOnUninitError) then
    FOnUninitError(AErrorCode, AErrorMessage);  
end;

procedure TTIMRenderer.Uninit;
var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnUninit;
  tmpOnError:=@jsOnUninitError;
  
  Init;

  asm //JavaScript
    timRendererInstance.TIMUninit().then((result) => {
      tmpOnSucc()
    }).catch((err) => {
      tmpOnError(result.data, err)
    });   
  end;
end;

end.