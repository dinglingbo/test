<template  >
	<div class="bodyA">

			 <!--优惠券-->
		    <div class="myCoupon-show">
		    	  <div class="myCoupon-body"  v-for="(wxbCouponData,index) in wxbCouponDataArray" :key="index">
		    	  		<div class="myCoupon-body-money">
		    	  	 		<div class="myCoupon-body-nbm">
		    	  	 			<span class="myCoupon-body-money-txt1">￥{{wxbCouponData.couponDiscountsPrice}}</span>
		    	  	 		</div>
		    	  	 		<div class="myCoupon-body-type">
		    	  	 			<span class="myCoupon-body-money-txt2">{{ wxbCouponData.couponType == 1 ? '通用券' : '专属劵' }}</span>
		    	  	 		</div>
		    	  	 	</div>
		    	  	 	<div class="myCoupon-body-mess">
		    	  	 		<div class="mess-title"> 
		    	  	 			<div class="mess-title-a">
		    	  	 				<span class="mess-title-a-txt" style="letter-spacing: 0.02rem;">{{wxbCouponData.couponTitle}}</span>
		    	  	 			</div>
		    	  	 			
		    	  	 			<div v-if="wxbCouponData.couponTimeBool" class="mess-title-b">
		    	  	 				<div class="useButton" v-if="wxbCouponData.couponBool" @click="userCouponClick(wxbCouponData.couponDistributeId,index,wxbCouponData.storeId,wxbCouponData.orgid,wxbCouponData.tenantId)" >
		    	  	 					<span class="useText" >
		    	  	 						领取
		    	  	 					</span>
		    	  	 				</div>
		    	  	 				<div v-else class="useButton" style="background-color: #ffffff;">
		    	  	 					<span class="useText" style="color: black;" >已领取</span>
		    	  	 				</div>
		    	  	 			</div>
		    	  	 			<div v-else class="mess-title-b">
		    	  	 				<div class="useButton" style="background-color: #ffffff;">
		    	  	 					<span class="useText" style="color: black;" >已过期</span>
		    	  	 				</div>
		    	  	 			</div>
		    	  	 			
		    	  	 		</div>
		    	  	 		<div class="mess-body"> 
		    	  	 			<span class="mess-txt" style="letter-spacing: 0.02rema;">{{wxbCouponData.conditionText}}</span>
		    	  	 		</div>
		    	  	 		<div class="mess-end"> 
		    	  	 			<span class="mess-txt">有效期：{{wxbCouponData.couponBeginDate}} 至 {{wxbCouponData.couponEndDate}}</span>
		    	  	 		</div>
		    	  	 	</div>
		    	  </div>	
		    </div>

	</div>
	
	
</template>
<script>
	import api from '../Api/api.js';
	import axios from 'axios';
	import {Group,Cell,Alert,AlertModule} from 'vux';
	export default {
		
	  components: {
	    Group,
	    Cell,
	    Alert,
	    AlertModule
	  },
	  
	  data(){//存放数据对象，以此在元素标签里使用
	    return {
	    	wxbCouponDataArray: [],
	    	userData:{},
	    	openid:""
	    	
	    }
	  },
	  created:function(){//初始化数据
	  	this.initLocad();
	  },
	  methods:{
	  	//获取token
		initLocad(){
			var _this = this;
			axios.post(api.getTokenApi,{password:api.getPassword,userId:api.getUserId}).then(response => {
			 	var  token = response.data.data.attributes.token;
			 	localStorage.setItem("token",token);
			 	const couponData = JSON.parse(localStorage.couponData);
			  	console.log(couponData);
			  	var couponId=couponData.couponArrayString;
			  	_this.openid=couponData.openid;
		 		_this.$http.post(api.couponUserApi,{couponDistributeIdList:couponId,openid:_this.openid,token:token}).then(function(resDatas){
		 			console.log(resDatas);
		        	var dataArray=resDatas.data.couponDataArray;
		        	_this.userData = resDatas.data.userData[0];
		        	for(var a=0;a<dataArray.length;a++){
		        		var beginDate=new Date(dataArray[a].couponBeginDate);
		        		dataArray[a].couponBeginDate = beginDate.getFullYear()+"-"+_this.formDateString(beginDate.getMonth()+1)+"-"+_this.formDateString( beginDate.getDate() );
		        		var endDate=new Date(dataArray[a].couponEndDate);
		        		dataArray[a].couponEndDate = endDate.getFullYear()+"-"+_this.formDateString(endDate.getMonth()+1)+"-"+_this.formDateString( endDate.getDate() );
		        		//现在的时间
		        		var newTimes = new Date(new Date());
		        		var newString = newTimes.getFullYear()+"-"+_this.formDateString(newTimes.getMonth()+1)+"-"+_this.formDateString( newTimes.getDate() );
		        		var newDates = new Date(newString);
		        		//判断当前优惠劵没有领用并且过期
		        		dataArray[a].couponTimeBool = true;
		        		if( dataArray[a].couponBool && ( newDates.getTime() < beginDate.getTime() || newDates.getTime() >= endDate.getTime() ) ){
		        			dataArray[a].couponTimeBool = false;
		        		}
		        		if(dataArray[a].couponType == 1){
		        			dataArray[a].conditionText="满"+dataArray[a].couponConditionPrice+"元使用";
		        		}else if(dataArray[a].couponType == 2){
		        			dataArray[a].conditionText="只限"+dataArray[a].serviceItemName+"项目使用";
		        		}
		        		dataArray[a].divMarginTo=false;
		        		if(a>0){
		        			dataArray[a].divMarginTo=true;
		        		}
		        	}
		        	_this.wxbCouponDataArray=dataArray;
				},function(resDatas){
		            console.log(resDatas);
		        });
			});
		},
	  	formDateString: function(dateString){
	  		return (dateString+"").length == 1 ? "0"+dateString : dateString;
	  	},
	  	userCouponClick(couponDistributeId,index,storeId,orgid,tenantId){
	  		var _this = this;
	  		var userCoupon={
	  			storeId:storeId,
	  			userId:_this.userData.userId,
	  			orgid:orgid,
	  			tenantId:tenantId,
	  			userOpenid:_this.openid,
	  			carId:_this.userData.carId,
	  			couponDistributeId:couponDistributeId
	  		};
	  		_this.$http.post(api.addUserCouponApi,{userCoupon:userCoupon,token:localStorage.token}).then(function(resDatas){
	 			if( resDatas.data.errCode == "S" ){
	 				_this.wxbCouponDataArray[index].couponBool = false;
	 			}else{
	 				AlertModule.show({
						title: '温馨提示',
	        			content: '领用失败,服务异常请稍后重新领用'
        			});
	 			}
			},function(resDatas){
	            console.log(resDatas);
	        });
	  	}
	  	
	  },
	  
	  
	}
	
