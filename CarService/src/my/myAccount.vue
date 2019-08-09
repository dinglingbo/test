<template>
	<div id="myAccount">
		<div class="myAccount">
				<span class="myAccount-txt" >总计消费</span >
		</div>
		<div v-if=" listBig.length <= 0 " style="text-align: center;margin-top: 20px;">
	 		<span> 暂无消费</span>
	 	</div>
		<div style="float: left; width: 100%;" v-for="(listBigItem,index) in listBig" :key="index">
			<div  class="accont-years">
				<span class="accont-years-txt">{{splitYears(listBigItem[index].outDate)}}年</span>
			</div>
			<div class="account-body" v-for="(messItem,index) in listBig[index] ">
				<div style="float: left;width: 15%;height: 1.8rem;">
					<span style=" margin-left:0.2rem ;">{{splitData(messItem.outDate)}}</span>
				</div>	
				<div style="float: left;width: 5%;">
					<flow orientation="vertical" style="height:1.8rem;" >
								     <flow-state  :is-done="true" >
								     	
								     </flow-state>
								  	<flow-line :is-done="true" class="line"></flow-line>
					</flow>
				</div>
				<div class="account-end" >
					<div  class="account-mess" slot="title"  >
						<div class="mess-show">
							<div class="account-mess-car">
								<span class="account-mess-car-txt" >{{messItem.carNo}}，{{messItem.companyName}}</span>
							</div>	
							<div class="account-mess-money">
								<span class="account-mess-money-txt">金额：{{messItem.balaAmt}}元，里程：{{messItem.enterKilometers}}</span>
							</div>	
						</div>
						<div class="mess-go" @click="orderDetails(messItem.id,messItem.carNo,messItem.companyName,messItem.balaAmt,messItem.enterKilometers,messItem.outDate,messItem.serviceCode)">
							<img class="mess-go-img" src="../assets/img/leftArrow.png"  />
						</div>	
					</div>	
				</div>	
			</div>	
		</div>	
		
	</div>
</template>

<script>
import { Flow, FlowState, FlowLine } from 'vux'
import axios from 'axios'
import api from "../Api/api.js"
export default {
		 	 components: {
			    Flow,
			    FlowState,
			    FlowLine
		 	 },
		  	data(){
			  	return{
			  		listBig:[],
			  		apiUrl:"",
			  	}
		 	},
		 	created(){
//		 		this.getToken();
				if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前是否绑定用户
					//this.$vux.toast.text('暂无数据');
					return;
				}else{
					this.apiUrl = api.getDms;
					this.getAccount();
				} 
				
			},
			methods:{
//				getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
				getAccount(){
					var _that = this;
					var params={
						billTypeIds:"0,2,4",
						isSettle:1,
						isDisabled:0,
						guestId:localStorage.guestId,
						orgid:localStorage.orgid
					};
					axios.post(api.getAccountApi, {params:params , token:localStorage.token} ).then(function(response) {
			    			_that.forYear(response.data.list);
			    			if(response.data.list.length =="0"){
			    				//_that.$vux.toast.text('暂无数据');
			    			}
						});
				},
				forYear(list){
					var _that = this; 
					_that.listBig = [];
					var listSmall = [];
					var outDate = null;
					var year = null;
					if(list.length>0){
						for(var i = 0;i<list.length;i++){
							if(i==0){
								outDate = list[i].outDate;
								year = outDate.substring(0,4);
							}
							var outDate2 = list[i].outDate;
							var year2 = outDate2.substring(0,4);
							if(year==year2){
								listSmall.push(list[i]);
							}else{
								var tempList = listSmall;
								_that.listBig.push(tempList);
								 listSmall = [];
								outDate = list[i].outDate;
								year = outDate.substring(0,4);
								listSmall.push(list[i]);
								
							}
							if(i==(list.length-1)){
								var tempList = listSmall;
								_that.listBig.push(tempList);
							}
						}
						var a = [];
						a = _that.listBig[0];
						//车道租户id
						var tenantId = a[0].tenantId;
						//车道门店id
						var  orgid = a[0].orgid;
						console.log(tenantId,orgid);
						localStorage.setItem("tenantId",tenantId);
						localStorage.setItem("orgid",orgid);
					}
				},
				//获取日期
				splitData(obj){
					var a = [];
					var b = [];
					 a = obj.split(" ");
					 b = a[0].split("-");
					 return b[1] + "-" + b[2]
				},
				//获取年份
				splitYears(obj){
					var a = [];
					var b = [];
					 a = obj.split(" ");
					 b = a[0].split("-");
					 return b[0]
				},
				//详情
				orderDetails(id,carNo,companyName,enterKilometer,balaAmt,outDate,serviceCode){
					var _that = this;
					//缓存会话缓存
					sessionStorage.setItem('accountMessData',JSON.stringify({
						serviceId:id ,
						carNo:carNo,
						companyName:companyName,
						enterKilometer:enterKilometer,
						balaAmt:balaAmt,
						outDate:outDate,
						serviceCode:serviceCode
					}));
					debugger;
					_that.$router.push({ 	
					path:'./myAccountMess',
					query: {
						serviceId:id,
						carNos:carNo,
						//公司名
						companyNames:companyName,
						//公里数
						enterKilometers:enterKilometer,
						//钱
						balaAmt:balaAmt,
						//下单时间
						outDate:outDate,
						//单号
						serviceCode:serviceCode,
						}
					})
				}
				
			}
}
</script>

