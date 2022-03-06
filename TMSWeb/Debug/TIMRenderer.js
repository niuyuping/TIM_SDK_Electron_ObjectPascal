// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron
// Render JS Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

const timRenderer = require('im_electron_sdk/dist/renderer');

//渲染进程的全局变量
let timRendererInstance;

//如果渲染进程没有创建，就创建它
const jsTIMInitRenderer = () => {
  if (typeof timRendererInstance == 'undefined') {
    timRendererInstance = new timRenderer();
    timRendererInstance.TIMInit();
    console.log("Init TIM SDK...OK")
  }
}

//取TIM服务器时间
function jsTIMGetServerTime() {
  jsTIMInitRenderer();
  timRendererInstance.TIMGetServerTime().then((result) => {
    console.log("Get TIM server time...OK", result.data)
  }).catch((err) => {
    console.log("Get TIM server time faild\n", err)
  })
}

//反初始化
const jsTIMUninit = () => {
  jsTIMInitRenderer();
  timRendererInstance.TIMUninit().then((result) => {
    console.log("Uninit TIM SDK...OK", result.data)
  }).catch((err) => {
    console.log("Uninit TIM SDK faild\n", err)
  })
}