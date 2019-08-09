<template>
	<div id="registered">
		<div >
			<group class="registered-group" gutter="0"  >
					<div class="registered-pho"  >
 						<div class="registered-pho-div" >
 							<img class="registered-pho-img" src="../assets/icons/acc.png" style="margin-right: 0.1rem;width: 0.5rem; height: 0.5rem;"  />
 						</div>
 						<div class="registered-pho-nbm" style="line-height: 0.85rem;">
 							<span class="registered-pho-nbm-txt">用户名：</span >
 						</div>
 						<div class="registered-pho-input" >
							<x-input  class="inpitAll"   v-model="account"    placeholder="请输入账号"  >
							</x-input>
						</div>
			 		</div>
			 		<div class="registered-pho"  >
 						<div class="registered-pho-div" >
 							<img class="registered-pho-img" src="../assets/icons/pass.png" style="margin-right: 0.1rem;width: 0.52rem; height: 0.52rem;"  />
 						</div>
 						<div class="registered-pho-nbm" style="line-height: 0.85rem;">
 							<span class="registered-pho-nbm-txt">密码：</span >
 						</div>
 						<div class="registered-pho-input" >
							<x-input  class="inpitAll" type="password" v-model="password"    placeholder="请输入密码"  ></x-input>
						</div>
			 		</div>
			</group>
		</div>
    <car-number-picker ref="picker" />
		<!--保存-->
		<div class="registered-button">
				<x-button type='primary' class="registered-button-save" @click.native="submitLogin()">认证</x-button>
		</div>
	</div>
</template>

<script>
import api from '../Api/api.js'
import axios from 'axios'
import licencePlate from '../assets/icons/icon_car.png'
import authCode from '../assets/icons/icon_yanzhengma.png'
import phone from '../assets/icons/icon_phone.png'
import CarNumberPicker from '../component/car-number-picker.vue';
import { XHeader,Group, XInput,XButton,Alert,AlertModule,Cell,Radio} from 'vux'
import wx from 'weixin-js-sdk';
export default{
	components:{
    CarNumberPicker,
		Group,
		XInput,
		XButton,
		XHeader,
		Alert,
		AlertModule,
		Cell,
		Radio
	},
	data(){
		return{
			account:"",
			password:"",
			openId:""
		}
	},
	created(){
		var _this=this;
		_this.openId = _this.$route.query.openId;
		console.log(_this.openId);
  	},
  	methods:{
	  	//登录
	  	submitLogin(){
	  		debugger;
	  		var _this = this;
	  		var account = _this.account;
	  		var password = _this.password;
	  		console.log(account,password);
		   	axios.get(api.authenticationApi+"?userId="+account+"&password="+password+"&token="+localStorage.token).then(function(response) {
				var returnValue =  response.data.returnValue;
				if(returnValue == 1){
					axios.get(api.saveMemberOpenIDApi+"?params/systemAccount="+account+"&params/openId="+_this.openId+"&token="+localStorage.token).then(function(responses) {
						if( responses.data.errCode == "S" ){
							AlertModule.show({
								title: '温馨提示',
			        			content: '认证成功',
			        			onHide(){
			        				wx.closeWindow();
						        }
		        			});
						}else{
							_this.$vux.toast.text('认证失败');
						}
				   	})
				}else{
					_this.$vux.toast.text('认证失败');
				}
		   	})
	  	}
	}



}
</script>

<style scoped>
.vux-label, .weui-cell__ft .weui-loading{
	overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: nowrap;
    	width: 80%;
}
	.vux-cell-primary.vux-cell-primary{
		overflow: hidden;
    	text-overflow: ellipsis;
    	white-space: nowrap;
	}
	.weui-cell:before{
		    content: " ";
		    position: absolute;
		    left: 0;
		    top: 0;
		    right: 0;
		    height: 0.02rem;
		    border-top: 0rem solid #D9D9D9 !important;
		    color: #D9D9D9;
		    -webkit-transform-origin: 0 0;
		    transform-origin: 0 0;
		    -webkit-transform: scaleY(0.5);
		    transform: scaleY(0.5);
		    left: 0.3rem;
	}
	
	/*解决监听被动事假*/
	/*.inpitAll{
		touch-action:none;
	}*/
	.registered-pho{
		float:left;
		width: 100%;
	}
	.registered-pho-input{
		border-bottom: 0.02rem solid #E8E8E8;
	}
	.registered-pho-div{
		float: left;
		width: 15%;
		height: 100%;
	}
	.registered-pho-img{
		float: right;
		margin: 0.15rem 0rem;
		padding-right: 0.2rem;
	}
	.registered-pho-nbm{
		float: left;
		width: 85%;
		height: 100%;
	}
	.registered-pho-nbm-txt{
		line-height: 0.75rem;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}
	.registered-phone{
		border-bottom: 0.02rem solid #e8e8e8;
	}

	/*验证码*/
	.registered-group-botton{
		background: #FFFFFF;
		border: 0rem solid;
		color: #ababab;
	}
	/*图像*/
	.registered-group-phone{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;


	}
	.registered-group-code{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;
	}
	.registered-group-plate{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;
	}

    .weui-label{
     color: #41cdff !important;
    }
    /*提交*/
    .registered-button{
    	width: 100%;
    	text-align: center;
    	margin-top: 0.8rem;

    }
    .registered-button-save{
    	width: 80%;
    }

  	/*button.weui-btn, input.weui-btn{
  		width: 80% !important;
  	}*/
    .registered-group{
    	margin-top:0.04rem;
    }

	/*&:active {
    border-color: rgba(206, 60, 57, 0.6)!important;
    color: rgba(206, 60, 57, 0.6)!important;
    background-color: transparent;
  }*/
 	.registered-button-save{
		margin-top: 1rem;
		text-align: center;
	}
	.registered-button-save{
		width: 80% !important;
		border: 0rem;
		background-color: #3087F7 !important;
	}
	.registered-carType-txt{
		width: 1.6rem;
		 overflow:hidden;
         white-space: nowrap;
         text-overflow: ellipsis;
         padding-left: 0rem;
	}
</style>
<style>
		#registered .weui-cell .vux-cell-bd >p{
		    width: 80%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
	}
	   #registered  .weui-cell>.vux-cell-bd {
	   	    width: 80%;
	    overflow: hidden;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	   }
</style>
