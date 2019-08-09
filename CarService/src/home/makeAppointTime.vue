<template>
	<div id="makeAppoointTime">
		<!--年-->
				<div class="makeAppoointTime-year">
					<span>{{year}}年</span>
				</div>
		<!--星期-->
				<div class="makeTime-tab" v-if="thimeData.length">
					<tab :line-width=2 active-color='#3B8CF7' default-color='#3f3f3f' bar-active-color='#3B8CF7'  v-model="index"  >
						<tab-item class="vux-center"   v-for="(thimeDataItem, index) in thimeData" @click.native="amTimes=[];pmTimes=[]" :key="index" >
							<div style="line-height: 0.4rem;font-size: 0.34rem;"><span>{{splitDate(thimeDataItem.name)}}</span ></div>
						</tab-item>
					</tab>
				</div>
		<!--时间选择-->
				
					<swiper v-model="index" @on-index-change="getAppiontTime(thimeData[$event].name,amIndex,pmIndex)"  :show-dots="false" height=" 10rem">
						<swiper-item v-for="(thimeDataItem, timeIndex) in thimeData"  height=" 10rem"  :key="timeIndex">
							<div class="makeTime-choose" v-if="index==timeIndex " >
								<div class="makeTime-choose-am">
									<div class="makeTime-choose-am-title">
										<span>上午</span>
									</div>
									<div  style="float:left; width:100%;">
										<div v-for="(amTimesItem,index) in amTimes" :key="index">
											<div :class="{'makeTime-choose-time':!amTimesItem.disabled,'makeTime-noChoose-time':amTimesItem.disabled,'isture':!amTimesItem.disabled&&amIndex==index}" @click="getAm(index,amTimesItem.timeId)">
												<span  class="makeTime-choose-time-txt">{{splitTime(amTimesItem.timeId)}}</span>
											</div>
										</div>
									</div>
								</div>
								<div class="makeTime-pm">
									<div class="makeTime-choose-pm-title ">
										<span>下午</span>
									</div>
									<div  style="float:left; width:100%;">
										<div v-for="(pmTimesItem,index) in pmTimes" :key="index">
											<div :class="{'makeTime-choose-time':!pmTimesItem.disabled,'makeTime-noChoose-time':pmTimesItem.disabled,'isture':!pmTimesItem.disabled&&pmIndex==index}" @click="getPm(index,pmTimesItem.timeId)">
												<span  class="makeTime-choose-time-txt">{{splitTime(pmTimesItem.timeId)}}</span>
											</div>
										</div>
									</div>
								</div>

							</div>
						</swiper-item>
					</swiper>
				
		<!--提交-->
				<div class="makeTime-choose-save" style="padding-bottom: 0.3rem;">
					<x-button type='primary' class="makeTime-choose-saveTon" @click.native="processSave()">确认预约</x-button>
				</div>
	</div>
</template>

