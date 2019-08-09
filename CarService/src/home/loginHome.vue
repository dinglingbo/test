<template>
</template>

<script>
	import axios from 'axios'
	import {Group,} from 'vux'
	export default {
		
	  components: {
	    Group
	  },
	  
	  data(){//存放数据对象，以此在元素标签里使用
	    return {
	    	
	    }
	  },
	  created:function(){//初始化数据
	  	var userId = this.$route.query.userId;
	  	var userPhone = this.$route.query.userPhone;
	  	var guestId = this.$route.query.guestId;
	  	var openid = this.$route.query.openid;
    	localStorage.setItem("userId",userId);
		localStorage.setItem("userPhone",userPhone);
		localStorage.setItem("guestId",guestId);
		localStorage.setItem("openId",openid);
	  	this.$router.push({
		    path:'/home'
		})
	  },
	  
	  methods:{
	  	
	  	
	  },
	  
	  
	}
</script>

<style>
</style>