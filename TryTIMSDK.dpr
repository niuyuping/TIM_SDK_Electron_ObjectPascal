program TryTIMSDK;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  MainUnit in 'MainUnit.pas' {MainForm: TElectronForm} {*.html},
  IMRendererUnit in 'tim_lib\IMRendererUnit.pas',
  IMRendererTypeUnit in 'tim_lib\IMRendererTypeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.