<template>
	<div id="registered">
		<!--标题-->
		<!--<div>
			<x-header :left-options="{backText: ''}">手机验证</x-header>
		</div>-->
		<!--验证-->
		<div >
			<group class="registered-group" gutter="0"  >
					
					<div class="registered-pho"  >
			 						<div class="registered-pho-div" >
			 							<img class="registered-pho-img" src="../assets/icons/icon_phone.png" style="width: 0.4rem; height: 0.4rem;"  />
			 						</div>
			 						<div class="registered-pho-nbm" >
			 							<span class="registered-pho-nbm-txt">联系电话</span >
			 						</div>
			 						<div class="registered-pho-input" >
										<x-input  class="inpitAll"   :max="13" mask="999 9999 9999"   v-model="phoneNumber"    placeholder="请输入手机号" @on-blur="queryCustomer" >
										</x-input>
									</div>
			 		</div>
			 		
					<div class="registered-phone">
									<div class="registered-pho-div" >
			 							<img class="registered-pho-img" :src="icons.iconsCode" style="width: 0.4rem; height: 0.4rem;"  />
			 						</div>
			 						<div class="registered-pho-nbm" >
			 							<span class="registered-pho-nbm-txt">验证码</span >
			 						</div>
			 						<div  >
											<x-input   class="inpitAll"   :max="6"  mask="999999"   :show-clear="false"  v-model="phoneCode" placeholder="请输入验证码"   >

												<!--<img slot="label" class="registered-group-code"    />-->
												<p  slot="right" class="registered-group-countDown">
													<button class="registered-group-botton" :class="{disabled:!this.canClick}" @click="countDown()">{{content}}</button>
												</p>
											</x-input>
									</div>
					</div>
					<div class="registered-phone" >
						<div class="registered-pho-div" >
			 							<img class="registered-pho-img" :src="icons.iconsPlate" style="width: 0.4rem; height: 0.4rem;"  />
			 			</div>
			 			<div class="registered-pho-nbm" >
			 							<span class="registered-pho-nbm-txt">车牌号</span >
			 			</div>
			 			<div  >
								<x-input  class="inpitAll" :max="7" v-model="carNo"  :required="true" readonly placeholder="请输入车牌号" @click.native="pickCarNo" >
								</x-input>
						</div>
					</div>
					<div class="registered-carType">
						<div class="registered-pho-div" >
			 							<img class="registered-pho-img" src="../assets/icons/icon_chexing.png" style="width: 0.4rem; height: 0.4rem;"  />
			 			</div>
			 			<div class="registered-pho-nbm" >
			 							<span class="registered-pho-nbm-txt">车型</span >
			 			</div>
						<cell  style="color:#757575; border-top:0rem;" :link="'/carType?key=' + key">
							<span slot="title" class="registered-carType-txt">{{carbrand || '请选择车型'}}{{carLine}}{{carModel}}</span>
						</cell>
				    </div>
				    <div   v-if="coustemerShow && customerList.length != 0" style="border-top: 0.02rem #EDEDED solid;">
			 				<div ><span style="font-size: 0.28rem;padding-left:0.5rem ;line-height: 0.6rem;">历史联系人</span></div>	
			 		  <!--<nut-radiogroup v-model="select">-->
						  <div v-for="(customerItem, index) in customerList" style="height: 0.8rem;padding-left: 0.9rem;height: 0.8rem;" @click="getCostomer(customerItem.fullName,customerItem.mobile,customerItem.id,customerItem.shortName,customerItem.orgid,customerItem.tenantId,$event)">
						  	<nut-radio  v-model="selectHis" :label="customerItem.id" size="base" style="line-height: .8rem;">
						  		{{customerItem.fullName}} {{customerItem.remark}}
						  	</nut-radio>
						  </div>
					  <!--</nut-radiogroup>-->
			 		</div>	

			</group>
		</div>
    <car-number-picker ref="picker" @change="onCarNoSelected"/>
		<!--保存-->
		<div class="registered-button">
					<x-button type='primary' class="registered-button-save" @click.native="saveMess()">提交</x-button>
		</div>
	</div>
