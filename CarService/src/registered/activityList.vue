<template>
	<div class="activityBoy">
		<div class="activityDiv" v-for="(storeActivityData, index) in storeActivityDataArray" @click="clickActivityUrl(storeActivityData.storeActivityUrl)" :key="index" >
			
			<span class="activitySpan" >{{storeActivityData.storeActivityTitle}}</span>
			
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
	    	storeActivityDataArray:[]
	    }
	  },
	  created:function(){//初始化数据
	  	var _this = this;
	  	if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前用户是否关联门店
  			_this.$vux.confirm.show({
		        title: '温馨提示',
		        content: '你还没有认证，请先认证。',
		        onCancel () {
		          	if( localStorage.storeId &&  localStorage.storeId != "undefined" &&  localStorage.storeId != "null" ){//判断当前用户虽然没有认证绑定，但已经有门店关系了
						_this.initData();
			  		}
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
			_this.initData();
		}
	  	
	  },
	  methods:{
	  	initData(){
	  		var _this = this;
	  		var map = {
	  			storeId:localStorage.storeId,
	  			storeActivityIsStart:1
	  		}
	  		axios.post(api.queryStoreActivityListApi,{map:map,token:localStorage.token}).then(response => {
				 var storeActivityDataArray = response.data.storeActivityDataArray;
				 _this.storeActivityDataArray = storeActivityDataArray;
			});
	  	},
	  	clickActivityUrl(url){
			window.location.href=url;
	  	}
	  	
	  },
	  
	  
	}
</script>

<style>
	body .activityBoy{
		padding: 0.2rem;
	}
	.activityDiv{
		background-image: url(../assets/activityBackground.jpg);
		background-repeat: round;
		margin-top: 0.4rem;
    	border-radius: 0.5rem;
    	height: 1.5rem;
   		text-align: center;
    	box-shadow: 0rem 0rem 0.18rem rgb(48, 135, 247);
	}
	.activitySpan{
		background-image: -webkit-gradient( linear, left top, right top, color-stop(0, #f22), color-stop(0.15, #f2f), color-stop(0.3, #22f), color-stop(0.45, #2ff), color-stop(0.6, #2f2), color-stop(0.75, #2f2), color-stop(0.9, #ff2), color-stop(1, #f22) );
    	color: transparent;
    	-webkit-background-clip: text;
		font-size: 0.65rem;
    	line-height: 1.5rem;
    	letter-spacing: 0.1rem;
	}
	
</style>