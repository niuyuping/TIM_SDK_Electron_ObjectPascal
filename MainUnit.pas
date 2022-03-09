unit MainUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Electron, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls,
  IMRendererUnit, IMCloudDefUnit;

type
  TMainForm = class(TElectronForm)
    WebButton1: TWebButton;
    WebButton2: TWebButton;
    WebButton3: TWebButton;
    WebButton4: TWebButton;
    DebugMemo: TWebMemo;
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
    procedure WebButton4Click(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure Form1Create(Sender: TObject);
  private
    { Private declarations }
    TIMRenderer: TTIMRenderer;
  public
    { Public declarations }
    procedure OnTIMRendererGetSDKVersion(AVersion: String);
    procedure OnTIMRendererGetServerTimer(AServerTime: NativeUInt);
    procedure OnTIMRendererInit;
    procedure OnTIMRendererUninit;
    procedure OnNetworkStatus(AStatus: TIMNetworkStatus; ACode: NativeInt; ADesc: String; AUserData: JSValue);
    procedure OnKickedOffline(AUserData: JSValue);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  TypInfo;

procedure TMainForm.Form1Create(Sender: TObject);
begin
  TIMRenderer:=TTIMRenderer.Create;
  
  TIMRenderer.OnGetSDKVersion:=OnTIMRendererGetSDKVersion;  
  TIMRenderer.OnGetServerTimer:=OnTIMRendererGetServerTimer;
  TIMRenderer.OnInit:=OnTIMRendererInit;
  TIMRenderer.OnUninit:=OnTIMRendererUninit;
  TIMRenderer.NetworkStatusListenerCallback:=OnNetworkStatus;
  TIMRenderer.KickedOfflineCallback:=OnKickedOffline;
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

procedure TMainForm.OnTIMRendererInit;
begin
  DebugMemo.Lines.Add('TIM renderer init');  
end;

procedure TMainForm.OnTIMRendererUninit;
begin
  DebugMemo.Lines.Add('TIM renderer uninit');  
end;

procedure TMainForm.OnNetworkStatus(AStatus: TIMNetworkStatus; ACode: NativeInt; ADesc: String; AUserData: JSValue);
begin
  DebugMemo.Lines.Add(GetEnumName(TypeInfo(TIMNetworkStatus), Ord(AStatus)));
end;

procedure TMainForm.OnKickedOffline(AUserData: JSValue);
begin
  DebugMemo.Lines.Add('Kicked offline');
end;


initialization
  RegisterClass(TMainForm);

end.      