// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Cloud Type Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

unit IMCloudDefUnit;

interface

type

{
****************************************
网络连接事件类型
*****************************************
}

  TIMNetworkStatus = (    
    kTIMConnected,       // 已连接
    kTIMDisconnected,    // 失去连接
    kTIMConnecting,      // 正在连接
    kTIMConnectFailed   // 连接失败
  );

implementation

end.