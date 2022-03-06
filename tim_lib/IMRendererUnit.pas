// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
// Render Class Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRendererUnit;

interface

uses
  IMRendererTypeUnit;

type
  //TIM Render
  TTIMRenderer = class (TObject)
  private
    FOnGetSDKVersion: TOnGetSDKVersion;
    FOnGetSDKVersionError: TOnGetSDKVersion_Error;
    //Event in JS asm block
    procedure jsOnGetSDKVersion(AVersion: String);
    procedure jsOnGetSDKVersion_Error(AErrorCode: Integer; AErrorMessage: String);
  public
    property OnGetSDKVersion: TOnGetSDKVersion read FOnGetSDKVersion write FOnGetSDKVersion;
    property OnGetSDKVersionError: TOnGetSDKVersion_Error read FOnGetSDKVersionError write FOnGetSDKVersionError;

    //取SDK版本号
    procedure GetSDKVersion;
  end;

implementation

//Event for success
procedure TTIMRenderer.jsOnGetSDKVersion(AVersion: String);
begin
  if Assigned(FOnGetSDKVersion) then
    FOnGetSDKVersion(AVersion);
end;

//Event for error
procedure TTIMRenderer.jsOnGetSDKVersion_Error(AErrorCode: Integer; AErrorMessage: String);
begin
  if Assigned(FOnGetSDKVersionError) then
    FOnGetSDKVersionError(AErrorCode, AErrorMessage);
end;

procedure TTIMRenderer.GetSDKVersion;
var
  tmpOnSucc, tmpOnError: Pointer; 
begin
  tmpOnSucc:=@jsOnGetSDKVersion;
  tmpOnError:=@jsOnGetSDKVersion_Error;

  asm //JavaScript
    jsTIMInitRenderer();
    
    timRendererInstance.TIMGetSDKVersion().then((result) => {
      console.log('SDK Version: ', result.data)
      tmpOnSucc(result.data)
    }).catch((err) => {
      console.log(err);
      tmpOnError(-1, 'Get SDK version error.')
    });   
  end;
end;

end.