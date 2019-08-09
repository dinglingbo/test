<template>
  <div id="myAppointment">
    <div class="myAppment">
      <tab
        active-color="#3B8CF7"
        default-color="#3f3f3f"
        bar-active-color="#3B8CF7"
        v-model="index"
      >
        <tab-item
          :selected="demo2 === key"
          v-for="(key,index) in tabKeys "
          @click="demo2 = key"
          :key="index"
        >
          <span class="myAppment-txt">{{list[index]}}</span>
        </tab-item>
      </tab>
      <swiper
        v-model="index"
        :show-dots="false"
        :height="height + 'px'"
        @on-index-change="changeIndex"
      >
        <swiper-item v-for="tabIndex in [0 , 1, 2 , 3]" :key="tabIndex" ref="scroller">
          <load-more
            class="scroller"
            :on-loadmore="[getAllBooking, getYetBooking,getPayedBooking,finishBooking][tabIndex]"
            :is-empty="![allList, yetList,payedList, finishList][tabIndex].length"
            ref="loadmore"
          >
            <div
              class="myAppment-mess-s"
              v-for="(listItem,innerIndex) in [allList, yetList,payedList, finishList][tabIndex]"
              :key="innerIndex"
            >
              <div class="mess-head-s">
              	<strong class="mess-head-ri-txt-n" >{{listItem.storeName}}</strong>
                <div class="mess-head-ri-s">
                  <span class="mess-head-ri-txt-r" v-if="listItem.orderStatus == 0">未支付</span>
                  <span class="mess-head-ri-txt-s" v-else>已支付</span>
                </div>
              </div>
              <div class="mess-body-s" @click="goOrderDetails(listItem)">
                <div class="mess-body-mess-s">
                  <span class="mess-txt-s"style="line-height: 0.6rem;">下单时间：{{splitData(listItem.orderTime)}}</span>
                </div>
                <div class="mess-body-mess-s">
                  <span class="mess-txt-s"style="line-height: 0.6rem;">车牌号码：{{listItem.carNo}}</span>
                </div>
                <div class="mess-body-time-s">
                	<!--<div style="width: 0.85rem;" >车型：</div>
                	<div style="width: 6.35rem;line-height: 0.3rem;" >{{listItem.carModelName}}</div>-->
                  <span class="mess-txt-s"style="line-height: 0.6rem;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">车型：{{listItem.carModelName}}</span>
                </div>
                <div class="mess-body-order-s">
                  <span class="mess-txt-s" style="line-height: 0.6rem;width: 5.7rem;">订单：{{listItem.orderCode}}</span>
                  <strong>￥{{listItem.orderAmount}}</strong>
                </div>
              </div>
              <div class="mess-end-s" v-if="listItem.orderStatus == 0">
                <span style="width: 5rem;padding-left: 0.32rem;" >支付剩余时间：{{listItem.lockTimeOut}}</span>
                 <div class="mess-end-but1" @click="payOrder(listItem)">
                  <span class="but">确认付款</span>
                </div>
                <div class="mess-end-but2" @click="remove(listItem, [allList, yetList,payedList, finishList][tabIndex], innerIndex)">
                  <span class="but">取消</span>
                </div>
              </div>
            </div>
          </load-more>
        </swiper-item>
      </swiper>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import api from '../Api/api.js';
