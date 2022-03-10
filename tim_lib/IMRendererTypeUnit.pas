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
  TTIMCommonResponse = record
    code: NativeInt;
    desc: JSValue;
    json_param: JSValue;
    json_params: JSValue;
    user_data: JSValue;
  end;

  //标准通知事件
  TTIMNotifyEvent = procedure of object;
  TTIMErrorEvent = procedure (AError: JSValue) of object;
  TTIMCommonEvent =  procedure (AResult: TTIMCommonResponse) of object;

  //成功取得SDK版本号的事件
  TTIMOnGetSDKVersion = procedure (AVersion: String) of object;
  //取SDK版本号出错的事件
  TTIMOnGetSDKVersion_Error = TTIMErrorEvent;

  //成功取得服务器时间的事件
  TTIMOnGetServerTime = procedure (AServerTime: NativeUInt) of object;
  //取服务器时间出错的事件
  TTIMOnGetServerTime_Error = TTIMErrorEvent;

  //成功初始化事件
  TTIMOnInit = procedure(AResult: NativeInt) of object;
  //初始化失败事件
  TTIMOnInit_Error = TTIMErrorEvent;

  //反成功初始化事件
  TTIMOnUninit = procedure(AResult: NativeInt) of object;
  //反初始化失败事件
  TTIMOnUninit_Error = TTIMErrorEvent;
  
  //网络状态回调
  TTIMNetworkStatusListenerCallback = procedure (AStatus: NativeInt; ACode: NativeInt; ADesc: String; AUserData: JSValue) of object;

  //被踢下线的回调
  TTIMKickedOfflineCallback = procedure (AUserData: JSValue) of object;

  //Log回调
  TTIMLogCallback = procedure(ALevel: NativeInt; ALog: String; AUserData: JSValue) of object;

  //Sig失效的回调
  TTIMUserSigExpiredCallback = procedure (AUserData: JSValue) of object;

  //取登录状态的事件
  TTIMOnGetLoginStatus = procedure (ALoginStatus: NativeInt) of object;
  TTIMOnGetLoginStatus_Error = TTIMErrorEvent;
  
  //取登录ID的事件
  TTIMOnGetLoginUserID = TTIMCommonEvent;
  TTIMOnGetLoginUserID_Error = TTIMErrorEvent;

  //登录事件
  TTIMOnLogin = TTIMCommonEvent;
  TTIMOnLogin_Error = TTIMErrorEvent;

  //登出事件
  TTIMOnLogout = TTIMCommonEvent;
  TTIMOnLogout_Error = TTIMErrorEvent;

  //获取用户资料事件
  TTIMOnGetUserProfileList = TTIMCommonEvent;
  TTIMOnGetUserProfileList_Error = TTIMErrorEvent;
implementation

end.