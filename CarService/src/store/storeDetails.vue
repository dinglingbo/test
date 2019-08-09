<template>
	<div id="storeDetails">
				<x-dialog v-model="showHideOnBlur" hide-on-blur>
		  				<div class="img-box">
		          			<img :src="tempImgUrl" style="max-width:100%">
		        		</div>
				</x-dialog>
				<!--门店信息-->
					<div class="store-details">
						<!--轮播图-->
					<swiper  :auto="true" :interval="2000" :aspect-ratio="300/800">
				      <swiper-item class="swiper-demo-img" v-for="(item, index) in showList" :key="index"><img :src="item.img"></swiper-item>
				    </swiper>
					</div>
					<!--店的信息-->
					<div class="store-details-mess">
						<!--店名-->
						<div class="store-details-title">
							<div class="store-details-name">
								<div class="store-details-name-title" >
									<span class="store-details-name-txt">{{storeData.storeName}}</span>
								</div>
							</div>
							<div class="store-details-grade" v-if=" Boolean( storeData.storeAverageScore ) && storeData.storeAverageScore > 0 ">
								<span class="store-details-garde-title" >
									<span class="store-details-grade-txt">评分：</span>
								</span>
								<span class="store-details-gradeTitle">
									<span class="store-details-gradeTxt">{{storeData.storeAverageScore}}</span>
								</span>
							</div>
							<div class="store-details-grade" v-else>
								<span class="store-details-garde-title" >
									<span class="store-details-grade-txt">暂无评分</span>
								</span>
							</div>
						</div>
						<!--营业时间-->
						<div class="store-details-time">
							<div class="store-details-timeImg">
										<img class="store-details-time-img" src="../assets/img/icon_yuyue1.png" />
								</div>
								<div class="store-details-timeTxt">
									<span class="store-details-time-txt">营业时间： {{storeData.storeBusinessBeginTime}} - {{storeData.storeBusinessEndTime}}</span>
								</div>
						</div>
						<!--地址-->
						<div class="store-details-plat">
								<div class="store-details-platImg">
										<img class="store-details-plat-img" src="../assets/img/icon_dizhi.png" />
								</div>
								<div class="store-details-platTxt">
									<span class="store-details-plat-txt">地址：{{storeData.storeStreetAddress}}</span>
								</div>
						</div>
					</div>
					<!--地图电话-->
					<div class="store-details-go">
						<div class="store-details-go-plat" @click.stop="clickMapStore(storeData.storeName,storeData.storeStreetAddress,storeData.storeLongitude,storeData.storeLatitude)">
								<div class="store-details-go-photo">
									<img class="store-details-go-img" src="../assets/img/icon_ditu.png">
								</div>
								<div class="store-details-go-body" >
									<span class="store-details-go-body-txt" >地图</span>
								</div>
						</div>
						<div class="store-details-go-phone">
								<a :href=" 'tel:'+ storeData.storePhone "  class="store-details-go-photo">
			   							<img class="store-details-go-img" src="../assets/icon_call.png">
			   						</a >
								<div class="store-details-go-body">
									<span class="store-details-go-body-txt" >电话</span>
								</div>
						</div>

					</div>

				<!--技师展示-->
				<div class="store-details-skill">
					<group :gutter="0" >
						 <cell
					      is-link
					      :border-intent="false"
					      :arrow-direction="showContent004 ? 'up' : 'down'"
					      @click.native="showContent004 = !showContent004">
					      		<div slot="title"><span style="letter-spacing: 0.04rem;">技师展示</span></div>
					      </cell>
					       <template v-if="showContent004">

					        <div class="store-details-skill-show" v-for="(storeEmp,index) in storeEmpPos" :key="index"  style="font-size:0.26rem ;">
					        	<div class="store-details-skillShow">
					        		<img class="store-details-skill-img" :src=" storeEmp.employePicture " />
					        	</div>
					        	<div class="store-details-skillTxt">
					        		<div class="store-details-skill-txt" >
					        			<span style="line-height: 0.4rem;">姓名：{{storeEmp.employeName}}</span>
					        		</div>
					        		<div class="store-details-skill-txt">
					        			<span style="line-height: 0.4rem;">从业经验：{{storeEmp.employeWorkExperience}}年</span>
					        		</div>
					        		<div class="store-details-skill-txt">
					        			<span style="line-height: 0.4rem;">简介：{{storeEmp.employeBriefIntroduction}}</span>
					        		</div>
					        	</div>
					        </div>
					      </template>

					</group>
				</div>
				<!--评价-->
				<div class="store-details-appraise">
					<!--title-->
					<div class="store-details-appraise-title">
						<div class="store-details-appraise-titleTxt">
							<span class="store-details-title-Txt" style="letter-spacing: 0.04rem;" >门店评价</span>
						</div>
						<div class="store-details-appraise-titleSho">
							<div  class="store-details-appraiseTxt" >
								<span class="store-details-appraise-txt">评价：</span>
							</div>
							<div class="store-details-appraiseShow" @click="comment">
								<img class="store-details-appraiseShow-img" src="../assets/img/icon_pingjia.png" />
							</div>
						</div>

					</div>
					<!--详情-->
					<div class="details" v-for="(storeCommentData,index) in storeCommentDataArrray" :key="index" >
						<div class="details-title">
							<div class="details-title-show">
								<img class="details-title-img" style="margin-top: 0.3rem;margin-left: 0.1rem;" :src="storeCommentData.userHeadPortrait" />
							</div>
							<div  class="details-titleTxt" style="padding-left: 0.3rem;">
								<div class="details-title-name" style="margin-top:0.2rem ;height: 0.48rem;">
									<span style="line-height:0.48rem;">{{storeCommentData.carNo}}</span>
								</div>
								<div class="details-time" style="margin-top:0rem ;height: 0.48rem;">
									<span style="line-height: 0.48rem;font-size: 0.26rem;color: #999999;">{{splitData(storeCommentData.commentDate)}}</span>
								</div>
		      					<div>
		      						<span style="line-height: 0.48rem;color: #999999;font-size: 0.26rem;">车型：{{storeCommentData.carModelName}}</span>
		      					</div>
							</div>
							<div class="details-title-gread">
               					 <span class="store-details-garde-title" >
									<span class="store-details-grade-txt">评分：</span>
								</span>
								<span class="store-details-gradeTitle">
									<span class="store-details-gradeTitle">{{storeCommentData.commentScore}}</span>
								</span>
							</div>
						</div>
						<div class="details-bodyTxt">
							<span class="details-body-txt" > {{storeCommentData.commentContent}}</span >
						</div>
						<div class="details-show">
						</div>
						<div style="padding: 0 0.3rem">
					  		<flexbox :gutter="0" wrap="wrap">
					  			<flexbox-item :span="4" class="details-item" v-for="(storeCommentImager,indexs) in storeCommentData.storeCommentImagerArray" :key="indexs">
					  				<div class="home-evaluate-div " >
					   					<img @click="showItemImager(storeCommentImager.pictureUrl)" class="home-evaluate-img " :src="storeCommentImager.pictureUrl " />
					   				</div>
					  			</flexbox-item>
					  		</flexbox>
				  		</div>
					</div>
				</div>
				<loadmore :onLoadmore="queryCommentByStore" :isEmpty="storeCommentDataArrray.length==0"></loadmore>

	</div>
