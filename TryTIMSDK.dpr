program TryTIMSDK;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  MainUnit in 'MainUnit.pas' {Form1: TElectronForm} {*.html},
  IMRendererUnit in 'tim_lib\IMRendererUnit.pas',
  IMRendererTypeUnit in 'tim_lib\IMRendererTypeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.