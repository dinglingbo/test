<template>
	<div id="myInformation">
		<div class="myInformation">
		  	<group gutter="0">
		  		
		  		<x-input title="选择性别" placeholder="请输入真实姓名" v-model="userName">
		  			<img slot="label" style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" 
		  				src="../assets/img/icon_name.png">
		  		</x-input>
		  		<cell title="选择性别">
		  			<div slot="icon">
		  				<img style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" src="../assets/img/icon_xingbie.png" />
		  			</div>
		            <checker v-model="userGender" default-item-class="circle-checker" selected-item-class="circle-checker__selected">
		              <checker-item value="1">男</checker-item>
		              <checker-item value="0">女</checker-item>
		            </checker>
		  		</cell>
		  		<cell title="选择生日">
		  			<div slot="icon">
		  				<img style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" src="../assets/img/icon_shengri.png" />
		  			</div>
		  				
     				<datetime style="position: absolute;top: 0;left: 0;bottom: 0;right: 0;" slot="child" v-model="value" start-date="1930-01-01" >
     				
     			</datetime>
     			</cell>
			    <x-input v-model="userAddress" placeholder="请输入地址">
			        <img slot="label" style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" src="../assets/img/icon_dizhi.png">
			    </x-input>
			    <x-input  class="inpitAll" ref="phoneNumber"  :max="13" mask="999 9999 9999"   v-model="phoneNumber"    placeholder="请输入手机号" >
						<img slot="label"  style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" class="registered-group-phone" src="../assets/img/icon_phone.png" />
				</x-input>
			    <x-input v-if="phoneNumber.replace(/\s/g, '') !== originalPhoneNumber"  v-model="phoneCode" placeholder="请输入验证码" :max="7" mask="999 999" :show-clear="clearIocn"  >
			        <img slot="label" style="padding-right:0.2rem;display:block;width: 0.4rem; height: 0.4rem;" src="../assets/icons/icon_car.png">
			    	<div  slot="right" class="registered-group-countDown">
						<p class="registered-group-botton" :class="{disabled:!this.canClick}" @click="countDown()">{{content}}</p>
					</div>
			    </x-input>
		  	</group>
		</div>
    <btn-area fixed>
      <button @click="submit">保存</button>
    </btn-area>
	</div>
</template>

