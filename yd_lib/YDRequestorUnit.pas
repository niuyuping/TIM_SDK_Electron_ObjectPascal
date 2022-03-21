// YingDan REST library
// Based on TMS Web Core Electron
// Requestor unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit YDRequestorUnit;

interface

uses
  WEBLib.REST, System.Classes, YDRequestTypeUnit, Web, JS;

type
  //REST请求异常的事件
  TOnRESTReq_Error = procedure(AMessage: String; AUserData: JSValue) of object;
  
  //盈单REST通讯类
  TYDRequestor = class(TWebHTTPRequest)
  private
    FOnReqError: TOnRESTReq_Error;

    FOnSMS: TYDOnSMS;
    FOnLogin: TYDOnLogin;
    FOnLogout: TYDOnLogout;
  public
    property OnReqError: TOnRESTReq_Error read FOnReqError write FOnReqError;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property OnSMS: TYDOnSMS read FOnSMS write FOnSMS;
    property OnLogin: TYDOnLogin read FOnLogin write FOnLogin;
    property OnLogout: TYDOnLogout read FOnLogout write FOnLogout;

    //请求发送短信
    [Async]procedure RequestSMS(AKind: String; APhoneNumber: String; AUserData: JSValue = Nil); 
    [Async]procedure RequestLogin(ALoginType: String; APhoneNumber, ACaptcha: String; AUserData: JSValue = Nil);
    [Async]procedure RequestLogout(AClientJSON, AToken: String; AUserData: JSValue = Nil);
  end;

implementation

uses
  System.SysUtils, TypInfo, YDLoginTypeUnit, YDSMSTypeUnit, WEBLib.JSON, ConstUnit;

constructor TYDRequestor.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TYDRequestor.Destroy;
begin
  inherited;
end;

procedure TYDRequestor.RequestSMS(AKind: String; APhoneNumber: String; AUserData: JSValue);
var
  Req: TJSXMLHttpRequest;
  TmpResponse: TYDCommonResponse;
begin
  //拼接地址和参数
  URL:=Format('%s/%s/%s?phoneNum=%s&smsType=%s', [YD_BASE_URL, YD_MOBILE_SERVER, YD_REQ_SMS, APhoneNumber, AKind]);
  with Headers do
  begin
    Clear;
    AddPair('Content-Type', 'application/json');
  end;

  Command:=httpPOST;
  try
    Req := await(TJSXMLHttpRequest, Perform);
    TmpResponse:=TYDCommonResponse(TJSJSON.parse(Req.responseText));
    if Assigned(FOnSMS) then
      FOnSMS(TmpResponse, AUserData);
  except
    on E: Exception do
    begin
      if Assigned(FOnReqError) then
        FOnReqError(E.Message, AUserData);
    end;
  end;
end;

procedure TYDRequestor.RequestLogin(ALoginType: String; APhoneNumber: string; ACaptcha: string; AUserData: JSValue = Nil);
var
  Req: TJSXMLHttpRequest;
  TmpResponse: TYDCommonResponse;
begin
  //拼接地址和参数
  URL:=Format('%s/%s/%s?platform=MacOS', [YD_BASE_URL, YD_MOBILE_SERVER, YD_REQ_LOGIN]);
  with Headers do
  begin
    Clear;
    AddPair('Content-Type', 'application/json');
  end;
  //以JSON传递参数
  with TJSONObject.Create do
  begin
    try
      AddPair('captcha', ACaptcha);
      AddPair('loginType', ALoginType);
      AddPair('mobile', APhoneNumber);
      PostData := ToString;
    finally
      Free;
    end;
  end;
  Command:=httpPOST;
  try
    Req := await(TJSXMLHttpRequest, Perform);
    TmpResponse:=TYDCommonResponse(TJSJSON.parse(Req.responseText));
    if Assigned(FOnLogin) then
       FOnLogin(TmpResponse, AUserData);
  except
    on E: Exception do
    begin
      if Assigned(FOnReqError) then
        FOnReqError(E.Message, AUserData);
    end;
  end;
end;

procedure TYDRequestor.RequestLogout(AClientJSON, AToken: String; AUserData: JSValue);
var
  Req: TJSXMLHttpRequest;
  TmpResponse: TYDCommonResponse;
begin
  //拼接地址和参数
  URL:=Format('%s/%s/%s', [YD_BASE_URL, YD_MOBILE_SERVER, YD_REQ_LOGOUT]);
  with Headers do
  begin
    Clear;
    AddPair('Content-Type', 'application/json');
    AddPair('x-pms-client', AClientJSON);
    AddPair('x-pms-token', AToken);
  end;
  Command:=httpDELETE;
  try
    Req := await(TJSXMLHttpRequest, Perform);
    TmpResponse:=TYDCommonResponse(TJSJSON.parse(Req.responseText));
    if Assigned(FOnLogout) then
       FOnLogout(TmpResponse, AUserData);
  except
    on E: Exception do
    begin
      if Assigned(FOnReqError) then
        FOnReqError(E.Message, AUserData);
    end;
  end;
end;

end.