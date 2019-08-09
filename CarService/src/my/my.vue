<template>
	<div id="my">
		<!--个人信息-->
		<div class="my-background">
				<!--个人信息-->
				<div class="my-message" >

					<div class="my-head">
						<!--头像-->
						<div class="my-head-photo">
								<img class="my-head-photo-img" :src="userPhoto"/>
						</div>
						<!--信息-->
						<div class="my-head-mess">
							<div class="my-head-body">
								<div class="my-head-id">
									<span>{{userName}}</span>
								</div>
								<div class="my-head-balance">
									<span   >余额：</span><span>{{userMoney || '无'}}</span>
								</div>
								<div class="my-head-pone">
									<span >Tel：{{userPhone}}</span>
								</div>
							</div>

						</div>
						<!--修改信息-->
						<div class="my-head-amend" @click="goMyInformation">
							<div class="my-head-amend-show">
								<img  class="my-head-amend-img" src="../assets/img/icon_pingjia.png">
							</div>
						</div>
					</div>
					<!--车库 优惠卷-->
					<div class="my-concect">
						<div class="my-garage" @click="goMyCar">
							<div class="my-garage-photo">
								<div class="my-garage-show-div">
									<img class="my-garage-img-car" src="../assets/icons/icon_car.png">
								</div>
							</div>
							<div class="my-garage-show" >
								<div class="my-garage-show-div">
									<span class="my-garage-txt">我的车库</span>
								</div>
							</div>
						</div>
						<div class="my-discount" @click="goMyCoupon">
							<div class="my-garage-photo">
								<div class="my-garage-show-div">
									<img class="my-garage-img-coupon" src="../assets/img/icon_youhuiquan.png">
								</div>
							</div>
							<div class="my-garage-show-div" >
								<div class="my-garage-show-div">
									<span class="my-garage-txt">我的优惠券</span>
								</div>
							</div>
						</div>
					</div>
				</div>
		</div>



		<!--我的-->
		<div class="my-go">
			<group class="my-go-group" gutter="0" >
				<div class="my-go-cell">
					<cell is-link link="/myAccount" >
						<div class="my-go-title" slot="title">{{accountBook}}</div>
						<img slot="icon"  style="display:block;margin-right:0.1rem;width:0.4rem; height:0.4rem" src="../assets/img/icon_chezhangben.png"/>
					</cell>
				</div>
				<div class="my-go-cell">
					<cell is-link link="/myOrder">
						<div class="my-go-title" slot="title">{{order}}</div>
						<img slot="icon"  style="display:block;margin-right:0.1rem;width:0.4rem; height:0.4rem" src="../assets/img/icon_dingdan.png"/>
					</cell>
				</div>
				<div class="my-go-cell">
					<cell is-link link="/myAppointment">
						<div class="my-go-title" slot="title">{{appointment}}</div>
						<img slot="icon"  style="display:block;margin-right:0.1rem;width:0.4rem; height:0.4rem" src="../assets/img/icon_yuyue1.png"/>
					</cell>
				</div>
				<div class="my-go-cell" >
					<cell is-link link="/myMeal">
						<div  class="my-go-title" slot="title">{{meal}}</div>
						<img slot="icon"  style="display:block;margin-right:0.1rem;width:0.4rem; height:0.4rem" src="../assets/img/icon_taocan.png"/>
					</cell>
				</div>

			</group>
		</div>
	</div>
</template>

<script>
import api from '../Api/api.js'
import axios from 'axios'
import { Group, Cell } from 'vux'
	export default {
	  components: {
	  	Group,
	    Cell
	  },
	  	data(){
	  		return{
	  			userMoney:"",
	  			userName:"",
	  			userPhoto:"",
	  			userPhone:"",
	  			userInfo:[],
	  			accountBook:"我的车账本",
	  			order:"我的订单",
	  			appointment:"我的预约",
	  			meal:"我的套餐",
	  			apiUrl:"",
	  		}
	  	},
	  	created() {
//			this.getToken();
			this.apiUrl = api.getDms;
			this.getUserInfo();
			this.getMoney();
			this.deleteOrderByTimeOut();
		},
	  	methods: {
//	  		getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
			  		goMyCar(){
			  				this.$router.push({path: '/myCar'});
			  		},
			  		goMyInformation(){
			  			var _this = this;
					  	if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前用户是否缓存里有客户id，判断是否绑定
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
					  		this.$router.push({path: '/myInformation'});
					  	}
			  		},
			  		goMyCoupon(){
			  			this.$router.push({path: '/myCoupon'});
			  		},
			  		//查询用户信息
			  		getUserInfo(){
			  		    var _that = this;
			    		var userId = localStorage.userId;
			    		localStorage.getItem("key");
				    		axios.post(api.getInfoApi, {userId: userId,token:localStorage.token}).then(function(response) {
				    		 _that.userInfo=  response.data.myUserInfo ||[];
				    		 _that.userPhoto = _that.userInfo[0].userHeadPortrait;
				    		 _that.userName = _that.userInfo[0].userNickname;
				    		 _that.userPhone = _that.userInfo[0].userPhone;
						});
			  		},
			  			//查询用户余额
			  		getMoney(){
			  		    var _that = this;
			    		var guestId = localStorage.guestId;
			    		if( guestId && guestId != "undefined" && guestId != "null" ){
			    			axios.post(api.getMoneyApi, {guestId: guestId,token: localStorage.token}).then(function(response) {
				    		 _that.userMoney =  response.data.member[0].rechargeBalaAmt;
							});
			    		}
			  		},
		  			//删除锁定超时订单
					deleteOrderByTimeOut(){
						axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{});
					}
	  	}

	}