<script>
import axios from 'axios'
import api from "../Api/api.js"
import BtnArea from '../component/btn-area.vue'
import {Group,XInput,XButton,Cell,Checker,CheckerItem,Checklist, Datetime} from 'vux'
export default{
			components:{
        BtnArea,
				Group,
				XInput,
				XButton,
		        Cell,
		        Checker,
		        CheckerItem,
				Checklist,
				Datetime,
				

			},
			data(){
				return{
			          value:"",
			          userName: '',
			          userGender: '',
			          userAddress: '',
						birthday:"选择生日",
			          commonList: [ '男', '女', ],
			          originalPhoneNumber: '',
					phoneNumber:"",
					content:"发送验证码",
					canClick:'ture',
					phoneCode:"",
					checkCode:"",
					clearIocn:false,
				}
			},
			 created(){
//		 		this.getToken();
			},
			methods: {
//			 	getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					}, 			
			 countDown(){
                if (!this.canClick) return
                try {
                  this.checkPhoneNumber()
                } catch(err) {
                  this.$vux.toast.text(err.message)
                  return
                }
						let _that=this;
						this.canClick = false;
						this.totalTime=60;
						this.clock = window.setInterval(() =>{
							this.content = this.totalTime + "s"
							this.totalTime--
							if(this.totalTime < 0){
								window.clearInterval(this.clock);
			                this.content = "重新发送"
			                this.canClick = true
			               
							}
						},1000);
						//正则表达是去掉空格
						var phone=""+this.phoneNumber;
						var params = { phone : Number( phone.replace(/\s+/g, "") ) };
						axios.post(api.verificationCodeApi,{params:params,toke:localStorage.token})
					  	.then(function (response) {
					    	_that.checkCode=response.data.data.msgCode;
					  	})
					  	.catch(function (error) {
					  	});

						},
				
            // 获取验证码时校验手机号
            checkPhoneNumber() {
              if (!this.phoneNumber) {
                throw new Error('必须填写手机号')
              }
              if (!this.$refs.phoneNumber.valid) {
                throw new Error('手机号格式不正确')
              }
              return this.phoneNumber.replace(/\s/g, '')
            },
            // 提交时校验：用户名
            getUserName() {
              if (!this.userName) {
                throw new Error('必须填写用户名')
              }
              return this.userName
            },
            // 提交时校验：性别
            getUserGender() {
              return this.userGender
            },
            // 提交时校验：生日
            getUserBirthday() {
              return this.value
            },
            // 提交时校验：地址
            getUserAddress() {
              return this.userAddress
            },
            // 提交时校验：手机号
            getUserPhone() {
              if (!this.$refs.phoneNumber.valid) {
                throw new Error('手机号格式不正确')
              }
              return this.phoneNumber.replace(/\s/g, '')
            },
            // 提交时校验：验证码
            getPhoneCode() {
            	var code = this.phoneCode;
				var codes =   code.replace(/\s+/g, "");
              	if (!this.phoneNumber ||
	                !this.$refs.phoneNumber.valid ||
	                this.phoneNumber.replace(/\s/g, '') === this.originalPhoneNumber) {
	                return ''
              	}
              	if (!this.phoneCode) {
               	 	throw new Error('必须填写验证码')
             	}
             	if (this.phoneCode.length !== 7) {
               		 throw new Error('验证码必须是6位数')
             	}
             	if( codes !== this.checkCode){
             		//debugger
					throw new Error('验证码错误')
				}
              	return this.phoneCode.slice(0, 3) + this.phoneCode.slice(4, 7)
             
            },
             showPlugin(){
         		debugger
         		var _that = this;
		      	_that.$vux.alert.show({
		        title: '提示',
		        content: "保存成功",
		        onHide () {
		            //跳转下一个页面
             		_that.$router.push({path: '/my'});
		        }
		      })
		    },
            // 提交表单
            async submit() {
              try {
              	this.$vux.loading.show({
                	text: '正在保存'
              })	
              	var userData = {
            		userName: this.getUserName(),
                    userGender: this.getUserGender(),
                    userBirthday: this.getUserBirthday(),
                    userAddress: this.getUserAddress(),
                    userPhone: this.getUserPhone().replace(/\s+/g, ""),
                    phoneCode: this.getPhoneCode(),
                    userId : localStorage.userId
                   
            	};
                const res = await axios.post(api.updateUserInfoApi, {
                  token: localStorage.token,
                		 userData:userData
                })
                if (res.data.serr === 'e') {
                  throw new Error('验证码错误')
                }
//              this.$vux.alert.show({
//              	text:"保存成功"
//              })
                
                localStorage.setItem("userPhone",userData.userPhone);
                debugger
             	this.showPlugin();
              } catch(err) {
              	//debugger
                this.$vux.toast.text(err.message)
              } finally {
                this.$vux.loading.hide()
              }
            }
        },
        async created() {
          const userId = localStorage.userId
          const { data } = await axios.post(api.getInfoApi, { userId:localStorage.userId,token:localStorage.token})
          const {
	            userName,
	            userGender,
	            userBirthday,
	            userAddress,
	            userPhone
          } = data.myUserInfo[0]
          this.userName = userName
          this.userGender = userGender
          this.value = userBirthday
          this.userAddress = userAddress
          this.originalPhoneNumber = userPhone
          this.phoneNumber = userPhone
        },
       
}
</script>

<style scoped="scoped">
.myInformation{
	float: left;
	width: 100%;
}
/*验证码*/
.registered-group-botton{
		background: #FFFFFF;
		border: 0;
		color: #ababab;
	}
.registered-group-phone{
		height: 0.5rem;
	    width: 0.5rem;
	    padding-right:0.4rem;
	    display:block;


	}
  /* 单选框 */
  .circle-checker {
    position: relative;
    padding-left: 1.5em;
  }
  .circle-checker + .circle-checker {
    margin-left: 1em;
  }
  .circle-checker::before {
    content: '';
    background-image: url(../assets/icons/icon_unchoose.png);
    background-repeat: no-repeat;
    background-position: center;
    background-size: contain;
    width: 1.2em;
    height: 1.2em;
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    margin: auto;
  }
  .circle-checker__selected::before {
    background-image: url(../assets/icons/icon_choose.png);
  }
  .vux-datetime.vux-datetime{
  	color:#757575
  }
  .weui-dialog__btn_primary.weui-dialog__btn_primary{
  	color:#3087F7 ;
  }
</style>
