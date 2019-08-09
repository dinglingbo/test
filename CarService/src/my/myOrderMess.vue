<template>
	<div id="myOrderMess">
			
		<!--下单店名-->
		<div class="mess-title">
			<div class="title-head">
				<span class="title-head-txt"  >{{userOrderData.storeName}}</span >
			</div>	
			<div class="title-body">
				<div  class="title-body-show">
					<img  class="title-body-img" src="../assets/img/icon_yuyue1.png" />
				</div>	
				<div class="title-body-time">
					<span class="title-body-txt">下单时间:{{userOrderData.orderTime}}</span >
				</div>	
			</div>
			<div class="title-end">
				<div  class="title-end-show">
					<img  class="title-end-img" src="../assets/img/icon_dizhi.png" />
				</div>	
				<div class="title-end-time">
					<span class="title-end-txt">{{userOrderData.storeStreetAddress}}</span >
				</div>
			</div>
		</div>	
		<!--下单项目-->
		<div class="mess-item-title">
			<div v-for="(orderItem,index) in orderItemArray" :key="index" >
				<div class="mess-body">
					<span  class="mess-body-txt">{{orderItem.itemTypeName}}</span >
				</div>
				<div class="mess-item" v-for="(itemData,indexs) in orderItem.itemArray" :key="indexs">
					<div class="mess-item-show">
						<div>
							<img class="mess-item-img" :src=" itemData.serviceItemPicture " />
						</div>	
					</div>	
					<div class="mess-item-money">
						<div class="mess-item-name">
							<span class="mess-item-name-txt" >{{itemData.serviceItemName}}</span >
							<span class="mess-item-money-txt">￥{{itemData.itemPrice}}</span>	
						</div>
						<div class="mess-item-nbu">
							<span >X{{itemData.itemQty}}</span >
						</div>
					</div>	
				</div>
			</div>
			
			<div class="mess-body-end">
				<span  class="mess-body-end-text">订单金额</span >
				<span  class="mess-body-end-money">￥{{userOrderData.orderAmount}}</span >
			</div>
		</div>
		<!--订单信息-->
		<div class="orderMess">
			<div class="orderMess-title">
				<span  class="orderMess-title-txt">订单信息</span >
			</div>
			<div class="orderMess-body">
				<div class="body-order-mess">
					<span class="body-order-txt" >订单号：{{userOrderData.orderCode}}</span >
				</div>	
				<div  class="body-order-mess">
					<span  class="body-order-txt" >订单状态：{{ setOrderState(userOrderData.orderStatus) }}</span >
				</div>	
				<div  class="body-order-mess">
					<span   class="body-order-txt">联系人：{{userOrderData.userNickname}}</span >
				</div>	
				<div  class="body-order-mess">
					<span   class="body-order-txt">手机：{{userOrderData.userPhone}}</span >
				</div>	
				<div  class="body-order-mess">
					<span   class="body-order-txt">车牌号码：{{userOrderData.carNo}}</span >
				</div>	
				<div  class="body-order-mess" style="display: flex;">
					<div style="width: 0.9rem;padding-left: 0.4rem;">车型：</div>
					<div style="width: 6rem;" >{{userOrderData.carModelName}}</div >
				</div>	
			</div>		
		</div>
		<!--按钮-->
		<div class="end" :hidden="memonyBool" >
			<div class="end-cancel">
				<span class="end-cancel-txt" @click="remove(userOrderData)">取消支付</span >
			</div>
			<div class="end-payment">
				<span class="end-payment-txt" @click="orderPayment(userOrderData)" >立即支付</span >
			</div>	
		</div>	
			
	</div>	
</template>