</template>

<script>
	import axios from 'axios'
	import api from '../Api/api.js';
	import { Rater, Group, Cell,Flexbox, FlexboxItem,XDialog,Swiper,SwiperItem} from 'vux'
	import loadmore from "../component/loadmore.vue"
	import wx from 'weixin-js-sdk';
	import LoadMore from '../component/loadmore.vue';
	export default{
		components: {
        	Rater,
		    Group,
		    Cell,
		    Flexbox,
		    FlexboxItem,
		    loadmore,
		    XDialog,
		    Swiper,
		    LoadMore,
		    SwiperItem
		},
		data(){
			return{
				tempImgUrl:'',
				showHideOnBlur:false,
				showContent004:true,
				storeData:{},
				storeEmpPos:[],
				storeCommentDataArrray:[],
				urlString:"",
				apiUrl:"",
				showList:[],
				demo01_index:0
			}
    },
    created(){
    	this.urlString = api.getStoreDetails;
    	this.apiUrl = api.getDms;
		this.getEvaluateList();
	},
    methods:{
//  	getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
		comment() {
			var _that = this;
			//校验用户有无预约
			const params = {
		        //客户id
		        guestId: localStorage.guestId,
		        //门店id
		        orgid: localStorage.orgid,
		        // 状态  0：全部 ：1：已预约 2： 已完成
		        status: 0
	      	};
	       axios.post(api.allMakeApponintApi, {page:"", params,token: localStorage.token}).then(response=>{
       	       var allMakeApponint = response.data.data || [];
       	       if(allMakeApponint.length == "0"){
			 			_that.$vux.toast.text('请下单后评价');
				}else{
						var storeId=_that.$route.query.storeId;//传入的门店id参数
						var orgid=_that.$route.query.orgid;
//								_that.$router.push('./myComment?storeId='+storeId+'&orgid='+1)
						_that.$router.push({
							    				path:'/myComment',
								    			query: {
								    				storeId:storeId,
								    				orgid:orgid
								    			}
							    			});
				}
	       });
		
		},
		splitData(obj){
			var a = [];
			var b = [];
			var c = [];
			if(obj !== null){
				a = obj.split(" ");
				b = a[0].split("-");
				c = a[1].split(":")
				return  b[0]+"-"+b[1] + "-" + b[2] + " " +c[0]+":"+c[1]
			} 
					
		},
      	//点击进入地图定位
		clickMapStore(storeName,storeStreetAddress,storeLongitude,storeLatitude){
						debugger;
						this.$vux.loading.show({text: 'Loading'});
						var _this = this;
						 _this.$http.post(api.mapUserApi,{url:_this.urlString,token:localStorage.token}).then(function(resDatas) {
						      var data = resDatas.data.map;
						      _this.initMapData(data.timestamp,data.nonceStr,data.qianm1,storeName,storeStreetAddress,storeLongitude,storeLatitude);
						    },
						    function(resDatas) {
						      console.log(resDatas);
						    }
						  );
   		 },
   		 initMapData(timestamp,nonceStr,qianm1,storeName,storeStreetaddress,storeLongitude,storeLatitude){
   		 				this.$vux.loading.hide();
						var storeLatitudeMap = storeLatitude;
						var storeLongitudeMap = storeLongitude;
						var storeNameMap = storeName;
						var storeStreetaddressMap = storeStreetaddress;
						wx.config({
							beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
						    debug: false,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				        	appId: 'wxd10b49dcb45e5591',   			// 必填，企业号的唯一标识，此处填写企业号corpid
				        	timestamp:timestamp, 		// 必填，生成签名的时间戳
				        	nonceStr: nonceStr, 	// 必填，生成签名的随机串
				        	signature: qianm1,		// 必填，签名
						    jsApiList: ['openLocation','getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
						});
						wx.error(function(res){
							alert(JSON.stringify(res));
				    		// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
						});
						wx.ready(function(){
							wx.openLocation({
								latitude:storeLatitudeMap, // 纬度，浮点数，范围为90 ~ -90
								longitude:storeLongitudeMap, // 经度，浮点数，范围为180 ~ -180。
								name: storeNameMap, // 位置名
								address: storeStreetaddressMap, // 地址详情说明
								scale: 25, // 地图缩放级别,整形值,范围从1~28。默认为最大
								infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
							});
							
						});
		},
		getEvaluateList() {
			var _this = this;
			_this.storeData.storePicture="#";

			var storeId=_this.$route.query.storeId;//传入的门店id参数
			var orgid=_this.$route.query.orgid;
			
			_this.urlString += ( "?storeId=" + storeId + "&orgid=" + orgid );
			
		  	var maps={
		  		storeId:storeId,
		  		orgid:orgid
		  	}
		  	return _this.$http.post(api.stoerAndEmpQueryApi,{map:maps,token: localStorage.token}).then(function(resDatas){
	        	var storeDataArray = resDatas.data.storeDataArray[0];//门店信息
	        	var storeEmpPos = resDatas.data.storeEmpPos;//技师;
	        	_this.showList.push({img:resDatas.data.storeDataArray[0].storePicture});
	        	var data = resDatas.data.storeDataArray[0].storeDetailImgs.split(",");
	        	for(var d = 0;d<data.length;d++){
	        		_this.showList.push({img:data[d]});
	        	}
	        	debugger;
	        	console.log(_this.showList);
	        	_this.storeData = storeDataArray;
	        	_this.storeEmpPos = storeEmpPos;
	        	_this.queryCommentByStore();
			})
       },
       figure_onIndexChange (index) {
 			 this.demo01_index = index;
    	},
       queryCommentByStore(){
       		var _this = this;
       		var storeId=_this.$route.query.storeId;//传入的门店id参数
			var orgid=_this.$route.query.orgid;
			var maps={
		  		storeId:storeId,
		  		orgid:orgid
		  	}
			const pageSize = 10;
			var page = {
		  		begin:_this.storeCommentDataArrray.length,
		  		length: pageSize
		  	}
			return _this.$http.post(api.queryCommentByStoreApi,{map:maps, page:page,token: localStorage.token}).then(function(resDatas){
	        	//_this.storeCommentDataArrray = resDatas.data.storeCommentDataArrray;
	        	_this.storeCommentDataArrray = [];
	        	_this.storeCommentDataArrray.push(...resDatas.data.storeCommentDataArrray);
	        	if( !resDatas.data.storeCommentDataArrray || resDatas.data.storeCommentDataArrray.length <= 0 )LoadMore.props.emptyText.default = "暂无评价";
	        	return resDatas.data.page.isLast;
			},function(resDatas){
	        });
       	
	     },
	     showItemImager(e){
	     	debugger;
	     	this.tempImgUrl = e;
			this.showHideOnBlur = true;
	     }
	
	}
}




</script>


<style lang="less" scoped>

.swiper-demo-img img{
	height:100%;
	width:100%;
}

.weui-cells.weui-cells{
	font-size: 0.28rem;
}
#storeDetails {
}
.store-details-go-body-txt{
	letter-spacing: 0.04rem;
}
/*// 图片*/
.store-details {
  > .store-details-img {
    display: block;
    width: 100vw;
    height: 56vw;
    object-fit: cover;
    overflow: hidden;
  }
}

