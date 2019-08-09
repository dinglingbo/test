<template>
</template>

<script>
	import axios from 'axios'
	import {Group,} from 'vux'
	import api from '../Api/api.js'
	export default {
		
	  components: {
	    Group
	  },
	  
	  data(){//存放数据对象，以此在元素标签里使用
	    return {
	    	
	    }
	  },
	  created:function(){//初始化数据
	  	var _this = this;
	  	var weChatMenuStirng = this.$route.query.weChatMenuStirng;
	  	
	  	var carId = this.$route.query.carId;
	  	var carModelId = this.$route.query.carModelId;
	  	var carid = this.$route.query.carid;
	  	var userCarNo = this.$route.query.userCarNo;
	  	var guestId = this.$route.query.guestId;
	  	var openId = this.$route.query.openid;
	  	var orgid = this.$route.query.orgid;
	  	var storeId = this.$route.query.storeId;
	  	var storeName = this.$route.query.storeName;
	  	var tenantId = this.$route.query.tenantId;
	  	var userId = this.$route.query.userId;
	  	var userPhone = this.$route.query.userPhone;
	  	
    	localStorage.setItem("carId",carId);
		localStorage.setItem("carModelId",carModelId);
		localStorage.setItem("carid",carid);
		localStorage.setItem("userCarNo",userCarNo);
		localStorage.setItem("guestId",guestId);
		localStorage.setItem("openId",openId);
		localStorage.setItem("orgid",orgid);
		localStorage.setItem("storeId",storeId);
		localStorage.setItem("storeName",storeName);
		localStorage.setItem("tenantId",tenantId);
		localStorage.setItem("userId",userId);
		localStorage.setItem("userPhone",userPhone);
		debugger;
		axios.post(api.menuDicApi, {dictName:weChatMenuStirng,token:localStorage.token}).then(function(response) {
    		var data = response.data.dictDataArray[0];
	      	_this.$router.push({
		  	  	path:data.dictUrl
			})
		});
		
	  	
	  },
	  
	  methods:{
	  	
	  	
	  },
	  
	  
	}
</script>

<style>
</style>