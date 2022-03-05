// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
// Render Class Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRenderUnit;

interface

uses
  IMRenderTypeUnit;

type
  //TIM Render
  TTIMRender = class (TObject)
  private
    FOnGetSDKVersion: TOnGetSDKVersion;
    FOnGetSDKVersionError: TOnGetSDKVersion_Error;
  public
    property OnGetSDKVersion: TOnGetSDKVersion read FOnGetSDKVersion write FOnGetSDKVersion;
    property OnGetSDKVersionError: TOnGetSDKVersion_Error read FOnGetSDKVersionError write FOnGetSDKVersionError;

    //取SDK版本号
    procedure GetSDKVersion;
  end;

implementation

procedure TTIMRender.GetSDKVersion;

  //Event for success
  procedure jsOnGetSDKVersion(AVersion: String);
  begin
    if Assigned(FOnGetSDKVersion) then
      FOnGetSDKVersion(AVersion);
  end;
  //Event for error
  procedure jsOnGetSDKVersion_Error(AErrorCode: Integer; AErrorMessage: String);
  begin
    if Assigned(FOnGetSDKVersionError) then
      FOnGetSDKVersionError(AErrorCode, AErrorMessage);
  end;

begin
  asm //JavaScript
    jsTIMInitRender();
    
    timRenderInstance.TIMGetSDKVersion().then((result) => {
      jsOnGetSDKVersion(result.data)
    }).catch((err) => {
      jsOnGetSDKVersion_Error(-1, 'Get SDK version error.')
    });   
  end;
end;

end.