<script>
		import api from '../Api/api.js'
		import axios from 'axios'
		import { Tab, TabItem, Swiper, SwiperItem, Checker, CheckerItem, XButton,AlertModule } from 'vux'

		export default {
			components: {
				Tab,
				TabItem,
				Swiper,
				SwiperItem,
				Checker,
				CheckerItem,
				XButton,
				AlertModule
			},
			data() {
				return {
					isture: true,
					thimeData: [],
					ApponintDataList: "",
					year: "",
					pmIndex: -1,
					amIndex: -1,
					showData: 0,
					index: 0,
					amTimes: [],
					pmTimes: [],
					isToday: "0",
					show: false,
					phoNumber: "",
					carNumber: "",
					makeappTxt: "",
					nowDate: "",
					toDate: "",
					userId:localStorage.userId,
					userlists:[],
					getdata:"",
					amTime:"",
					pmTime:"",
					userCarId:"", //车道用户车辆id
					userList:[],
				}
			},
			watch: {
				'$route': 'getParams'
			},
			created() {
				this.getToken();
			

			},
			mounted() {

			},
			methods: {
				//获取token
				getToken(){
					this.getId();
					this.getAppiontData();
					this.compare();
					this.$vux.loading.hide();
					/*axios.post(api.getTokenApi,{password:"qxy.123",userId:"syswechat"}).then(response => {
						 var  token = response.data.data.attributes.token;
						 localStorage.setItem("token",token);
						 	this.getId();
							this.getAppiontData();
							this.compare();
						 this.$vux.loading.hide();
							
					});*/
				},
				// 切换
   				changeIndex(index) {
   					debugger
   				},
   				//获取上午时间
				getAm(index, time) {
					this.amIndex = index;
					this.pmIndex = -1;
					this.amTime = time;
				},
				//获取下午时间
				getPm(index, time) {
					this.pmIndex = index;
					this.amIndex = -1;
					this.pmTime = time;
				},
				getAppiontData() {

					var _that = this;
					axios.post(api.makeApponintDateApi, {
							orgid: localStorage.orgid,
							token:localStorage.token
						})
						.then(function(response) {
							_that.ApponintDataList = response.data;
							var nowMinute = _that.ApponintDataList.nowMinute;
							var endMinute = _that.ApponintDataList.endMinute;
							var nowDateStr = _that.ApponintDataList.nowDateStr;
							var advanceDay = _that.ApponintDataList.advanceDay;
							var errCode = _that.ApponintDataList.errCode;
							if(errCode == "S") {
								var newDateStr = "";
								for(var i = 0; i < advanceDay; i++) {
									newDateStr = _that.addDate(nowDateStr, i);
									var newObj = {
										id: newDateStr,
										name: newDateStr

									};
									_that.thimeData.push(newObj);

								}
								_that.getAppiontTime(_that.thimeData[0].name);
							}

						}).catch(function(error) {

						});
				},
				//计算日期
				addDate(dates, days) {
					if(days === undefined || days === '') {
						days = 1;
					}
					var date = new Date(dates);
					date.setDate(date.getDate() + days);
					var month = date.getMonth() + 1 ;
					var day = date.getDate();
					return date.getFullYear() + '-' + month + '-' + day;
				},
				splitDate: function(obj) {
					var a = [];
					a = obj.split("-");
					return a[1] + '月' + a[2] + '日'
				},
				//获取时间
				getAppiontTime(data,amIndex,pmIndex) {
					//加载
						var _that = this;
						//解决选择时间同步
						_that.amIndex =-1;
						_that.pmIndex = -1;
						_that.amTimes = [];
						_that.pmTimes = [];
						_that.getdata = data;
						//区分上午 下午
						var judeDateStr = "13:00:00";
						var curTime = new Date();
						var h = curTime.getHours() < 10 ? '0' + curTime.getHours() : curTime.getHours();
						var m = curTime.getMinutes() < 10 ? '0' + curTime.getMinutes() : curTime.getMinutes();
						var s = curTime.getSeconds() < 10 ? '0' + curTime.getSeconds() : curTime.getSeconds();
						var nowTime = h + ":" + m + ":" + s;
						var nowDate = curTime.getFullYear() + "-" + (curTime.getMonth() + 1) + "-" + curTime.getDate();
						_that.year = curTime.getFullYear();
						var isToday = 1;
						if(nowDate == data || typeof yearDate == "undefined") {
							isToday = 0;
						}
						axios.post(api.makeApponintTimeApi, {
								isToday: isToday,
								orgid: localStorage.orgid,
								token: localStorage.token
						}).then(function(response) {
							//加载完成关闭
								_that.timeLists = response.data.timeList;
								for(var a = 0; a < _that.timeLists.length; a++) {
									if(isToday === 0 &&  nowDate ===data) {
										if(_that.compare(_that.timeLists[a].timeId, nowTime)) {
											_that.timeLists[a].disabled = true;
										} else {
											_that.timeLists[a].disabled = false;
										}
									} else {
										_that.timeLists[a].disabled = false;
									}
									if(_that.timeLists[a].timeId < judeDateStr) { //上午
										_that.amTimes.push(_that.timeLists[a]);
									} else if(_that.timeLists[a].timeId >= judeDateStr) { //下午
										_that.pmTimes.push(_that.timeLists[a]);

									}
								}

							}, function(error) {})
					},
				splitTime(obj) {
						var a = [];
						a = obj.split(":");
					return a[0] + ':' + a[1]
				},
				compare(toDate, nowDate) {
					if(toDate <= nowDate) {
						return true;
					} else{
						return false;
					}

				},
				//获取联系人id和客户id
				getId(){
						var _that = this;
					   var userId = localStorage.userId;
					   axios.post(api.findUserAllApi, {userId:userId ,token: localStorage.token})
					   .then(function(response) {
					   			_that.userlists = response.data.userList;
					   })
				},
				//获取车道用户车辆id
				getCarId(){	
					var  _that = this;
						//预约车牌
					var carNumber = _that.$route.query.carNum;
				let err =  axios.post(api.findcarIdApi,{userId:localStorage.userId,carNo:carNumber,token:localStorage.token}).then(function(response) {
						_that.userCarId = response.data.carIdList[0].userCarId || [];
						_that.userList = response.data.carIdList;
						
				})
					return err;
				},	
			
				//新增预约 和通知预约
				async processSave(){
					this.$vux.loading.show({text: 'Loading'});
					var  _that = this ;
					//预约项目id
					var  appItemId = _that.$route.query.itmeId;
					//预约电话
					var phoNumber = _that.$route.query.phoNum;
					//预约车牌
					var carNumber = _that.$route.query.carNum;
					//预约项目
					var makeappItemName = _that.$route.query.itemName;
					//预约备注
					var makeappTxt = _that.$route.query.appTxt;
					//预约项目id
					var  makeappTtemId = _that.$route.query.itmeId;
					//预约业务id
					var  serviceTypeId = _that.$route.query.serviceTypeId;
					//获取预约时间
					var predictComeDate = _that.getdata;
					var pm  = _that.pmTime;
					var am = _that.amTime;
					if(pm == "" && am == ""){
						this.$vux.toast.text('请选择预约时间');	
						this.$vux.loading.hide();
						return;
					}
					await _that.getCarId();
					if(_that.amTime == ""){
						predictComeDate = _that.getdata+" "+pm ;
					}
					if(_that.pmTime == ""){
						predictComeDate = _that.getdata+" "+ am  ;
					}
					typeof predictComeDate;
						var	rpsPrebook = {
							contactorName:_that.userlists[0].userNickname,
							//车道用户车辆id
							carId :_that.userCarId,
							//车辆品牌id
							carBrandId:11,
							//车牌号
							carNo:carNumber,
							//联系人id
							contactorId:_that.userlists && _that.userlists[0].contactorId,
							//contactorId:localStorage.contactorId,
							//联系人电话
							contactorTel:phoNumber,
							//客户id
//							guestId: _that.userlists && _that.userlists[0].guestId,
							guestId:localStorage.guestId,
							//预约时间
							predictComeDate:predictComeDate,
							//预约备注
							faultDesc :makeappTxt,
							//预约项目id
							itemId:makeappTtemId,
							//预约项目名
							itemName:makeappItemName,
							//项目标准 0：本地项目
							itemType:0,
							//客户主动预约
							prebookCategory:0,
							//预约业务id
							serviceTypeId:serviceTypeId,
							//租户ID
							tenantId: localStorage.tenantId,
							//组织机构ID
							orgid: localStorage.orgid,
							//线上预约
							prebookSource:"042102"
							
						};
            
            if (this.$route.query.type === 'time') {
              rpsPrebook = Object.assign({}, rpsPrebook, this.$route.query, {
                predictComeDate
              })
            }

			 //openID
			 //var	openid= _that.userlists && _that.userlists[0].userOpid;
			 axios.post(api.addMakeApponintApi, {rpsPrebook:rpsPrebook ,openid:localStorage.openId,action:"edit",token: localStorage.token})
			 .then(function(response) {
			 	debugger;
			 	console.log(response);
			 	_that.$vux.loading.hide();
			 	if(response.data.errCode = "s"){
	                 //预约跳转到首页
	                 if (_that.$route.query.type == 'time') {
	                 	debugger
	                 	AlertModule.show({
							title: '温馨提示',
		        			content: '更改成功',
		        			onHide(){
		        				
		        				_that.$router.back();
					        }
	        			});
	                   
	                 } else {
	                 	AlertModule.show({
							title: '温馨提示',
		        			content: '预约成功',
		        			onHide(){
		        				_that.$router.push({path: '/home'});
					        }
	        			});
	                   
	                 }
			    }
					 })
				}

			},
			computed: {

			}

		}