/*// 门店信息*/
.store-details-mess {
  padding: 0 0.32rem;
  background-color: #fff;
  border-bottom: 0.02rem solid #ededed;

  > .store-details-title {
    line-height: 0.8rem;
    display: flex;
    align-items: center;
    justify-content: space-between;

    > .store-details-name {
      letter-spacing: 0.04rem;
    }

    .store-details-gradeTitle {
      color: #3087F7;
    }
  }

  > .store-details-time,
  > .store-details-plat {
    margin: 0.2rem 0;
    display: flex;
    align-items: center;
  }

  .store-details-timeImg,
  .store-details-platImg {
    width: 0.4rem;
    height: 0.4rem;
    margin-right: 0.08rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    > img {
      display: block;
      width: 100%;
    }
  }

  .store-details-timeTxt,
  .store-details-platTxt {
    flex: 1;
  }
}

/*// 地图和电话*/
.store-details-go {
  height: 3em;
  display: flex;
  align-items: center;
  background-color: #fff;
  margin-bottom: 0.2rem;

  > div {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;

    & + div {
      border-left: 0.02rem solid #ededed;
    }

    > .store-details-go-photo {
      display: block;
      margin-right: 0.2rem;

      > img {
        display: block;
        width: 0.4rem;
        height: 0.4rem;
      }
    }
  }
}

