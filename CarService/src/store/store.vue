<template>
	<div id="store">
		<div class="search">
			<!--<div class = "user-location">
				<div class = "user-location-store" >
					<img class = "user-location-show" src="../assets/img/icon_ditu.png"/>
				</div>
				<div class = "user-location-title">
					<span class="user-location-txt">广州</span>
				</div>
			</div>-->
			<div class="store-search">
					<input class="store-input" type="search" v-model="storeName" placeholder="输入店名" @keyup.enter="searchStore"> </input>
			</div>
			<div @click="search"  class="store-photo-search">
				<img class="store-photo-search-img" src="../assets/img/icon_search.png"/>
			</div>
		</div>
		<!--门店-->
		<div class="store">
			<div class="store-for" v-for="(finallyUserStoreItem,index) in finallyUserStore" :key="index">
				<!--门店信息-->
				<div class="store-mess" @click="clickItemInfo(finallyUserStoreItem.storeId,finallyUserStoreItem.orgid)" ><!--@click="clickItemInfo(finallyUserStoreItem.storeId,finallyUserStoreItem.orgid)"-->
					<div class="store-photo">
						<div class="store-photo-show">
							<img class="store-photo-img" :src=" finallyUserStoreItem.storePicture "/>
						</div>
					</div>
					<div class="store-title">
						<div class="store-title-name">
							<div style="float: left; width: 85%;margin-top: 0.2rem;">
								<span class="store-title-nameTxt" >{{finallyUserStoreItem.storeName}}</span>
							</div>
							<nut-radio class="store-radio" @click.native.stop="setStore(finallyUserStoreItem.storeId,finallyUserStoreItem.orgid,finallyUserStoreItem.tenantId)" v-model="lastPatronageStore" :label="index" ></nut-radio>
						</div>
						<div class="store-title-site" >
							<span class="store-title-site-txt"> 地址: {{finallyUserStoreItem.storeStreetAddress}} </span>
						</div>
					</div>
				</div>
				<div class="store-lable" v-if="finallyUserStoreItem.storeLable.length">
					<flexbox class="store-lable-flex" :gutter="0">
						<flexbox-item   v-for="(storeLableItem, lableIndex ) in finallyUserStoreItem.storeLable" :key="lableIndex">
							<div class="store-lable-style">
									<span class="store-lable-txt">{{storeLableItem.tabContent}}</span>
							</div>
						</flexbox-item>
					</flexbox>
				</div>
				<div class="store-go">
					<div class="store-go-plat">
							<div class="store-go-photoA">
								<img class="store-go-img" src="../assets/img/icon_ditu.png">
							</div>
							<div class="store-go-body" @click.stop="clickMapStore(finallyUserStoreItem.storeName,finallyUserStoreItem.storeStreetAddress,finallyUserStoreItem.storeLongitude,finallyUserStoreItem.storeLatitude)">
								<span class="store-go-body-txt" >地图</span>
							</div>
					</div>
					<div class="store-go-phone">
						 <a  :href=" 'tel:' + finallyUserStoreItem.storePhone " >
						   <div class="store-go-photoB">
								<img class="store-go-img" src="../assets/img/icon_bodadianhua.png">
							</div>
							<div class="store-go-body">
								<span  class="store-go-body-txt" >电话</span>
							</div>
						</a>
					</div>

				</div>
			</div>
		</div>
    <template v-if="showHint">
      <div class="hint" v-if="loading">正在加载...</div>
      <div class="hint" v-else-if="errmsg" @click="onReachBottom"></div>
      <div class="hint" v-else-if="!finallyUserStore.length" @click="onReachBottom">没有数据，点击重试</div>
      <div class="hint" v-else-if="finished">全部数据加载完成</div>
      <div class="hint" v-else @click="onReachBottom">点击加载更多</div>
    </template>
	</div>

</template>

