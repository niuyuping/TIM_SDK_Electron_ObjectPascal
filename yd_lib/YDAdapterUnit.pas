unit YDAdapterUnit;

interface

uses
  classes, IMRendererUnit, IMRendererTypeUnit, YDRequestTypeUnit, YDUserUnit;

type

  TYDAdapter = class (TComponent)
  private
    FTIM: TTIMRenderer;
    FMe: TYDUser;

    FOnLogin: TNotifyEvent;
    FOnGetSMS: TYDOnSMS;

    FOnKickOff: TNotifyEvent;
    FOnSigExpired: TNotifyEvent;

    FOnConnected: TNotifyEvent;
    FOnDisconnected: TNotifyEvent;
    FOnConnecting: TNotifyEvent;
    FOnConnectFailed: TNotifyEvent;

    FOnConvCreate: TConvCreateEvent;
    FOnConvDelete: TConvDeleteEvent;
    FOnConvUpdate: TConvUpdateEvent;
    FOnConvUpdateStart: TNotifyEvent;
    FOnConvUpdateFinish: TNotifyEvent;

    FOnNewMessage: TNewMessageEvent;

    FOnLogout: TNotifyEvent;
  
    procedure SetOnConnected(Value: TNotifyEvent);
    procedure SetOnDisconnected(Value: TNotifyEvent);
    procedure SetOnConnecting(Value: TNotifyEvent);
    procedure SetOnConnectFailed(Value: TNotifyEvent);

    procedure SetOnKickOff(Value: TNotifyEvent);
    procedure SetOnSigExpired(Value: TNotifyEvent);

    procedure SetOnConvCreate(const Value: TConvCreateEvent);
    procedure SetOnConvDelete(const Value: TConvDeleteEvent);
    procedure SetOnConvUpdate(const Value: TConvUpdateEvent);
    procedure SetOnConvUpdateStart(const Value: TNotifyEvent);
    procedure SetOnConvUpdateFinish(const Value: TNotifyEvent);

    procedure SetOnNewMessage(const Value: TNewMessageEvent);

    procedure SetOnMsgElemUploadProgress(const Value: TMsgElemUploadProgressEvent);

    procedure SetOnMsgReceipt(const Value: TMsgReceiptEvent);
    
    procedure SetOnMsgRevoke(const Value: TMsgRevokeEvent);

    procedure SetOnUnreadMessageCountChanged(const Value: TUnreadMessageCountChangedEvent);

    procedure OnYDLogin(AResult: TYDCommonResponse; AUserData: JSValue); 

    [async]procedure OnTIMLogin(AResult: TTIMCommonResponse);

    function GetXPMSClientJSON: string;
    
  protected
    property XPMSClientJSON: string read GetXPMSClientJSON;
  public
    //TIM SDK的实例
    property TIM: TTIMRenderer read FTIM write FTIM;

    //用户个人信息实例
    property Me: TYDUser read FMe write FMe;

    //网络状态相关事件
    property OnConnected: TNotifyEvent read FOnConnected write SetOnConnected;
    property OnDisconnected: TNotifyEvent read FOnDisconnected write SetOnDisconnected;
    property OnConnecting: TNotifyEvent read FOnConnecting write SetOnConnecting;
    property OnConnectFailed: TNotifyEvent read FOnConnectFailed write SetOnConnectFailed;

    //同一帐号在其它地方登录事件
    property OnKickOff: TNotifyEvent read FOnKickOff write SetOnKickOff;

    //Sig过期事件
    property OnSigExpired: TNotifyEvent read FOnSigExpired write SetOnSigExpired;

    //新建会话事件
    property OnConvCreate: TConvCreateEvent read FOnConvCreate write SetOnConvCreate;

    //删除会话事件
    property OnConvDelete: TConvDeleteEvent read FOnConvDelete write SetOnConvDelete;

    //更新会话事件
    property OnConvUpdate: TConvUpdateEvent read FOnConvUpdate write SetOnConvUpdate;

    //开始拉取会话事件
    property OnConvUpdateStart: TNotifyEvent read FOnConvUpdateStart write SetOnConvUpdateStart;

    //拉取会话完成事件
    property OnConvUpdateFinish: TNotifyEvent read FOnConvUpdateFinish write SetOnConvUpdateFinish;

    //收到新消息事件
    property OnNewMessage: TNewMessageEvent read FOnNewMessage write SetOnNewMessage;

    //消息元素上传进度事件
    FOnMsgElemUploadProgress: TMsgElemUploadProgressEvent;
    property OnMsgElemUploadProgress: TMsgElemUploadProgressEvent read FOnMsgElemUploadProgress write SetOnMsgElemUploadProgress;

    //发出的消息变为已读事件
    FOnMsgReceipt: TMsgReceiptEvent;
    property OnMsgReceipt: TMsgReceiptEvent read FOnMsgReceipt write SetOnMsgReceipt;

    //消息撤回事件
    FOnMsgRevoke: TMsgRevokeEvent;
    property OnMsgRevoke: TMsgRevokeEvent read FOnMsgRevoke write SetOnMsgRevoke;

    //未读消息总数变化事件
    FOnUnreadMessageCountChanged: TUnreadMessageCountChangedEvent;
    property OnUnreadMessageCountChanged: TUnreadMessageCountChangedEvent read FOnUnreadMessageCountChanged write SetOnUnreadMessageCountChanged;

    //成功登录事件
    property OnLogin: TNotifyEvent read FOnLogin write FOnLogin;

    //成功登出事件
    property OnLogout: TNotifyEvent read FOnLogout write FOnLogout;

    //成功获取短信验证码事件
    property OnGetSMS: TYDOnSMS read FOnGetSMS write FOnGetSMS;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    //登录，包括盈单登录和TIM登录，全流程完成以后会触发OnLogin事件
    [async]procedure Login(ALoginType: String; APhoneNumber: string; ACaptcha: string; AUserData: JSValue = Nil);

    //登出
    [async]procedure Logout;

    //申请短信验证码
    [async]procedure GetSMS(AKind: String; APhoneNumber: String; AUserData: JSValue = Nil);
  end;

