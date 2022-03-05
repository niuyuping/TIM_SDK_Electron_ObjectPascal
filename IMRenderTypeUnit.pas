// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
// Render Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRenderTypeUnit;

interface

type
  //标准通知事件
  TNotifyEvent = procedure of object;
  TErrorEvent = procedure (AErrorCode: Integer; AErrorMessage: String) of object;

  //成功取得SDK版本号的事件
  TOnGetSDKVersion = procedure (AVersion: String) of object;
  //取SDK版本号出错的事件
  TOnGetSDKVersion_Error = TErrorEvent;

implementation

end.