program TryTIMSDK;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  MainUnit in 'MainUnit.pas' {Form1: TElectronForm} {*.html},
  IMRenderUnit in 'IMRenderUnit.pas',
  IMRenderTypeUnit in 'IMRenderTypeUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.AutoFormRoute := True;
  Application.MainFormOnTaskbar := True;
  if not Application.NeedsFormRouting then
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.