# TIM_SDK_Electron_ObjectPascal

这是腾讯即时通信（TIM）云服务Electron SDK的ObjectPascal版本，基于TMS Web Core框架，对使用ObjectPascal进行跨平台桌面开发的开发者提供支持。

1、此SDK基于腾讯官方SDK，需要在工程文件夹中通过npm i im_electron_sdk安装官方版本的Electron SDK。

2、在TMS Web Core Electron项目的主JS文件main.js中增加主进程的初始化代码：

//Modules to TIM SDK
const electronStore = require('electron-store');
const timMain = require('im_electron_sdk/dist/main');
const { SDK_APP_ID } = require('./const/const');

//TIM local store
const timStore = new electronStore();
electronStore.initRenderer();

//TIM main instance
let timMainInstance;

//TIM SDK AppID
let catchedSDKAppID;
const settingConfig = timStore.get('setting-config');
const sdkAppID =  catchedSDKAppID = settingConfig?.sdkappId ?? SDK_APP_ID;

//Init TIM main 
const initTIMMain = (appid) => {
  timMainInstance = new timMain({
    sdkappid: appid
  });
}
console.log("Create main instance with ID %s: %d", [sdkAppID], [initTIMMain(sdkAppID)]);

3、将TIMRenderer.js复制到项目文件夹下。

4、在TMS Web Core Electron项目的主HTML文件{ProjectName}.html中增加对TIMRenderer.js的引用：

    <!-- TIM Render Java Script -->
    <script type="text/javascript" src="TIMRenderer.js"></script>

5、编辑运行TryTIMSDK查看演示。