</template>

<script>
import api from '../Api/api.js'
import axios from 'axios'
import licencePlate from '../assets/icons/icon_car.png'
import authCode from '../assets/icons/icon_yanzhengma.png'
import phone from '../assets/icons/icon_phone.png'
import CarNumberPicker from '../component/car-number-picker.vue';
import { XHeader,Group, XInput,XButton,Alert,AlertModule,Cell,Radio} from 'vux'
export default{
	components:{
    CarNumberPicker,
		Group,
		XInput,
		XButton,
		XHeader,
		Alert,
		AlertModule,
		Cell,
		Radio
	},
	data(){
		return{
			icons:{
				iconsPhone:phone,
				iconsCode:authCode,
				iconsPlate:licencePlate,
			},
			phoneNumber:"",
			phoneCode:"",
			content:"发送验证码",
			totalTime:60,
			canClick:'ture',
			checkCode:"",
			carNo:"",
			carbrand:"",
			carLine:"",
			carModel:"",
			BrandId:"",
			SeriesId:"",
			ModelId:"",
			allList:[],
			carBrandIds:"",
			carSeriesIds:"",
			carModelIds:"",
		    guestId:"",
		    key: '',
		    //联系人
		    customerList:[],
		    pastCostomer:{
		    		fullName:"",
					mobile:	"",
					id:	"",
					shortName:"",
					orgid:"",
					tenantid:""
		    },
		    coustemerShow:false,
		    //选着择状态
		    coustemerState:false,
		    selectHis:"",
		    oldSelect:"",
		}
	},
	created(){
//		this.getToken();
		var _this=this;
    this.key = Math.random().toString().slice(2);
    var storeMarke =_this.$route.query.storeMarke;
    if( storeMarke == "useStore" ){
    	localStorage.setItem("openId",_this.$route.query.openid);
			localStorage.setItem("userId",_this.$route.query.userId);
			localStorage.setItem("orgid",_this.$route.query.orgid);
			localStorage.setItem("storeId",_this.$route.query.storeId);
			localStorage.setItem("storeName",_this.$route.query.storeName);
			localStorage.setItem("tenantId",_this.$route.query.tenantId);
    }
		this.getParams();
		this.getSite();
//		查看是否缓存
//		console.log(this.$route);
  },
  activated() {
    const carInfo = JSON.parse(sessionStorage.getItem('车型'))
    if (carInfo && carInfo._key === this.key) {
      //车辆品牌id
	    var carBrandId = carInfo.carBrandId;
	    //车系id
	    var carSeriesId = carInfo.carSeriesId;
	    //车型id
	    var carModelId = carInfo.carModelId;
	    //车name
	    var routerParamsB = carInfo.carbrand;
	    var routerParamsl = carInfo.carLine;
	    var routerParamsC = carInfo.carModel;
	    this.carBrandIds  = carBrandId;
	    this.carSeriesIds  = carSeriesId;
	    this.carModelIds = carModelId;
	    this.carbrand = routerParamsB;
	    this.carLine = routerParamsl;
      this.carModel = routerParamsC;
      sessionStorage.removeItem('车型')
    }
    this.key = Math.random().toString().slice(2);
  },
	watch:{
	},
	methods:{
//		getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
			pickCarModel() {
			      this.$router.push('/carType?key=' + this.key);
			},
			countDown(){
				let _that=this;
				this.canClick = false;
				this.totalTime=60;
				let clock = window.setInterval(() =>{
					this.content = this.totalTime + "s"
					this.totalTime--
					if(this.totalTime < 0){
						window.clearInterval(this.clock);
						this.content = "重新发送验证码"
					}
				},1000);
				//正则表达是去掉空格
				var phone=""+this.phoneNumber;
	//			console.log(Number( phone.replace(/\s+/g, "") ));
				var params = { phone : Number( phone.replace(/\s+/g, "") ) };
				//var json = JSON.stringify({params:params,token:localStorage.token});
				axios.post(api.verificationCodeApi,{params:params,token:localStorage.token})
			  	.then(function (response) {
			    	_that.checkCode=response.data.data.msgCode;
			  	})
			  	.catch(function (error) {
			  	});

				},
			getParams(){
				//车辆品牌id
				 var carBrandId = this.$route.query.carBrandId;
				 //车系id
				 var carSeriesId = this.$route.query.carSeriesId;
				 //车型id
				 var carModelId = this.$route.query.carModelId;
				 //车name
				 var routerParamsB = this.$route.query.carbrand;
				 var routerParamsl = this.$route.query.carLine;
				 var routerParamsC = this.$route.query.carModel;
				 this.carBrandIds  = carBrandId;
				 this.carSeriesIds  = carSeriesId;
				 this.carModelIds = carModelId;
				 this.carbrand = routerParamsB;
				 this.carLine = routerParamsl;
				 this.carModel = routerParamsC;
			},
			//得到用户微信信息
			getSite(){
				var  _that = this ;
			   	var opendId = localStorage.openId;
			   	axios.post(api.inquireAllApi, {opendId:opendId ,token: localStorage.token}).then(function(response) {
					_that.allList =  response.data.idList;
			   	})
			},
			//根据手机号查询门客服
			queryCustomer(){
				let  _that = this;
				let phone = _that.phoneNumber;
				phone  =   phone.replace(/\s+/g,"");
				let params={
					mobile:phone,
					tenantId:localStorage.tenantId
				}
				if(_that.phoneNumber != ""){
						axios.post(api.queryCustomerApi,{params:params,token:localStorage.token}).then(function(response){
							debugger;
							_that.customerList = response.data.list;
							_that.coustemerShow = true; 
					});
				}
			
			},
			//得到历史联系人
			getCostomer(PastFullName,PastMobile,PastId,PsstShortName,PastOrgid,PastTenantId,eventIndex){
				debugger;
				// eventIndex.stopImmediatePropagation();
				if(eventIndex.target.nodeName == "INPUT"){
					if(this.oldSelect != PastId){
						this.oldSelect = PastId;
						this.coustemerState = true;
					    this.pastCostomer = {
							fullName:PastFullName,
							mobile:	PastMobile,
							id:	PastId,
							shortName:	PsstShortName,
							orgid:	PastOrgid,
							tenantId:	PastTenantId,
						}
					}else{
						this.coustemerState = false;
						this.oldSelect = "";
						this.selectHis = "";
					}
				}
			},
			
	

      /**
       * 输入车牌号
       */
      pickCarNo() {
        this.$refs.picker.carplateFn()
      },

      /**
       * 选取车牌号成功
       */
      onCarNoSelected(carNo) {
        this.carNo = carNo
      },

		//提交客户信息
	  saveMess(){
				var  _that = this ;
						//去掉手机空格
						var phone = _that.phoneNumber;
						 phone  =   phone.replace(/\s+/g,"");
					   var 	insGuest = {
					   		//地址
					   	  	addr : _that.allList[0].userProvince+_that.allList[0].userCity,
					   	  	//城市
//					   	  	cityId : 'null',
					   	  	//客户名称 (微信昵称)
					   	  	fullName : _that.allList[0].userNickname,

					   	  	guestType : "01020103",
					   	  	//手机号
					   	  	mobile : phone,
						
					   	  	//简称(微信昵称)
					   	  	shortName :_that.allList[0].userNickname,
					   	  	//租户ID
					   	  	tenantId:localStorage.tenantId,
					   	  	//机构ID
					   	  	orgid:localStorage.orgid
					   };
//					   var insCar= {};
					   var insCar = {
					   		//	车牌号
					   		carNo: _that.carNo,
					   		//车辆品牌
					   		carBrandId :_that.carBrandIds ,
					   		//	车型
					   		carModelFullName: _that.carModel,
					   		//	车型ID
					   		carModelId: _that.carModelIds ,
					   		//租户ID
					   	  	tenantId:localStorage.tenantId,
					   	  	//机构ID
					   	  	orgid:localStorage.orgid
					   };

//					   	insCarList.push(insCarList1);
//					   	var insContactList = {};
					    var insContactor = {
					    	//opID
					   		wechatOpenId: localStorage.openId,
					   		//服务号
					   		wechatServiceId: _that.allList[0].userMarke,
//					    	guestId :"",
//					    	identity:"060301",
//					    	mobile: _that.phoneNumber,
//					    	name:_that.allList[0].userNickname,
//					    	source:"060110",
					    };
//					    insContactList.push(insContactList1);
					    var vehicleNumber = this.carNo
			    		var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
			    		var  r =  vehicleNumber.match(express);
					    if(r == null ){
								this.$vux.toast.text('车牌号错误');	
								return false;
				   		}
				   		if(_that.phoneNumber== "" || _that.phoneCode== ""||_that.carNo == ""){
						    this.$vux.toast.text('请填写信息');	
						    return false;
						} 
						if(!_that.carbrand){
							this.$vux.toast.text('请选择车型');	
						    return false;
						}
						if(this.phoneCode !== this.checkCode){
							this.$vux.toast.text('验证码错误');
							return false;
						}else if(this.coustemerState){
							axios.post(api.addClientApi, {action:"add",	insGuest:this.pastCostomer ,insCar:insCar,insContactor:insContactor,token: localStorage.token}).then(function(response) {
						   		  	console.log(response,_that.allList);
						   		  	var judgeNbm = response.data.guest.id;//客户id
						   		  	var userName = response.data.guest.fullName;//姓名
						   		  	var contactorId = response.data.contactor.id;//联系人id
						   		  	var carList = response.data.carList;//车list
						   		  	_that.guestId = judgeNbm;
									if(response.data.errCode != "S"){
										AlertModule.show({
											title: '温馨提示',
						        			content: response.data.errMsg,
					        			});
					        			setTimeout(() => {
									        AlertModule.hide()
									    }, 2000);
									}else{
										_that.upAddGuestId(userName,contactorId,phone,carList);
									}
	
						   		})
							
						}else{
								axios.post(api.addClientApi, {action:"add",	insGuest:insGuest ,insCar:insCar,insContactor:insContactor,token: localStorage.token}).then(function(response) {
						   		  	console.log(response,_that.allList);
						   		  	var judgeNbm = response.data.guest.id;//客户id
						   		  	var userName = response.data.guest.fullName;//姓名
						   		  	var contactorId = response.data.contactor.id;//联系人id
						   		  	var carList = response.data.carList;//车list
						   		  	_that.guestId = judgeNbm;
									if(response.data.errCode != "S"){
										AlertModule.show({
											title: '温馨提示',
						        			content: response.data.errMsg,
					        			});
					        			setTimeout(() => {
									        AlertModule.hide()
									    }, 2000);
									}else{
										_that.upAddGuestId(userName,contactorId,phone,carList);
									}
	
						   		})
						    }
			},
			//修改客户ID
			upAddGuestId(userName,contactorId,phone,carList){
				debugger;
				var _that = this;
				var userId = localStorage.userId;
				var guestId = _that.guestId;
				var userCarData= [];
				for(var cl = 0;cl<carList.length;cl++){
					if(_that.carNo == carList[cl].carNo){
						userCarData.push({	
							userId:userId,
				 			userCarId:carList[cl].id,
				 			carNo:carList[cl].carNo,
				 			carBrandId:this.carBrandIds,
				 			carSeriesId:this.carSeriesIds,
				 			carModelId:this.carModelIds,
				 			carModelName:carList[cl].carModel,
							lastPatronageCar:0
						});
						continue;
					}
					userCarData.push({
						 			userId:userId,
						 			userCarId:carList[cl].id,
						 			carNo:carList[cl].carNo,
						 			carBrandId:carList[cl].carBrandId,
						 			carSeriesId:carList[cl].carSeriesId,
						 			carModelId:carList[cl].carModelId,
						 			carModelName:carList[cl].carModel,
						 			lastPatronageCar:1
					});
				}
				console.log(contactorId,userCarData);
				axios.post(api.upAddGuestIdApi, {contactorId:contactorId,userName:userName,phone:phone,userCarData:userCarData,userId:userId,guestId:guestId,token: localStorage.token}).then(function(response) {
				 	debugger
				 	var errCode = response.data.errCode;
				 	var errMsg = response.data.errMsg;
				 	debugger;
				 	if(errCode == "S"){
				 		AlertModule.show({
							title: '温馨提示',
		        			content: '认证成功',
		        			onHide(){
		        				//储存用户的电话和车牌号
					    		localStorage.setItem("userPhone",_that.phoneNumber);
					    		localStorage.setItem("userCarNo",_that.carNo);
					    		localStorage.setItem("guestId",_that.guestId);
					    		localStorage.setItem("contactorId",contactorId);
		        				//跳转到首页
					         	_that.$router.push({path: '/home'});
					        }
	        			});
				 	}else if(errCode == "E"){
				 		_that.$vux.toast.text('认证失败');
				 	}

				})
			}

	}



}
</script>

