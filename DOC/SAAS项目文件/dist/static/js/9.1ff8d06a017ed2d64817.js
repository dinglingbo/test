webpackJsonp([9],{EPXR:function(t,n){},Pd5I:function(t,n){},Vihc:function(t,n,a){"use strict";Object.defineProperty(n,"__esModule",{value:!0});var i={name:"changeUserAvatar",data:function(){return{isLink:!1,link:String}},mounted:function(){},methods:{onRead:function(t){this.isLink=!0,this.link=t.content,console.log(t)},submit:function(){}}},e={render:function(){var t=this,n=t.$createElement,a=t._self._c||n;return a("div",{staticClass:"change_user_avatar"},[a("van-nav-bar",{attrs:{title:"头像","left-arrow":"","left-text":"我的资料"},on:{"click-left":function(n){t.$router.go(-1)}}}),t._v(" "),a("div",{staticClass:"io_ps"},[t.isLink?a("img",{attrs:{src:t.link}}):a("span",[t._v("图片预览")])]),t._v(" "),a("div",{staticClass:"io_up"},[a("van-uploader",{attrs:{"after-read":t.onRead}},[a("p",[a("van-icon",{attrs:{name:"photograph"}})],1),t._v(" "),a("p",[t._v("点击上传")])])],1),t._v(" "),a("div",{staticClass:"button-warp"},[a("button",{class:t.isLink?"button-login":"",on:{click:t.submit}},[t._v("确认修改")])])],1)},staticRenderFns:[]};var s=a("VU/8")(i,e,!1,function(t){a("EPXR"),a("Pd5I")},"data-v-7bb5886c",null);n.default=s.exports}});