</script>

<style lang="less" scoped>
	.bodyA{
		background-color: #7430E5;
		background-repeat: no-repeat;
    	background-image: url(../assets/img/couponUse.png);
    	background-size: 100%;
    	padding-top: 4.95rem;
    	padding-bottom: 0.8rem;
	}
	.useButton{
		width: 1rem;
	    height: 0.5rem;
	    background-color: #3087F7;
	    border-radius: 0.1rem;
	    text-align: center;
	    margin-top: 0.16rem;
	    line-height: 0.44rem;
	}
	.useText{
		font-size: 0.26rem;
    	color: #ffffff;
    	letter-spacing: 0.02rem;
	}
	.myCoupon{
		width: 100%;
	}
	.myCoupon-txt{
		font-size: 0.034rem;
		letter-spacing: 0.04rem;
	}
	/*优惠券*/
	.myCoupon-show {min-height: 7rem;}
	.myCoupon-body ~ .myCoupon-body{
		margin-top: 0.4rem;
		
	}
	.myCoupon-body{
	    width: 6.9rem;
	    margin: auto;
	    height: 2rem;
	    border-radius: 0.1rem;
	    background-color: #FFF;
	    display: flex;
	}
	.myCoupon-body-money{
		width: 2rem;
		height: 2rem;
		background-image: url(../assets/img/img_2.png);
		background-size: 100%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
	}
	.myCoupon-body-mess{
		flex: 1;
	}
	/*.myCoupon-body-photo-img{
		height: 120px;
		width: 100px;
	}*/
	.myCoupon-body-nbm{
    	height: 0.76rem;
    	width: 100%;
    	text-align: center;
	}
	.myCoupon-body-type{
		text-align: center;
	    height: 1.16rem;
	    width: 100%;
	}
	.myCoupon-body-money-txt1{
		color: #FFFFFF;
		font-size:0.38rem ;
		line-height: 1.2rem;
		letter-spacing:0.04rem;
		padding-right:0.2rem ;
	}
	.myCoupon-body-money-txt2{
		color: #FFFFFF;
    	font-size: 0.34rem;
    	line-height: 0.92rem;
    	letter-spacing: 0.04rem;
    	padding-right: 0.1rem;
	}
	.mess-title{
		height: 0.64rem;
		width: 100%;
		display: inline-flex;
		justify-content: space-between;
	}
	.mess-body{
		height: 0.6rem;
		width: 100%;
	}
	.mess-end{
		height: 0.72rem;
		width: 100%;
	}
	.mess-txt{
		font-size: 0.24rem;
	    line-height: 0.8rem;
	    padding-left: 0.2rem;
	    color: #959595;
	}
	.mess-title-b {
		margin-right: 0.2rem;
	}
	.mess-title-a-txt{
		line-height: 0.8rem;
	    font-size: 0.30rem;
	    padding-left: 0.2rem;
	}
	.mess-title-b-img{
    	width: 0.44rem;
    	height: 0.44rem;
    	padding-right: 0.2rem;
    	padding-top: 0.1rem;
	}
</style>