// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Render Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMRendererTypeUnit;

interface

uses
  IMCloudDefUnit, JS;

type
  //标准结构的返回数据
  TCommonResponse = record
    code: NativeInt;
    desc: JSValue;
    json_param: JSValue;
    json_params: JSValue;
    user_data: JSValue;
  end;

  //标准通知事件
  TNotifyEvent = procedure of object;
  TErrorEvent = procedure (AError: JSValue) of object;
  TCommonEvent =  procedure (AResult: TCommonResponse) of object;

  //成功取得SDK版本号的事件
  TOnGetSDKVersion = procedure (AVersion: String) of object;
  //取SDK版本号出错的事件
  TOnGetSDKVersion_Error = TErrorEvent;

  //成功取得服务器时间的事件
  TOnGetServerTime = procedure (AServerTime: NativeUInt) of object;
  //取服务器时间出错的事件
  TOnGetServerTime_Error = TErrorEvent;

  //成功初始化事件
  TOnInit = procedure(AResult: NativeInt) of object;
  //初始化失败事件
  TOnInit_Error = TErrorEvent;

  //反成功初始化事件
  TOnUninit = procedure(AResult: NativeInt) of object;
  //反初始化失败事件
  TOnUninit_Error = TErrorEvent;
  
  //网络状态回调
  TNetworkStatusListenerCallback = procedure (AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue) of object;

  //被踢下线的回调
  TKickedOfflineCallback = procedure (AUserData: JSValue) of object;

  //Log回调
  TLogCallback = procedure(ALevel: NativeInt; ALog: String; AUserData: JSValue) of object;

  //Sig失效的回调
  TUserSigExpiredCallback = procedure (AUserData: JSValue) of object;

  //取登录状态的事件
  TOnGetLoginStatus = procedure (ALoginStatus: NativeInt) of object;
  TOnGetLoginStatus_Error = TErrorEvent;
  
  //取登录ID的事件
  TOnGetLoginUserID = TCommonEvent;
  TOnGetLoginUserID_Error = TErrorEvent;

  //登录事件
  TOnLogin = TCommonEvent;
  TOnLogin_Error = TErrorEvent;

  //登出事件
  TOnLogout = TCommonEvent;
  TOnLogout_Error = TErrorEvent;

  //获取用户资料事件
  TOnGetUserProfileList = TCommonEvent;
  TOnGetUserProfileList_Error = TErrorEvent;
implementation

end.