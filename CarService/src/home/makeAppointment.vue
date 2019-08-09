<template>
	<div id="makeAppoointment" ref="scroller">
		<!--预约信息-->
		<div class="makeapp-mess">
			<div class="makeapp-mess-pho">
				<div class="makeapp-pho">
					<div class="makeapp-pho-div">
						<img class="makeapp-pho-img" src="../assets/icons/icon_phone.png" width="20" height="20" />
					</div>
					<div class="makeapp-pho-nbm">
						<span class="makeapp-pho-nbm-txt">联系电话</span >
			 						</div>
			 				</div>
			 				<div>
			 					<!--<input type="number" class="makeapp-pho-input" placeholder="请输入手机号码" />-->
			 					<x-input  class="makeapp"  :max="13" mask="999 9999 9999"  v-model="phoNumber"     placeholder="请输入手机号" >	</x-input>
			 				</div>
			 		</div>
			 		<div class="makeapp-mess-pho" >
			 				<div class="makeapp-pho"  >
			 						<div class="makeapp-pho-div" >
			 							<img class="makeapp-pho-img" src="../assets/icons/icon_car.png" width="20"	height="20" />
			 						</div>
			 						<div class="makeapp-pho-nbm" >
			 							<span class="makeapp-pho-nbm-txt">车牌号</span >
			 						</div>
			 				</div>
			 				<div>
			 					<x-input  :max="7"  class="makeapp"   :required="true"  v-model="carNumber"  placeholder="请输入车牌号" @on-blur	="isVehicleNumber" >
								</x-input>
			 				</div>
			 		</div>
		 	</div>
	<!--项目选择--->
			<!--<div class="makeapp-item">
							<div >
								<group gutter="0px"  v-for="(item,index) in serciveType" :key="index">
							      <cell
							      :title="item.name"
							      class="item-name"
							      is-link
							      :border-intent="false"
							      :arrow-direction="item.showitemA ? 'up' : 'down'"
							      @click.native="getItem(item.id,index)" >  
							      </cell>
							       <div v-show="item.showitemA && item.serciveItem && item.serciveItem.length">
									       <p class="slide" :class="item.showitemA ? 'animate' : '' ">
                           <checker @on-change="getItemData(item,$event)" default-item-class="subitem" selected-item-class="subitem subitem__selected">
                            
                           </checker>
							 </p>
							       </div>
						</group>
							</div>
				 		
			</div>-->
				<div style="float: left; width: 100%; margin-top:0.2rem ;">
					<div class="makeapp-item-title" style="border-bottom:#EDEDED 0.02rem solid  ; height: 0.8rem; line-height: 0.8remrem; background-color: #FFFFFF; float: left;width: 100%;">
							<span class="makeapp-item-title-txt">预约项目</span >
					</div>
					<div style="background-color: #FFFFFF;">
						 <checker @on-change="getItemData" default-item-class="subitem" selected-item-class="subitem subitem__selected">
                           <checker-item :value="subItem" v-for="(subItem,index) in serciveItem" :key="index" style="overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">{{subItem.name}}</checker-item>	
		             	</checker>
					</div>
				</div>
			<!--预约详情-->
		 	<div class="makeapp-word" >
		 			 <group  gutter="0px" >
					      <div class="makeapp-word-title" >
					      	<span class="makeapp-word-title-txt">预约详情</span>
							</div>
							<div>
								<x-textarea  class="makeapp"  :max="200" name="description" :placeholder="wordtxt" :autosize="true" v-model="makeappTxt"></x-textarea>
							</div>
					</group>
					<!--<input class="makeapp-word-txt"   type="textarea" rows="10" cols="30" placeholder="请输入手机号码" />-->
					</div>
				<!--下一步-->
					<div class="makeapp-bot">
						<x-button class="makeapp-bot-ton" type="primary" @click.native="getData(phoNumber,carNumber,makeappTxt)">
							<span>下一步</span >
			  			</x-button>
			  		</div>
		  </div>
  </div>
</template>

<script>
	import axios from 'axios'
import api from "../Api/api.js"
import btnArea from "../component/btn-area.vue"
import wx from 'weixin-js-sdk';
import { Checklist, Cell, Group, XInput, XTextarea, XButton, XHeader, Checker, CheckerItem,AlertModule, } from 'vux'

