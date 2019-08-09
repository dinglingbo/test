<template>
	<div id="myAccountMess">
			<x-dialog v-model="showHideOnBlurComm" hide-on-blur>
  				<div class="img-box">
          			<img :src="tempImgUrl" style="max-width:100%">
        		</div>
			</x-dialog>
			<div class="myAccountMess-title">
				<div class= "title-show">
					<img class="title-show-img" src="../assets/img/宝马logo.png"  />
				</div>
				<div class="title-car">
					<span class="title-car-txt">{{carNos}}</span>
				</div>
				<div class="title-money">
					<span class="title-money-txt">消费金额：￥{{enterKilometers}}</span>
				</div>
			</div>
			<div class="body-title headText" style="">
				<span class="body-title-txt">项目</span>
			</div>
			<div class="myAccountMess-body" v-for="(itemDetailsItem ,index) in itemDetails" >
				 <div class="body-title">
				 	<span class="body-title-txt">{{itemDetailsItem.itemName}}</span>
				 </div>
				<!-- <div class="body-parts">
				 	<span class="body-parts-txt" >项目配件明细</span>
				 </div>-->
				 <div class="body-details" v-for="(partListItem,indexs) in itemDetails[index].partList" >
				 	<div class="body-details-left"><span class="body-details-left-txt">{{partListItem.partName}}</span></div>
				 	<div class="body-details-right"><span class="body-details-right-txt" >x{{partListItem.qty}}</span></div>
				 </div>
			</div>
			<div class="body-title headText" :style=" pkgList.length > 0 ? 'display: block;' : 'display:none' " >
				<span class="body-title-txt">套餐</span>
			</div>
			<div class="myAccountMess-body" v-for="(pkgData ,indexss) in pkgList" :key="index" :style=" pkgList.length > 0 ? 'display: block;' : 'display:none;' " >
				 <div class="body-title">
				 	<span class="body-title-txt">{{pkgData.packageName}}</span>
				 </div>
				<!-- <div class="body-parts">
				 	<span class="body-parts-txt" >项目配件明细</span>
				 </div>-->
				 <div class="body-details" v-for="(partListItem,index) in pkgData.itemList" >
				 	<div class="body-details-left"><span class="body-details-left-txt">{{partListItem.itemName}}</span></div>
				 	<div class="body-details-right"><span class="body-details-right-txt" >x{{partListItem.itemTime}}</span></div>
				 </div>
				 
				 <div class="body-details" v-for="(partListData,index) in pkgData.partList" >
				 	<div class="body-details-left"><span class="body-details-left-txt">{{partListData.partName}}</span></div>
				 	<div class="body-details-right"><span class="body-details-right-txt" >x{{partListData.qty}}</span></div>
				 </div>
				 
			</div>
			
			<div class="myAccountMess-order">
				<div class="order-mess">
					<span class="order-mess-txt">工单号：{{serviceCode}}</span>
				</div>
				<div class="order-mess">
					<span class="order-mess-txt">时间：{{splitData(outDate)}}</span>
				</div>
				<div class="order-mess">
					<span class="order-mess-txt">门店：{{companyNames}}</span>
				</div>
				<div class="order-mess">
					<span class="order-mess-txt">进场里程数：{{balaAmt}}</span>
				</div>
			</div>
			<div class="service-before" :hidden=" serviceBeforePhotoArray.length > 0 ? false : true " >
				<div class="service-before-title">
					<span class="service-before-title-txt">服务前</span>
				</div>
				<div class="service-before-show">
					<div class="service-later-show-a" v-for="(serviceBeforePhoto,index) in serviceBeforePhotoArray" :key="index">
						<img  class="service-later-show-img" :src="serviceBeforePhoto.attachName" />
					</div>
				</div>
			</div>
			<div class="service-later" :hidden=" serviceAfterPhotoArray.length > 0 ? false : true ">
				<div class="service-later-title">
					<span class="service-later-title-txt">服务后</span>
				</div>
				<div class="service-later-show">
					<div class="service-later-show-a" v-for="(serviceAfterPhoto,index) in serviceAfterPhotoArray" :key="index">
						<img  class="service-later-show-img" :src="serviceAfterPhoto.attachName" />
					</div>
					
				</div>
			</div>
			<div class="evaluate" style="padding-bottom: 0.3rem;" v-if="showPjBut">
					<x-button class="makeapp-bot-ton" type="primary" @click.native="appraiseOrders">
						<span>评价此服务</span >
		  			</x-button>
			</div>
			<!--详情-->
			<div class="store-appraise" v-else>
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
	</div>