<script>
import { Group, Cell,AlertModule } from "vux";
import api from '../Api/api.js';
import wx from 'weixin-js-sdk';
export default {
	components: {
    	Group,
    	Cell,
    	AlertModule
	},

  	data() {
	    //存放数据对象，以此在元素标签里使用
	    return {
	    	url:"",
	    	apiUrl:"",
	    	memonyBool:false,
	    	userOrderData:{},
	    	orderItemArray:[]
    	};
  	},
  	created: function() {
  		var _this = this;
		_this.apiUrl = api.getDms;
		var orderId = _this.$route.query.orderId;
		//查询订单
	    _this.$http.post(api.queryUserOrdersListApi,{ orderId: orderId,token:localStorage.token}).then(function(resDatas) {
		      var userOrderData = resDatas.data.userOrderData[0];
		      userOrderData.orderTime = userOrderData.orderTime.substring(0,userOrderData.orderTime.length-2);
		      _this.userOrderData = userOrderData;
		      console.log("订单", userOrderData);
		      var userOrderDetailArray = userOrderData.userOrderDetailArray;
		      var itmeTypeList = resDatas.data.itmeTypeList;
		      var orderItemArray=[];
		      for(var a=0;a<itmeTypeList.length;a++){
		      	var data={itemTypeName:itmeTypeList[a].serviceTypeName};
		      	var array=[];
		      	for(var b=0;b<userOrderDetailArray.length;b++){
		      		if( userOrderDetailArray[b].serviceTypeName == itmeTypeList[a].serviceTypeName ){
		      			array.push(userOrderDetailArray[b]);
		      		}
		      		if( b == userOrderDetailArray.length-1 ){
		      			data.itemArray=array;
		      			orderItemArray.push(data);
		      		}
		      	}
		      	if( a == itmeTypeList.length-1 ){
		      		_this.orderItemArray = orderItemArray;
		      		console.log(orderItemArray);
		      	}
		      }
		      if(userOrderData.orderStatus != 0){//如果不是未支付的订单
		      	_this.memonyBool = true;
		      	document.getElementById("myOrderMess").style.bottom="0";
		      }
		      
		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		);
		_this.url = api.getOrderInfoUrl+orderId;
		console.log(_this.url);
		//微信接口初始化
		_this.initWechat();
  	},
  	//离开页面触发事件
	destroyed: function () {
		//解除订单锁定
		this.removeOrderLocking();
	},
  	methods: {
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
  		setOrderState(orderStatus){
  			switch (orderStatus){
  				case "0":
  					return "未支付";
  				case "1":
  					return "已支付";
  				case "2":
  					return "已完成";
  			}
  		},
  		//订单支付
  		orderPayment(orderData){
  			console.log(orderData);
  			var _this = this;
			//查询数据库现在时间和时间限制
		    _this.$http.post(api.queryOrderExpirationTimeApi,{ dictName: "ORDER_TIME_OUT",token:localStorage.token}).then(function(resDatas) {
			      var timeDate = resDatas.data.timeData[0];
			      var timeNumber = timeDate.dictContent;
			      var str=timeDate.newDate;
			      str = str.substring(0,str.length-2);
			      var nowDate = new Date( str.replace(/\-/g, '/') );
			      var nowDateLong = nowDate.getTime();
			      var str2=orderData.orderTime;
			      var orderDate = new Date( str2.replace(/\-/g, '/') );
			      var orderDateLong = orderDate.getTime();
			      var timeLong= orderDateLong + Number(timeNumber)*60000-10000;
			      nowDate.setTime(timeLong);
			      if( timeLong > nowDateLong){
			      	var timeStart = orderDate.getFullYear()+ _this.fromeDate(orderDate.getMonth()+1) + _this.fromeDate(orderDate.getDate()) + _this.fromeDate(orderDate.getHours()) + _this.fromeDate(orderDate.getMinutes()) + _this.fromeDate(orderDate.getSeconds());
			      	var timeExpire = nowDate.getFullYear() + _this.fromeDate(nowDate.getMonth()+1) + _this.fromeDate(nowDate.getDate()) + _this.fromeDate(nowDate.getHours()) + _this.fromeDate(nowDate.getMinutes()) + _this.fromeDate(nowDate.getSeconds());
			      	_this.wechatInfor(orderData.orderAmount,orderData.orderCode,timeStart,timeExpire,localStorage.openId,orderData.orderId);
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
			     	console.log(userWechatOrder);
			     	if(!userWechatOrder.errMesg){
			     		_this.pay(userWechatOrder);
			     	}else{
			     		AlertModule.show({
							title: '温馨提示',
		        			content: userWechatOrder.errMesg,
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
  		pay(config){
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
	        				_this.$router.push({
								path:'/myOrder',
								query: {}
							});
				        }
		        	});
				},
				//如果你按照正常的jQuery逻辑，下面如果发送错误
				fail: function(res) {  //接口调用失败时执行的回调函数。
					
				},
				complete: function(res) {//接口调用完成时执行的回调函数，无论成功或失败都会执行。
					
				},
				cancel: function(res) {   //用户点击取消时的回调函数，仅部分有用户取消操作的api才会用到。
				   _this.removeOrderLocking();
				},
				trigger: function(res) {	//监听Menu中的按钮点击时触发的方法，该方法仅支持Menu中的相关接口。
				
				}
			});
  			
  		},
  		//解除订单锁定
  		removeOrderLocking(){
  			var _this=this;
  			_this.$http.post(api.updateUserOrderLockingApi,{orderId:_this.userOrderData.orderId,token:localStorage.token}).then(function(resDatas) {
			     	console.log(resDatas);
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			);
  		},
  		// 取消订单
	    remove(item) {
	    	this.showPlugin(item);
	    },
	    showPlugin (item) {
	      const _this=this;
	      this.$vux.confirm.show({
	        title: '系统提示',
	        content: '确定取消订单？',
	        onCancel () {
	          console.log('plugin cancel');
	        },
	        onConfirm () {
	           _this.$http.post(api.deleteOrderByIdApi, {
			        rpsPrebook: {
			          ...item
			        },
			        token: localStorage.token
			      }).then(res=>{
		      		  if (res.data.result.code === 'S') {
				        _this.$vux.toast.text('取消成功');
				        _this.$router.go(-1)
				      } else {
				        _this.$vux.toast.text('取消失败');
				      }
			      }).catch(res=>{
			      	// _this.$vux.toast.text('取消失败');
			      })
	        }
	      })
	    }
  	}
}
</script>

<style scoped="scoped">
	.mess-body-end{
		float: left;
	    height: 0.8rem;
	    width: 100%;
	    border-top: 1px solid #CACACA;
	    text-align: right;
	}
	.mess-body-end-text{
	    letter-spacing: 1px;
	    padding-right: 0.15rem;
	    line-height: 0.8rem;
	    width: 100%;
	    color: #5e5e5e;
	}
	.mess-body-end-money{
		padding-right: 0.4rem;
    	color: red;
	}
	#myOrderMess{
		width: 100%;
	    float: left;
	    overflow-x: hidden;
	    position: absolute;
	    bottom: 0.9rem;
	    top: 0;
	}
	.mess-title{
		background-color: #FFFFFF;
		height: 1.8rem;
		float:left;
		width: 100%;
	}
	.title-head{
		float:left;
		width: 100%;
		height: 0.7rem;
	}
	.title-head-txt{
		float:left;
		letter-spacing: 1px;
		width: 100%;
		line-height: 0.7rem;
		padding-left: 0.4rem;
		font-size:0.34rem;
	}
	.title-body{
		float:left;
		width: 100%;
		height:0.5rem;
	}
	.title-body-show{
		float:left;
		width: 10%;
		height:0.4rem;
	}
	.title-body-img{
		margin-top: 2px;
		width: 0.32rem;
		height: 0.32rem;
		padding-left:0.4rem;
	}
	.title-body-time{
		float:left;
		width: 90%;
		
	}
	.title-body-txt{
		float:left;
		line-height:0.45rem;
		padding-left:0.1rem;
		font-size:0.25rem;
		letter-spacing: 1px;
		color: #5e5e5e;
	}
	.title-end{
		float:left;
		width: 100%;
		height:0.5rem;
	}
	.title-end-show{
		float:left;
		width: 10%;
		height:0.5rem;
	}
	.title-end-img{
		margin-top: 2px;
		margin-right: 3px;
		width:0.35rem;
		height:0.35rem;
		padding-left:0.4rem;
	}
	.title-end-time{
		float:left;
		width: 90%;
		
	}
	.title-end-txt{
		float:left;
		line-height:0.45rem;
		padding-left:0.1rem;
		font-size:0.25rem;
		letter-spacing: 1px;
		color: #5e5e5e;
	}
	/*下单项目title*/
	.mess-item-title{
		/*height: 100%;*/
		float: left;
		width: 100%;
		margin-top:0.2rem;
		background: #FFFFFF;
	}
	.mess-body{
		float: left;
		height:0.6rem;
		width: 100%;
		border-bottom:1px solid #CACACA;
	}
	.mess-body-txt{
		font-size:0.3rem;
		letter-spacing: 1px;
		padding-left:0.4rem;
		line-height:0.6rem;
		width: 100%;
		color: #5e5e5e;
	}
	/*下单项目*/
	.mess-item{
		float: left;
		width: 100%;
		border-bottom: 1px solid #f1f1f1;
	}
	.mess-item-show{
		float: left;
		height:1.8rem;
		width: 30%;
		text-align: center;
	}	
	.mess-item-img{
		margin-top:0.2rem;
		width:1.4rem;
		height:1.4rem;
	}
	.mess-item-money{
		float: left;
		height:1.8rem;
		width: 70%;
	}
	.mess-item-name{
		 padding-top: 0.2rem;
		height:0.4rem;
		font-size:0.26rem;
	}
	.mess-item-name-txt{
		line-height:0.4rem;
		letter-spacing: 2px;
		float: left;
		color: #5e5e5e;
	}
	.mess-item-nbu{
		height:0.4rem;
		font-size:0.26rem;
		 padding-top:0.6rem;
		 color: #5e5e5e;
	}
	.mess-item-money-txt{
		line-height:0.4rem;
		float: right;
		padding-right:0.3rem;
		color: #5e5e5e;
	}
	/*订单信息*/
	.orderMess{
		/*height: 100%;*/
		float: left;
		width: 100%;
		margin-top:0.2rem;
		margin-bottom: 0.3rem;
		background: #FFFFFF;
	}
	.orderMess-title{
		float: left;
		height:0.8rem;
		width: 100%;
		border-bottom:1px solid #CACACA;
	}
	.orderMess-title-txt{
		font-size:0.34rem;
		letter-spacing: 1px;
		padding-left:0.4rem;
		line-height:0.8rem;
		width: 100%;
		color: #5e5e5e;
	}
	.orderMess-body{
		float: left;
		padding-bottom: 0.3rem;
		width: 100%;
	}
	.body-order-mess{
		/*height:0.45rem;*/
		float: left;
		width: 100%;
	}
	.body-order-txt{
		padding-left:0.4rem;
		font-size:0.25rem;
		line-height:0.44rem;
		color: #353535;
		letter-spacing: 2px;
	}
	/*支付*/
	.end{
		position: fixed;
    	bottom: 0px;
		margin-top:0.2rem;
		float: left;
		width: 100%;
	}
	.end-cancel{
		float: left;
	    width: 50%;
	    height: 0.9rem;
	    text-align: center;
	    background-color: #ffffff;
	}
	.end-payment{
		float: left;
	    width: 50%;
	    height: 0.9rem;
	    background-color: #3087F7;
	    text-align: center;
	}
	.end-cancel-txt{
		line-height: 0.9rem;
	    font-size: 0.32rem;
	    letter-spacing: 1px;
	}
	.end-payment-txt{
		line-height: 0.9rem;
	    color: #F4F3F8;
	    font-size: 0.32rem;
	    letter-spacing: 1px;
	}
</style>