unit MainUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Electron, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls,
  IMRendererUnit, IMCloudDefUnit, IMRendererTypeUnit, YDRequestorUnit, YDRequestTypeUnit, WEBLib.ExtCtrls,
  WEBLib.TMSFNCCustomControl, WEBLib.TMSFNCListBox, WEBLib.TMSFNCTypes, WEBLib.TMSFNCUtils, WEBLib.TMSFNCGraphics,
  WEBLib.TMSFNCGraphicsTypes, WEBLib.Chatbox, WEBLib.WebCtrls, YDUserUnit, YDAdapterUnit;

type

  TMainForm = class(TElectronForm)
    WebButton1: TWebButton;
    WebButton2: TWebButton;
    DebugMemo: TWebMemo;
    WebButton5: TWebButton;
    WebButton6: TWebButton;
    WebButton10: TWebButton;
    PhoneNumberEdit: TWebEdit;
    LoginBtn: TWebButton;
    CaptchaEdit: TWebEdit;
    WebPanel1: TWebPanel;
    WebButton4: TWebButton;
    WebChatbox1: TWebChatbox;
    WebImageControl1: TWebImageControl;
    WebButton11: TWebButton;
    WebHTMLDiv1: TWebHTMLDiv;
    WebButton3: TWebButton;
    [Async]procedure WebButton2Click(Sender: TObject);
    procedure WebButton4Click(Sender: TObject);
    procedure Form1Create(Sender: TObject);
    [Async]procedure WebButton5Click(Sender: TObject);
    [Async]procedure WebButton6Click(Sender: TObject);
    procedure CaptchaEditChange(Sender: TObject);
    procedure LoginBtnClick(Sender: TObject);
    procedure WebButton11Click(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
  private
    { Private declarations }
    
    YDAdapter: TYDAdapter;
  public
    { Public declarations }

    [Async]procedure OnLogin(Sender: TObject);
    procedure OnLogout(Sender: TObject);

    procedure OnConnected(Sender: TObject);
    procedure OnDisconnected(Sender: TObject);
    procedure OnConnecting(Sender: TObject);
    procedure OnConnectFailed(Sender: TObject);

    procedure OnKickOff(Sender: TObject);
    procedure OnSigExpired(Sender: TObject);

    procedure OnConvCreate(AConveArray: TTIMConvInfoArray);
    procedure OnConvDelete(AConveArray: TTIMConvInfoArray);
    procedure OnConvUpdate(AConveArray: TTIMConvInfoArray);
    procedure OnConvUpdateStart(Sender: TObject);
    procedure OnConvUpdateFinish(Sender: TObject);

    procedure OnNewMessage(AMessageArray: TTIMMessageArray);

    procedure OnMsgElemUploadProgress(AJSONMsg: JSValue; AIndex: NativeInt; ACurSize: NativeInt; ALocalSize: NativeInt);

    procedure OnMsgReceipt(AMsgReceiptArray: TTIMMsgReceiptArray);

    procedure OnMsgRevoke(AMsgLocatorArray: TTIMMsgLocatorArray);

    procedure OnUnreadMessageCountChanged(AUnreadMessageCount: NativeInt);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  TypInfo, YDSMSTypeUnit, YDLoginTypeUnit, ConstUnit, libelectron;

procedure TMainForm.WebButton3Click(Sender: TObject);
begin
  YDAdapter.Logout;  
end;

procedure TMainForm.WebButton1Click(Sender: TObject);
begin
  //??????SDK????????????
  DebugMemo.Lines.Add(YDAdapter.TIM.SDKVersion);  
end;

procedure TMainForm.WebButton11Click(Sender: TObject);
var
  TmpCaption: String;
begin
  WebButton11.Caption:='?????????';
  TmpCaption:='??????';
  asm //JavaScript
        $(function () {
          $("#buttonContainer").dxCheckBox({
            text: TmpCaption,
            value: undefined
          });
        });      
  end;  
end;

procedure TMainForm.LoginBtnClick(Sender: TObject);
begin
  YDAdapter.Login(GetEnumName(TypeInfo(TYDLoginType), 0), PhoneNumberEdit.Text, CaptchaEdit.Text);  
end;

procedure TMainForm.CaptchaEditChange(Sender: TObject);
begin
  LoginBtn.Enabled:=CaptchaEdit.Text<>''; 
end;

procedure TMainForm.WebButton6Click(Sender: TObject);
begin
  DebugMemo.Lines.Add(await(YDAdapter.TIM.GetLoginUserID)); 
end;

procedure TMainForm.WebButton5Click(Sender: TObject);
var
  TmpLoginStatus: NativeInt;
begin
  TmpLoginStatus:=await(NativeInt, YDAdapter.TIM.GetLoginStatus);
  DebugMemo.Lines.Add(TmpLoginStatus.ToString);  
end;

procedure TMainForm.Form1Create(Sender: TObject);
begin
  //????????????????????????  
  document.getElementById('titleBar')['style']:=document.getElementById('titleBar')['style']+' -webkit-app-region: drag; -webkit-user-select: none;';
  document.getElementById('formCloseBtn')['style']:=document.getElementById('formCloseBtn')['style']+' -webkit-app-region: no-drag;';

  YDAdapter:=TYDAdapter.Create(Self);
  YDAdapter.OnLogin:=OnLogin;
  YDAdapter.OnConnected:=OnConnected;
  YDAdapter.OnDisconnected:=OnDisconnected;
  YDAdapter.OnConnecting:=OnConnecting;
  YDAdapter.OnConnectFailed:=OnConnectFailed;
  YDAdapter.OnKickOff:=OnKickOff;
  YDAdapter.OnSigExpired:=OnSigExpired;
  YDAdapter.OnConvCreate:=OnConvCreate;
  YDAdapter.OnConvDelete:=OnConvDelete;
  YDAdapter.OnConvUpdate:=OnConvUpdate;
  YDAdapter.OnConvUpdateStart:=OnConvUpdateStart;
  YDAdapter.OnConvUpdateFinish:=OnConvUpdateFinish;
  YDAdapter.OnNewMessage:=OnNewMessage;
  YDAdapter.OnMsgElemUploadProgress:=OnMsgElemUploadProgress;
  YDAdapter.OnMsgReceipt:=OnMsgReceipt;
  YDAdapter.OnMsgRevoke:=OnMsgRevoke;
  YDAdapter.OnUnreadMessageCountChanged:=OnUnreadMessageCountChanged;
  YDAdapter.OnLogout:=OnLogout;
end;

procedure TMainForm.WebButton4Click(Sender: TObject);
begin
  Electron.IPCRenderer.invoke('ipc-custom-window-close');
end;

procedure TMainForm.WebButton2Click(Sender: TObject);
var
  TmpServerTime: NativeUInt;
begin
   TmpServerTime:=await(YDAdapter.TIM.GetServerTime);
   DebugMemo.Lines.Add(TmpServerTime.ToString);
end;

procedure TMainForm.OnLogin(Sender: TObject);
var
  TmpConvInfoList: TTIMConvInfoArray;
begin
  DebugMemo.Lines.Add('?????????');

  TmpConvInfoList:= await(TTIMConvInfoArray, YDAdapter.TIM.GetConvList);
  console.log(YDAdapter.Me.Profile);
  console.log(TmpConvInfoList);
end;

procedure TMainForm.OnConnected(Sender: TObject);
begin
  DebugMemo.Lines.Add('???????????????');
end;

procedure TMainForm.OnDisconnected(Sender: TObject);
begin
  DebugMemo.Lines.Add('?????????????????????');
end;

procedure TMainForm.OnConnecting(Sender: TObject);
begin
  DebugMemo.Lines.Add('??????????????????');
end;

procedure TMainForm.OnConnectFailed(Sender: TObject);
begin
  DebugMemo.Lines.Add('??????????????????');
end;

procedure TMainForm.OnKickOff(Sender: TObject);
begin
  DebugMemo.Lines.Add('???????????????????????????');
end;

procedure TMainForm.OnSigExpired(Sender: TObject);
begin
  DebugMemo.Lines.Add('?????????????????????');
end;

procedure TMainForm.OnConvCreate(AConveArray: TTIMConvInfoArray);
begin
  DebugMemo.Lines.Add('??????????????????');
  console.log(AConveArray);
end;

procedure TMainForm.OnConvDelete(AConveArray: TTIMConvInfoArray);
begin
  DebugMemo.Lines.Add('??????????????????');
  console.log(AConveArray);
end;

procedure TMainForm.OnConvUpdate(AConveArray: TTIMConvInfoArray);
begin
  DebugMemo.Lines.Add('????????????');
  console.log(AConveArray);
end;

procedure TMainForm.OnConvUpdateStart(Sender: TObject);
begin
  DebugMemo.Lines.Add('????????????????????????');
end;

procedure TMainForm.OnConvUpdateFinish(Sender: TObject);
begin
  DebugMemo.Lines.Add('????????????????????????');
end;

procedure TMainForm.OnNewMessage(AMessageArray: TTIMMessageArray);
begin
  DebugMemo.Lines.Add('???????????????');
  console.log(AMessageArray);
end;

procedure TMainForm.OnMsgElemUploadProgress(AJSONMsg: JSValue; AIndex: NativeInt; ACurSize: NativeInt; ALocalSize: NativeInt);
begin
  DebugMemo.Lines.Add('???????????????????????????: '+AIndex.ToString+' '+ALocalSize.ToString);
  console.log(AJSONMsg, AIndex, ALocalSize);
end;

procedure TMainForm.OnMsgReceipt(AMsgReceiptArray: TTIMMsgReceiptArray);
begin
  DebugMemo.Lines.Add('????????????????????????');
  console.log(AMsgReceiptArray);
end;

procedure TMainForm.OnMsgRevoke(AMsgLocatorArray: TTIMMsgLocatorArray);
begin
  DebugMemo.Lines.Add('???????????????');
  console.log(AMsgLocatorArray);
end;

procedure TMainForm.OnUnreadMessageCountChanged(AUnreadMessageCount: NativeInt);
begin
  DebugMemo.Lines.Add('????????????????????????'+AUnreadMessageCount.ToString);
end;

procedure TMainForm.OnLogout(Sender: TObject);
begin
  DebugMemo.Lines.Add('??????');
end;

initialization
  RegisterClass(TMainForm);

end.                                   