implementation

uses 
  sysutils, YDRequestorUnit, ConstUnit, YDLoginTypeUnit, js, web, IMCloudDefUnit, WEBLib.JSON;

constructor TYDAdapter.Create(AOwner: TComponent);
begin
  inherited;

  FTIM:=TTIMRenderer.Create;
  FTIM.OnLogin:=OnTIMLogin;
  
  FMe:=TYDUser.Create;
end;

destructor TYDAdapter.Destroy;
begin
  FreeAndNil(FMe);
  FreeAndNil(FTIM);
  inherited;
end;

procedure TYDAdapter.Login(ALoginType: String; APhoneNumber: string; ACaptcha: string; AUserData: JSValue);
var
  TmpRequestor: TYDRequestor;
begin
  TmpRequestor:=TYDRequestor.Create(Self);
  try
    TmpRequestor.OnLogin:=OnYDLogin;
    await(TmpRequestor.RequestLogin(ALoginType, APhoneNumber, ACaptcha, AUserData));
  finally
    FreeAndNil(TmpRequestor);
  end;
end;

procedure TYDAdapter.GetSMS(AKind: String; APhoneNumber: String; AUserData: JSValue);
var
  TmpRequestor: TYDRequestor;
begin
  TmpRequestor:=TYDRequestor.Create(Self);
  try
    TmpRequestor.OnSMS:=FOnGetSMS;
    await(TmpRequestor.RequestSMS(AKind, APhoneNumber, AUserData));
  finally
    FreeAndNil(TmpRequestor);
  end;
end;

procedure TYDAdapter.OnYDLogin(AResult: TYDCommonResponse; AUserData: JSValue);
var
  TmpResponse: TYDLoginResponse;
begin
  case AResult.code of
    '0': begin
      if AResult.data <> Nil then
      begin
        TmpResponse:= TYDLoginResponse(AResult.data);
        FMe.Profile.LoadFromYDResponse(TmpResponse);
        
        FTIM.Login(FMe.Profile.ID, FMe.Profile.UserSig);      
      end;
    end;
  end;
end;

procedure TYDAdapter.OnTIMLogin(AResult: TTIMCommonResponse);
var
  TmpProfileArray: TTIMUserProfileArray;