/*// 技师展示*/


.store-details-skill-show {
  font-weight: normal;
  padding: 0.32rem;
  border-top: 0.02rem solid #ededed;
  display: flex;
  align-items: flex-start;

  > .store-details-skillShow {
    border-radius: 50%;
    overflow: hidden;
    margin-right: 0.28rem;
    font-size: 0.85rem;

    > img {
      display: block;
      width: 1.1rem;
      height: 1.1rem;
      border-radius: 50%
    }
  }

  > .store-details-skillTxt {
    flex: 1;
    line-height: 1.6;
  }
}

/*// 门店评价*/
.store-details-appraise {
  margin-top: 0.2rem;

/*  // 标题栏*/
  > .store-details-appraise-title {
    line-height: 0.88rem;
    padding: 0 0.32rem;
    background-color: #fff;
    display: flex;
    justify-content: space-between;

    > .store-details-appraise-titleTxt {
    }

    > .store-details-appraise-titleSho {
      display: flex;
      align-items: center;

      img {
        display: block;
        width: 0.4rem;
        height: 0.4rem;
      }
    }
  }

/*  // 门店列表项*/
  > .details {
    /*padding: 17px;*/
    border-top: 0.02rem solid #ededed;
    background-color: #fff;

/*    // 头部信息*/
    > .details-title {
      display: flex;
      align-items: flex-start;
      position: relative;
		padding: 0 0.2rem;
      > .details-title-show {
        margin-right: 8px;
        border-radius: 50%;
        overflow: hidden;

        > img {
          width: 1.1rem;
          height: 1.1rem;
          border-radius: 50%;
        }
      }

      > .details-titleTxt {
        flex: 1;

        > .details-time,
        > .details-body {
          font-size: 0.26rem;
          color: #999;
        }
      }

      > .details-title-gread {
        text-align: right;
        position: absolute;
        right: 0.4rem;
        top: 0.06rem;

        .store-details-gradeTitle {
          font-size: 0.36rem;
          color: #3087F7;
        }
      }
    }

  /*  // 文字*/
    .details-bodyTxt,
    .details-show {
      margin-top: 0.16rem;
      padding: 0 0.3rem;
    }

  /*  // 图片*/
    .home-evaluate-div {
      margin-bottom: 0.15rem;

      img {
        display: block;
        width: 2rem;
        height: 2rem;
        border-radius: 0.25rem;
        background-color: #eee;
        overflow: hidden;
      }
    }
  }
}
</style>
