unit YDSMSTypeUnit;

interface

uses
  YDRequestTypeUnit;
  
type
  //短信类型：登录，邀请，变更手机号
  TYDSMSKind = (LOGIN, INVITATION, CHANGE_MOBILE);

  //盈单申请短信REST返回结构
  TYDSMSResponse = TYDCommonResponse;

const
  REQ_SERVER_SMS = 'mobile-server';
  REQ_URL_SMS = 'v1/sms/msg';

implementation

end.