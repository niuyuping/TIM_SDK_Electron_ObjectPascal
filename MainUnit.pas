unit MainUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Electron, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls,
  IMRendererUnit, IMCloudDefUnit, IMRendererTypeUnit;

type
  TMainForm = class(TElectronForm)
    WebButton1: TWebButton;
    WebButton2: TWebButton;
    WebButton3: TWebButton;
    WebButton4: TWebButton;
    DebugMemo: TWebMemo;
    WebButton5: TWebButton;
    WebButton6: TWebButton;
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    UserIDEdit: TWebEdit;
    UserSigEdit: TWebEdit;
    WebButton7: TWebButton;
    WebButton8: TWebButton;
    WebButton9: TWebButton;
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
    procedure WebButton4Click(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure Form1Create(Sender: TObject);
    procedure WebButton5Click(Sender: TObject);
    procedure WebButton6Click(Sender: TObject);
    procedure WebButton7Click(Sender: TObject);
    procedure WebButton8Click(Sender: TObject);
    procedure WebButton9Click(Sender: TObject);
  private
    { Private declarations }
    TIMRenderer: TTIMRenderer;
  public
    { Public declarations }
    procedure OnTIMRendererGetSDKVersion(AVersion: String);
    procedure OnTIMRendererGetServerTimer(AServerTime: NativeUInt);
    procedure OnTIMRendererInit(AResult: NativeInt);
    procedure OnTIMRendererUninit(AResult: NativeInt);
    procedure OnTIMNetworkStatus(AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue);
    procedure OnTIMKickedOffline(AUserData: JSValue);
    procedure OnTIMLog(ALevel: NativeInt; ALog: String; AUserData: JSValue);
    procedure OnTIMUserSigExpired(AUserData: JSValue);
    procedure OnTIMGetLoginStatus(ALoginStatus: NativeInt);
    procedure OnTIMGetLoginUserID(AResult: TCommonResponse);
    procedure OnTIMLogin(AResult: TCommonResponse);
    procedure OnTIMLogout(AResult: TCommonResponse);
    procedure OnTIMGetUserProfileList(AResult: TCommonResponse);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  TypInfo;

procedure TMainForm.WebButton9Click(Sender: TObject);
begin
  TIMRenderer.GetUserProfileList([], False);  
end;

procedure TMainForm.WebButton8Click(Sender: TObject);
begin
  TIMRenderer.Logout;  
end;

procedure TMainForm.WebButton7Click(Sender: TObject);
begin
  TIMRenderer.Login(UserIDEdit.Text, UserSigEdit.Text);
end;

procedure TMainForm.WebButton6Click(Sender: TObject);
begin
  TIMRenderer.GetLoginUserID;  
end;

procedure TMainForm.WebButton5Click(Sender: TObject);
begin
  TIMRenderer.GetLoginStatus;  
end;

procedure TMainForm.Form1Create(Sender: TObject);
begin
  TIMRenderer:=TTIMRenderer.Create;
  
  TIMRenderer.OnGetSDKVersion:=OnTIMRendererGetSDKVersion;  
  TIMRenderer.OnGetServerTimer:=OnTIMRendererGetServerTimer;
  TIMRenderer.OnInit:=OnTIMRendererInit;
  TIMRenderer.OnUninit:=OnTIMRendererUninit;
  TIMRenderer.SetNetworkStatusListenerCallback(@OnTIMNetworkStatus);
  TIMRenderer.SetKickedOfflineCallback(@OnTIMKickedOffline);
  TIMRenderer.SetLogCallback(@OnTIMLog);
  TIMRenderer.SetUserSigExpiredCallback(@OnTIMUserSigExpired);
  TIMRenderer.OnGetLoginStatus:=OnTIMGetLoginStatus;
  TIMRenderer.OnGetLoginUserID:=OnTIMGetLoginUserID;
  TIMRenderer.OnLogin:=OnTIMLogin;
  TIMRenderer.OnLogout:=OnTIMLogout;
  TIMRenderer.OnGetUserProfileList:=OnTIMGetUserProfileList;
end;

procedure TMainForm.WebButton1Click(Sender: TObject);
begin
  TIMRenderer.GetSDKVersion;  
end;

procedure TMainForm.WebButton4Click(Sender: TObject);
begin
  TIMRenderer.Init;  
end;

procedure TMainForm.WebButton3Click(Sender: TObject);
begin
  TIMRenderer.Uninit;  
end;

procedure TMainForm.WebButton2Click(Sender: TObject);
begin
  TIMRenderer.GetServerTime;
end;

procedure TMainForm.OnTIMRendererGetSDKVersion(AVersion: String);
begin
  DebugMemo.Lines.Add(Format('TIM renderer get SDK version: %s', [AVersion]));
end;

procedure TMainForm.OnTIMRendererGetServerTimer(AServerTime: NativeUInt);
begin
  DebugMemo.Lines.Add(Format('TIM renderer get server time: %d', [AServerTime]));
end;

procedure TMainForm.OnTIMRendererInit(AResult: NativeInt);
begin
  DebugMemo.Lines.Add(Format('TIM renderer init: %d', [AResult]));  
end;

procedure TMainForm.OnTIMRendererUninit(AResult: NativeInt);
begin
  DebugMemo.Lines.Add(Format('TIM renderer uninit: %d', [AResult]));  
end;

procedure TMainForm.OnTIMNetworkStatus(AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue);
begin
  DebugMemo.Lines.Add(Format('Network status: %d %s %s', [AStatus, ADesc, AUserData]));
end;

procedure TMainForm.OnTIMKickedOffline(AUserData: JSValue);
begin
  DebugMemo.Lines.Add(Format('Kicked offline: %s', [AUserData]));
end;

procedure TMainForm.OnTIMLog(ALevel: NativeInt; ALog: String; AUserData: JSValue);
begin
  console.log(Format('Log: %d %s %s', [ALevel, ALog, AUserData]));
end;

procedure TMainForm.OnTIMUserSigExpired(AUserData: JSValue);
begin
  DebugMemo.Lines.Add('User_sig expired');
end;

procedure TMainForm.OnTIMGetLoginStatus(ALoginStatus: NativeInt);
begin
  DebugMemo.Lines.Add(Format('Login status: %d', [ALoginStatus]));
end;

procedure TMainForm.OnTIMGetLoginUserID(AResult: TCommonResponse);
begin
  DebugMemo.Lines.Add(Format('Login user ID: %d', [AResult.code]));
end;

procedure TMainForm.OnTIMLogin(AResult: TCommonResponse);
begin
  DebugMemo.Lines.Add(Format('Login: %d', [AResult.code]));
end;

procedure TMainForm.OnTIMLogout(AResult: TCommonResponse);
begin
  DebugMemo.Lines.Add(Format('Logout: %d', [AResult.code]));  
end;

procedure TMainForm.OnTIMGetUserProfileList(AResult: TCommonResponse);
begin
  DebugMemo.Lines.Add(Format('Get user profile list: %d', [AResult.code]));    
end;

initialization
  RegisterClass(TMainForm);

end.      