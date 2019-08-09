<template>
	<div id="carSeries">
		<group gutter="0" >
			<cell v-for="(carSeriess,index) in carSeriesLists " :key="index" @click.native="getCar(carSeriess.carModel,nameCXId,nameCTId,carSeriess.carModelId)">
				<div slot="title" class="carType-data-txt">
					 <span>
					 	{{carSeriess.carModel}}
					 </span>
				</div>
			</cell>
		</group>
	</div>
</template>

<script>
	import axios from 'axios'
	import api from "../Api/api.js"
	import {Cell,Group, } from 'vux'
	export default{
		components: {
			Cell,
			Group,
		},
		data(){
			return{
				carBrand:"",
				nameCX:"",
				nameCXId:"",
				nameCTId:"",
				carBrandName:"",
				carSeriesName:"",
				carSeriesLists:[],
			}
		},
		created(){
//			this.getToken();
			this.getParams();
			this.getCarSeries();
		},
		watch:{
		'$route':'getParams'
		},
		methods:{
//			getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
			getParams(){
				var routerParams = this.$route.query.nameCn	;
				var routerParamsCX = this.$route.query.nameCX;
				var routerParamsIdCX = this.$route.query.carBrandId;
				var routerParamsIdCT = this.$route.query.carSeriesId;
//				console.log(routerParams);
				this.carBrand = routerParams;
				this.nameCXId = routerParamsIdCX;
				this.nameCTId = routerParamsIdCT;
				this.nameCX = routerParamsCX;
				this.carSeriesName = this.$route.query.carSeriesName;
				this.carBrandName = this.$route.query.carBrandName;
			},
			//查车型
			getCarSeries(){
				var _that = this;
				axios.post(api.carSeriesApi,{carBrandId:this.nameCXId,carSeriesId:this.nameCTId,token:localStorage.token})
				.then(function(response){
							_that.carSeriesLists = response.data.data;
							//console.log(_that.carSeriesLists);
						},function(error){ 
				         
						 })
			},
			getCar(carModel,carBrandId,carSeriesId,carModelId){
       			var key = this.$route.query.key;
       			var carNo = this.$route.query.carNo;
		        sessionStorage.setItem('车型', JSON.stringify({
		          _key: key,
		          carNo:carNo,
		          carModel,
		          carBrandId,
		          carSeriesId,
		          carModelId,
		          carbrand: this.$route.query.nameCn,
		          carLine: this.$route.query.nameCX,
		          carBrandName:this.carBrandName,
		          carSeriesName:this.carSeriesName
		        }))
        		this.$router.go(-2)
			}
			
		}
	}
</script>
