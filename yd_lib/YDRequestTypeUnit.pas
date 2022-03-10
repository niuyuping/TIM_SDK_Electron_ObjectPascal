// YingDan REST library
// Based on TMS Web Core Electron
// Requestor type unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit YDRequestTypeUnit;

interface

type
  //标准盈单REST返回结构
  TYDCommonResponse = record
    code: NativeInt;
    data: JSValue;
    message: String;
    status: String;
    timestamp: NativeUInt;
  end;
  
  //标准盈单REST事件
  TYDCommonEvent =  procedure (AResult: TYDCommonResponse; AUserData: JSValue) of object;

  //申请短信的事件
  TYDOnSMS = TYDCommonEvent;

  //盈单登录的事件
  TYDOnLogin = procedure (AResult: TYDCommonResponse; AUserData: JSValue) of object;
  
implementation

end.