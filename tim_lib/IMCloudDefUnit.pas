// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Cloud Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMCloudDefUnit;

interface

type

const
  {
  ****************************************
  网络连接事件类型 TIMNetworkStatus
  *****************************************
  }

  kTIMConnected = 0;       // 已连接
  kTIMDisconnected = 1;    // 失去连接
  kTIMConnecting = 2;      // 正在连接
  kTIMConnectFailed = 3;   // 连接失败

  {
  ****************************************
  登陆状态 TIMLoginStatus
  *****************************************
  }

  kTIMLoginStatus_Logined = 1;     // 已登录
  kTIMLoginStatus_Logining = 2;    // 登录中
  kTIMLoginStatus_UnLogined = 3;   // 未登录
  kTIMLoginStatus_Logouting = 4;   // 登出中

  {
  ****************************************
  调用接口的返回值 TIMResult

  note: 若接口参数中有回调，只有当接口返回TIM_SUCC时，回调才会被调用
  *****************************************
  }

  TIM_SUCC = 0;          // 接口调用成功
  TIM_ERR_SDKUNINIT = -1; // 接口调用失败，ImSDK未初始化
  TIM_ERR_NOTLOGIN = -2; // 接口调用失败，用户未登录
  TIM_ERR_JSON = -3;     // 接口调用失败，错误的Json格式或Json Key
  TIM_ERR_PARAM = -4;    // 接口调用失败，参数错误
  TIM_ERR_CONV = -5;     // 接口调用失败，无效的会话
  TIM_ERR_GROUP = -6;    // 接口调用失败，无效的群组


implementation

end.