export default {
	components: {
		Checker,
		CheckerItem,
		Checklist,
		Group,
		Cell,
		XInput,
		XTextarea,
		XButton,
		XHeader,
		AlertModule,
	
	},
	data() {
		return {
			phoNumber: "",
			carNumber: "",
			makeappTxt: "",
			makeappItemName: "",
			serciveItemName: [1],
			showitemA: false,
			fullValues: [],
			wordtxt: '请输入信息(非必填)',
			serciveItem: [],
			makeappItemId:"",
			//预约业务id
			serviceTypeId:'',
		}
	},
	created() {
		var _this = this;
		if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前用户是否缓存里有客户id，判断是否绑定
	  		_this.$vux.confirm.show({
		        title: '温馨提示',
		        content: '你还没有认证，请先认证。',
		        onCancel () {
		          wx.closeWindow();
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
	  		this.getToken();
	  	}
	},

	methods: {
		//获取token
		getToken(){
			/*this.$vux.loading.show({text: 'Loading'});
			axios.post(api.getTokenApi,{password:"qxy.123",userId:"syswechat"}).then(response => {
				 var  token = response.data.data.attributes.token;
				 localStorage.setItem("token",token);
				 this.getSetUserPhoneCar();
				 this.getItem();
				 this.$vux.loading.hide();
			});*/
			this.getSetUserPhoneCar();
			this.getItem();
			this.$vux.loading.hide();
		},
		//查询用户的电话和车牌号
		getSetUserPhoneCar(){
			var _this=this;
			_this.carNumber = localStorage.userCarNo;
			_this.phoNumber=localStorage.userPhone;
		},

		//获取预约项目
		getItem() {
			var _that = this;
			var params = {
				isCanOrder: 1,
				isDisabled: 0,
				//门店id
				orgid: localStorage.orgid,
				//
				tenantId: localStorage.tenantId
			};
			axios.post(api.serciveItemApi , { params: params, token:localStorage.token }).then(response => {
				console.log(response);
				_that.serciveItem = response.data.list;
			})
		},
		getData(phoNumber, carNumber, makeappTxt) {
			var _that = this;
			if(_that.phoneNumber== "" || _that.carNumber== ""||_that.makeappItemName == ""){
					    	AlertModule.show({
											title: '温馨提示',
						        			content: '请填写信息',
					        			});
					        			 setTimeout(() => {
									        AlertModule.hide()
									      }, 2000);
			}else{
				_that.$router.push({
					path:'./makeAppointTime',
					query: {
						phoNum: phoNumber.split(' ').join(''),
						carNum: carNumber,
//						appItem: makeappItem,
//						appItem: makeappItem,
						appTxt: makeappTxt,
						//项目ID
						itmeId:_that.makeappItemId,
						//项目名称
						itemName:_that.makeappItemName

					}
				})
			}

		},
		//判断车牌号是否正确
			isVehicleNumber(){
					var result = false;
					var vehicleNumber = this.carNumber;
				    var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
				    var  r =  vehicleNumber.match(express);
				    if(r == null ){
						    	AlertModule.show({
								title: '温馨提示',
			        			content: '车牌号错误，请重新输入',
		        			});
		        			 setTimeout(() => {
						        AlertModule.hide()
						     }, 5000);

				   		}

			},
		//获取项目数据
		getItemData(subItem) {
      		this.makeappItemName = subItem.name;
      		this.makeappItemId = subItem.id;
		}

	}
}
</script>

<style scoped="scoped">
	.scroller{
		 height: 100%;
  		overflow: auto;
	}
	.item-name{
		touch-action:none;
	}
	.makeapp{
		touch-action:none;
	}
	.makeapp-mess{
		float: left;
		width: 100%;

	}
	.makeapp-pho{
		float: left;
		width: 100%;
		height: 35px;
		background-color: #FFFFFF;
	}
	.makeapp-mess-pho{
		float: left;
		width:100%;
		border-bottom: 1px solid #dfdfdf;
	}
	.makeapp-pho-div{
		float: left;
		width: 15%;
		height: 100%;

	}
	.makeapp-pho-img{
		float: right;
		margin: 7.5px 0px;
		padding-right: 10px;
	}
	.makeapp-pho-nbm{
		float: left;
		width: 85%;
		height: 100%;
	}
	.makeapp-pho-nbm-txt{
		line-height: 35px;
		}
	.makeapp-pho-input{
		font-size: 18px;
    width: 80%;
    padding-left: 50px;
    border: 0px;
    height: 35px;
	}
	.slide {
	  padding: 0 20px;
/*	  overflow: hidden;
*/	  max-height: 0;
	  transition: max-height .5s cubic-bezier(0, 1, 0, 1) -.1s;
	}
	.animate {
	  max-height: 9999px;
	  transition-timing-function: cubic-bezier(0.5, 0, 1, 0);
	  transition-delay: 0s;
	}
	/*预约信息*/
	.makeapp-mess{
		float: left;
		width: 100%;
		background-color: #FFFFFF;
		
	}
	/*预约详情*/
	.makeapp-word{
		float: left;
		width: 100%;
		margin-top: 8px;

	}
	.makeapp-word-txt{

		float: left;
		width: 100%;
		border: 0px ;
		height: 80px;
	}
	.makeapp-word-title{
		float: left;

		width: 100%;
		height: 35px;
	}
	.makeapp-word-title-txt{
		font-size:16px ;
		float: left;
		margin-left:10px ;
		margin-top: 6px;
	}
	.makeapp-bot.makeapp-bot{
		float: left;
		width: 100%;
		margin-top:20px ;
	}
	.makeapp-bot-ton{
		background-color: #3087F7!important;
		width: 80% !important;
	}
	 .vux-x-textarea {
    border: 1px solid #dfdfdf !important;
    border-radius: 10px !important;
    margin: 5px 10px  10px 10px !important ;
    }
    .makeapp-item{
    	background-color: #FFFFFF;
    	width: 100%;
    	margin-top: 0.2rem;
    	height: 3rem;
    	border-bottom:#EDEDED 0.02rem solid;
    }
    .makeapp-item-title-txt{
    	float: left;
    	padding-left: 0.2rem;
    }
    /*.makeapp-item-title{
    	height: 3rem;
    }*/
    .makeapp-item .vux-checker-box {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin-bottom: 0.2rem;
    }
    .subitem {
    	     height: 0.9rem;
	    background:gainsboro;
	    margin-top: 0.2rem;
	    margin-left: 0.2rem;
	    margin-right: 0.1rem;
	    width: calc(50% - 0.4rem);
	    box-sizing: border-box;
	    text-align: center;
	    line-height: 0.9rem;
	    padding: 0 0.16rem;
	    border-radius: 0.12rem;
	    border: 0.02rem solid #ddd;
	    margin-bottom: 0.2rem;
    }
    .subitem__selected {
      background-color: #3087f7;
      color: #FFFFFF;
    }
</style>
