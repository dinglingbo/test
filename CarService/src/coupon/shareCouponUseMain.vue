<template>
	<div class="couponMain" >
		
		<div  class="coverUp" :hidden="coverBool" @click="hidePanel">
			<img class="imgCover" src="../assets/img/weChateShareArrow.png" />
			<div class="share-contentDiv" id="child" >
				<span class="share-content-text" >
					点击右上角分享，朋友圈晒分享优惠劵
				</span>
			</div>
		</div>
		
		<!--优惠劵信息-->
		<div class="body-content">
			<div class="markImg-div" >
				<img class="mark-img" src="../assets/img/storeMarke.jpg" />
			</div>
			
			<div class="couponType-div" >
				<span class="couponType-text" >{{ shareUseCouponData.couponType == 1 ? '通用券' : '专属劵' }}</span>
			</div>
			<div class="couponTitle-div" >
				<span class="couponTitle-text" >{{shareUseCouponData.couponTitle}}</span>
			</div>
			<div class="coupon-bottom">
				<div class="useButton" style="margin-right: 0.4rem;" :hidden=" shareUseCouponData.wxbIsShareCouponUse == 0 || shareUseCouponData.wxbIsCouponUse == 0 " @click="addShareUseCoupon" >
 					<span class="useText" >
 						立即领取
 					</span>
 				</div>
 				<div class="useButton" @click="clickShareCouponUse" :style=" shareUseCouponData.wxbIsShareCouponUse == 0 || shareUseCouponData.wxbIsCouponUse == 0 ? 'background-color: #FF9700;margin-left: 1.1rem;' : 'background-color: #FF9700;' " >
 					<span class="useText" >
 						优惠分享
 					</span>
 				</div>
			</div>
			<div class="text-div" >
				<div class="text-div-left" >有效时间：</div>
				<div class="text-div-reight" >{{shareUseCouponData.couponBeginDate}} - {{shareUseCouponData.couponEndDate}}</div>
			</div>
			<div class="text-div" >
				<div class="text-div-left" >面值金额：</div>
				<div class="text-div-reight" >{{shareUseCouponData.couponDiscountsPrice}}元</div>
			</div>
			<div class="text-div" >
				<div class="text-div-left" >优惠说明：</div>
				<div class="text-div-reight" >{{shareUseCouponData.couponDescribe}}</div>
			</div>
			<div class="text-div">
				<div class="text-div-left" >优惠条件：</div>
				<div class="text-div-reight" >{{ shareUseCouponData.couponType == 1 ? '不限项目，任何项目都可优惠，满'+ shareUseCouponData.couponConditionPrice + '元可优惠' : '只限'+shareUseCouponData.serviceItemName+'项目使用，根据项目金额可优惠'+ shareUseCouponData.couponDiscountsPrice + '元' }}</div>
			</div>
			<div class="text-div" >
				<div class="text-div-left" >使用条件：</div>
				<div class="text-div-reight" >{{ shareUseCouponData.isCarUse == 0 ? '只限当前领取的车辆使用' : shareUseCouponData.isStoreUse == 0 ? '只限当前门店使用' : '只限此连锁门店使用' }}</div>
			</div>
		</div>
		
		<!--门店信息-->
		<div class="body-content-store">
			<div class="store-div" >
				<img class="marke-img" src="../assets/img/store1.png" />
				<div class="marke-text-store" >
					<span>{{shareUseCouponData.storeName}}</span>
				</div>
			</div>
			<div class="store-div">
				<img class="marke-img" src="../assets/img/callphone.png" />
				<div class="marke-text-store">
					<a :href=" 'tel:' + shareUseCouponData.storePhone " style="color: #000000;" class="home-sercive-call">{{shareUseCouponData.storePhone}}</a>
				</div>
			</div>
			<div class="store-div" >
				<img class="marke-img" src="../assets/img/addressMarke.png" />
				<div class="marke-text-store" @click="clickMapStore(shareUseCouponData.storeName,shareUseCouponData.storeStreetAddress,shareUseCouponData.storeLongitude,shareUseCouponData.storeLatitude)">
					<span>{{shareUseCouponData.storeStreetAddress}}</span>
				</div>
			</div>
		</div>
		
		
	</div> 