<script>
import wx from 'weixin-js-sdk';
import api from '../Api/api.js'
import axios from 'axios'
import loadmore from '../mixin/loadmore.js'
import { Search,Group,Flexbox,FlexboxItem,AlertModule } from 'vux'
	export default {
        mixins: [
          loadmore()
        ],
				 components: {
				    Search,
				    Group,
				    Flexbox,
			    	FlexboxItem,
			    	AlertModule
				},
			 	data(){
			  		return{
			  			key:0,
			  			//默认门店
			  			lastPatronageStore:0,
			  			finallyUserStore:[],
			  			storeName:"",
			  			urlString:"",
			  			apiUrl:"",
//			  			storeId:"",
              // 显示提示信息
              showHint: false

			  		}
			 	},
			  	created() {
			  		/*this.getToken();*/
			  		var _this = this;
			  		this.urlString = api.getStore;
			  		this.apiUrl = api.getDms;
			  		if( !localStorage.storeId || localStorage.storeId == "undefined" || localStorage.storeId == "null" ){//判断当前用户是否关联门店
			  			_this.$vux.confirm.show({
					        title: '温馨提示',
					        content: '你还没有认证，请先认证。',
					        onCancel () {
					          
					        },
					        onConfirm () {
					        	_this.$router.push({
		  	  						path:"/mapLocation?openid="+localStorage.openId
								})
					        }
					      })
					}else{
						this.$vux.loading.show({text: 'Loading'});
			  			this.findStore();
			  			this.deleteOrderByTimeOut();
					} 
				},
				methods:{
//					getToken(){
//						var _that= this;
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 _that.findStore();
//								_that.$vux.loading.hide();
//							});
//					},
					clickItemInfo: function(storeId,orgid){
						var _this =  this;
		    			_this.$router.push({
		    				path:'/storeDetails',
			    			query: {
			    				storeId:storeId,
			    				orgid:orgid
			    			}
		    			});
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
					//查找用户最后关注门店
					findStore(){
						var _that =  this;
						_that.finallyUserStore = [];
						axios.post(api.finallyUserStoreApi,{userId:localStorage.userId ,storeId :localStorage.storeId,token:localStorage.token}).then(function (response){
							//门店
							_that.finallyUserStore = response.data.finallyStore || [];
							if(_that.finallyUserStore[0].storeLable.length > 0){
								_that.finallyUserStore[0].lableBool=true;
							}else{
								_that.finallyUserStore[0].lableBool=false;
							}
							//门店标签
//							_that.storeLable = response.data.storeLable;
							console.log(_that.finallyUserStore[0].storePhone);
							_that.$vux.loading.hide();
						})

					},
					//点击图片搜索
					search(){
						var _that = this;
						_that.searchStore();
					},
					//监听键盘回车搜索
					searchStore(){
						var _that = this ;
						_that.getStore(_that.storeName);
					},
					//删除锁定超时订单
					deleteOrderByTimeOut(){
						axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{});
					},
					//模糊分页查询门店storeName:门店名
					getStore(storeName){
						if( !localStorage.storeId || localStorage.storeId == "undefined" || localStorage.storeId == "null" ){//判断当前用户是否关联门店
							return;
						}
			            this.showHint = true
			            this.finallyUserStore = this.finallyUserStore.slice(0, 1);
			            this.errmsg = "";
			            this.loading = false;
			            this.finished = false;
			            this.onReachBottom();
						 var _that = this;
						 var data=_that.finallyUserStore[0];
						 _that.finallyUserStore=[];
						 _that.finallyUserStore[0]=data;
						 const page={
						 	begin : 0,
						 	length:10
						 }
						 axios.post(api.searchStoreApi,{ page: page,storeId:localStorage.storeId, storeName:storeName,token:localStorage.token}).then(function(response){
						 	var storeList = response.data.storeList || [];
						 	for (var i=0;i<storeList.length;i++) {
						 		_that.finallyUserStore.push(storeList[i]);
						 		if(_that.finallyUserStore[i].storeLable.length > 0){
						 			_that.finallyUserStore[i].lableBool=true;
						 		}else{
						 			_that.finallyUserStore[i].lableBool=false;
						 		}
							}
							_that.storeName= ""
						 })
					},
          // 加载更多
          async loadmore() {
            if (!this.storeName) return
            if (this.loadmore.source) {
              this.loadmore.source.cancel();
            }
            this.loadmore.source = axios.CancelToken.source('请求已取消');
            const pageSize = 10;
		      const page = {
		        begin: Math.ceil((this.finallyUserStore.length - 1) / pageSize),
		        length: pageSize
		      };
            const { data } = await axios.post(
              api.searchStoreApi,
              {
                page: page,
                storeName: this.storeName,
                toke:localStorage.token
              },
              {
                cancelToken: this.loadmore.source.token
              }
            );
            this.finallyUserStore.push(...data.storeList)
            if (data.storeList.length < pageSize) {
              this.finished = true
            }
          },
					//设置默认门店
					setStore(storeId,orgid,sTenantId){
						var _that = this ;
						//得到设置默认门店的id
						var sStoreId = storeId;
						//得到 取消默认门店的id
						var cStoreId = localStorage.storeId;
						axios.post(api.setStoreApi,{ userId: localStorage.userId , sStoreId:sStoreId, cStoreId:cStoreId,orgid:orgid,sTenantId:sTenantId,token:localStorage.token}).then(function(response){
							var errCode = response.data.errCode;
							var resStoreData = response.data.resStoreData[0];
							if(errCode == "S"){
								//缓存默认门店
								localStorage.setItem("storeId",storeId);
								localStorage.setItem("storeName",resStoreData.storeName);
								localStorage.setItem("tenantId",resStoreData.tenantId);
								localStorage.setItem("orgid",resStoreData.orgid);
							}else{
								AlertModule.show({
									title: '温馨提示',
				        			content: '选择失败，请重新选择。',
			        			});
			        			setTimeout(() => {
							        AlertModule.hide()
							    }, 1000);
							}

						})
					}
				}
	}
</script>

