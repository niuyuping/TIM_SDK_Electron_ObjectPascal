unit MainUnit;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Electron, WEBLib.Dialogs, WEBLib.Menus, WEBLib.StdCtrls,
  IMRenderUnit;

type
  TForm1 = class(TElectronForm)
    WebButton1: TWebButton;
    WebButton2: TWebButton;
    WebButton3: TWebButton;
    WebButton4: TWebButton;
    procedure WebButton2Click(Sender: TObject);
    procedure WebButton3Click(Sender: TObject);
    procedure WebButton4Click(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure Form1Create(Sender: TObject);
  private
    { Private declarations }
    TIMRender: TTIMRender;
  public
    { Public declarations }
    procedure OnGetSDKVersion(AVersion: String);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Form1Create(Sender: TObject);
begin
  TIMRender:=TTIMRender.Create;
  
  TIMRender.OnGetSDKVersion:=OnGetSDKVersion;  
end;

procedure TForm1.WebButton1Click(Sender: TObject);
begin
  TIMRender.GetSDKVersion;  
end;

procedure TForm1.WebButton4Click(Sender: TObject);
begin
//  TIMInit;  
end;

procedure TForm1.WebButton3Click(Sender: TObject);
begin
  // TIMUninit;
end;

procedure TForm1.WebButton2Click(Sender: TObject);
begin
  // TIMGetServerTime;
end;

procedure TForm1.OnGetSDKVersion(AVersion: String);
begin
  console.log('Get SDK version: ', AVersion);
end;


initialization
  RegisterClass(TForm1);

end.   