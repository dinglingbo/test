<template>
  <div id="app" class="car_service">
    <keep-alive v-if="bootstrap">
				    <router-view v-if="$route.meta.keepAlive" v-wechat-title="$route.meta.title"></router-view>
		</keep-alive>
				<router-view v-if="!$route.meta.keepAlive && bootstrap"></router-view>
  </div>
</template>

<script>
import axiosConfig from "./repuest/axiosConfig.js"
import api from "./Api/api.js"
import axios from 'axios'
export default {
		  data(){
				return{
						bootstrap :false
				}
			},
			created() {
					this.getToken();
					this.deleteOrderByTimeOut();
					let deviveWidth = window.screen.availWidth
      		document.documentElement.style.fontSize = `${deviveWidth / 7.5}px`
      		
			},
			methods:{
						//获取token
					getToken(){
							axios.post(api.getTokenApi,{password:"qxy.123",userId:"syswechat"}).then(response => {
							// axios.post(api.getTokenApi,{password:"000000",userId:"yx001"}).then(response => {
								 var  token = response.data.data.attributes.token;
								if(token){
									localStorage.setItem("token",token);
								 this.bootstrap = true
									
								} else {
									this.$vux.toast.text('加载中');
								}

							});
					},
					//删除锁定超时订单
					deleteOrderByTimeOut(){
						axios.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{});
					}

			}
}
</script>

<style lang="less">

@import '~vux/src/styles/reset.less';

body {
	/*主题色#368af4*/
	font-family: "微软雅黑" !important;
  background-color: #f4f3f8;
  color: #3F3F3F ;
  font-size: 0.28rem;
  }
/*取消input点击边框*/
input:focus{
  	outline: none;
	}



.nut-imagepicker .img-list .add-icon {
  border: none;
  background-color: #dcdcdc;
}

.nut-imagepicker .img-list .add-icon i {
  color: #ccc;
}

.nut-imagepicker .img-list .img-item a img {
  object-fit: contain;
}

.vux-rater-box .vux-rater-inner > span {
  color: transparent;
}

.vux-rater-box .vux-rater-inner {
  background-image: url(./assets/icons/icon_start1.png);
  background-repeat: no-repeat;
  background-size: contain;
}

.vux-rater-box.is-active .vux-rater-inner {
  background-image: url(./assets/icons/icon_start.png);
}
.weui-toast__content {
    font-size: 0.32rem;
}

</style>