begin
  case AResult.code of
    0: begin
      TmpProFileArray:=await(FTIM.GetUserProfileList([FMe.Profile.ID], True, YD_FLAG_SELF));
      if Length(TmpProFileArray)>0 then
        FMe.Profile.LoadFromTIMResponse(TmpProfileArray[0]);      

      if Assigned(FOnLogin) then
        FOnLogin(Self);
    end;
  end;
end;

procedure TYDAdapter.SetOnConnected(Value: TNotifyEvent);
begin
  FOnConnected:=Value;
  FTIM.OnConnected:=Value;
end;

procedure TYDAdapter.SetOnDisconnected(Value: TNotifyEvent);
begin
  FOnDisconnected:=Value;
  FTIM.OnDisconnected:=Value;
end;

procedure TYDAdapter.SetOnConnecting(Value: TNotifyEvent);
begin
  FOnConnecting:=Value;
  FTIM.OnConnecting:=Value;
end;

procedure TYDAdapter.SetOnConnectFailed(Value: TNotifyEvent);
begin
  FOnConnectFailed:=Value;
  FTIM.OnConnectFailed:=Value;
end;

procedure TYDAdapter.SetOnKickOff(Value: TNotifyEvent);
begin
  FOnKickOff:=Value;
  FTIM.OnKickOff:=Value;
end;

procedure TYDAdapter.SetOnSigExpired(Value: TNotifyEvent);
begin
  FOnSigExpired:=Value;
  FTIM.OnSigExpired:=Value;
end;

procedure TYDAdapter.SetOnConvCreate(const Value: TConvCreateEvent);
begin
  FOnConvCreate:=Value;
  FTIM.OnConvCreate:=Value;
end;

procedure TYDAdapter.SetOnConvDelete(const Value: TConvDeleteEvent);
begin
  FOnConvDelete:=Value;
  FTIM.OnConvDelete:=Value;
end;

procedure TYDAdapter.SetOnConvUpdate(const Value: TConvUpdateEvent);
begin
  FOnConvUpdate:=Value;
  FTIM.OnConvUpdate:=Value;
end;

procedure TYDAdapter.SetOnConvUpdateStart(const Value: TNotifyEvent);
begin
  FOnConvUpdateStart:=Value;
  FTIM.OnConvUpdateStart:=Value;
end;

procedure TYDAdapter.SetOnConvUpdateFinish(const Value: TNotifyEvent);
begin
  FOnConvUpdateFinish:=Value;
  FTIM.OnConvUpdateFinish:=Value;
end;

procedure TYDAdapter.SetOnNewMessage(const Value: TNewMessageEvent);
begin
  FOnNewMessage:=Value;
  FTIM.OnNewMessage:=FOnNewMessage;
end;

procedure TYDAdapter.SetOnMsgElemUploadProgress(const Value: TMsgElemUploadProgressEvent);
begin
  FOnMsgElemUploadProgress:=Value;
  FTIM.OnMsgElemUploadProgress:=Value;
end;

procedure TYDAdapter.SetOnMsgReceipt(const Value: TMsgReceiptEvent);
begin
  FOnMsgReceipt:=Value;
  FTIM.OnMsgReceipt:=Value;
end;

procedure TYDAdapter.SetOnMsgRevoke(const Value: TMsgRevokeEvent);
begin
  FOnMsgRevoke:=Value;
  FTIM.OnMsgRevoke:=Value;
end;

procedure TYDAdapter.SetOnUnreadMessageCountChanged(const Value: TUnreadMessageCountChangedEvent);
begin
  FOnUnreadMessageCountChanged:=Value;
  FTIM.OnUnreadMessageCountChanged:=Value;
end;

procedure TYDAdapter.Logout;
var
  TmpRequestor: TYDRequestor;
begin
  TmpRequestor:=TYDRequestor.Create(Self);
  try
    await(FTIM.Logout);
    await(TmpRequestor.RequestLogout(XPMSClientJSON, FMe.Profile.Token));
  finally
    if Assigned(FONLogout) then
      FOnLogout(Self);
    FreeAndNil(TmpRequestor);
  end;
end;

function TYDAdapter.GetXPMSClientJSON: string;
begin
  Result:='';

  with TJSONObject.Create do
  begin
    try
      AddPair('deviceInfo', '');
      AddPair('platform', 'MacOS');
      AddPair('pushToken', FMe.Profile.Token);
      Result:=ToString;
    finally
      Free;
    end;
  end;
end;
  
end.