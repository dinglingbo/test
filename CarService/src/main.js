// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import FastClick from 'fastclick'
import VueRouter from 'vue-router'
import App from './App'
import './assets/font/iconfont.css'
import './assets/modify_vux.less'
import axios from 'axios'
import { AjaxPlugin, ToastPlugin, LoadingPlugin } from 'vux'
import VueWechatTitle from 'vue-wechat-title';
Vue.use(VueWechatTitle)
import { ImagePicker,Radio } from '@nutui/nutui'
ImagePicker.install(Vue)
Radio.install(Vue)
import  { AlertPlugin } from 'vux'
Vue.use(AlertPlugin)
import  { ConfirmPlugin } from 'vux'
Vue.use(ConfirmPlugin)

//页面
import menu from './menu.vue'
import mapLocation from './firstIn/mapLocation.vue'
import home from './home/home.vue'
import loginHome from './home/loginHome.vue'
import registered from './registered/registered.vue'
import carType from './registered/carType.vue'
import carSeries from './registered/carSeries.vue'
import activityList from './registered/activityList.vue'
import makeAppointment from './home/makeAppointment.vue'
import makeAppointTime from './home/makeAppointTime.vue'
import autoServiceItem from './service/autoServiceItem.vue'
import store from './store/store.vue'
import storeDetails from './store/storeDetails'
import my from './my/my.vue'
import myCar from './my/myCar.vue'
import addCar from './my/addCar.vue'
import myAccount from './my/myAccount.vue'
import myAppointment from './my/myAppointment.vue'
import myCoupon from './my/myCoupon.vue'
import myMeal from './my/myMeal.vue'
import myOrder from './my/myOrder.vue'
import myOrderMess from './my/myOrderMess.vue'
import myInformation from './my/myInformation.vue'
import serviceMess from './service/serviceMess.vue'
import couponUse from './coupon/couponUse.vue'
import couponUseMain from './coupon/couponUseMain.vue'
import myAccountMess from './my/myAccountMess.vue'
import myComment from './my/myComment.vue'
import storeMap from './firstIn/storeMap.vue'
import menuLogin from './home/menuLogin.vue'
import shareCouponUseList from './coupon/shareCouponUseList.vue'
import shareCouponUseMain from './coupon/shareCouponUseMain.vue'
import useShareCouponLogin from './coupon/useShareCouponLogin.vue'
import slideshow from './home/slideshow'
import empRegister from './registered/empRegister'
//import service from './service/service.vue'
import settleMaitain from './settle/settleMaitain'

