program TryTIMSDK;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  MainUnit in 'MainUnit.pas' {MainForm: TElectronForm} {*.html},
  IMRendererUnit in 'tim_lib\IMRendererUnit.pas',
  IMRendererTypeUnit in 'tim_lib\IMRendererTypeUnit.pas',
  IMCloudCallbackUnit in 'tim_lib/IMCloudCallbackUnit.pas',
  IMCloudDefUnit in 'tim_lib/IMCloudDefUnit.pas',
  YDRequestorUnit in 'yd_lib/YDRequestorUnit.pas',
  YDRequestTypeUnit in 'yd_lib/YDRequestTypeUnit.pas',
  YDSMSTypeUnit in 'yd_lib/YDSMSTypeUnit.pas',
  YDLoginTypeUnit in 'yd_lib/YDLoginTypeUnit.pas',
  ConstUnit in 'const/ConstUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.