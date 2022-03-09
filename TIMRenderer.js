// TIM SDK for ObjectPascal 
// Based on TMS Web Core Electron and TIM Electron SDK
// Render JS Unit 
// v1.0.0.0
// Eric Niu From YingDan Tech 2022

const timRenderer = require('im_electron_sdk/dist/renderer');

//渲染进程的全局变量
let timRendererInstance;

//反初始化
const jsTIMUninit = () => {
  jsTIMInitRenderer();
  timRendererInstance.TIMUninit().then((result) => {
    console.log("Uninit TIM SDK...OK", result.data)
  }).catch((err) => {
    console.log("Uninit TIM SDK faild\n", err)
  })
}