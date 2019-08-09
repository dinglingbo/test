<template>
	<div id="home">
		<x-dialog v-model="showHideOnBlurComm" hide-on-blur>
  				<div class="img-box">
          			<img :src="tempImgUrl" style="max-width:100%">
        		</div>
		</x-dialog>
		<!--车主-->
		<div >
			<group :gutter="0" >
				<cell
			      is-link
			      :border-intent="false"
			      :arrow-direction="showData ? 'up' : 'down'"
			      @click.native="showData = !showData"  >
			      <div slot="title" style="padding-top: 0.04rem;"><span style="padding-left:0.1rem;" >{{userCar.carNo}}</span></div>
			      <img slot="icon"  style="display:block; margin-top: 0.04rem;width:0.44rem; height:0.32rem"  src="../assets/img/车.png">
			      <div   >
			          <span style="color:#3F3F3F; padding-right: 0.32rem;font-size: 0.28rem;">下次保养时间： {{ carMess ? splitData(carMess.careDueDate) : '无' }}</span>
			      </div>
			    </cell>
			    <!--显示内容-->
			    <div class="slide" :class="showData?'animate':''" style=" font-size: 0.28rem;">
				     <div>
				     	<span >车型： {{userCar.carModelName}}</span >
				     </div>
				     <div style="float: left;width: 50%;" >
				     	<span >商业险到期：{{ carMess ? splitData(carMess.annualInspectionDate) : '无' }}  </span >
				     </div>
				     <div style="float: left;width: 50%;" >
				     	<span >驾照年审：{{ userMess ? splitData(userMess.licenseOverDate) : '无' }} </span >
				     </div>
				     <div style="float: left;width: 50%;" >
				     	<span >交强险到期：{{ carMess ? splitData(carMess.insureDueDate) : '无' }} </span >
				     </div>
				     <div style="float: left;width: 50%;" >
				     	<span > 车辆年检：{{ carMess ? splitData(carMess.annualVerificationDueDate) : '无' }}</span >
				     </div>

			    </div>
			</group>
		</div>
		<!--轮播图-->
		<div>
			<swiper loop auto :list="showList"  :interval="2000" @on-index-change="figure_onIndexChange" dots-position="right" :show-desc-mask="false"></swiper>
		</div>
		<!--菜单-->
		<div>
			<flexbox class="home-menu">
					<flexbox-item  >
						<div class="home-menu-div" @click="order">
							<div>
								<img class="home-menu-img" src="../assets/icons/icon_yuyue.png" />
							</div>
							<div class="home-menu-txt">
								<span>预约</span>
							</div>
						</div>
					</flexbox-item>
					<flexbox-item >
						<div class="home-menu-div" @click="serviceItem('保养')" >
							<img class="home-menu-img"   src="../assets/icons/icon_baoyang.png" />
							<div class="home-menu-txt">
								<span>保养</span>
							</div>
						</div>
					</flexbox-item>
					<flexbox-item>
						<div class="home-menu-div" @click="serviceItem('洗车')" >
							<div >
								<img class="home-menu-img"   src="../assets/icons/icon_kefu.png" />
							</div>
							<div class="home-menu-txt">
								<span>洗车</span>
							</div>
						</div>
					</flexbox-item>
					<flexbox-item>
						<div class="home-menu-div" @click="goStore">
							<img class="home-menu-img"  src="../assets/icons/icon_shangchang.png" />
							<div class="home-menu-txt">
								<span>商城</span>
							</div>
						</div>
					</flexbox-item>
					<flexbox-item>
						<div class="home-menu-div" @click="goWeiZhang">
							<img class="home-menu-img"  src="../assets/icons/icon_weizhang.png" />
							<div class="home-menu-txt">
								<span>违章</span>
							</div>
						</div>
					</flexbox-item>
			</flexbox>
		</div>
		<!--门店展示-->
		<div class="home-store">
				<div class="home-store-pho" >
					<img class="home-store-pho-img" :src=" userStore.storePicture "/>
				</div>
				<div class="home-store-title" @click="storeInfo">
				<!--	<div style="width: 100%; float: left;">-->
						<div class="home-store-name">
							<span style="padding-left: 0.1rem;">{{userStore.storeName}}</span>
						</div>
					<!--</div>-->
					<div class="home-store-site" style="padding-left: 0.1rem;">
						<span >地址：{{userStore.storeStreetaddress}}</span>
					</div>
				</div>
				<div class="home-store-show" @click="storeInfo">
					<div class="home-store-grad">
							<span style="color: #3087F7;">{{userStore.storeAverageScore || 3}}</span><span>分</span>
					</div>
					<div class="home-store-navig" @click.stop="clickMapStore(userStore.storeName,userStore.storeStreetaddress,userStore.storeLongitude,userStore.storeLatitude)" >
						<img class="home-store-navig-img" :src="navig">
					</div>
				</div>

		</div>
   		<!--客服-->
   		<div class="home-service" >
		   		<div class="home-service-title">
		 			<span class="home-service-title-txt">专属客服</span>
				</div>
				<div class="home-service-body">
				   				<div class="home-sercive-fw"  >
				   						<div class="home-sercive-show" >
						   					<div>
						   						<img id="serviceImg" class="home-call-service" :src=" EmployesFw.employePicture ?  EmployesFw.employePicture : '../assets/img/1551101796(1).jpg' " />
						   					</div>
						   					<div class="home-service-txt">
						   						<span class="home-txt" >服务客服</span >
						   					</div>
						   				</div  >
						   				<div class="home-sercive-change" >
							   				
							   				<div class="home-serviceName" >
						   							<div class="home-service-name" >
						   								<span class="home-skill-swit-txt">{{EmployesFw.employeName || "暂无"}}</span>
						   							</div>
						   							<div class="home-service-switch-a"  @click="changeServiceFw()">
						   								<img   class="home-sercive-swit" src="../assets/img/icon_change.png">
						   							</div>
						   					</div>
						   					<div class="home-call-contact"  >
								   					<div class="home-sercive-chat" @click="wechatImgA" >
								   						<img  class="home-sercive-wechat" src="../assets/img/icon_wechat.png" />
								   					</div >
								   					 <x-dialog v-model="showHideOnBlurA"  hide-on-blur>
								   					 	<div  style="padding-top:0.2rem ;">长按识别二维码,添加客服微信</div>
													        <div >
													          <img :src="EmployesFw.employeWechatImg" style="max-width:100%">
													        </div>
													 </x-dialog>
								   					<a :href=" 'tel:'+ EmployesFw.employePhone "  class="home-sercive-call">
								   						<img class="home-sercive-phone" src="../assets/img/icon_bodadianhua.png" />
								   					</a >
							   				</div>
						   				</div  >
				   				</div>
				   			<div class="home-sercive-js" >
				   						<div class="home-sercive-show" >
						   					<div>
						   						<img id="techniqueImg" class="home-call-service" :src=" EmployesJs.employePicture ?  EmployesJs.employePicture : '../assets/img/1551101796(1).jpg' " />
						   					</div>
						   					<div class="home-service-txt">
						   						<span class="home-txt" >技术客服</span >
						   					</div>
						   				</div  >
						   				<div class="home-sercive-change" >
							   				
							   				<div class="home-serviceName" >
						   							<div class="home-service-name" >
						   								<span class="home-skill-swit-txt">{{EmployesJs.employeName || "暂无"}}</span>
						   							</div>
						   							<div class="home-service-switch-a"  @click="changeServiceJs()">
						   								<img   class="home-sercive-swit" src="../assets/img/icon_change.png" />
						   							</div>
						   					</div>
						   					<div class="home-call-contact"  >
								   					<div class="home-sercive-chat" @click="wechatImgB">
								   						<img  class="home-sercive-wechat" src="../assets/img/icon_wechat.png" />
								   					</div >
								   					 <x-dialog v-model="showHideOnBlur"  hide-on-blur>
													       <div style="padding-top:0.2rem ;">长按识别二维码,添加客服微信</div>
													       <div >
													          <img :src="EmployesJs.employeWechatImg" style="max-width:100%">
													        </div>
													 </x-dialog>
								   					<a :href=" 'tel:' + EmployesJs.employePhone " class="home-sercive-call">
								   						<img class="home-sercive-phone" src="../assets/img/icon_bodadianhua.png" />
								   					</a>
							   				</div>
						   				</div  >
				   				</div>
		   	</div>
   		</div>
   		<!--爆款推荐-->
   		<div class="home-faddish" >
   			<div class="home-recom">
   				<span class="home-recom-txt">爆款推荐</span>
   			</div>
   			<div class="panel-parent" :class="{ odd: ItemActivity.length % 2 === 1 }">
           		<img class="panel-child" v-for="(item, index) of ItemActivity" :key="index" :src=" item.itemUrl " @click="clickItemInfo(item.serviceItemId, item.serviceTypeId, item.serviceItemType)" alt="" />
	   		</div>
	   	</div>
	   	<!--评价-->
		<div class="store-appraise">
					<!--title-->
					<div class="store-appraise-title">
						<div class="store-appraise-titleTxt">
							<span class="store-title-Txt">服务评价</span>
						</div>
					</div>
					<!--详情-->
					<div class="details" v-for="(evaluateComment,index) in evaluateList" :key="index">
						<div class="details-title">
							<div class="details-title-show">
								<img class="details-title-img" :src="evaluateComment.userHeadPortrait" />
							</div>
							<div  class="details-titleTxt">
								<div style="margin-top:0.2rem;">
									<div class="details-title-name">
										<span style="line-height:0.6rem;">{{evaluateComment.carNo}}</span>
									</div>
									<div class="details-time">
										<span style="line-height:0.3rem;">{{splitTime(evaluateComment.commentDate)}}</span>
									</div>
								</div>
                				<div class="details-title-gread">
									<span style="line-height:0.6rem;">评分：</span>
                  					<span class="store-details-gradeTitle">{{evaluateComment.commentScore}}</span>
								</div>
							</div>
						</div>
						<div class="details-body">
							<span class="details-body-txt">车型：{{evaluateComment.carModelName}}</span>
						</div>
						<div class="details-bodyTxt">
							<span>{{evaluateComment.commentContent}}</span >
						</div>
						<div class="details-show">
						</div>
						<!--评价图片-->
						<div  style="float: left;padding: 0 0.21rem 0.2rem;background: #FFFFFF;width: 94%;">
					  		<flexbox :gutter=0 wrap="wrap">
					  			<flexbox-item :span="4" v-for="(commetImage,index) in evaluateComment.commetImageList" :key="index">
					  				<div class="home-evaluate-div " >
					   					<img class="home-evaluate-img " :src="commetImage.pictureUrl" @click="showItemImager(commetImage.pictureUrl)"/>
					   				</div>
					  			</flexbox-item>
					  		</flexbox>
				  		</div>
					</div>
						
				</div>
				<loadmore :onLoadmore="getEvaluateList" :isEmpty="evaluateList.length==0"></loadmore>

	</div>

