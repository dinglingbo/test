<template>
  <div id="firstIn">
    <div class="search-bar">
      <div class="search-input-box">
        <input class="search-input" type="search" v-model="storeName" placeholder="搜索" @keyup.enter="search">
      </div>
      <div class="search-btn-box" @click="search">
        <img class="search-btn" src="../assets/img/icon_search.png">
      </div>
    </div>
    <!--定位-->
    <flexbox style="box-sizing:border-box;font-size: 0.3rem;padding-left:0.2rem ; color: #999999;">
      <span style="padding: 0.1rem 0;">当前城市</span>
    </flexbox>
    <div class="firstIn-posit">
      <flexbox class="firstIn-posit-flexbox">
        <div class="firstIn-posit-city">
          <span class="firstIn-posit-city-txt" id="A">{{city+" "+region}}</span>
        </div>
        <div style="width: 30%; float: left;height: 1rem; " @click="mapLocation">
          <div class="firstIn-posit-src">
            <img class="firstIn-posit-img" src="../assets/img/positioning.png">
          </div>
          <div class="firstIn-posit-set">
            <span class="firstIn-posit-set-txt">重新定位</span>
          </div>
        </div>
      </flexbox>
    </div>
    <!--全部门店-->
    <flexbox style="box-sizing:border-box;margin-top: 0.2rem;font-size: 0.3rem;padding-left:0.2rem ; color: #999999;" >
      <span style="padding: 0.1rem 0;">全部门店</span>
    </flexbox>
    <div>
      <group gutter="0" class="firstIn-store-group">
        <cell class="firstIn-store-cell" @click.native="clickChooseStore(storeNameData.storeId,storeNameData.tenantId,storeNameData.orgid)" v-for="(storeNameData, index) in storeNameDataArray" :key="index" :title="storeNameData.storeName" is-link >
        	{{ storeNameData.storeDistance >= 1000 ? (storeNameData.storeDistance/1000).toFixed(1) + 'km' : storeNameData.storeDistance == null ? 0 + 'm' : storeNameData.storeDistance + 'm' }}
        </cell>
        <!--<divider class="first-divider">到底了，别再拉了</divider>-->
      </group>
    </div>
    <loadmore :onLoadmore="queryMapStore" :isEmpty="queryMapStore.length==0"></loadmore>
  </div>
</template>
<script>
	import loadmore from "../component/loadmore.vue"
	import axios from 'axios'
import positioning from "../assets/img/positioning.png";
import leftArrow from "../assets/img/leftArrow.png";
import {TMap} from "../assets/js/TMap.js";
import api from '../Api/api.js';
import wx from 'weixin-js-sdk';


