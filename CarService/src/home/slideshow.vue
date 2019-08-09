<template>
	<div id="slideshow">
		<div class="slideshow-item" v-for="(MessList,index) in SlideshowMessList" :key="index">
			<img class="slideshow-item-img" :src=" MessList.slideshowPictureUrl " @click="clickItemInfo(MessList.serviceItemId,MessList.serviceTypeId,MessList.serviceItemType,MessList.slideshowDetailType)" />
		</div>
	</div>
</template>

<script>
	import api from '../Api/api.js'
	import axios from 'axios'
export default{
	data(){
		return{
			SlideshowMessList:[],
			apiUrl:""
		}
			
	},
	watch: {
		'$route': 'getParams'
	},
	created(){
		this.apiUrl = api.getDms;
		this.getActivityImg();
	},
	methods:{
		getActivityImg(){
			var _that =this;
			let slideshowId = _that.$route.query.wxbSlideshowId;
			axios.post( api.SlideshowMessApi,{wxbSlideshowId:slideshowId,token:localStorage.token}).then(response=>{
				_that.SlideshowMessList = response.data.imgList;
				if (response.data.imgList.length === 0){
					_that.$vux.toast.text('暂无详情');
				}
			});
		},
		clickItemInfo(serviceItemId,serviceTypeId,serviceItemType,slideshowDetailType){
			if(slideshowDetailType == 1)return;
			var _this = this;
  			_this.$router.push({
				path:'/serviceMess',
				query: {
					serviceItemId:serviceItemId,
					serviceItemType:serviceItemType,
					serviceTypeId:serviceTypeId
				}
			});
		}
	}
}
</script>

<style>
	.slideshow-item-img{
		width: 100%;
		height: 100%;
	}
	.slideshow-item{
		width: 100%;
		height: 100%;
	}
</style>