</template>

<script>
	import wx from 'weixin-js-sdk';
import api from '../Api/api.js'
import axios from 'axios'
import navigation from '../assets/img/icon_daohang.png'
import storeimg from '../assets/img/ab487815f4640290414af6e9e3a67f4e.jpg'
import benChi from '../assets/img/benChi.jpg'
import loadmore from "../component/loadmore.vue"
import LoadMore from '../component/loadmore.vue';
import { Flexbox, FlexboxItem,Sticky, Group, Cell, Swiper,SwiperItem, Card,Rater,XDialog} from 'vux'

export default{
	components:{
		LoadMore,
		Flexbox,
		FlexboxItem,
		Group,
		Cell,
		Sticky,
		Swiper,
		SwiperItem,
		Card,
		Rater,
		loadmore,
		XDialog
	},
	data(){
		return{
			tempImgUrl:'',
			showHideOnBlurComm:false,
			showHideOnBlur:false,
			showHideOnBlurA:false,
			carMess:"",//车的信息
			userMess:"",//人的信息
			userCar:"",
			userStore: {},
			EmployesFw:{},
			EmployesJs:{},
			storeEmployesFw:[],
			storeEmployesJs:[],
			showList:[],
			gutter:"0",
			navig:navigation,
			grade:'5',
			data3:'5',
			list_index:'0',
			showData:false,
			ItemActivity:[],
			//工单评价
			evaluateList:[],
			//工单评价图片
			evaluateImgList:[],
			apiUrl:"",
			//地址访问路径
			urlString:"",

		}
	},
	created() {
		//this.getToken();
		var _this=this;
		this.urlString = api.getHome;
		this.apiUrl = api.getDms;
		if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前用户是否关联门店
  			_this.$vux.confirm.show({
		        title: '温馨提示',
		        content: '你还没有认证，请先认证。',
		        onCancel () {
		        	debugger;
		          	if( localStorage.storeId &&  localStorage.storeId != "undefined" &&  localStorage.storeId != "null" ){//判断当前用户虽然没有认证绑定，但已经有门店关系了
						_this.getUserStore();
						_this.deleteOrderByTimeOut();
			  		}
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
			_this.getUserStore();
			_this.deleteOrderByTimeOut();
		}
	},
	methods:{
		//获取token
		/*getToken(){
			
			this.$vux.loading.show({text: 'Loading'});
			axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
				var  token = response.data.data.attributes.token;
				localStorage.setItem("token",token);
				
			});
		},*/
			
				//点击进入地图定位
					clickMapStore(storeName,storeStreetaddress,storeLongitude,storeLatitude){
						this.$vux.loading.show({text: 'Loading'});
						debugger;
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
			//点击进入项目
			clickItemInfo(serviceItemId,serviceTypeId,serviceItemType){
				var _this = this;
	  			_this.$router.push({
					path:'/serviceMess',
					query: {
						serviceItemId:serviceItemId,
						serviceItemType:serviceItemType,
						serviceTypeId:serviceTypeId
					}
				});
			},
			figure_onIndexChange (index) {
	     		 this.demo01_index = index;
	    	},
	    	//预约
	    	order(){
	    		var _this = this;
	    		if( !localStorage.carid || localStorage.carid == "undefined" || localStorage.carid == "null" ){//判断当前是否绑定用户
					_this.$vux.confirm.show({
				        title: '温馨提示',
				        content: '你还没有认证，请先认证。',
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
					this.$router.push({path:'/makeAppointment'});
				}
	    	},
	    	//跳转到服务项目
	    	serviceItem(itemName){
	    		if( itemName=="保养" ){
	    			this.$router.push({
		    			path:'/autoServiceItem',
		    			query: {
		    				itemName:itemName
		    			}
		    		});
	    		}else if( itemName == "洗车" ){
	    			this.$router.push({
		    			path:'/autoServiceItem',
		    			query: {
		    				itemName:itemName
		    			}
		    		});
	    		}

	    	},
	    	//点击查看门店详情信息
	    	storeInfo(){
	    		var _this=this;
	    		this.$router.push({
	    			path:'/storeDetails',
	    			query: {
	    				storeId:_this.userStore.storeId,
	    				orgid:localStorage.orgid
	    			}
	    		});
	    	},
	    	//项目活动
	    	getItemActivity(){
	    		var _this = this;
		  		var map={
		  			storeId: localStorage.storeId
		  		}
		  		_this.$http.post(api.itemActityApi,{map: map,token:localStorage.token}).then(function(resDatas) {
		          	var ItemActivity = resDatas.data.ItemActivity
		          	_this.ItemActivity = ItemActivity;
		          	console.log("项目活动", resDatas);
		        },
		        function(resDatas) {
		            console.log(resDatas);
		        });
	    	},
	    	//车辆信息查询
	    	getUserCar(){
	    		var _that = this;
	    		var userId = localStorage.userId;
	    		axios.post(api.getCarApi,{userId: userId,token:localStorage.token}).then(function(response) {
	    		 	_that.userCar =  response.data.wxbUserCars;
	    		 	console.log("车的信息",_that.userCar);
	    		 	localStorage.setItem("carModelId",_that.userCar.carModelId);
	    		 	//车道id
	    		 	localStorage.setItem("carId",_that.userCar.userCarId);
	    		 	localStorage.setItem("userCarNo",_that.userCar.carNo);
	    		 	//wechat 车id
	    		 	localStorage.setItem("carid",_that.userCar.carId);
	    		 	//获取车道用户id
	    		 	_that.getCarMess(_that.userCar.userCarId);

				});
			},
			//查找车辆 车险,下次保养里程，保险到期等
	    	getCarMess(userCarId){
	    		var _that = this;
	    		var params={
	    			guestId:localStorage.guestId,
	    			carId:userCarId //15677
	    		};
	    		//车道用户id:carId
	    		axios.post(api.carMessApi,{params:params,token:localStorage.token}).then(function(response) {
	    		 	console.log("车险数据：",response);
	    		 	_that.$vux.loading.hide();
	    			_that.carMess = response.data.data.carExtend || []//车的信息
	    			_that.userMess = response.data.data.con ||[] // 人的信息
					_that.getEvaluateList();
				});
	    		
	    	},
	    	//用户默认门店
	    	getUserStore(){
	    		var _that = this;
	    		var userId = localStorage.userId;
		    	axios.post(api.getStoreApi, {userId: userId,token:localStorage.token}).then(function(response) {
		    		 _that.userStore = response.data.wxbStore;
		    		 localStorage.setItem("storeId",_that.userStore.storeId);
		    		 localStorage.setItem("tenantId",_that.userStore.tenantId);
		    		 localStorage.setItem("orgid",_that.userStore.orgid);
		    		 localStorage.setItem("storeName",_that.userStore.storeName);
		    		//用户默认门店客服
					_that.getStoreEmpiyes();
					//用户默认门店轮播图信息
					_that.getStoreSliderShow();
					//项目活动
					_that.getItemActivity();
				});

	    	},
	    	//用户默认门店客服
	    	getStoreEmpiyes(){
	    		var _that = this;
	    			//获取门店id
				var storeId = _that.userStore.storeId;
	    		axios.post(api.getServiceUserApi,{userId:localStorage.userId,storeId: storeId,token:localStorage.token}).then(function(response) {
					//服务客服
					_that.storeEmployesFw = response.data.servicenEmpData;
					_that.changeEmployesFw(0);
					//技师客服
					_that.storeEmployesJs =  response.data.techniqueEmpData;
					_that.changeEmployesJs(0);
	    		});
	    	},
	    	//切换服务客服
	    	changeServiceFw(){
	    		var _that = this;
	    		const {index} = this.EmployesFw;
	    		var a = index+1;
				if(a == this.storeEmployesFw.length){
					a=0;
				}
	    		this.changeEmployesFw(a);
	    		this.item = !this.item;
	    	},
	    	//使用析构 的方法
	    	changeEmployesFw(index){
	    		this.EmployesFw = {...this.storeEmployesFw[index], index: index};
	    		let param = {userId: localStorage.userId,serviceId: this.EmployesFw.serviceId,type: 0,} ;
	    		axios.post(api.updateUserByServiceApi, {
		    		param:param,
			        token: localStorage.token
		      })
	    	},
	    	//切换技术客服
	    	changeServiceJs(){
				var _that = this;
	    		const {index} = _that.EmployesJs;
	    		var b = index+1;
				if(b == this.storeEmployesJs.length){
					b = 0;
				}
	    		_that.changeEmployesJs(b);
	    	},
	    	//使用析构 的方法
	    	changeEmployesJs(index){
    			this.EmployesJs = {...this.storeEmployesJs[index], index: index};
    			let param = {userId: localStorage.userId,serviceId: this.EmployesJs.serviceId,type: 1,} ;
	    		axios.post(api.updateUserByServiceApi, {
		    		param:param,
			        token: localStorage.token
		      })
	    	},
	    	//用户默认门店轮播图信息
	    	getStoreSliderShow(){
	    		var _that = this;
	    		var storeSlideShow = [];
	    		var slideList = [];
	    		//获取门店id
				var storeId = _that.userStore.storeId;
	    		axios.post(api.getSlidesShowApi, {storeId: storeId,token:localStorage.token}).then(function(response) {
					storeSlideShow = response.data.wxbSlideshowS || [];
					for(var a= 0; a<= storeSlideShow.length-1; a++){
						var data={
							//url: storeSlideShow[a].connectUrl, 跳转地址
							url:"/slideshow"+"?"+"wxbSlideshowId="+storeSlideShow[a].wxbSlideshowId,
							//轮播图地址apiUrl
		  					img:storeSlideShow[a].pictureUrl
						}
						slideList.push(data);
						if( a == storeSlideShow.length-1 ){
							_that.showList = slideList;
						}
					}
					//_that.$router.push({ path:'./slideshow',query:{wxbSlideshowId:""}});
					_that.getUserCar();
				});
	    	},
	    	//首页工单评价
	    	getEvaluateList(){
	    		var _that  = this;
	    		//开始条数
	    		const pageSize = 10;
			      const page = {
		    	    begin:_that.evaluateList.length,
			        length: pageSize
			      };
	    		//Math.ceil(_that.evaluateList.length / pageSize)
	    		return axios.post(api.evaluateListApi,{storeId:localStorage.storeId,page:page,token:localStorage.token}).then(function(response){
	    			//门店所有评价
//	    			_that.evaluateList = response.data.evaluateList ;
	    			console.log("门店工单评",_that.evaluateList);
	    			_that.evaluateList.push(...response.data.evaluateList);
	    			if( !response.data.evaluateList || response.data.evaluateList.length <= 0 )LoadMore.props.emptyText.default = "暂无评价";
//	    			if (_that.evaluateList.length >= response.data.page.count) return true
	    			return  response.data.page.isLast;
	    		})
	    	},
	    	splitData(obj){
				var a = [];
				var b = [];
				if(obj !== null && obj){
				 a = obj.split(" ");
				 b = a[0].split("-");
				 return  b[0]+"."+b[1] + "." + b[2]
				}else{
					return "无";
				}

			},
			splitTime(obj){
							let a = [];
							let b = [];
							if(obj !== null){
							 a = obj.split(" ");
							 b = a[1].split(":");
							 return  a[0] +" "+ b[0]+":" + b[1]  
							} 
					
			},
			goStore(){
				 this.$vux.toast.text('开发中');	
			},
			goWeiZhang(){
				this.$vux.toast.text('开发中');	
			},
			wechatImgA(){
				this.showHideOnBlurA = !this.showHideOnBlurA;
			},
			wechatImgB(){
				this.showHideOnBlur = !this.showHideOnBlur;
			},
			showItemImager(e){
				this.tempImgUrl = e;
				this.showHideOnBlurComm = true;
			},
			//删除锁定超时订单
			deleteOrderByTimeOut(){
				axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{});
			}


    }
}

</script>

<style lang="less" scoped>
	/*.vux-x-dialog>:first-child{
		background-color: rgba(0, 0, 0, .2);
	}*/
	/*车牌号*/
	.home-head-txt{
		margin-left: 0.1rem;
		font-size:0.3rem;
		color: #323232;
	}
	.home-head-upkeep{
		width: 50%;
		float: left;
		font-size: 0.36rem;
	}
	.home-head-upkeep-txt{
		float: left;
		font-size: 0.3rem;
		color: #323232;
	}


  /*.home-group{
   position: absolute;
   top: 0;
    width: 100%;
  }*/
	.slide {
	  padding: 0 0.4rem;
	  overflow: hidden;
	  max-height: 0;
	  transition: max-height .5s cubic-bezier(0, 1, 0, 1) -.1s;
	}
	.animate {
	  max-height: 199.98rem;
	  transition-timing-function: cubic-bezier(0.5, 0, 1, 0);
	  transition-delay: 0s;
	  padding-bottom: 0.4rem;
	}
  /*菜单*/
	.home-menu{
		background-color: #FFFFFF;
		padding:0.2rem 0px;
	}
	.home-menu-div{
		text-align: center;

	}

	.home-menu-img{
		width: 0.7rem;
		height: 0.7rem;
	}

	.home-menu-txt{
	}
	/*门店*/
	.home-store{
		margin-top: 0.2rem;
		float: left;
		width: 100%;
		background-color: #fff;
	}
	.home-store-pho-img{
		width: 1.6rem;
		height: 1.6rem;
		margin: 0.2rem 0px 0.1rem 0.2rem;
		border-radius:0.3rem;

	}
	.home-store-pho{
		float: left;
		width: 25%;
		/*border-radius:5px ;*/
	}
	.home-store-title{
		float: left;
		width: 50%;
		height: 100%;
		/*padding: 0px 5px;*/
	}
	.home-store-show{
		float: left;
		width: 25%;
		height: 100%;
	}

	.home-store-name{
		font-weight: 500;
		float: left;
		width: 100%;
		height: 20px;
		padding:0.2rem 0 0 0;
	}

	.home-store-site{
		float: left;
		width: 100%;
    	color: #7f7f7f;
    	/*margin-top: 10px;*/
    	padding:0.2rem 0 0 0;
	}
	.home-store-grad{
		font-size: 0.32rem;
		font-weight: 500;
		float: left;
		width: 100%;
		padding:0.2rem 0 0 0;
		text-align: center;
	}
	.home-store-navig{
		float: left;
		width: 100%;
		text-align: center;
	}
	.home-store-navig-img{
		width: 0.6rem;
		height: 0.6rem;
		margin-top: 0.4rem;
	}

	/*客服*/
	.home-service-body{
		/*float: left;*/
		width: 100%;
	/*	height: 100px;*/
		display: flex;
	}
	.home-inform{
		float: left;
		width: 100%;
		padding-left: 0.1rem;
	}
	.home-service-title{
		height: 0.8rem;
		width: 100%;
		background-color: #fff;
		/*border-top:1px solid #ededed ;*/
		float: left;

	}
	.home-service-title-txt{
		line-height: 0.8rem;
		letter-spacing:2px;
		margin-left: 0.2rem;
	}

	.home-service{
		background-color: #fff;
		float: left;
		width: 100%;
		margin-top: 0.2rem;
	}
	.home-service-txt{
		font-size: 0.24rem;
		color: #969696;
		height: 0.6rem;
		text-align: center;

	}
	.home-txt{
		line-height: 0.6rem;
	}
	.home-sercive-js{
		border-top:1px solid #ededed;
		/*border-right:1px solid #ededed ;*/
		/*padding-left:10px ;*/
		flex: 1;
	}
	.home-sercive-fw{
		border-top:1px solid #ededed;
		/*border-right:1px solid #ededed ;*/
		/*padding-left:10px ;*/
		flex: 1;
		    border-right: 1px solid #ededed;
	}
	.home-sercive-show{
		float: left;
		width: 35%;
	}
	.home-sercive-change{
		float: left;
		width: 65%;
	}
	.home-serviceName{
		float: left;
		width: 100%;
		height: 1rem;
	}
	.home-technology{
		padding-left:0.2rem;
		border-top:1px solid #ededed;
		border-left:1px solid #ededed ;
	}
	.home-skill{
		border-top:1px solid #ededed;
		padding-left: 0.2rem;

	}
	.home-sercive-phone{
		width: 0.4rem;
		height: 0.4rem;
	}
	.home-sercive-wechat{
		width: 0.46rem;
		height: 0.46rem;

	}
	.home-call-contact{
		padding-top: 0.2rem;
		float: left;
		width: 100%;
	}
	.home-sercive-call{
		float: left;
		width: 50%;
		text-align: center;
	}
	.home-sercive-chat{
		float: left;
		width: 50%;
		text-align: center;
	}
	.home-skill-contact{
		margin-top: 0.4rem;
	}
	/*客服照片*/
	.home-call-service{
		width: 14vw;
	    height: 14vw;
	    border-radius: 50%;
		margin-top: 0.1rem;
		margin-left: 0.1rem;
	}
	.home-skill-service{
		width: 1.1rem;
		height: 1.1rem;
		border-radius: 0.2rem;
		margin-top: 0.08rem;
	}
	/*转换*/
	.vux-flex-row{
		width: 100%
	}
	.home-service-name{
		touch-action: none;
		float: left;
		width: 60%;
	}
	.home-service-switch-a{
		touch-action: none;
		float: left;
		width: 40%;
		/*padding-right:15px ;*/
	}
	.home-service-switch-b{
		touch-action: none !important;
		float: left;
		width: 30%;
		padding-right: 0.2rem;
	}
	.home-skill-swit-txt{
		float: left;
		margin-top: 0.1rem;
		margin-left: 0.1rem;
	}
	.home-call-swit-txt{
		font-size: 0.3rem;
		float: left;
	}
	.home-sercive-swit{
		width: 0.4rem;
		height: 0.4rem;
		float: right;
		padding-right: 0.4rem;
		padding-top:0.1rem;
	}
	/*爆款推荐*/
	.home-faddish{
		margin-top:0.2rem;
		width: 100%;
		float: left;
	}
	.home-recom{

		height:0.8rem;
		width: 100%;
		background-color: #fff;
		border-top:1px solid #ededed ;
		border-bottom:1px solid #ededed ;
		float: left;

		background-repeat:no-repeat;
		background-size: 100%  50px;
	}
	.home-recom-txt{
		line-height:0.8rem;
		letter-spacing:0.04rem;
		margin-left:0.2rem;
	}
	/*车主评价*/
	  .details{
		float: left;
		width: 100%;
		border-top: 1px solid #ededed;
	}
	.details-title{
		float: left;
		width: 100%;
		background-color: #FFFFFF;
	}
	.details-title-show{
		float: left;
		width: 25%;
		height: 100%;
		/*background-color:#04BE02;*/
		text-align: center;
	}
	.details-title-img{
		    width: 15vw;
		    height: 15vw;
		    border-radius: 50%;
			margin-top: 0.2rem;
		
	
	}
	.details-titleTxt{
		float: left;
		width: 75%;
    height: 100%;
    position: relative;
		/*background-color:#10AEFF;*/
	}
	.details-title-name{
		height: 0.6rem;
	}
	.details-title-gread{
	    height: 0.6rem;
	    position: absolute;
	    right: 0.64rem;
	    top: 0.2rem;
  }
  .store-details-gradeTitle {
      font-weight: bold;
      font-size: 0.36rem;
      color: #3087F7;
    }
	.details-time{
		font-size:0.28rem ;
	    height:0.3rem;
	}
	.details-body{
		background-color: #FFFFFF;
		font-size:0.28rem ;
		/*padding-left: 20px;*/
		color: #A8A8A8;
		padding-left:0.40rem;

	}
	.details-body-txt{
		word-wrap: break-word;
		width: 100%;
	}
	.details-bodyTxt{
		font-size: 0.28rem;
		background-color: #FFFFFF;
		letter-spacing:1px;
		    word-wrap: break-word;
		    padding-left: 0.40rem;
		    line-height: 2em;
	}
   .store-appraise{
   		float: left;
   		width: 100%;
   }
   .store-appraise-title{
   		margin-top:0.2rem;
   		float: left;
   		width: 100%;
   		height:0.8rem;
   		background: #FFFFFF;
   }
   .store-appraise-titleTxt{
   		float: left;
   		width: 30%;
   		height:100% ;
   }
   .store-appraise-titleTxt{
   		float: left;
   		width: 30%;
   		height:100% ;

   }
   .store-title-Txt{
   		letter-spacing:0.04rem;
   		line-height:0.8rem;
   		padding-left:0.2rem;
   }
   .store-appraise-titleSho{
   		float: left;
   		width: 70%;
   		height:100% ;
   }
   .store-appraise-txt{
   		float:right;
   		line-height:0.8rem;
   		color: #A8A8A8;
   }
   .store-appraiseTxt{
   		float: left;
   		width: 80%;
   		height:100% ;
   }
   .store-appraiseShow{
   		float: left;
   		width: 20%;
   		height:100% ;
   }
   .store-appraiseShow-img{
   		float: left;
   		width:0.4rem;
   		height:0.4rem;
   		margin-top:0.2rem;
   }
  .home-evaluate-img{
		width: 100%;
		height: 2rem;
		border-radius:0.1rem;
	}
	.home-evaluate-div{
		margin: 0px 0.1rem;

  }
  /* 爆款推荐 */
  .panel-parent {
    display: flex;
    flex-wrap: wrap;
    clear: both;
  }
  .panel-child {
    flex: 1;
    min-width: 50%;
    height: 2.5rem;
  }
  .panel-parent.odd > .panel-child:first-child {
    min-width: 100%;
    height: 5rem;
  }
	/*箭头*/
	/*.weui-cell_access .weui-cell__ft:after {
		    height: 10px !important;
		    width: 10px !important;
		    border-color: #3087F7 !important;
		    margin-top: -10px !important;
    }*/

</style>
