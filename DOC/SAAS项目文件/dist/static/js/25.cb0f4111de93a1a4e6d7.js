webpackJsonp([25],{VSO0:function(t,e,s){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var i={render:function(){var t=this,e=t.$createElement,s=t._self._c||e;return s("section",{staticClass:"inner-page customer"},[s("header",{staticClass:"app-header"},[s("van-nav-bar",{attrs:{"left-text":"返回","left-arrow":"",title:"客户列表"},on:{"click-left":t.onClickLeft}})],1),t._v(" "),s("div",{staticClass:"inner-con"},[t._m(0),t._v(" "),s("div",{staticClass:"inner-item"},[s("ul",t._l(t.listArr,function(e,i){return s("li",{directives:[{name:"tap",rawName:"v-tap",value:{fn:t.select,index:i},expression:"{fn:select, index: i}"}],key:i,staticClass:"inner-li"},[s("div",{staticClass:"inner-li-left"},[s("b",{staticClass:"circle",class:{active:e.active}})]),t._v(" "),s("div",{staticClass:"inner-li-right"},[s("h5",{staticClass:"customer-name"},[t._v(t._s(e.name))]),t._v(" "),s("p",{staticClass:"customer-id"},[t._v("车牌号："+t._s(e.carId))])])])}))]),t._v(" "),s("div",{staticClass:"inner-item customer-btn"},[s("button",{staticClass:"btn",class:t.curr<0?"btn-disabled":"btn-active",attrs:{type:"button"}},[t._v("确定")])])])])},staticRenderFns:[function(){var t=this.$createElement,e=this._self._c||t;return e("div",{staticClass:"customer-search"},[e("div",{staticClass:"inner-item"},[e("input",{staticClass:"ipt",attrs:{type:"text",placeholder:"输入客户名称搜索"}})])])}]},a=s("VU/8")({data:function(){return{listArr:[{name:"李霞",carId:"和C 344821",active:!1},{name:"王笑笑",carId:"粤C 344821",active:!1},{name:"陈李庄",carId:"沪C 344821",active:!1}],curr:-1,value:""}},methods:{onClickLeft:function(){this.$router.go(-1)},select:function(t){var e=t.index;this.curr>=0&&(this.listArr[this.curr].active=!1),this.curr=e,this.listArr[e].active=!0}}},i,!1,null,null,null);e.default=a.exports}});