import LoadMore from '../component/loadmore.vue';
import wx from 'weixin-js-sdk';
import { XButton, Tab, TabItem, Swiper, SwiperItem,AlertModule } from 'vux';
export default {
  components: {
    LoadMore,
    XButton,
    Tab,
    TabItem,
    Swiper,
    SwiperItem,
    AlertModule
  },
  data() {
    const clientHeight =
      document.body.clientHeight ||
      document.documentElement.clientHeight ||
      window.innerHeight ||
      0;
    return {
    	apiUrl:"",
      height: clientHeight - 44,
      index: 0,
      url:"",
      list: ['全部', '待支付', '已支付', '已完成'],
      demo2: 'all',
      allList: [],
      yetList: [],
      payedList:[],
      finishList: [],
      tabKeys: ['all', 'yet','payed','finish'],
      tabValueMap: {},
      orderPayId:"",//当前点击的支付订单
    };
  },
  mounted() {
    this.$refs.loadmore.forEach(item => item.loadmore());
		const timer = setInterval(() =>{                    
   		// 定时器操作          
    this.onLoadTimeOut();
			}, 1000);
		//监听定时器，路由跳转关闭
	  this.$once('hook:beforeDestroy', () => {            
    	clearInterval(timer);                                    
		});    
  },
  //离开页面触发事件
	destroyed: function () {
		//解除订单锁定
		this.removeOrderLocking();
	},
  created() {
  		LoadMore.props.emptyText.default = "暂无此订单";
			this.apiUrl = api.getDms;
			this.url = api.getMyOrderUrl;
		//微信接口初始化
			this.initWechat();
			this.deleteOrderByTimeOut();
	},
  methods: {
  	//删除锁定超时订单
		deleteOrderByTimeOut(){
			axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{});
		},
		initWechat(){
  			var _this = this;
  			_this.$http.post(api.mapUserApi,{url:_this.url,token:localStorage.token}).then(function(resDatas) {
		      		var data = resDatas.data.map;
		      		_this.initWechatDatas(data.timestamp,data.nonceStr,data.qianm1);
		    	},
		    	function(resDatas) {
		      		console.log(resDatas);
		    	}
		    );
  	},
  	//解除订单锁定
		removeOrderLocking(){
			var _this=this;
			if(_this.orderPayId){
				_this.$http.post(api.updateUserOrderLockingApi,{orderId:_this.orderPayId,token:localStorage.token}).then(function(resDatas) {
			     	console.log(resDatas);
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
				);
			}
		},
  	//初始化微信接口授权
	  initWechatDatas(timestamp,nonceStr,qianm1){
	  	var _this = this;
			wx.config({
				beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
			    debug: false,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	        	appId: "wxd10b49dcb45e5591",   			// 必填，企业号的唯一标识，此处填写企业号corpid
	        	timestamp:timestamp, 		// 必填，生成签名的时间戳
	        	nonceStr: nonceStr, 	// 必填，生成签名的随机串
	        	signature: qianm1,		// 必填，签名
			    jsApiList: ['checkJsApi',
			                'chooseImage',
			                'previewImage',
			                 'uploadImage',
			                 'downloadImage',
			                  'getNetworkType',//网络状态接口
			                  'openLocation',//使用微信内置地图查看地理位置接口
			                  'getLocation', //获取地理位置接口
			                  'hideOptionMenu',//界面操作接口1
			                  'showOptionMenu',//界面操作接口2
			                  'closeWindow' ,  ////界面操作接口3
			                  'hideMenuItems',////界面操作接口4
			                  'showMenuItems',////界面操作接口5
			                  'hideAllNonBaseMenuItem',////界面操作接口6
			                  'showAllNonBaseMenuItem',
			                  'chooseWXPay'////界面操作接口7
			               ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
			});
			wx.error(function(res){
				// alert(res);config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
			});
				
		},
    // 切换
    changeIndex(index) {},
    onLoadTimeOut(){
    	const _this=this;
    	for(var t = 0 ;t < _this.allList.length;t++){
    	     if(_this.allList[t].orderStatus == 0){
    	     		let tempDate = _this.allList[t].lockTimeOut;
    	     		let lastTime = _this.changeLockTimeOut(tempDate);
    	     		_this.allList[t].lockTimeOut = lastTime ;
    	     		if(lastTime == '00:00'){
    	     			axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {
    	     				_this.reloadOrder();
    	     			}).catch(res =>{});
    	     		}
    	     }
    	}
    	for(var y = 0 ;y < _this.yetList.length;y++){
    	     if(_this.yetList[y].orderStatus == 0){
    	     		let tempDateY = _this.yetList[y].lockTimeOut;
    	     		_this.yetList[y].lockTimeOut = _this.changeLockTimeOut(tempDateY);
    	     }
    	}
    },
    //格式化时间减少1秒
    changeLockTimeOut(e){
    	let tempTimeList = e.split(":");
    	let secondAll = Number(tempTimeList[0])*60 + Number(tempTimeList[1])
    	let tempMin = Math.floor((secondAll - 1)/60);
    	let tempSecond = (secondAll - 1)%60;
    	if(tempMin < 10 && tempMin > 0) tempMin = '0'+tempMin;
    	if(tempMin == 0) tempMin = '00';
    	if(tempSecond < 10) tempSecond = '0'+tempSecond;
    	return tempMin + ":" + tempSecond;
    },
    //重新加载
    reloadOrder(){
    	const _this = this;
    		_this.yetList = [];
        _this.payedList = [];
        _this.allList = [];
        _this.finishList = [];
        _this.getYetBooking();
        _this.getAllBooking();
        _this.getPayedBooking();
        _this.finishBooking();
    },
    // 加载更多
    async onLoadmore(index,tabIndex) {
      const list = [this.allList, this.yetList,this.payedList,this.finishList][tabIndex];
      const pageSize = 3;
      const page = {
        begin: list.length,
        length: pageSize
      };
      const param = {
        //用户openId
        userOpid: localStorage.openId,
        //门店ID
        storeId: localStorage.storeId,
        //租户ID
        tenantId: localStorage.tenantId,
        // 状态  3：全部 ：0：待支付 1： 已支付  2：已完成
        orderStatus: index
      };
      const { data } = await axios.post(api.orderInfoByUserApi, {
        page,
        param,
        token: localStorage.token
      });
      if (data.result.errCode === 'E') {
        throw new Error("暂无数据");
      }
      list.push(...data.result.data);
      return data.result.page.isLast;
    },
    //全部
    getAllBooking() {
      return this.onLoadmore(3,0);
    },
    //待支付
    getYetBooking() {
      return this.onLoadmore(0,1);
    },
    //已支付
    getPayedBooking() {
      return this.onLoadmore(1,2);
    },
    //已完成
    finishBooking() {
      return this.onLoadmore(2,3);
    },
    splitData(obj){
							var a = [];
							var b = [];
							var c = [];
							if(obj !== null){
							 a = obj.split(" ");
							 b = a[0].split("-");
							 c = a[1].split(":")
							 return  b[0]+"-"+b[1] + "-" + b[2] + " " +c[0]+":"+c[1]
							} 
					
		},

    //确认付款
    payOrder(item) {
    	var  _this = this;
			//查询数据库现在时间和时间限制
		  _this.$http.post(api.queryOrderExpirationTimeApi,{ dictName: "ORDER_TIME_OUT",token:localStorage.token}).then(function(resDatas) {
			      var timeDate = resDatas.data.timeData[0];
			      var timeNumber = timeDate.dictContent;
			      var str = timeDate.newDate;
			      str = str.substring(0,str.length-2);
			      var nowDate = new Date( str.replace(/\-/g, '/') );
			      var nowDateLong = nowDate.getTime();
			      var str1 = item.orderTime;
			      str1 = str1.substring(0,str1.length-2);
			      var orderDate = new Date( str1.replace(/\-/g, '/') );
			      var orderDateLong = orderDate.getTime();
			      debugger;
			      var timeLong= orderDateLong + Number(timeNumber)*60000-15000;
			      nowDate.setTime(timeLong);
			      if( timeLong > nowDateLong){
			      	var timeStart = orderDate.getFullYear()+ _this.fromeDate(orderDate.getMonth()+1) + _this.fromeDate(orderDate.getDate()) + _this.fromeDate(orderDate.getHours()) + _this.fromeDate(orderDate.getMinutes()) + _this.fromeDate(orderDate.getSeconds());
			      	var timeExpire = nowDate.getFullYear() + _this.fromeDate(nowDate.getMonth()+1) + _this.fromeDate(nowDate.getDate()) + _this.fromeDate(nowDate.getHours()) + _this.fromeDate(nowDate.getMinutes()) + _this.fromeDate(nowDate.getSeconds());
			      	_this.wechatInfor(item.orderAmount,item.orderCode,timeStart,timeExpire,localStorage.openId,item.orderId);
			      	_this.orderPayId = item.orderId;
			      }else{
			      	AlertModule.show({
								title: '温馨提示',
	        			content: "此订单已经过了限定时间",
	        			onHide(){
	        				
				        }
		        	});
			      }
			      
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			);
    },
    //将单个日期的数字加零
		fromeDate(num){
			return Number(num) < 10 ? "0"+num : num;
		},
    //调用接口的参数
		wechatInfor(itemAmountPrice,ordersCode,timeStart,timeExpire,userOpenid,orderId){
  			var _this = this;
		    _this.$http.post(api.weChatPayApi,{ orderId:orderId,userOpenid:userOpenid,itemAmountPrice:itemAmountPrice,ordersCode:ordersCode,timeStart:timeStart,timeExpire:timeExpire,token:localStorage.token}).then(function(resDatas) {
			    	var userWechatOrder = resDatas.data.userWechatOrder;
			     	if(userWechatOrder){
			     		_this.pay(userWechatOrder,orderId);
			     	}else{
			     		AlertModule.show({
							title: '温馨提示',
		        			content: errMesg,
		        			onHide(){
		        				
					        }
			        	});
			     	}
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			);
		
		},
		//微信支付接口
		pay(config,orderId){
			var _this = this;
			wx.chooseWXPay({
				timestamp: config["timeStamp"], // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
				nonceStr: config["nonceStr"], 	// 支付签名随机串，不长于 32 位
				package: config["package"], 	// 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
				signType:config["signType"], 	// 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
				paySign: config["paySign"], 	// 支付签名
				success: function(res) {		// 支付成功后的回调函数
					AlertModule.show({
						title: '温馨提示',
	        			content: "支付成功",
	        			onHide(){
	        				//加上让订单页面刷新
	        				_this.reloadOrder();
				        }
		        	});
				},
				//如果你按照正常的jQuery逻辑，下面如果发送错误
				fail: function(res) {  //接口调用失败时执行的回调函数。
					
				},
				complete: function(res) {//接口调用完成时执行的回调函数，无论成功或失败都会执行。
					
				},
				cancel: function(res) {   //用户点击取消时的回调函数，仅部分有用户取消操作的api才会用到。
				    _this.$http.post(api.updateUserOrderLockingApi,{ orderId:orderId,token:localStorage.token}).then(function(resDatas) {
					     	console.log(resDatas);
					    },
					    function(resDatas) {
					      console.log(resDatas);
					    }
					);
				},
				trigger: function(res) {	//监听Menu中的按钮点击时触发的方法，该方法仅支持Menu中的相关接口。
				
				}
			});
			
		},
    //跳转订单详情页面
    goOrderDetails(item){
    	  this.$router.push({
        path: './myOrderMess',
        query: {
          orderId:item.orderId
        }
      });
    },
    // 取消订单
    remove(item, list, index) {
    	this.showPlugin(item, list, index);
    },
    
    showPlugin (item, list, index) {
      const _this=this;
      this.$vux.confirm.show({
        title: '系统提示',
        content: '确定取消订单？',
        onCancel () {
          console.log('plugin cancel');
        },
        onConfirm () {
           axios.post(api.deleteOrderByIdApi, {
		        rpsPrebook: {
		          ...item
		        },
		        token: localStorage.token
		      }).then(res=>{
	      		  if (res.data.result.code === 'S') {
			        _this.$vux.toast.text('取消成功');
			        _this.reloadOrder();
			      } else {
			        _this.$vux.toast.text('取消失败');
			      }
		      }).catch(res=>{
		      	// _this.$vux.toast.text('取消失败');
		      })
        }
      })
    }
  },beforeDestroy() {
	}
};
</script>
 <style >
 .mess-head-s{
 	margin-top: 0.2rem;
 	background: #FFFFFF;
 	border-bottom: #EDEDED 0.02rem solid; 
 }
 .mess-body-s{
 		display: flex;
 		flex-direction:column-reverse;
 		background: #FFFFFF;
 		height: 1.76rem;
 		padding-bottom: 0.15rem;
 	}
 .mess-head-ri-s{
 	height: 0.64rem;
 		display: flex;
    flex-direction: row-reverse;
    padding-right: 0.64rem;
 	}
 	.mess-body-order-s{
 		height: 0.48rem;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-body-mess-s{
 		height: 0.48rem;
 		font-size:0.26rem ;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-body-time-s{
 		height: 0.48rem;
 		font-size:0.26rem ;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-txt-s{
 		line-height: 0.48rem;
 		}
 	.mess-end-s{
 		border-top: 0.02rem solid #EDEDED;
 		background: #FFFFFF;
 		height: 0.9rem;
 		display: flex;
 		 flex-direction: row;
 		 padding-right: 0.3rem;
    align-items: center;
 	}
 	.mess-end-but1{
 		padding-left: 0.2rem;
    padding-right: 0.2rem;
    width: 1.4rem;
 		border:0.02rem solid #878786;
 		/*width: 1.2rem;*/
 		height: 0.54rem;
 		/*align-items: center;*/
 		text-align: center;
 		border-radius:0.1rem ;
 		margin-right: 0.3rem;
 	}
 	.mess-end-but2{
 		height: 0.54rem;
 		/*width: 1.2rem;*/
 		/*align-items: center;*/
		border:0.02rem solid #878786;
 		text-align: center;
 		border-radius:0.1rem ;
 		padding-left: 0.2rem;
    padding-right: 0.2rem;
    width: 0.8rem;
 	}
 	
 	.but{
 		font-size: .26rem;
 		color:#878786 ;
 			line-height: 0.54rem;
 	}
 	.scroller {
  height: 100%;
  overflow: auto;
}
.mess-head-ri-txt-s{
	line-height: 0.64rem;
	color: #3087F7;
} 
.mess-head-ri-txt-r{
	line-height: 0.64rem;
	color: red;
}
.mess-head-ri-txt-n{
	line-height: 0.64rem;
	color: black;
	float: left;
	margin-left: 0.32rem;
	font-family:微软雅黑;
}
.myAppment-txt{
	}

</style>
