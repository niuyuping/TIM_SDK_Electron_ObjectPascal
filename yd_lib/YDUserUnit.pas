unit YDUserUnit;

interface

uses
  YDProfileUnit;

type
  TYDUser = class(TObject)
  private
  public
    Profile: TYDProfile;
    constructor Create; reintroduce;
    destructor Destroy; reintroduce;
  end;

implementation

uses
  sysutils;

constructor TYDUser.Create;
begin
  inherited;
  Profile:=TYDProfile.Create;
end;

destructor TYDUser.Destroy;
begin
  FreeAndNil(Profile);
  inherited;
end;

end.