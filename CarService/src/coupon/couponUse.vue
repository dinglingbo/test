<template>
</template>

<script>
	import {Group,Cell,} from 'vux'
	export default {
		
	  components: {
	    Group,
	    Cell
	  },
	  
	  data(){//存放数据对象，以此在元素标签里使用
	    return {
	    	msg: '',
	    	
	    }
	  },
	  created:function(){//初始化数据
	  	var couponArrayString = this.$route.query.couponArrayString;
	  	var openid = this.$route.query.openid;
    	const couponData = {'couponArrayString': couponArrayString,"openid":openid}
		localStorage.setItem('couponData', JSON.stringify(couponData));
	  	this.$router.push({
		    path:'/couponUseMain'
		})
	  },
	  
	  methods:{
	  	
	  	
	  },
	  
	  
	}
</script>

<style>
</style>