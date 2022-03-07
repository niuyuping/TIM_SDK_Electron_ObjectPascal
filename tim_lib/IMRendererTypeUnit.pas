// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
// Render Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRendererTypeUnit;

interface

type
  //标准通知事件
  TNotifyEvent = procedure of object;
  TErrorEvent = procedure (AErrorCode: Integer; AErrorMessage: String) of object;

  //成功取得SDK版本号的事件
  TOnGetSDKVersion = procedure (AVersion: String) of object;
  //取SDK版本号出错的事件
  TOnGetSDKVersion_Error = TErrorEvent;

  //成功取得服务器时间的事件
  TOnGetServerTime = procedure (AServerTime: NativeUInt) of object;
  //取服务器时间出错的事件
  TOnGetServerTime_Error = TErrorEvent;

  //成功初始化事件
  TOnInit = TNotifyEvent;
  //初始化失败事件
  TOnInit_Error = TErrorEvent;

  //反成功初始化事件
  TOnUninit = TNotifyEvent;
  //反初始化失败事件
  TOnUninit_Error = TErrorEvent;
  
implementation

end.