<style>
	.myAccount{
		width: 100%;
		height: 0.6rem;
		background-color: #3087F7;
		text-align: center;
		
	}
	.myAccount-txt{
		letter-spacing: 0.04rem;
		line-height: 0.6rem;
		color: #FFFFFF;
	}
	.weui-wepay-flow, .weui-wepay-flow-auto{
		padding: 0rem !important;
	}
	.weui-wepay-flow__bd{
     -webkit-align-items: none !important; 
     align-items: normal !important; 
	}
	.weui-wepay-flow_vertical .weui-wepay-flow__process{
		width:0.04rem !important;
	}
	.weui-wepay-flow__li_done .weui-wepay-flow__state{
		background-color:#3087F7 !important;
	}
	.weui-wepay-flow__process{
		background-color:#3087F7 !important;
	}
	.line{
		 margin-left: 0.12rem;
	}
	/*年份*/
	.accont-years{
		float: left;
		width: 100%;
		height: 0.8rem;
	}
	.accont-years-txt{
		font-size:0.36rem ;
		line-height: 0.8rem;
		margin-left: 0.2rem;
	}
	/*消费*/
	.account-body{
		/*padding-top: 10px;/*/
		float: left;
		width: 100%;
		background-color: #FFFFFF !important;
	}
	.account-end{
		float: left;
		width: 80%;
		height: 1.2rem;
	}
	.account-mess{
		width: 95%;
		height: 1.4rem; 
		border:0.02rem solid #E3E3E3;
		border-radius: 0.1rem;
		float: left;
		margin-top:0.1rem ;
	}
	.mess-show{
		float: left;
		width: 90%;
	}
	.mess-go{
		float:left;
		width: 10%;
		height: 100%;
		text-align: center;
	}
	.mess-go-img{
		margin-top: 0.4rem;
		  width: 0.6rem;
    	height: 0.6rem;
	}
	.account-mess-car{
		float: left;
		width: 100%;
		height: 0.8rem;
	}
	.account-mess-money{
		float: left;
		width: 100%;
		height: 0.6rem;
	}
	.account-mess-car-txt{
		padding-left: 0.1rem;
		line-height: 0.8rem;
	}
	.account-mess-money-txt{
		padding-left: 0.1rem;
		font-size:0.26rem ;
		line-height: 0.6rem;
	}
</style>