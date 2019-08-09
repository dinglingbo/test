<template>
  <div class="container">
	  <header class="header">
	      <div class="title">请您对门店进行打分</div>
	      <Rater :font-size="35" v-model="couponMess.commentScore" />
	  </header>
    <section class="my-comment--main">
      <textarea class="text-box" v-model="couponMess.commentContent" placeholder="请您对本次服务进行评价"></textarea>
    </section>
    <Upload     class="profile"
								ref="upload"
								v-model="files"
								:action="qiniupAction"
								:process-file="processFile"
								:max="6"
								@files-added="filesAdded"
								@file-success="fileSuccess"
								@file-removed="removeFile"
								@file-error="errHandler">
				</upload>
    <footer class="btn-area">
      <div class="wrapper">
        <x-button class="makeapp-bot-ton" @click.native="saveComment()">提交</x-button>
      </div>
    </footer>
  </div>
</template>

<script>
		import axios from 'axios'
import api from '../Api/api.js'
import Upload from '../component/upload'
import UploadFile from '../component/upload/file.vue'
import UploadBtn from '../component/upload/btn.vue'
import { Rater, XButton,AlertModule } from 'vux'
import compress from '../component/upload/image'
export default {
		  components: {
		    Rater,
		    XButton,
		    Upload,
		    UploadFile,
		    UploadBtn,
		    AlertModule
		  },		 
			 data() {
			    return {
						profile: {},
						sheetVisible: false,
						files: [],
						qiniupAction: {
			    		target: '//up-z2.qiniup.com',
			    		data: {}
			    	},
			    	couponMess: {
			    		storeId: null,
			    		userId: localStorage.userId,
			    		carId: localStorage.carid,
			    		commentScore: null,
			    		commentContent: null,
			    	},
			    	imgList: [],
			    	serviceId:''
			    }
			  },
			 created() {
				this.uploadToken();
				debugger;
				this.couponMess.storeId = this.$route.query.storeId;
				this.serviceId = this.$route.query.serviceId;
			},	
				methods: {
				//获取七牛上传的token
					uploadToken(){
							axios.post(api.getQNtokenApi,{token:localStorage.token}).then(response => {
								this.qiniupAction.data.token = response.data.uptoken
							});
					},
					processFile(file, next) {
			      compress(file, {
			      	type: 'file',
			        compress: {
			          quality: 0.75
			        }
			      }, next)
			    },
			    filesAdded(files) {
						    	const maxSize = 5 * 1024 * 1024 // 5M
						    	for (let k=0;k < files.length; k++) {
							        const file = files[k]
							        if (file.size > maxSize) {
							        	_that.$vux.toast.text('上传图片过大')
							        }
							        if (file.type !== 'image/png' && file.type !== 'image/jpeg') {
							        	_that.$vux.toast.text('请上传JPG或PNG格式的图片')
							        	file.ignore = true
							        }
						    	}
			  	},
			    errHandler(file) {
						    	_that.$vux.toast.text('上传失败')
						    	//上传失败重新获取七牛token
						   		axios.post(api.getQNtokenApi,{token:localStorage.token}).then(response => {
										this.qiniupAction.data.token = response.data.uptoken
									});
			      
			    },
		    	fileSuccess(files) {
		    		//getQNImgUrl
		    		let imgUrl = ''
		    		axios.post(api.getQNImgUrl,{token:localStorage.token}).then(response => {
							imgUrl = response.data.companyLogoUrl
							this.imgList.push({
								pictureName: files.response.key, 
								pictureUrl: imgUrl + files.response.key,
								pictureType: files.file.type,
								pictureSize: files.size} )
						});
						
						console.log(999, this.imgList)
			   	},
			   	removeFile(files) {
			   		
			   		console.log(files.response.hash)
			   		for (let i in this.imgList) {
			   			if (this.imgList[i].pictureName == files.response.hash) {
			   				this.imgList.splice(i, 1)
			   			}
			   		}
			   		console.log(888, this.imgList)
			   	},
			   	saveComment() {
			   		debugger;
			   		var _that = this;
			   		if(_that.couponMess.commentContent === null){
			   			   	_that.$vux.toast.text('请填写评论');
		   		}else if( !Boolean(_that.couponMess.commentScore) ){
			   				_that.$vux.toast.text('请打分');
			   		}else{
			   				//追加参数map
			   				let appendMap = {};
			   			  //车道工单表外键
			   			  var serviceOrderId = this.serviceId;
			   				if(serviceOrderId != '' && serviceOrderId != null){
			   					 //租户ID
			   			     let tenant_id = localStorage.tenantId;
			   			     //门店ID
			   			     let orgid = localStorage.orgid;
			   			     appendMap.serviceOrderId = serviceOrderId;
			   			     appendMap.tenantId = tenant_id;
			   			     appendMap.orgId = orgid;
			   				}
			   			 
			   				axios.post(api.addComment,{imgList: _that.imgList, couponMess: _that.couponMess,appendMap:appendMap,token: localStorage.token}).then(response => {
		                if(response.data.errCode == "E"){
		                	_that.$vux.toast.text('评论失败');
		                } else {
		                	AlertModule.show({
													title: '温馨提示',
								        			content: '评论成功',
								        			onHide(){
								        									var storeId=_that.$route.query.storeId;//传入的门店id参数
																					var orgid=_that.$route.query.orgid;
								        									//评价后跳转页面
								        									let afterUrl = '/storeDetails';
								        									let afterData = {storeId:storeId,orgid:orgid}
								        								  if(serviceOrderId != '' && serviceOrderId != null){
								        								  		afterUrl = '/myAccountMess';
								        								  		let accountMessData = JSON.parse(sessionStorage.getItem('accountMessData'));
								        								  		afterData = {
								        								  					serviceId:accountMessData.serviceId,
																										carNos:accountMessData.carNo,
																										//公司名
																										companyNames:accountMessData.companyName,
																										//公里数
																										enterKilometers:accountMessData.enterKilometer,
																										//钱
																										balaAmt:accountMessData.balaAmt,
																										//下单时间
																										outDate:accountMessData.outDate,
																										//单号
																										serviceCode:accountMessData.serviceCode
								        								  		};
								        								  		sessionStorage.removeItem('accountMessData');
								        								  }
																					_that.$router.push({
																							    				path:afterUrl,
																								    			query: afterData
																						    			});
																			}
											        
							        			});
		                   
		                }
								});
								_that.imgList = []
			   	}
			   		}
			   		//保存评论
			   	
		}
}
</script>


<style scoped>
.header {
  padding: 0.6rem 0;
  text-align: center;
  background-color: #fff;
  border-bottom: 0.02rem solid #ededed;
}

.header > .title {
  margin-bottom: 0.4rem;
}

.my-comment--main {
}

.text-box {
  width: 100%;
  height: 1.4rem;
  padding: 0.2rem 0.32rem;
  box-sizing: border-box;
  border: none;
  outline: none;
  display: block;
  font-size: inherit;
}

.text-box::-webkit-input-placeholder {
  color: #aaa;
}

.my-comment--main::after {
  content: '（必填）';
  display: block;
  background-color: #fff;
  text-align: right;
  padding: 0.2rem 0.32rem;
  color: #aaa;
}

.uploader-area {
  padding: 0.2rem 0.32rem;
}

.uploader-area > .title {
}

.uploader {
  margin: 0.2rem 0;
}

.btn-area {
  height: 1.2rem;
}

.btn-area > .wrapper {
  height: inherit;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  align-items: center;
}
</style>
