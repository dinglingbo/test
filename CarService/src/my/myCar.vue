<template>
	<div id="myCar">
		<div v-if=" userCars.length <= 0 " style="text-align: center;margin-top: 20px;">
	 		<span> 暂无车辆 </span>
	 	</div>
				<div class="car" v-for="(userCarsItem, index) in userCars" :key="index">
					<!--车信息-->
					  <div class="car-head">
					  	 	<div class="car-show">
					  	 		<img class="car-show-img" src="../assets/img/宝马logo.png" />
					  	 	</div>
					  	 	<div class="car-mess">
					  	 		<div class="car-mess-head"><span class="car-mess-head-txt">{{userCarsItem.carNo}}</span></div>
					  	 		<div class="car-mess-body"><span class="car-mess-body-txt">{{userCarsItem.carModelName}}</span></div>
					  	 	</div >
					  </div>
					  <!--设置默认-->
					  <div class="car-body">
					  	<div class="car-delete" @click="deleteCar(userCarsItem.carId,index,userCarsItem.lastPatronageCar)" >
					  		<span class="car-delete-txt"  >删除</span>
					  	</div>
					  	<div v-if=" userCarsItem.lastPatronageCar == 0 " class="car-default">
					  		<span class="car-default-txt" >已设为默认车辆</span>
					  	</div>
					  	<div v-else class="car-default" @click="setCar(userCarsItem.carId,index,userCarsItem.carNo,userCarsItem.carModelId)"  >
					  		<span class="car-default-txt" style="color: #686868;" >设为默认车辆</span>
					  	</div>
					  </div>
				</div> 
				<!--添加-->
				<!-- <div class="addCar">
					<x-button class="makeapp-bot-ton" type="primary">
						<span>添加爱车</span >
		  			</x-button>
				</div> -->
        <btn-area fixed>
          <button @click="addCar">添加爱车</button>
        </btn-area>
	</div>
</template>

<script>
import axios from 'axios'
import api from "../Api/api.js"
import { XButton,AlertModule,ConfirmPlugin } from 'vux'
import BtnArea from '../component/btn-area.vue'
export default{
			components:{
				XButton,
        		AlertModule,
        		BtnArea
			},
			data(){
				return{
					userCars:[],

				}
			},
			 created(){
//			 	this.getToken();
				this.getUserCar();

			},
			methods: {
//					getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
					addCar(){
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
					  		this.$router.push({path: '/addCar'});
					  	}
					  	
					},
					//用户所有车辆
					getUserCar(){
			  		    var _that = this;
				    	axios.post(api.getUserCarsApi, {userId: localStorage.userId,token:localStorage.token}).then(function(response) {
				    		_that.userCars =  response.data.userGarageData;
							console.log(_that.userCars);
						});
					},
					//设置默认车辆
					setCar(carId,index,carNo,carModelId){
					    var _that = this;
					    axios.post(api.setCarApi, {userId: localStorage.userId,carId: carId,token:localStorage.token}).then(function(response) {
			    		 	var errCode =  response.data.errCode;
			    		 	console.log(response.data.errCode);
			    		 	if( errCode == "S" ){
			    		 		for(var u=0;u<_that.userCars.length;u++){
			    		 			_that.userCars[u].lastPatronageCar = 1;
			    		 		}
			    		 		_that.userCars[index].lastPatronageCar = 0;
			    		 		localStorage.setItem("userCarNo",carNo);
			    		 		localStorage.setItem("carModelId",carModelId);
			    		 		_that.$vux.toast.text( '设置成功');

			    		 	}else{
			    		 		 _that.$vux.toast.text( '设置失败');
			    		 	}

						});
					},
					//删除车辆
					deleteCar(carId,index,lastPatronageCar){
						var _that = this;
						debugger;
						if(lastPatronageCar == "0"){
							 _that.$vux.toast.text( '默认车辆无法删除');
						}else if(lastPatronageCar == "1"){
							_that.$vux.confirm.show({
								title: '系统提示',
        						content: '确定删除车辆？',
							  // 组件除show外的属性
							   onCancel () {},
							  onConfirm () {
							  		axios.post(api.deleteCarApi , {carId:carId,token:localStorage.token}).then(function(response){
									var errCode=response.data.errCode;
									if( errCode == "S" ){
										_that.userCars.splice(index,1);
										_that.$vux.toast.text( '删除成功');
									}else if( errCode == "E" ){
										 _that.$vux.toast.text( '删除失败');
									}
								}).catch(res=>{
									
								});
							  }
							})
						}


					}
			}
}

</script>

<style scoped="scoped">
	.car{
		margin-top:0.2rem ;
		border-radius:0.2rem ;
		margin-top:0.2rem;
		margin-left:2.5% ;
		background-color: #FFFFFF;
		width: 95%;
		height: 3rem;
	}
	.car-head{

		float: left;
		width: 100%;
		height: 2.2rem;
	}
	.car-show{
		height:100%;
		float: left;
		width: 30%;
		text-align: center;
	}
	.car-show-img{
		width: 1rem;
		height: 1rem;
		padding-top:0.4rem ;
	}
	.car-mess{
		float: left;
		width: 70%;
	}
	.car-mess-head{
		float: left;
		width: 95%;
		height: 0.6rem;
		margin-top:0.2rem ;
	}
	.car-mess-head-txt{
		color: #333333;
		font-size:0.36rem ;
	}
	.car-mess-body{
		float: left;
    	width: 95%;
      margin-top: 0.2rem;
    	line-height: 0.3rem;
	}
	.car-mess-body-txt{
		font-size:0.26rem ;
		color:#666666 ;
	}
	.car-mess-end{
		float: left;
		width: 95%;
		height: 0.6rem;
	}
	.car-mess-end-txt{
		font-size:0.26rem ;
		color:#666666 ;
	}

	/*设置*/
	.car-body{
		float: left;
		width: 100%;
		height: 0.8rem;
		border-top:0.02rem #f9f9f9 solid ;
	}
	.car-delete{
		float: left;
		width: 50%;
		text-align: center;
	}
	.car-default{
		float: left;
		width: 50%;
		text-align: center;
	}
	.car-delete-txt{
		line-height: 0.8rem;
		letter-spacing: 0.02rem;
	}
	.car-default-txt{
		letter-spacing: 0.02rem;
		line-height: 0.8rem;
		color: #3087F7;
	}
	/*添加*/
	.makeapp-bot-ton{

		background-color: #3087F7!important;
		width: 80% !important;
	}
	.addCar{
		margin-top: 0.8rem;
	}
</style>
