<template>
	<div id="myMeal">
		 <div class="myMeal">
		 	<div v-if="showNullBool" style="text-align: center;margin-top: 20px;">
		 		<span>你还没有套餐卡哦！</span>
		 		<span>^_^</span>
		 	</div>
		 	  <div class="myMeal-show" v-for="(userMealItem, index) in userMeal">
					<div class="meal-photo">
						<img  class="meal-photo-img" src="../assets/imgCs/1552568418(1).jpg" />
					</div>
					<div class="meal-mess">
						<div class="meal-mess-title">
							<span class="meal-mess-title-txt">{{userMealItem.cardName}} </span>
						</div>
						<div v-if="userMealItem.showBool" class="meal-mess-body">
							<span class="meal-mess-body-txt"> 过期时间：{{splitData(userMealItem.pastDate)}}</span>
						</div>
						<div v-else class="meal-mess-body">
							<span class="meal-mess-body-txt">永久有效</span>
						</div>
						<div class="meal-mess-end">
							<span class="meal-mess-end-txt"> 车牌号：{{userMealItem.carNo}}</span>
						</div>
					</div>	
		 	  </div>	
		 </div>
	</div>
</template>

<script>
import api from '../Api/api.js'
import axios from 'axios'
export default{
	data(){
				return{
					userMeal:[],
					showNullBool:false
				}
			},
			created(){
//				this.getToken();
				if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前是否绑定用户
					this.showNullBool=true;
					return;
				}else{
					this.$vux.loading.show({text: 'Loading'});
					this.getMeal();
				}
			},
			methods:{
//					getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
						//全部套餐
						getMeal(){
							
						   var _that = this;
							axios.post(api.getMealApi,{guestId:localStorage.guestId,orgid:localStorage.orgid,token: localStorage.token}).then(function(response) {
				    			_that.userMeal = response.data.data;
				    			if(_that.userMeal.length <= 0){
				    				_that.showNullBool=true;
				    			};
				    			for(var a=0;a<_that.userMeal.length;a++){
				    				_that.userMeal[a].showBool = false;
				    				if(_that.userMeal[a].pastDate){
				    					_that.userMeal[a].showBool = true;
				    				}
				    			}
				    			_that.$vux.loading.hide();
							});
						},
						splitData(obj){
							var a = [];
							var b = [];
							if(obj !== null){
							 a = obj.split(" ");
							 b = a[0].split("-");
							 return  b[0]+"-"+b[1] + "-" + b[2]
							} 
					
						},

			}
}
</script>

<style scoped="scoped">
	.myMeal{
	   float: left;
	   width: 100%;
	}
	.myMeal-show{
		height:2.4rem;
		float: left;
		width: 92%;
		margin-left:4% ;
		margin-right: 4%;
		margin-top:0.2rem;
		background: #FFFFFF;
		border-radius:0.2rem;
	}
	.meal-photo{
		float: left;
	   width: 40%;
	   height: 100%;
	   text-align: center;
	   
	}
	.meal-photo-img{
		margin-top:0.3rem;
		height: 1.8rem;
		width: 1.8rem;	
		border-radius:0.1rem;
	}
	.meal-mess{
		float: left;
	   width: 60%;
	}
	.meal-mess-title{
		float: left;
	   width: 100%;
	   height: 0.6rem;
	   margin-top: 0.3rem;
	}
	.meal-mess-body{
		float: left;
	   width: 100%;
	      height: 0.6rem;
	}
	.meal-mess-end{
		float: left;
	   width: 100%;
	      height: 0.6rem;
	}
	.meal-mess-title-txt{
		line-height: 0.6rem;
		font-weight: 600;
		letter-spacing:1px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	.meal-mess-body-txt{
		line-height: 0.6rem;
		/*font-weight: 600;*/
		letter-spacing:1px;
		font-size: 0.3rem;
	}
	.meal-mess-end-txt{
		line-height: 0.6rem;
		/*font-weight: 600;*/
		letter-spacing:1px;
		font-size: 0.3rem;
	}
	
</style>