</script>

<style scoped="scoped">
	.my-background{
		float: left;
		width: 100%;
		background-image: url(../assets/img/bg1.png);
		 background-repeat:no-repeat;
		background-size:100% 3rem ;
	}
	.my-message{
		float: left;
		border-radius:0.2rem ;
		margin-top: 0.4rem ;
		background: #FFFFFF;
		width: 90%;
		height: 3.4rem;
		margin-left: 5%;
		margin-right: 5%;


	}
	.my-go{
		
	}
	.my-head{
		height: 2.6rem;
		width: 100%;
		/*background-color: rosybrown;*/
	}
	.my-concect{
		border-top: 0.02rem solid #f4f4f4;
		height:0.8rem;
		width: 100%;
		/*background-color: deepskyblue;*/
	}
	.my-head-photo{
		height: 100%;
		float: left;
		width: 40%;
		text-align: center;
		/*background: #04BE02;*/
	}
	.my-head-mess{
		height: 100%;
		float: left;
		width: 40%;
		/*background: salmon;*/
	}
	.my-head-amend{
		height: 100%;
		float: left;
		width: 20%;
	}
	/*头像*/
	.my-head-photo-img{
		margin-top: 0.3rem;
		height: 1.7rem;
		width: 1.7rem;
		border-radius:0.1rem ;
	}
	/*账号名 电话*/
	.my-head-body{
		margin-top:0.3rem;
	}
	.my-head-id{
		height:0.6rem ;
		font-weight: 550;
		letter-spacing:0.04rem;
	}
	.my-head-balance{
		height: 0.6rem;
	}
	.my-head-pone{
		height: 0.6rem;
	}
	/*修改*/
	.my-head-amend-show{
		text-align: center;
		height: 0.4rem;
		margin: 0.2rem auto;
	}
	.my-head-amend-img{
		width: 0.4rem;
		height: 0.4rem;
	}
	/*车库*/

	.my-garage{
		height: 100%;
		float:left;
		width: 49%;
		border-right: 0.02rem solid #e3e3e3;
	/*	background-color: #09BB07;*/
	}
	.my-discount{
		height: 100%;
		float:left;
		width: 49%;
		/*background-color: #09BB07;*/
	}
	.my-garage-photo{
		height: 100%;
		float: left;
		width: 40%;

		/*text-align: center;*/
	}
	.my-garage-img-car{
		width:0.46rem ;
		height: 0.46rem;
		float:right;
		padding-right: 0.2rem;
		  margin-top: 0.06rem;
	}
	.my-garage-img-coupon{
		    width: 0.4rem;
		    height: 0.4rem;
		    float: right;
		    padding-right: 0.2rem;
		    margin-top: 0.1rem;
	}
	.my-garage-show{
		height: 100%;
		float: left;
		width: 60%;
		/*text-align: center;*/
	}
	.my-garage-show-div{
		height:0.6rem;
		margin-top:0.1rem
	}
	.my-garage-txt{
		line-height: 0.6rem;
	}

	/*我的*/
	.my-go{
		margin-top:0.2rem ;
		float: left;
		width: 90%;
		margin-left: 5%;
		margin-right: 5%;
		border-radius: 0.3rem;
		height: 6.66rem;
		background: #FFFFFF;
	}
	.my-go-cell{
		border-bottom: 0.02rem solid #EDEDED;
	}
	.my-go-title{
		padding-left:0.2rem ;
	}

		/*箭头*/
	.weui-cell_access .weui-cell__ft:after {
		    height: 0.2rem !important;
		    width: 0.2rem !important;
		    border-width: 0.06rem 0.06rem 0 0 !important;
		    border-color: #C8C8CD !important;
		    margin-top: -0.16rem !important;
    }
</style>