</template>

<script>
import axios from 'axios'
import api from "../Api/api.js"
import { Flexbox,FlexboxItem,XButton,AlertModule,XDialog} from 'vux'
export default{
	components:{
				Flexbox,
				FlexboxItem,
				XButton,
				AlertModule,
				XDialog
			},
			data(){
				return{
					index:0,
					userCars:[],
//					itemList:[],
//					mealList:[],
					itemDetails:[],
					carNos:"",
					serviceId:"",
					companyNames:"",
					enterKilometers:"",
					balaAmt:"",
					outDate:"",
					serviceCode:"",
					apiUrl:"",
					evaluateList:[],
					showPjBut:true,
					showHideOnBlurComm:false,
					tempImgUrl:'',
					pkgList:[],//套餐
					serviceBeforePhotoArray:[],//服务前照片
					serviceAfterPhotoArray:[]//服务后照片
				}
			},
			watch: {
				'$route': 'getParams'
			},
			created(){
//				this.getToken();
				this.apiUrl = api.getDms;
				this.getSerciveId();
				this.getEvaluateList();

			},
			methods:{
//				getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
					getSerciveId(){
						var  _that = this ;
						//订单详情id
						var  serviceId = _that.$route.query.serviceId;
						_that.carNos = _that.$route.query.carNos;
						_that.companyNames = _that.$route.query.companyNames;
						//公里数
						_that.enterKilometers = _that.$route.query.enterKilometers;
						//订单金额
						_that.balaAmt = _that.$route.query.balaAmt;
						//订单日期
						_that.outDate = _that.$route.query.outDate;
						//单号
						_that.serviceCode = _that.$route.query.serviceCode;
						//查询工单
						_that.getParts(serviceId);
						
					},
					//查工单明细
					getParts(id){
						var _that = this;
						axios.post(api.orderDetailsApi, {serviceId:id , token:localStorage.token} ).then(function(response) {
			    			//项目
			    			_that.itemDetails = response.data.data.itemList;
			    			//套餐
			    			_that.pkgList = response.data.data.pkgList;
			    			
			    			console.log( response.data.data.itemList);
			    			console.log(_that.itemDetails[0].partList);
			    			
			    			//查询帐本服务前后照片
			    			axios.post(api.orderCommentPhotoApi, {serviceId:id ,token:localStorage.token} ).then(function(response) {
			    				var photoArray = response.data.data;
			    				for(var a=0;a<photoArray.length;a++){
			    					if( photoArray[a].type == "1" ){
			    						_that.serviceBeforePhotoArray.push( photoArray[a] );
			    					}else{
			    						_that.serviceAfterPhotoArray.push( photoArray[a] );
			    					}
			    				}
							});
			    			
			    			
			    			
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
			    		return axios.post(api.evaluateListApi,{storeId:localStorage.storeId,page:page,serviceId:_that.$route.query.serviceId,token:localStorage.token}).then(function(response){
			    			//门店所有评价
			    			_that.evaluateList.push(...response.data.evaluateList);
			    			if(response.data.evaluateList.length > 0){
			    				_that.showPjBut = false;
			    			}
			    			return  response.data.page.isLast;
			    		})
			    	},	
			    	showItemImager(e){
						this.tempImgUrl = e;
						this.showHideOnBlurComm = true;
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
					//格式化日期
					splitData(obj){
							var a = [];
							var b = [];
							var c = [];
							if(typeof obj === 'string'){
							 a = obj.split(" ");
							 b = a[0].split("-");
							 c = a[1].split(":");
							} else {
                return ''
             	 }
							 return  b[0]+"-"+b[1] + "-" + b[2] +" " + c[0] +":" + c[1]
					},
					appraiseOrders(){
						var _that = this;
						_that.$router.push({
						path:'./myComment',
						query: {
							serviceId:_that.$route.query.serviceId,
							storeId:localStorage.storeId
							}
						})
						}
			}
}
</script>

<style scoped="scoped">
	.headText{
		margin-top: 0.2rem;
		background: #fff;
	    border-bottom: 1px solid #ccc;
	    font-size: 0.29rem;
	    font-weight: bolder;
	}
	.myAccountMess-title{
		float: left;
		width: 100%;
		height: 0.8rem;
		background-color: #FFFFFF;
		border-bottom: 0.02rem solid #EDEDED;
	}

	.title-show{
		float: left;
		width: 10%;
		height: 100%;
	}
	.title-show-img{
		float: left;
		width: 0.5rem;
		height: 0.5rem;
		padding-top: 0.14rem;
		padding-left: 0.2rem;
	}
	.title-car{
		float: left;
		width: 45%;
		height: 100%;
	}
	.title-car-txt{
		padding-left: 0.1rem;
		line-height: 0.8rem;

	}
	.title-money{
		float: left;
		width: 45%;
		height: 100%;
	}
	.title-money-txt{
		/*float: right;*/
		line-height: 0.8rem;
	}
	/*配件明细*/
	.myAccountMess-body{
		float: left;
		width: 100%;
		background-color: #FFFFFF;
	}
	.body-title{
		float: left;
		width: 100%;
		height: 0.6rem;

	}
	.body-title-txt{
		margin-left: 0.2rem;
		line-height: 0.6rem;
	}
	.body-parts{
		float: left;
		width: 100%;
		height: 0.6rem;

	}
	.body-parts-txt{
		margin-left: 0.5rem;
		line-height: 0.6rem;
	}
	.body-details{
		float: left;
		width: 100%;
		height: 0.6rem;
	}
	.body-details-left{
		float: left;
		width: 50%;
		/*padding-left: 10px;*/
		line-height: 0.6rem;
		color: rgba(63, 63, 63, 0.56);
	}
	.body-details-left-txt{
		padding-left: 0.5rem;
		line-height: 0.6ren;
	}
	.body-details-right{
		float: left;
		width: 50%;
		color: rgba(63, 63, 63, 0.56);
	}
	.body-details-right-txt{
		padding-right: 0.2rem;
		line-height: 0.6rem;
		float: right;
	}
	/*订单*/
	.myAccountMess-order{
		float: left;
		width: 100%;
		height: 2.5rem;
		margin-top: 0.2rem;
		background-color: #FFFFFF;
	}
	.order-mess{
		float: left;
		width: 100%;
		height: 0.6rem;
	}
	.order-mess-txt{
		line-height: 0.6rem;
		margin-left: 0.2rem;
	}
	/*服务图片*/
	.service-before{
		margin-top:0.2rem ;
		float: left;
		width: 100%;
		background-color: #FFFFFF;
	}
	.service-before-title{
		float: left;
		width: 100%;
		height: 0.8rem;
	}
	.service-before-title-txt{
		font-size: 0.36rem;
		margin-left:0.2rem ;
		line-height: 0.8rem;
	}
	.service-before-show{
		float: left;
		width: 100%;
		border-top: 0.02rem solid #EDEDED;

	}
	.service-before-show-a{
		float: left;
		width: 33.33%;
		height:2rem ;
		text-align:center ;
	}
	.service-before-show-img{
		margin-top: 0.3rem;
		height: 1.4rem;
		width: 1.4rem;
	}
	.service-later{
		margin-top:0.2rem ;
		float: left;
		width: 100%;
		background-color: #FFFFFF;
	}
	.service-later-title{
		float: left;
		width: 100%;
		height: 0.8rem;
	}
	.service-later-title-txt{
		font-size: 0.36rem;
		margin-left:0.2rem ;
		line-height: 0.8rem;
	}
	.service-later-show{
		float: left;
		width: 100%;
		border-top: 0.02rem solid #EDEDED;

	}
	.service-later-show-a{
		float: left;
		width: 33.33%;
		height:2.4rem ;
		text-align:center ;
	}
	.service-later-show-img{
		margin-top: 0.2rem;
		height: 2rem;
		width: 2rem;
	}
	/*评价*/
	.makeapp-bot-ton{

		background-color: #3087F7!important;
		width: 80% !important;
	}
	.evaluate{
		float: left;
		width: 100%;
		margin-top: 0.8rem;
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
   		font-size: 0.36rem;
	    margin-left: 0.2rem;
	    line-height: 0.8rem;
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
</style>