</script>

<style scoped >
	..weui-dialog__hd.weui-dialog__hd{
		padding: 0rem;
	}
	.weui-dialog__btn_primary.weui-dialog__btn_primary{
		color: #3087F7;
	}
	.makeAppoointTime-year{

		background:#FFFFFF ;
		text-align: center;
		padding-top: 0.2rem;
		color: #3087F7;
		font-size: 0.5rem;
	}
	.vux-center{
	}
	.makeTime-tab{
		/*position: absolute;
		top: 0;
		left: 0;*/
		padding-top:0.4rem ;
		background: #fff;
	}
	.makeTime-in {
		height: 1.4rem;
		background-color: #fff;
		font-size: 0.4rem;
		color: #10AEFF;
		text-align: center;
	}
	.makeTime-time-show{
		height: 8rem;
	}
	.makeTime-choose{
		float: left;
		width: 100%;
		height: 100%;
		margin-top:0.2rem ;
		}
	.makeTime-choose-am-title{
	    font-size: 0.4rem;
    	padding-left: 0.2rem;
	}
	.makeTime-choose-pm-title{
	    font-size: 0.4rem;
    	padding-left: 0.2rem;
	}
	.makeTime-pm{
		margin-top: 0.4rem;
		float: left;
		width: 100%;
	}
	.isture {
		background-color: #3087F7!important;
		color: #FDFDFD !important;
	}

	.makeTime-choose-time {
		text-align: center;
	    width: 1.6rem;
	    height: 0.9rem;
	    background-color: #FDFDFD;
	    float: left;
	    margin-left: 0.2rem;
	    color: #3f3f3f;
	    margin-top: 0.2rem;
	    border-radius: 0.28rem;
	    border: #D7D7D7 0.02rem solid;
	}
	.makeTime-noChoose-time{
		text-align: center;
	    width: 1.6rem;
	    height: 0.9rem;
	    background-color: gainsboro;
	    float: left;
	    margin-left: 0.2rem;
	    color: #3f3f3f;
	    margin-top: 0.2rem;
	    border-radius: 0.28rem;
	    border: #D7D7D7 0.02rem solid;
	}
	.makeTime-choose-time-txt{
		line-height: 0.9rem;
	}
	.makeTime-choose-save{
		/*position: absolute;
		width: 100%;
		top: 500px; 		*/
		text-align: center;
	}
	.makeTime-choose-saveTon{
		width: 80% !important;
		border: 0rem;
		background-color: #3087F7;
	}
	.defluCss{
		background-color: red;
	}
</style>
