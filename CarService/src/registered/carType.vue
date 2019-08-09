<template>
	<div id="carType">
	   <div class="carType-tabe">
		   	<div  v-for="(carBrandList, index) in carBrandList" :key="index">
		   		<span @click="returnTop(carBrandList.code)"  > {{carBrandList.code}}</span>
		   	</div>
	   </div>
	   <div class="carType-data" v-for="(carBrandList, index) in carBrandList"  >
	   		<div class="carType-data-title" :id="carBrandList.code" ><span>{{carBrandList.code}}</span></div>
	   		<group v-for="(carBrandLists,index) in carBrandList.dataArray" :key="index"   gutter="0rem" >	   		
				   	<cell  	is-link
						    :border-intent="false"
						   	:arrow-direction="shows.direction"
						    @click.native="groupShow(carBrandLists.id)"
				   			  >
				   	      <div slot="title" class="carType-data-txt">品牌：{{carBrandLists.nameCn}}</div>
				   	      <!--<img slot="icon" width="20" height="20" src="../assets/imgCs/方向盘.png" />-->
				   	</cell>
				   	<div>
				   		<template v-if="shows.show && carBrandLists.id == shows.id " v-for="(carBrandIdList,index) in carBrandIdList"  >
					        <div :border-integroupShow.nt="false" :class="shows.show?'animate':''" class="sub-item" @click="goToSDetails(carBrandIdList.carBrandId,carBrandIdList.carSeriesId,carSeriesList.carModel,carBrandLists.nameCn,carBrandIdList.name,carBrandIdList.carBrandName,carBrandIdList.carSeriesName)" >
					        	<span class="sub-item-txt">
					        		{{carBrandIdList.name}}
					        	</span>
		   					</div>
				    	</template>
				   	</div>
		   	</group>
	   </div>
	</div>
</template>

<script>
	import axios from 'axios'
	import api from "../Api/api.js"
	import {Cell,Group,Actionsheet } from 'vux'
	export default{
		components: {
			Cell,
			Group,
			Actionsheet,
		},
		data(){
			return{
				carBrandList:[],
				carBrandIdList:[],
				carSeriesList:[],
				shows:{
					id:0,
					show:false,
					direction:"down",
				},


			}
		},
		created(){
//			this.getToken();
	        this.getCarBrand();   //定义方法

	      	},
		methods:{
//			getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
			getCarBrand:function(){
				  var _that = this;
				  var params= {fromDb:true};
				 axios.post(api.carBrandApi,{params:params,token:localStorage.token})
				  .then(function(response){ //接口返回数据
				  	var data = response.data.data;//console.log(data[a].firstCode,data[a].name);				console.log(response.data,response.data.data);
				  	var codeArray=[];
				  	for(var a=0;a<data.length;a++){
				  		//排除所有
				  		if(data[a].name == '所有'){
				  			continue;
				  		}
				  		var bool=true;
				  		if( a==1 ) codeArray[0] = data[a].firstCode;//测试 : a==0                正式：a==1
				  		for(var b=0;b<codeArray.length;b++){
				  			if( data[a].firstCode == codeArray[b] ){
				  				bool=false;
				  			}
				  			if( b == codeArray.length-1 && bool && data[a].firstCode != null){
				  				codeArray.push(data[a].firstCode);
				  			}
				  		}
				  	}

				  	for(var a=0;a<codeArray.length;a++){
				  		for(var b=0;b<codeArray.length;b++){
				  			if( codeArray[a] != null && codeArray[b] != null && codeArray[a].charCodeAt() < codeArray[b].charCodeAt() ){
				  				var index=codeArray[a];
				  				codeArray[a] = codeArray[b];
				  				codeArray[b]=index;
				  			}
				  		}
				  	}

				  	var array=[];
				  	for(var c=0; c<codeArray.length;c++){
				  		var dataArray=[];
				  		for(var d=0;d<data.length;d++){
				  			if( codeArray[c] == data[d].firstCode ){
				  				dataArray.push(data[d]);
				  			}
				  			if(d == data.length-1){
				  				array[c]={
						  			code:codeArray[c],
						  			dataArray:dataArray,
						  		}
				  			}
				  		}
				  	}
		            _that.carBrandList = array ;
		          },function(error){ 
		          })
			},

			//首字母定位
			returnTop(i){
				var id="#"+i
				document.querySelector(id).scrollIntoView(true);
			},
			//查找车型
			goToSDetails(a ,b,c,d,e,carBrandName,carSeriesName){
				var _that = this;
				axios.post(api.carSeriesApi,{carBrandId:a,carSeriesId:b,token:localStorage.token})
				.then(function(response){
					debugger;
              var key = _that.$route.query.key;
              var carNo = _that.$route.query.carNo;
              debugger;
							_that.carSeriesList = response.data.data;
							if( _that.carSeriesList.length == 0 ){
								debugger;
				                sessionStorage.setItem('车型', JSON.stringify({
				                  	_key: key,
				                  	carNo:carNo,
				                  	carBrandId:a,
								  	carSeriesId:b,
									carbrand:d,
									carLine:e,
									carBrandName:carBrandName,
									carSeriesName:carSeriesName
				                }))
								_that.$router.go(-1)
							}else{
								_that.$router.push({
								    path:'./carSeries',
								    query:{
                      					key: key,
                      					carNo:carNo,
								    	carBrandId:a,
								    	carSeriesId:b,
									    nameCn:d,
									    nameCX:e,
									    carBrandName:carBrandName,
									    carSeriesName:carSeriesName
								    }
								})
						  	}

						},function(error){ 
					           
						})


			},
			//查找车系
			groupShow(carId){
					this.carBrandIdList = [];
				if(this.shows.show == false){
						this.shows.show = true;
						this.shows.id = carId;
//						console.log(carId);
						var _that = this;
						axios.post(api.getcarBrandIdApi,{carBrandId:carId,fromDb:true,token:localStorage.token})
						.then(function(response){debugger;
							_that.carBrandIdList = response.data.data;
							//console.log(_that.carBrandIdList);
						},function(error){ 
				         
						 })
				}else{
					this.shows.show = false;
				}
			},
		}

	}
</script>

<style scoped="scoped">

	.carType-tabe{
		z-index: 99;
		padding-top: 0.1rem;
		/*float: right;*/
		position:fixed ;
		height: 100%;
		left: 0.2rem;
		/*width: 5%;*/
		padding-right:0.6rem ;
		color: #878786;
		/*background-color: #fff;*/
	}

	.carType-data{

		padding-left: 0.8rem;
		/*overflow-x: hidden*/
		/*position: relative;
		left: 0;
		top: 0;
		width: 100%;*/
	}
	.carType-data-title{
		margin-left: 0.4rem;
	}
	.carType-data-txt{
	}
	.sub-item{
		height: 0.75rem;
		/*background-color: #9e99fd;*/
		border-bottom: 1px solid #D9D9D9;
		margin-top: 0.1rem;
		/*text-align: center;*/
		padding: 0 0.4rem;
		  overflow: hidden;
		  max-height: 0;
		  transition: max-height .5s cubic-bezier(0, 1, 0, 1) -.1s;
		}
	.sub-item-txt{
		line-height: 0.7rem;
		width: 1rem;
		color: #333333;
		/*background-color: #1AAD19;*/
	}
	.animate {
	  max-height: 9999rem;
	  transition-timing-function: cubic-bezier(0.5, 0, 1, 0);
	  transition-delay: 1s;
	}
</style>
