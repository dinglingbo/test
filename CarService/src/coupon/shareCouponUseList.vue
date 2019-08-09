<template>
	<div id="firstIn">
	    <div class="search-bar">
	      <div class="search-input-box">
	        <input class="search-input" type="search" v-model="storeName" placeholder="搜索优惠劵的适用门店" @keyup.enter="search">
	      </div>
	      <div class="search-btn-box" @click="search">
	        <img class="search-btn" src="../assets/img/icon_search.png">
	      </div>
	    </div>
    	
    	<!--优惠券-->
	    <div class="myCoupon-show" style="padding-top: 0.25rem;padding-bottom: 0.25rem;">
			<div class="myCoupon-body"  v-for="(shareUseCouponData,index) in shareUseCouponDataArray" :key="index" @click="clickShareCouponUseMain(index)" >
				<div class="myCoupon-body-money">
			 		<div class="myCoupon-body-nbm">
			 			<span class="myCoupon-body-money-txt1">￥{{shareUseCouponData.couponDiscountsPrice}}</span>
			 		</div>
			 		<div class="myCoupon-body-type">
			 			<span class="myCoupon-body-money-txt2">{{ shareUseCouponData.couponType == 1 ? '通用券' : '专属劵' }}</span>
			 		</div>
			 	</div>
			 	<div class="myCoupon-body-mess">
			 		<div class="mess-title"> 
			 			<div class="mess-title-a">
			 				<span class="mess-title-a-txt" style="letter-spacing: 0.02rem;">{{shareUseCouponData.couponTitle}}</span>
			 			</div>
			 			<div  class="mess-title-b">
			 				<div v-if=" shareUseCouponData.wxbIsCouponUse == 1 "  >
			 					<div class="useButton" style="background-color: #ffffff;" :hidden=" shareUseCouponData.wxbIsShareCouponUse == 1 " >
			 						<span class="useText" style="color: black;" >已领取</span>
			 					</div>
			 				</div>
			 				<div v-else class="useButton" style="background-color: #ffffff;">
			 					<span class="useText" style="color: black;" >已领取</span>
			 				</div>
			 			</div>
			 		</div>
			 		<div class="mess-body"> 
			 			<span class="mess-txt" style="letter-spacing: 0.02rema;">{{shareUseCouponData.conditionText}}</span>
			 		</div>
			 		<div class="mess-end"> 
			 			<span class="mess-txt">有效期：{{shareUseCouponData.couponBeginDate}} 至 {{shareUseCouponData.couponEndDate}}</span>
			 		</div>
			 		<div class="mess-end"> 
			 			<span class="mess-txt">适用门店：{{shareUseCouponData.storeName}}</span>
			 		</div>
			 	</div>
				<div class="myCoupon-body-background" :hidden=" Number( shareUseCouponData.couponNumber ) !=  Number( shareUseCouponData.distributeCouponUseNumber ) + Number( shareUseCouponData.shareCouponUseNumber)  " >
					<div class="myCoupon-body-background-text" >已领完</div>
				</div>
			</div>	
	    </div>
	    
  	</div>
</template>

<script>
	import axios from 'axios'
	import api from '../Api/api.js';
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
	    	shareUseCouponDataArray:[],
	    	storeName:""
	    };
	  },
	  created(){
	  	this.queryShareUseCoupon();
	  },
	  methods: {
	  	queryShareUseCoupon(){
	  		var _this = this;
			axios.post(api.queryShareUseCouponListApi,{storeName:_this.storeName,userOpenId:localStorage.openId,token:localStorage.token}).then(response => {
				var shareUseCouponDataArray = response.data.shareUseCouponDataArray;
				for(var a=0;a<shareUseCouponDataArray.length;a++){
					var beginDate=new Date(shareUseCouponDataArray[a].couponBeginDate);
		        	shareUseCouponDataArray[a].couponBeginDate = beginDate.getFullYear()+"-"+_this.formDateString(beginDate.getMonth()+1)+"-"+_this.formDateString( beginDate.getDate() );
	        		var endDate=new Date(shareUseCouponDataArray[a].couponEndDate);
	        		shareUseCouponDataArray[a].couponEndDate = endDate.getFullYear()+"-"+_this.formDateString(endDate.getMonth()+1)+"-"+_this.formDateString( endDate.getDate() );
	        		if(shareUseCouponDataArray[a].couponType == 1){
	        			shareUseCouponDataArray[a].conditionText="满"+shareUseCouponDataArray[a].couponConditionPrice+"元使用";
	        		}else if(shareUseCouponDataArray[a].couponType == 2){
	        			shareUseCouponDataArray[a].conditionText="只限"+shareUseCouponDataArray[a].serviceItemName+"项目使用";
	        		}
				}
				_this.shareUseCouponDataArray = shareUseCouponDataArray;
				console.log(shareUseCouponDataArray);
			});
	  	},
	  	//根据门店查询其下的可以分享的优惠劵
	  	search(){
			this.queryShareUseCoupon();
	  	},
	  	formDateString: function(dateString){
	  		return (dateString+"").length == 1 ? "0"+dateString : dateString;
	  	},
	  	clickShareCouponUseMain(index){
	  		console.log(index);
	  		var _this = this;
	  		if( Number( _this.shareUseCouponDataArray[index].couponNumber ) ==  Number( _this.shareUseCouponDataArray[index].distributeCouponUseNumber ) + Number( _this.shareUseCouponDataArray[index].shareCouponUseNumber) ){
	  			return;
	  		}
	  		_this.$router.push({
				path:'/shareCouponUseMain',
				query: {
					couponCode:_this.shareUseCouponDataArray[index].couponCode,
					from:"singlemessage"
				}
			});
	  	}
	  	
	  }
	}
	
	
</script>

<style scoped="scoped">
	.myCoupon-body-background{
		width: 6.9rem;
    	height: 2rem;
    	position: absolute;
    	background: rgba(204, 204, 204, 0.67);
	}
	.myCoupon-body-background-text{
		text-align: center;
	    line-height: 2rem;
	    font-size: 0.85rem;
	    letter-spacing: 0.2rem;
	    color: rgba(0, 0, 0, 0.19);
	}
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
		height: 0.4rem;
		width: 100%;
	}
	.mess-end{
		height: 0.4rem;
		width: 100%;
	}
	.mess-txt{
		font-size: 0.24rem;
	    line-height: 0.4rem;
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

.firstIn-city-txt {
  color: #000;
}
.firstIn-posit {
  width: 100%;
  float: left;
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
}
.firstIn-posit-set-txt {
  padding-left: 0.2rem;
  float: left;
  line-height: 1rem;
}

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

</style>