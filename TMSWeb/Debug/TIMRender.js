const timRender = require('im_electron_sdk/dist/renderer');

//渲染进程的全局变量
let timRenderInstance;

//如果渲染进程没有创建，就创建它
const jsTIMInitRender = () => {
  if (typeof timRenderInstance == 'undefined') {
    timRenderInstance = new timRender();
    timRenderInstance.TIMInit();
    console.log("Init TIM SDK...OK")
  }
}

//取TIM服务器时间
function jsTIMGetServerTime() {
  jsTIMInitRender();
  timRenderInstance.TIMGetServerTime().then((result) => {
    console.log("Get TIM server time...OK", result.data)
  }).catch((err) => {
    console.log("Get TIM server time faild\n", err)
  })
}

//反初始化
const jsTIMUninit = () => {
  jsTIMInitRender();
  timRenderInstance.TIMUninit().then((result) => {
    console.log("Uninit TIM SDK...OK", result.data)
  }).catch((err) => {
    console.log("Uninit TIM SDK faild\n", err)
  })
}