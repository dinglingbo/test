<template>

</template>

<script>
	import axios from 'axios'
import api from '../Api/api.js';
import wx from 'weixin-js-sdk';
export default{
	components:{
		
	},
	data(){
		return{
			url:"http://tomato.harsonserver.com/app/chedaoWeixin/default/storeMap"  

		}
	},
	created(){
		var _this = this;
	    _this.$http.post(api.mapUserApi,{url:_this.url,token:localStorage.token}).then(function(resDatas) {
		      var data = resDatas.data.map;
		      _this.initData(data.timestamp,data.nonceStr,data.qianm1);
		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		);
	},
	methods: {
		initData(timestamp,nonceStr,qianm1){
			var storeLatitudeMap = localStorage.storeLatitudeMap;
			var storeLongitudeMap = localStorage.storeLongitudeMap;
			var storeNameMap = localStorage.storeNameMap;
			var storeStreetaddressMap = localStorage.storeStreetaddressMap;
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
				/*localStorage.removeItem("storeLatitudeMap");
				localStorage.removeItem("storeLongitudeMap");
				localStorage.removeItem("storeNameMap");
				localStorage.removeItem("storeStreetaddressMap");*/
			});
		}
			
	}
}
</script>

<style>
</style>