<style scoped>

	.search {
		display: flex;
    background-color: #ffffff;
    height: 0.8rem;
    position: sticky;
    top: 0;
    left: 0;
    right: 0;
  }
	.store{/*
		  width: 100%;
	    position: absolute;
	    top: 40px;
	*/}
	.user-location{
		float: left;
		height: 100%;
		width:20%;
	}
	.user-location-store{
		float: left;
		height: 100%;
		width:40%;

		/*text-align: center;*/

	}
	.user-location-show{
		float: right;
		width: 0.4rem;
		height: 0.4rem;
		margin-top: 0.2rem;
	}
	.user-location-title{
		float: left;
		height: 100%;
		width:60%;
	}
	.user-location-txt{
		line-height: 0.8rem;
		padding-left:0.1rem ;
		float: left;
	}
	.store-search{
		height: 100%;
		width:90%;
		/*background-color: #FFFFFF;*/

	}

	.store-input{
		/*去掉input在ios的影响*/
		touch-action:none;
		 -webkit-appearance: none;
		border: 0.02rem solid #DEDEDE;
		margin-top:0.1rem ;
		margin-left:0.1rem ;
		height: 0.6rem;
		width: 99%;
		border-radius:0.1rem ;
		text-align: center;
	}
	.store-photo-search{
		width: 10%;
		text-align: center;
	}
	.store-photo-search-img{
		margin-top: 0.19rem;
		padding-right: 0.1rem;
	    width: 0.4rem;
	    height: 0.4rem;
	}

	/*input.text{
		text-align:center
	}*/
	.store-for{
		margin-top: 0.2rem;
		width: 100%;
		background-color: #FFFFFF;
	}
	.store-mess{
		height:2rem ;
		width: 100%;
		/*background-color: royalblue;*/
	}
	.store-lable{
		color: #969696;
		text-align: -webkit-center;
		height:0.9rem ;
		width: 100%;
		/*background-color: #04BE02;*/
	}
	.store-lable-flex{
		text-align: center !important;
		padding-top: 0.14rem !important;
    	width: 95% !important;
	}
	.vux-flexbox .vux-flexbox-item:first-child{
		text-align: -webkit-center !important;
	}
	.store-go{
		border-top: 0.02rem solid #ededed ;
		height:1rem ;
		width: 100%;
		background-color: #FFFFFF;
		/*background-color: chartreuse;*/
		/*border-top:1px solid #CDCDCD;*/
	}
	/*门店照片信息*/
	.store-photo{
		height: 100%;
		float: left;
		width: 30%;
		/*background-color: #179B16;*/
	}
	.store-title{
		height: 100%;
		float: left;
		width: 70%;
		/*background-color: rosybrown;*/
	}
	.store-photo-show{
	/*	margin: 10px auto;*/
		text-align: center;
		height: 1.6rem;
		padding-top:0.2rem;
	}
	.store-photo-img{

		width: 1.7rem;
		height: 1.7rem;
		border-radius:0.1rem;
	}
	.store-title-name{
		height: 0.8rem;
		overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;

	}
	.store-title-nameTxt{
		letter-spacing:0.04rem;
		padding-right: 0.2rem;
		font-weight: bold;
	}
	

	.store-title-site{
		padding-right: 0.2rem;
   		 overflow: hidden;
        height: 1.2rem;
		color: #969696;
	}
	.store-title-site-txt{
		letter-spacing: 0.02rem;
	    overflow: hidden;
	    -webkit-line-clamp: 3;
	    display: -webkit-box;
	    -webkit-box-orient: vertical;
	}
	.store-lable-style{
		text-align: center;
		width: 1.2rem;
		letter-spacing: 0.02rem;
		/*background-color: #3087F7;*/
		border: 0.02rem solid #e1e1e1;
		border-radius:0.1rem ;
		margin-left: 0.1rem;
		margin-right: 0.1rem;
		padding-bottom: 0.04rem;
		/*margin-top: 5px ;*/
	}
	.store-lable-txt{
		color:##969696 ;
		padding-top:-0.06rem ;
		font-size: 0.2rem;
		/*line-height:22px;*/

	}
	/*地图 电话*/
	.store-go-plat{
		height: 100%;
		float: left;
		width: 49%;
		/*border-right:1px solid #cdcdcd ;*/
		/*background-color:#179B16;*/
	}
	.store-go-phone{
		height: 100%;
		float: left;
		width: 49%;
		/*border-top:0.5px solid #CDCDCD  ;*/

		/*background-color: #333333;*/
	}
	.store-go-photoA{
		width: 45%;
	    float: left;
	    margin-top: 0.3rem;

	}
	.store-go-photoB{
	width: 45%;
    float: left;
    margin-top:0.3rem;
    border-left: 0.02rem solid #EDEDED;
	}
	.store-go-img{
		width: 0.4rem;
		height: 0.4rem;
		float: right;
	}
	.store-go-body{
		height: 0.6rem;
		width: 54%;
		float: left;
		margin-top: 0.24rem;
	}
	.store-go-body-txt{
		line-height: 0.5rem;
		padding-left:0.2rem ;
		letter-spacing: 0.06rem;
		color: #555555;
	}
  .hint {
    text-align: center;
    line-height: 3em;
  }
</style>