import {
  Divider,
  XInput,
  Group,
  Cell,
  XHeader,
  Actionsheet,
  TransferDom,
  ButtonTab,
  ButtonTabItem,
  Search,
  Loading,
  Flexbox,
  AlertModule
} from "vux";
export default {
  directives: {
    TransferDom
  },
  components: {
    XHeader,
    XInput,
    Actionsheet,
    ButtonTab,
    ButtonTabItem,
    Group,
    Cell,
    Divider,
    Search,
    Loading,
    Flexbox,
    AlertModule
  },
  data() {
    return {
      region:"",//地区
      city:"",//城市
      key:"F4IBZ-BD6WR-EELWH-WJJEQ-DBHJK-56F4F",//腾讯地图接口调用密钥
			lat:0,//纬度
			lng:0,//经度
			url:"",
      results: [],
      pageNum:0,
      storeName:"",
      storeNameDataArray: []
    };
  },
  created(){
  	var _this = this;
  	_this.url = api.getMapLocation;
  	debugger;
	_this.mapLocation();//定位用户位置
	localStorage.setItem("openId",_this.$route.query.openid);
	localStorage.setItem("userId",_this.$route.query.userId);
  },
  methods: {
  	//门店查询
  	search(){
  		var _this = this;
		_this.queryMapStore();
  	},
  	//点击进入页面
  	clickChooseStore(storeId,tenantId,orgid){
  		var _this = this;
  		console.log(storeId,tenantId);
  		var storeUserData={
  			storeId:storeId,
  			tenantId:tenantId,
  			userId:localStorage.userId,
  			lastPatronageStore:0
  		};
  		_this.$http.post(api.storeUserAddApi,{storeUserData:storeUserData,token:localStorage.token}).then(function(resDatas) {
			    var errCode = resDatas.data.errCode
		      console.log(errCode);
		      if(errCode == "S"){
		      	localStorage.setItem("orgid",orgid);
						localStorage.setItem("tenantId",tenantId);
		      	//跳转到认证页面
					  _this.$router.push({path: '/registered'});
		      }else{
		      	AlertModule.show({
							title: '温馨提示',
		        			content: '选择失败，请重新选择。',
	        	});
		      }
		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		 	);
  	},
  	//查询门店
  	queryMapStore(){
  		var _this = this;
  		_this.storeNameDataArray = [];
  		const pageSize = 10;
  		 const page = {
		    	    begin: _this.storeNameDataArray.length,
			        length: pageSize
			  };
  		var map={
  			storeRegionName:_this.region,
  			longitude:_this.lng,//经度
  			latitude:_this.lat //纬度
  		}
  		if(_this.storeName) map.storeName = _this.storeName;
	  	 return _this.$http.post(api.mapStoreQueryApi,{map:map,token:localStorage.token,page:page}).then(function(resDatas) {
//		      _this.storeNameDataArray = resDatas.data.mapStoreDataArray;
		       _this.storeNameDataArray.push(...resDatas.data.mapStoreDataArray);
		       _this.$vux.loading.hide();
		       return resDatas.data.page.isLast;
		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		 	);
  		 
  		  
  	},
  	//定位用户位置
  	mapLocation(){
  		var _this = this;
  		_this.$vux.loading.show({//加载
        text: 'Loading'
     });
     var urlString=_this.url+"?openid="+_this.$route.query.openid+"&userId="+_this.$route.query.userId;
	  	_this.$http.post(api.mapUserApi,{url:urlString,token:localStorage.token}).then(function(resDatas) {
			    var data = resDatas.data.map
		      console.log("微信参数", data);
		      _this.getLatLng(data.timestamp,data.nonceStr,data.qianm1);
		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		 	);
  	},
  	//获得当前用户位置的经纬度
  	getLatLng(timestamp,nonceStr,qianm1){
  		var _this = this;
			wx.config({
				beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
			  debug: false,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	      appId: 'wxd10b49dcb45e5591',   			// 必填，企业号的唯一标识，此处填写企业号corpid
	      timestamp:timestamp, 		// 必填，生成签名的时间戳
	      nonceStr: nonceStr, 	// 必填，生成签名的随机串
	      signature: qianm1,		// 必填，签名
			  jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
			});
			wx.error(function(res){// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
				//console.log(JSON.stringify(res));
			});
			wx.ready(function(){
				wx.getLocation({
					type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
					success: function (res) {
						_this.lat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
						_this.lng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
						var speed = res.speed; // 速度，以米/每秒计
						var accuracy = res.accuracy; // 位置精度
						_this.getAddressCity();//根据经纬度得到城市
						_this.$vux.loading.hide();//终止加载
					}
				});
			});
		},
  	//根据经纬度得到城市
  	getAddressCity(){
  		var _this=this;
  		TMap(this.key).then(qq => {
	  		var citylocation = null;
		  	//设置经纬度信息
		    var latLng = new qq.maps.LatLng( _this.lat, _this.lng );
		    citylocation = new qq.maps.CityService({
		        complete : function(results){
		        		var addressString=results.detail.detail;
		        		console.log(addressString);
		        		var addressArray=addressString.split(",");
		        		_this.region=addressArray[0];
		        		_this.city=addressArray[1];
		        		_this.queryMapStore();
//		        		_this.$vux.loading.hide();//终止加载
		            console.log(addressArray);
		        }
		    });
		    //调用城市经纬度查询接口实现经纬查询
		    citylocation.searchCityByLatLng(latLng);
	  	});
	  	
  	},
    setFocus() {
      this.$refs.search.setFocus();
    },
    resultClick(item) {
      window.alert("you click the result item: " + JSON.stringify(item));
    },
    getResult(val) {
      console.log("on-change", val);
      this.results = val ? getResult(this.value) : [];
    },
    onSubmit() {
      this.$refs.search.setBlur();
      this.$vux.toast.show({
        type: "text",
        position: "top",
        text: "on submit"
      });
    },
    onFocus() {
      console.log("on focus");
    },
    onCancel() {
      console.log("on cancel");
    },
 
  }
};
</script>

<style scoped="scoped">
.search-bar {
  padding: 0.1rem 0.32rem;
  display: flex;
  align-items: center;
  background-color: #FFFFFF;
  position: sticky;
  top: 0;
  left: 0;
  right: 0;
  z-index: 1;
}

.search-input-box {
  flex: 1;
  height: 0.64rem;
}

.search-input {
  display: block;
  width: 100%;
  height: 100%;
  padding: 0 0.2rem;
  border-radius: 0.08rem;
  box-sizing: border-box;
  border: 0.02rem solid #ededed;
}

.search-btn-box {
  margin-left: 0.2rem;
}

.search-btn {
  display: block;
  width: 0.4rem;
  height: 0.4rem;
}

.vux-header {
  height: 0.96rem;
  background-color: #41cdff !important;
}

.vux-header .vux-header-left .left-arrow {
  position: absolute;
  width: 0.6rem;
  height: 0.6rem;
  top: -0.12rem !important;
}
.firstIn-input-group {
  position: absolute;
  top: 0.4rem;
  width: 100%;
}
/*.weui-cells {
    margin-top: 28px !important;
    }*/
/*.vux-header .vux-header-left .left-arrow:before {
    content: "";
    position: absolute;
    width: 15px;
    height: 15px;
    border: 0px solid #fff !important;
    border-width: 3px 0px 0 3px !important;
    -webkit-transform: rotate(315deg);
    transform: rotate(315deg);
    top: 5px  !important;
    left: 7px;
	}
	a{
		color: #fff !important;

		font-size: 17px;
		font-weight: 400;
	}*/
.firstIn-txt {
  color: #000;
  font-size: 0.36rem;
}
/*修改搜索框样式*/
.firstIn-seat {
  float: left;
  width: 100%;
}
.firstIn-seatch {
  height: 0.7rem;
}

.weui-search-bar {
  background: #ededed !important;
}
.weui-search-bar:before {
  border: 0rem solid !important;
}
.weui-search-bar:after {
  border: 0rem solid !important;
}
/*.vux-search-box {
    margin-top: 25px;
  }*/
/*取消按钮*/
.weui-search-bar__cancel-btn {
  background: #41cdff;
  border-radius: 0.1rem;
  text-align: center;
  width: 0.9rem;
}

.weui-cells__title {
  height: 0.2rem;
  letter-spacing: 0.04rem;
  font-size:0.36rem  !important;
  font-weight: 500 !important;
  color: #999999 !important;
}
/*当前城市*/
/*.firstIn-city{
			font-size: 18px;
			font-weight: 500;
			color: #999999 ;
			position: absolute;
			top: 100px;
	}*/

.firstIn-city-txt {
  color: #000;
}
.firstIn-posit {
  width: 100%;
  float: left;
  /*	margin-top:15px ;*/
  background-color: #fff;
  height: 1rem;
}
.firstIn-posit-flexbox {
  float: left;
  width: 100%;
  height: 1rem;
}
.firstIn-posit-city {
  float: left;
  width: 70%;
  margin-left: 0.2rem;
}
.firstIn-posit-city-txt {
  line-height: 1.1rem;
}
.firstIn-posit-src {
  float: left;
  width: 22%;
  /*	padding-right: 10px;*/
}
.firstIn-posit-img {
  height: 0.5ren;
  width: 0.4rem;
  float: right;
  margin: 0.3rem 0px;
}
.firstIn-posit-set {
  float: left;
  width: 76%;
  /*	line-height: 50px;*/
}
.firstIn-posit-set-txt {
  padding-left: 0.2rem;
  float: left;
  line-height: 1rem;
}

/*当前门店*/
/*.firstIn-store{
		font-size: 18px;
		font-weight: 500;
		color: #999999 ;
		position: absolute;
		top: 190px;
	}*/
.weui-cell_access .weui-cell__ft:after {
  height: 0.2rem !important;
  width: 0.2rem !important;
  border-width: 0.044rem 0.044rem 0 0 !important;
  border-color: #3c3c3c !important;
  border-style: solid;
}
.first-divider {
  display: block;
}
/*.firstIn-store-cell{
 	height: 28px;
 }*/
</style>