<style scoped>
.vux-label, .weui-cell__ft .weui-loading{
	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: nowrap;
    	width: 80%;
}
	.vux-cell-primary.vux-cell-primary{
		overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: nowrap;
	}
	.weui-cell:before{
		    content: " ";
		    position: absolute;
		    left: 0;
		    top: 0;
		    right: 0;
		    height: 0.02rem;
		    border-top: 0rem solid #D9D9D9 !important;
		    color: #D9D9D9;
		    -webkit-transform-origin: 0 0;
		    transform-origin: 0 0;
		    -webkit-transform: scaleY(0.5);
		    transform: scaleY(0.5);
		    left: 0.3rem;
	}
	
	/*解决监听被动事假*/
	/*.inpitAll{
		touch-action:none;
	}*/
	.registered-pho{
		float:left;
		width: 100%;
	}
	.registered-pho-input{
		border-bottom: 0.02rem solid #E8E8E8;
	}
	.registered-pho-div{
		float: left;
		width: 15%;
		height: 100%;
	}
	.registered-pho-img{
		float: right;
		margin: 0.15rem 0rem;
		padding-right: 0.2rem;
	}
	.registered-pho-nbm{
		float: left;
		width: 85%;
		height: 100%;
	}
	.registered-pho-nbm-txt{
		line-height: 0.75rem;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}

	/*验证码*/
	.registered-group-botton{
		background: #FFFFFF;
		border: 0rem solid;
		color: #ababab;
	}
	/*图像*/
	.registered-group-phone{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;


	}
	.registered-group-code{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;
	}
	.registered-group-plate{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;
	}

    .weui-label{
     color: #41cdff !important;
    }
    /*提交*/
    .registered-button{
    	width: 100%;
    	text-align: center;
    	margin-top: 0.8rem;

    }
    .registered-button-save{
    	width: 80%;
    }

  	/*button.weui-btn, input.weui-btn{
  		width: 80% !important;
  	}*/
    .registered-group{
    	margin-top:0.04rem;
    }

	/*&:active {
    border-color: rgba(206, 60, 57, 0.6)!important;
    color: rgba(206, 60, 57, 0.6)!important;
    background-color: transparent;
  }*/
 	.registered-button-save{
		margin-top: 1rem;
		text-align: center;
	}
	.registered-button-save{
		width: 80% !important;
		border: 0rem;
		background-color: #3087F7 !important;
	}
	.registered-carType-txt{
		width: 1.6rem;
		 overflow:hidden;
         white-space: nowrap;
         text-overflow: ellipsis;
         padding-left: 0rem;
	}
</style>
<style>
		#registered .weui-cell .vux-cell-bd >p{
		    width: 80%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
	}
	   #registered  .weui-cell>.vux-cell-bd {
	   	    width: 80%;
	    overflow: hidden;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	   }
</style>
