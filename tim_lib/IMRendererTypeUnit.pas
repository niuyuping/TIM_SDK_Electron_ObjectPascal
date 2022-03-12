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

  //会话事件回调
  TTIMConvEventCallback = procedure (AConvEvent: NativeInt; AJSONConvArray: JSValue; AUserData: JSValue) of object;

  //会话列表未读消息总数变更回调
  TTIMConvTotalUnreadMessageCountChangedCallback = procedure(ATotalUnreadCount: NativeInt; AUserData: JSValue) of object;

  //获取最近联系人的会话列表
  TTIMOnGetConvList = TTIMCommonEvent;
  TTIMOnGetConvList_Error = TTIMErrorEvent;

  //创建会话事件
  TTIMOnConvCreate = TTIMCommonEvent;
  TTIMOnConvCreate_Error = TTIMErrorEvent;

  //删除会话事件
  TTIMOnConvDelete = TTIMCommonEvent;
  TTIMOnConvDelete_Error = TTIMErrorEvent;
  
  //收到新消息回调
  TTIMRecvNewMsgCallback = procedure (AJSONMsgArray: JSValue; AUserData: JSValue) of object;

  //消息内元素文件上传进度回调
  TTIMMsgElemUploadProgressCallback = procedure (AJSONMsg: JSValue; AIndex, ACurSize, ALocalSize: NativeInt; AUserData: String) of object;

  //消息已读回调
  TTIMMsgReadedReceiptCallback = procedure (AJSONMsgReadedReceiptArray: JSValue; AUserData: JSValue) of object;

  //消息撤回回调
  TTIMMsgRevokeCallback = procedure (AJSONMsgLocatorArray: JSValue; AUserData: JSValue) of object;

  //发送消息回调
  TTIMSendMessageCallback = procedure (ACode: NativeInt; ADesc: JSValue; AJSONParam: JSValue; AUserData: JSValue) of object;

  //发送消息事件
  TTIMOnSendMessage = procedure(AMessageID: String) of object;
  TTIMOnSendMessage_Error = TTIMErrorEvent;

  //导入消息列表到指定会话事件
  TTIMOnImportMsgList = TTIMCommonEvent;
  TTIMOnImportMsgList_Error = TTIMErrorEvent;

  //消息已读上报事件
  TTIMOnMsgReportReaded = TTIMCommonEvent;
  TTIMOnMsgReportReaded_Error = TTIMErrorEvent;

  //消息撤回事件
  TTIMOnMsgRevoke = TTIMCommonEvent;
  TTIMOnMsgRevoke_Error = TTIMErrorEvent;

  //获取指定会话消息列表事件
  TTIMOnGetMsgList = TTIMCommonEvent;
  TTIMOnGetMsgList_Error = TTIMErrorEvent;
implementation

end.