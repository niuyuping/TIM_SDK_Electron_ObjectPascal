unit YDLoginTypeUnit;

interface

uses
  YDRequestTypeUnit;
  
type
  TYDLoginType = (SMS, WECHAT_OPEN, TELECOM_CARRIER);

  //盈单登录REST返回结构
  TYDLoginResponse = record
    avatarUrl: String;
    company: String;
    createdAt: String;
    department: String;
    email: String;
    id: String;
    lastLoginAt: String;
    mobile: String;
    name: String;
    quickMark: String;
    token: String;
    updatedAt: String;
    userSig: string;
  end;

const

implementation

end.