</template>

<script>
	import axios from 'axios'
	import api from '../Api/api.js';
	import wx from 'weixin-js-sdk';
	import {
	  Search,
	  Loading,
	  Flexbox,
	  AlertModule
	} from "vux";
	export default {
	  components: {
	    Search,
	    Loading,
	    Flexbox,
	    AlertModule
	  },
	  data() {
	    return {
	    	shareUseCouponData:{},
	    	storeName:"",
	    	coverBool:true,
			urlString:""//分享页面访问路径
	    };
	  },
	  created(){
	  	this.queryShareUseCoupon();
	  	this.urlString = api.shareCouponUseUrl + this.$route.query.couponCode+"&from=singlemessage";
	  	this.shareCouponUse();
	  },
	  methods: {
	  	queryShareUseCoupon(){
	  		var _this = this;
			axios.post(api.queryShareUseCouponMainApi,{couponCode:_this.$route.query.couponCode,userOpenId:localStorage.openId,token:localStorage.token}).then(response => {
				var shareUseCouponDataArray = response.data.shareUseCouponDataArray;
				if( !shareUseCouponDataArray || shareUseCouponDataArray.length == 0 ){
		  			_this.$vux.confirm.show({
				        title: '温馨提示',
				        content: '对不起，此优惠劵已过期',
				        onCancel () {
				            wx.closeWindow();
				        },
				        onConfirm () {
				        	wx.closeWindow();
				        }
				    })
		  		}else{
		  			for(var a=0;a<shareUseCouponDataArray.length;a++){
						var beginDate=new Date(shareUseCouponDataArray[a].couponBeginDate);
			        	shareUseCouponDataArray[a].couponBeginDate = beginDate.getFullYear()+"-"+_this.formDateString(beginDate.getMonth()+1)+"-"+_this.formDateString( beginDate.getDate() );
		        		var endDate=new Date(shareUseCouponDataArray[a].couponEndDate);
		        		shareUseCouponDataArray[a].couponEndDate = endDate.getFullYear()+"-"+_this.formDateString(endDate.getMonth()+1)+"-"+_this.formDateString( endDate.getDate() );
					}
					_this.shareUseCouponData = shareUseCouponDataArray[0];
		  		}
				console.log(_this.shareUseCouponData);
			});
	  	},
	  	formDateString(dateString){
	  		return (dateString+"").length == 1 ? "0"+dateString : dateString;
	  	},
	  	//显示分享指引
	  	clickShareCouponUse(){
	  		this.coverBool = false;
	  	},
	  	//隐藏分享指引
	  	hidePanel(event) {
		    let dom = document.getElementById("child");
		    if (dom) {
		        if (!dom.contains(event.target)) {
		            this.coverBool = true;
		        }
		    }
		},
	  	//添加用户领用的可分享优惠劵
	  	addShareUseCoupon(){
	  		var _this=this;
	  		_this.$vux.loading.show({text: 'Loading'});
			axios.post(api.queryShareUseCouponMainApi,{couponCode:_this.$route.query.couponCode,userOpenId:localStorage.openId,token:localStorage.token}).then(response => {
				var shareUseCouponData = response.data.shareUseCouponDataArray[0];
				if( Number( shareUseCouponData.couponNumber ) ==  Number( shareUseCouponData.distributeCouponUseNumber ) + Number( shareUseCouponData.shareCouponUseNumber) ){
					_this.$vux.confirm.show({
				        title: '温馨提示',
				        content: '没有剩余的优惠劵了，优惠劵已领完',
				        onCancel () {
				          
				        },
				        onConfirm () {
				        	
				        }
				   });
					_this.$vux.loading.hide();
				}else{
					_this.saveUserUseShareCoupon();//保存用户领的优惠劵
				}
			});
	  		
	  	},
	  	//保存用户领的优惠劵
	  	saveUserUseShareCoupon(){
	  		var _this=this;
	  		var data={
	  			storeId: _this.shareUseCouponData.storeId,
	  			userId: localStorage.userId,
	  			orgid: _this.shareUseCouponData.orgid,
	  			tenantId: _this.shareUseCouponData.tenantId,
	  			userOpenid: localStorage.openId,
	  			couponId:_this.shareUseCouponData.couponId,
	  			userCouponStatus:"0",
	  			shareUseCoupon:"1"
	  		};
	  		if(  _this.shareUseCouponData.isCarUse == 1 ){
	  			if(localStorage.carid && localStorage.carid != "undefined" && localStorage.carid != "null") data.carId = localStorage.carid;
	  			axios.post(api.addUserShareUseCouponApi,{shareUseCoupon:data,token:localStorage.token}).then(response => {
					var errCode = response.data.errCode;
					var errCode = response.data.errMsg;
					if(errCode == "E" ){
						_this.$vux.confirm.show({
					        title: '温馨提示',
					        content: '领取失败，请重新进入再领取',
					        onCancel () {
					          
					        },
					        onConfirm () {
					        	wx.closeWindow();
					        }
					    })					
					}
					_this.queryShareUseCoupon();//重新查询一遍
					console.log(response.data);
					_this.$vux.loading.hide();
				});
	  		}else if( _this.shareUseCouponData.isCarUse == 0 ){//只限车辆使用
	  			_this.$vux.loading.hide();
	  			if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前用户是否缓存里有客户id，判断是否绑定
			  		_this.$vux.confirm.show({
				        title: '温馨提示',
				        content: '你还没有认证，所以没有车辆信息，请先认证。',
				        onCancel () {
				          
				        },
				        onConfirm () {
				        	if( localStorage.storeId &&  localStorage.storeId != "undefined" &&  localStorage.storeId != "null" ){//判断当前用户虽然没有认证绑定，但已经有门店关系了
								_this.$router.push({
					  	  			path:"/registered"
								})
					  		}else{
					  			_this.$router.push({
							  	  	path:"/mapLocation?openid="+localStorage.openId
								})
					  		}
				        }
				      })
			  	}else{
			  		data.carId = localStorage.carid;
		  			axios.post(api.addUserShareUseCouponApi,{shareUseCoupon:data,token:localStorage.token}).then(response => {
						var errCode = response.data.errCode;
						var errCode = response.data.errMsg;
						if(errCode == "E" ){
							_this.$vux.confirm.show({
						        title: '温馨提示',
						        content: '领取失败，请重新进入再领取',
						        onCancel () {
						          
						        },
						        onConfirm () {
						        	wx.closeWindow();
						        }
						      })					
						}
						_this.queryShareUseCoupon();//重新查询一遍
						console.log(response.data);
						_this.$vux.loading.hide();
					});
			  	}
	  		}
	  	},
	  	//点击进入地图定位
		clickMapStore(storeName,storeStreetaddress,storeLongitude,storeLatitude){
			this.$vux.loading.show({text: 'Loading'});
			var _this = this;
			 _this.$http.post(api.mapUserApi,{url:_this.urlString,token:localStorage.token}).then(function(resDatas) {
			      var data = resDatas.data.map;
			      _this.initMapData(data.timestamp,data.nonceStr,data.qianm1,storeName,storeStreetaddress,storeLongitude,storeLatitude);
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			  );
		},
		initMapData(timestamp,nonceStr,qianm1,storeName,storeStreetaddress,storeLongitude,storeLatitude){
			this.$vux.loading.hide();
				var storeLatitudeMap = storeLatitude;
				var storeLongitudeMap = storeLongitude;
				var storeNameMap = storeName;
				var storeStreetaddressMap = storeStreetaddress;
				wx.config({
					beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
				    debug: false,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		        	appId: 'wxd10b49dcb45e5591',   			// 必填，企业号的唯一标识，此处填写企业号corpid
		        	timestamp:timestamp, 		// 必填，生成签名的时间戳
		        	nonceStr: nonceStr, 	// 必填，生成签名的随机串
		        	signature: qianm1,		// 必填，签名
				    jsApiList: ['openLocation','getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
				});
				wx.error(function(res){
					alert(JSON.stringify(res));
		    		// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
				});
				wx.ready(function(){
					wx.openLocation({
						latitude:storeLatitudeMap, // 纬度，浮点数，范围为90 ~ -90
						longitude:storeLongitudeMap, // 经度，浮点数，范围为180 ~ -180。
						name: storeNameMap, // 位置名
						address: storeStreetaddressMap, // 地址详情说明
						scale: 25, // 地图缩放级别,整形值,范围从1~28。默认为最大
						infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
					});
					
				});
		},
	  	//分享优惠劵
	  	shareCouponUse(){
	  		var _this = this;
			_this.$http.post(api.mapUserApi,{url:_this.urlString,token:localStorage.token}).then(function(resDatas) {
			    	var data = resDatas.data.map;
			      	_this.wechatShareCoupon(data.timestamp,data.nonceStr,data.qianm1);
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			);
	  	},
	  	wechatShareCoupon(timestamp,nonceStr,qianm1){
	  		var _this = this;
	  		var shareUseCouponData = _this.shareUseCouponData;
	  		var couponType = shareUseCouponData.couponType == 1 ? '通用券' : '专属劵';
	  		wx.config({
				beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
			    debug: false,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	        	appId: 'wxd10b49dcb45e5591',   			// 必填，企业号的唯一标识，此处填写企业号corpid
	        	timestamp:timestamp, 		// 必填，生成签名的时间戳
	        	nonceStr: nonceStr, 	// 必填，生成签名的随机串
	        	signature: qianm1,		// 必填，签名
			    jsApiList: ['updateAppMessageShareData','updateTimelineShareData','onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
			});
			wx.error(function(res){
				alert(JSON.stringify(res));
	    		// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
			});
			wx.ready(function(){ //需在用户可能点击分享按钮前就先调用
				
				//分享到朋友圈
				wx.onMenuShareTimeline({
			        title: couponType+":"+shareUseCouponData.couponTitle, // 分享标题
			        link: api.useUserShareCouponTransferPageUrl+"?couponCode="+shareUseCouponData.couponCode, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			        imgUrl: 'http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7', // 分享图标
			        success: function () {
			          // 用户点击了分享后执行的回调函数
			        }
			   	});
			   	
			   	//分享给朋友
				wx.onMenuShareAppMessage({
			        title: couponType+":"+shareUseCouponData.couponTitle, // 分享标题
			        desc: shareUseCouponData.couponDescribe, // 分享描述
			        link: api.useUserShareCouponTransferPageUrl+"?couponCode="+shareUseCouponData.couponCode, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			        imgUrl: 'http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7', // 分享图标
			        type:'link',
			        dataUrl:'',
			        success: function () {
			          // 用户点击了分享后执行的回调函数
			        }
			    });
			    
			    //分享到QQ
			    wx.onMenuShareQQ({
					title: couponType+":"+shareUseCouponData.couponTitle, // 分享标题
					desc: shareUseCouponData.couponDescribe, // 分享描述
					link: _this.urlString, // 分享链接
					imgUrl: 'http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7', // 分享图标
					success: function () {
					// 用户确认分享后执行的回调函数
					},
					cancel: function () {
					// 用户取消分享后执行的回调函数
					}
				});
				
				//分享到QQ空间
				wx.onMenuShareQZone({
					title: couponType+":"+shareUseCouponData.couponTitle, // 分享标题
					desc: shareUseCouponData.couponDescribe, // 分享描述
					link: _this.urlString, // 分享链接
					imgUrl: 'http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7', // 分享图标
					success: function () {
					// 用户确认分享后执行的回调函数
					},
					cancel: function () {
					// 用户取消分享后执行的回调函数
					}
				});
				
				
			});
	  	}
	  	
	  }
	}
</script>

<style>
	.share-contentDiv{
		position: absolute;
	    top: 3rem;
	    background: rgba(255, 151, 0, 0.88);
	    width: 3.6rem;
	    left: 1.6rem;
	    padding: 0.5rem;
	    border-radius: 25rem;
	}
	.share-content-text{
		color: #ffffff;
    	letter-spacing: 0.04rem;
    	font-size: 0.32rem;
	}
	.couponMain{
		background-color: #3087F7;
	    width: 100%;
	    height: 100%;
	    padding-top: 1rem;
	    padding-bottom: 0.5rem;
	}
	.body-content{
		background-color: #ffffff;
    	margin-left: 0.3rem;
    	margin-right: 0.3rem;
    	border-radius: 0.12rem;
    	padding-bottom: 0.4rem;
	}
	.body-content-store{
		background-color: #ffffff;
    	margin-left: 0.3rem;
    	margin-right: 0.3rem;
    	border-radius: 0.12rem;
    	padding-bottom: 0.4rem;
    	margin-top: 0.8rem;
	    padding-top: 0.15rem;
	    padding-left: 0.3rem;
	}
	.mark-img{
		width: 1.2rem;
    	border-radius: 1rem;
    	height: 1.2rem;
    	border: 0.02rem solid #ffffff;
    	position: relative;
    	bottom: 0.5rem;
	}
	.useButton{
		width: 2rem;
	    height: 0.55rem;
	    background-color: #3087F7;
	    border-radius: 0.1rem;
	    text-align: center;
	    margin-top: 0.16rem;
	    line-height: 0.55rem;
	}
	.useText{
		font-size: 0.26rem;
    	color: #ffffff;
    	letter-spacing: 0.02rem;
	}
	.markImg-div{
		text-align: center;
    	height: 0.8rem;
	}
	.couponType-div{
		text-align: center;
	}
	.couponType-text{
		font-size: 0.3rem;
	}
	.couponTitle-div{
		text-align: center;
	}
	.couponTitle-text{
		font-size: 0.44rem;
	}
	.coupon-bottom{
		display: flex;
	    padding-left: 18%;
	    padding-right: 18%;
	    padding-bottom: 0.2rem;
	}
	.text-div{
		display: flex;
		margin-left: 0.25rem;
	}
	.text-div-left{
		width: 1.8rem;
		padding-left: 0.25rem;
    	line-height: 0.6rem;
	}
	.text-div-reight{
		width: 6rem;
		padding-top: 0.08rem;
    	letter-spacing: 0.02rem;
		color: #AFAFAF;
	}
	.store-div{
		display: flex;
	    padding-top: 0.18rem;
	    padding-bottom: 0.2rem;
	    border-bottom: 0.02rem solid #F0F0F0;
	}
	.marke-img{
		width: 0.4rem;
    	height: 0.4rem;
	}
	.marke-text-store{
		line-height: 0.35rem;
	    margin-left: 0.2rem;
	    letter-spacing: 0.02rem;
	    margin-top: 0.03rem;
	}
	.coverUp{
		background-color: rgba(0, 0, 0, 0.48);
	    position: absolute;
	    width: 100%;
	    height: 100%;
	    bottom: 0;
	    top: 0;
	    z-index: 9;
	}
	.imgCover{
		position: fixed;
		width: 7rem;
	    height: 4rem;
	    margin-left: 2rem;
	    margin-top: 0.4rem;
	    transform: rotate(-23deg);
	}
</style>