Vue.use(VueRouter)
Vue.use(AjaxPlugin)
Vue.use(ToastPlugin)
Vue.use(LoadingPlugin)
//兼容浏览器
require('es6-promise').polyfill()
const routes = [{
  path: '/',
  redirect: '/home',
  name: menu,
  component: menu,
  children: [
    {
      path: '/home',
      name: 'home',
      meta: {
        keepAlive: false, // 不需要缓存
        title: '首页'
      },
      component: home,
    }, {
      path: '/autoServiceItem',
      name: 'autoServiceItem',
      meta: {
        keepAlive: false, // 不需要缓存
        title: '服务'
      },
      component: autoServiceItem,
    }, {
      path: '/store',
      name: 'store',
      meta: {
        keepAlive: false, // 不需要缓存
        title: '门店'
      },
      component: store,
    }, {
      path: '/my',
      name: 'my',
      meta: {
        keepAlive: false, // 不需要缓存
        title: '个人中心'
      },
      component: my,
    },

  ]
},{
  path: '/empRegister',
  name: 'empRegister',
  meta: {
    keepAlive: false,  // 缓存
    title: '员工认证页面'
  },
  component: empRegister
},{
  path: '/activityList',
  name: 'activityList',
  meta: {
    keepAlive: false,  // 缓存
    title: '营销活动'
  },
  component: activityList
},{
  path: '/useShareCouponLogin',
  name: 'useShareCouponLogin',
  meta: {
    keepAlive: false,  // 缓存
    title: '领取优惠劵'
  },
  component: useShareCouponLogin
},{
  path: '/shareCouponUseMain',
  name: 'shareCouponUseMain',
  meta: {
    keepAlive: false,  // 缓存
    title: '领取优惠劵'
  },
  component: shareCouponUseMain
},{
  path: '/shareCouponUseList',
  name: 'shareCouponUseList',
  meta: {
    keepAlive: false,  // 缓存
    title: '优惠劵营销'
  },
  component: shareCouponUseList
},{
  path: '/loginHome',
  name: 'loginHome',
  meta: {
    keepAlive: true,  // 缓存
    title: '车道车服'
  },
  component: loginHome
},{
  path: '/menuLogin',
  name: 'menuLogin',
  meta: {
    keepAlive: false,  // 缓存 公众号菜单点击的进入的页面
    title: '车道车服'
  },
  component: menuLogin
},{
  path: '/default/storeMap',
  name: 'storeMap',
  meta: {
    keepAlive: false,  // 缓存
    title: '地图定位'
  },
  component: storeMap
}, {
  path: '/registered',
  name: 'registered',
  meta: {
    keepAlive: true,  // 缓存
    title: '手机验证'
  },
  component: registered
}, {
  path: '/couponUse',
  name: 'couponUse',
  meta: {
    keepAlive: true,  // 缓存
    title: '优惠劵领取'
  },
  component: couponUse
}, {
  path: '/couponUseMain',
  name: 'couponUseMain',
  meta: {
    keepAlive: true,  // 缓存
    title: '优惠劵领取'
  },
  component: couponUseMain
}, {
  path: '/mapLocation',
  name: 'mapLocation',
  meta: {
    keepAlive: true, // 不需要缓存
    title: '门店定位'
  },
  component: mapLocation
}, {
  path: '/carType',
  name: 'carType',
  meta: {
    keepAlive: false, // 不需要缓存
    title: '车系'
  },
  component: carType
}, {
  path: '/carSeries',
  name: 'carSeries',
  meta: {
    keepAlive: false, // 不需要缓存
    title: '车型'
  },
  component: carSeries
}, {
  path: '/makeAppointment',
  name: 'makeAppointment',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '预约'
  },
  component: makeAppointment
}, {
  path: '/makeAppointTime',
  name: 'makeAppointTime',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '预约时间'
  },
  component: makeAppointTime
}, {
  path: '/serviceMess',
  name: 'serviceMess',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '服务详情'
  },
  component: serviceMess
}, {
  path: '/storeDetails',
  name: 'storeDetails',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '门店详情'
  },
  component: storeDetails
}, {
  path: '/myCar',
  name: 'myCar',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的车库'
  },
  component: myCar
},
{
  path: '/myAccount',
  name: 'myAccount',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的车账本'
  },
  component: myAccount
},
{
  path: '/myAppointment',
  name: 'myAppointment',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的预约'
  },
  component: myAppointment
},
{
  path: '/myCoupon',
  name: 'myCoupon',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的优惠券'
  },
  component: myCoupon
},
{
  path: '/myMeal',
  name: 'myMeal',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的套餐'
  },
  component: myMeal
},
{
  path: '/myOrder',
  name: 'myOrder',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '我的订单'
  },
  component: myOrder
}, {
  path: '/myOrderMess',
  name: 'myOrderMess',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '订单详情'
  },
  component: myOrderMess
}, {
  path: '/addCar',
  name: 'addCar',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '添加爱车'
  },
  component: addCar
}, {
  path: '/myInformation',
  name: 'myInformation',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '修改个人信息'
  },
  component: myInformation
}, {
  path: '/myAccountMess',
  name: 'myAccountMess',
  meta: {
    keepAlive: false,// 不需要缓存
    title: '工单详情'
  },
  component: myAccountMess
}, {
  path: '/myComment',
  name: 'myComment',
  meta: {
    keepAlive: false,
    title: '填写评价'
  },
  component: myComment
},{
  path: '/slideshow',
  name: 'slideshow',
  meta: {
    keepAlive: false,
    title: '活动'
  },
  component: slideshow
},{
  path: '/settleMaitain',
  name: 'settleMaitain',
  meta: {
    keepAlive: false,
    title: '工单结算'
  },
  component: settleMaitain
}
]

const router = new VueRouter({
  mode: 'history',
  routes,
  	base:'/app/chedaoWeixin/'  //部署服务器   /app/chedaoWeixin/
  	// base:'/app/test-chedaoWeixin/'  //部署服务器   /app/chedaoWeixin/

})

FastClick.attach(document.body)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  router,
  render: h => h(App)
}).$mount('#app-box')
