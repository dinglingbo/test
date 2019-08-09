import axios from 'axios'
//import { Dialog } from 'vant'
//import {getToken} from '@/utils'
//import { editCatch } from '@/http/kaidan'
// 响应时间
axios.defaults.timeout = 1000 * 60 * 2
// 配置cookie
// axios.defaults.withCredentials = true
// 静态资源

// 配置接口地址
//axios.defaults.baseURL = 'http://14.23.35.20:6288/'
// process.prodEnv.API_ROOT

// POST传参序列化(添加请求拦截器)
axios.interceptors.request.use(
  config => {
  let token = localStorage.token;
    if (token) {
      config.headers['Content-Type'] = 'application/json';
    }
    return config
  },
  err => {
//  Dialog.alert({
//    message: '弹窗内容'
//  }).then(() => {
//  });
    return Promise.reject(err)
  }
)
// 返回状态判断(添加响应拦截器)
axios.interceptors.response.use(res => {
if (res.status === 200) {
//	  if(res.data.errMsg=="登录超时"){
//	  	let weixinPrame = []
//	  	for(let k in localStorage) {
//	  		if (k=='loginUser' || k == 'loginPass' || k == 'token') {
//	  			//保留
//	  		} else {
//	  			localStorage.removeItem(k);
//	  		}
//	    }
//			// editCatch('set', {key: 'USER_QUANXIAN_DATA', data: []})
//			if (localStorage.loginUser && localStorage.loginPass && localStorage.token) {
//				login({
//						userId: localStorage.loginUser,
//						password: localStorage.loginPass
//				}).then(res => {
//						if (res.errCode == 'S') {
//							location.reload()
//							localStorage.setItem('compAddress', res.data.attributes.compAddress)
//							localStorage.setItem('compName', res.data.attributes.userOrgName)
//							localStorage.setItem('compTel', res.data.attributes.compTel)
//							localStorage.setItem('empId', res.data.attributes.empId)
//							localStorage.setItem('userName', res.data.attributes.currUserName)
//							localStorage.setItem('userId', res.data.attributes.currUserId)
//
//							localStorage.setItem('orgId', res.data.attributes.userOrgId)
//							localStorage.setItem('token', res.data.attributes.token)
//            localStorage.setItem('empId', res.data.attributes.empId)
//            localStorage.setItem('userName', res.data.userName)
//							localStorage.setItem('time', +new Date());
//							localStorage.setItem('cache', Math.ceil(Math.random() * 10))
//
//							localStorage.setItem('loginUser', localStorage.loginUser)
//							localStorage.setItem('loginPass', localStorage.loginPass)
//							let params ={
//								userName: res.data.userName,
//								userId: res.data.userId,
//								company: res.data.userOrgName,
//								realName: res.data.userRealName
//							}
//							this.$store.dispatch('setUserInfo', params)
//
//							this.$store.commit('SET_PRINT_INFO', res.data.attributes.billParams)
//							JSBridge.invoke('loginSuccess', {id: res.data.userId})
//						}
//
//					}).catch( err => {})
//			} else {
//				location.href = '/app/ceshi-HuaHeShiNe/#/lgeg/login'
//			}
//
//
//		return false
//	  }
    return res
//} else {
//  Dialog.alert({
//    message: res.statusText
//  }).then(() => {
//  })
  }
}, err => {
//  Dialog.alert({
//    message: '请求失败'
//  }).then(() => {
//  })
  return Promise.reject(err)
})
// 发送请求
export function post (url, params) {
  let token = localStorage.token;
  if (params) {
    if (token) params.token = token
  } else {
    params = {
      token: token
    }
  }
  return new Promise((resolve, reject) => {
    axios.post(url, params).then(res => {
      resolve(res.data)
    }, err => {
      reject(err.data)
    }).catch(err => {
      reject(err.data)
    })
  })
}
export function get (url, params) {
  return new Promise((resolve, reject) => {
    axios.get(url, {params: params})
      .then(res => {
        resolve(res.data)
      }).catch(err => {
        reject(err.data)
      })
  })
}

export function login(data) {
    let url = 'dms/com.hsapi.system.auth.LoginManager.userLogin.biz.ext'
    return post(url, data)
}
