<template>
  <div id="myAppointment">
    <div class="myAppment">
      <tab
        active-color="#3B8CF7"
        default-color="#3f3f3f"
        bar-active-color="#3B8CF7"
        v-model="index"
      >
        <tab-item
          :selected="demo2 === key"
          v-for="(key,index) in tabKeys "
          @click="demo2 = key"
          :key="index"
        >
          <span class="myAppment-txt">{{list[index]}}</span>
        </tab-item>
      </tab>
      <swiper
        v-model="index"
        :show-dots="false"
        :height="height + 'px'"
        @on-index-change="changeIndex"
      >
        <swiper-item v-for="tabIndex in [0, 1, 2]" :key="tabIndex" ref="scroller">
          <load-more class="scroller" :on-loadmore="[getAllCoupon,getYetCoupon,finishCoupon][tabIndex]" :is-empty="![allList, yetList, finishList][tabIndex].length" ref="loadmore" >
            <div class="myAppment-mess-s" v-for="(listItem,innerIndex) in [allList, yetList, finishList][tabIndex]"  :key="innerIndex">
             			<div class="myCoupon-body" >
						    	  		<div class="myCoupon-body-money">
						    	  	 		<div class="myCoupon-body-nbm">
						    	  	 			<span class="myCoupon-body-money-txt1">￥{{listItem.couponDiscountsPrice}}</span>
						    	  	 		</div>
						    	  	 		<div class="myCoupon-body-type">
						    	  	 			<span class="myCoupon-body-money-txt2">{{['', '通用券', '专属券'][listItem.couponType]}}</span>
						    	  	 		</div>
						    	  	 	</div>
						    	  	 	<div class="myCoupon-body-mess">
								    	  	 		<div class="mess-title"> 
								    	  	 			<div class="mess-title-a">
								    	  	 				<span class="mess-title-a-txt">{{listItem.couponTitle}}</span>
								    	  	 			</div>
								    	  	 			<div class="mess-title-status" v-if="index === 1">
								    	  	 				<span >已过期</span>
								    	  	 			</div>
								    	  	 			<div class="mess-title-status" v-else-if="index === 2">
								    	  	 				<span>已核销</span>
								    	  	 			</div>	
								    	  	 			<div v-else class="mess-title-b" >
								    	  	 				<img  class="mess-title-b-img" @click="QRcode = listItem.userCouponCode" src="../assets/img/icon_erweima.png" />
								    	  	 				<!--<qrcode size="60"  :value="QRcode" :fg-color="fgColor"></qrcode>-->
								    	  	 			</div>
								    	  	 		</div>
								    	  	 		<div class="mess-body"> 
								    	  	 			<span class="mess-txt">(到店使用)</span>
								    	  	 		</div>
								    	  	 		<div class="mess-end"> 
								    	  	 			<span class="mess-txt">有效期：{{listItem.couponBeginDate}} ~ {{listItem.couponEndDate}}</span>
								    	  	 		</div>
						    	  		</div>
		    	 				</div>	
             </div>
             <div class="mask" v-if="QRcode" @click="QRcode = null" >             	
             	<qrcode size="200"  :value="QRcode" :fg-color="fgColor"></qrcode>
             </div>
          </load-more>
        </swiper-item>
      </swiper>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import api from '../Api/api.js';
import LoadMore from '../component/loadmore.vue';
import { XButton, Tab, TabItem, Swiper, SwiperItem,Qrcode,AlertModule } from 'vux';
export default {
  components: {
    LoadMore,
    XButton,
    Tab,
    TabItem,
    Swiper,
    SwiperItem,
    Qrcode,
    AlertModule
  },
  data() {
    const clientHeight =
      document.body.clientHeight ||
      document.documentElement.clientHeight ||
      window.innerHeight ||
      0;
    return {
    	QRcode:false,
      height: clientHeight - 44,
      index: 0,
      list: ['待使用', '已过期', '已核销'],
      demo2: 'all',
      allList: [],
      yetList: [],
      finishList: [],
      tabKeys: ['all', 'yet', 'finish'],
      tabValueMap: {}
    };
  },
  mounted() {
    this.$refs.loadmore.forEach(item => item.loadmore());
  },
   created() {
  	LoadMore.props.emptyText.default = "暂无此优惠劵";
  	if( !localStorage.storeId || localStorage.storeId == "undefined" || localStorage.storeId == "null" ){//判断当前是否缓存里有门店id
	  	LoadMore.props.normalText.default = "暂无优惠劵";
	  	return;
	  }else{
	  	LoadMore.props.normalText.default = "点击加载更多";
	  }
//		this.getToken();
		
	},
  methods: {
//	getToken(){
//							axios.post(api.getTokenApi,{password:"000000",userId:"YX001"}).then(response => {
//								 var  token = response.data.data.attributes.token;
//								 localStorage.setItem("token",token);
//								 this.bootstrap = true
//							});
//					},
    // 切换
    changeIndex(index) {
    	this.allList = []
    	this.yetList = []
    	this.finishList = []
    	this.$refs.loadmore[index].loadmore();
    },
    // 加载更多
    async onLoadmore(index) {
      const list = [this.allList, this.yetList, this.finishList][index];
      const pageSize = 10;
      const page = {
        begin: list.length,
        length: pageSize
      };
      if( !localStorage.storeId || localStorage.storeId == "undefined" || localStorage.storeId == "null" ){//判断当前是否缓存里有门店id
      	LoadMore.props.normalText.default = "暂无优惠劵";
      	return;
      }else{
      	LoadMore.props.normalText.default = "点击加载更多";
      } 
      console.log(558, list, this.allList, this.yetList, this.finishList)
      const { data } = await axios.post(api.getCouponApi, {
        page,
        state:index,
        userId:localStorage.userId,
        storeId:localStorage.storeId,
        token: localStorage.token
      }).then(function(response){
      	console.log(response);
      	return response
      })
      if (data.errCode === 'E') {
        throw new Error("暂无数据");
      }
      list.push(...data.couponList);
      return data.page.isLast;
    },
   
    //待使用优惠卷
    getAllCoupon(){
      return this.onLoadmore(0);
    },
    //已过期优惠卷
    getYetCoupon(){
      return this.onLoadmore(1);
    },
    //已核销优惠卷
    finishCoupon(){
      return this.onLoadmore(2);
    },
    splitData(obj){
							var a = [];
							var b = [];
							var c = [];
							if(obj !== null){
							 a = obj.split(" ");
							 b = a[0].split("-");
							 c = a[1].split(":")
							 return  b[0]+"-"+b[1] + "-" + b[2] + "" +c[0]+":"+c[1]
							} 
					
		},
		showCode(){
				this.QRcode = !this.QRcode;
		}
  }
};
</script>
 <style scoped="scoped">
 	.mess-title-status{
 		    display: flex;
    flex-direction: row-reverse;
    padding-right: 0.3rem;
    padding-top: 0.171rem;
 		}
 	.mask{
			 		position: fixed;
			  top: 0;
			  right: 0;
			  bottom: 0;
			  left: 0;
			  background-color: rgba(0,0,0,.5);
			  text-align: center;
			  display: flex;
			  justify-content: center;
			  align-items: center;
			 
 	}
 	 	.scroller {
  height: 100%;
  overflow: auto;
}
	.myCoupon{
		float: left;
		width: 100%;
	}
	.myCoupon-txt{
		font-size: 0.54rem;
		letter-spacing: 0.04rem;
	}
	/*优惠券*/
	.myCoupon-show{
		margin-top: 0.2rem;
		float: left;
		width: 100%;
	}
	.myCoupon-body{
		margin-top: 0.2rem;
		float: left;
		width: 92%;
		margin-left: 4%;
		margin-right: 4%;
		height: 2.4rem;
		border-radius:0.1rem ;
		background-color: #FFFFFF;
	}
	.myCoupon-body-money{
		float: left;
		width: 30%;
		height: 100%;
		background-image: url(../assets/img/img_2.png);
		background-size: 100% 2.4rem;
	}
	.myCoupon-body-mess{
		float: left;
		width: 70%;
		height: 2.4rem;
	}
	/*.myCoupon-body-photo-img{
		height: 120px;
		width: 100px;
	}*/
	.myCoupon-body-nbm{
		float: left;
		height: 1.2rem;
		width: 100%;
		text-align: center;
	}
	.myCoupon-body-type{
		text-align: center;
		float: left;
		height: 1.2rem;
		width: 100%;
	}
	.myCoupon-body-money-txt1{
		color: #FFFFFF;
		font-size:0.4rem ;
		line-height: 1.2rem;
			letter-spacing:0.04rem;
			padding-right:0.2rem ;
	}
	.myCoupon-body-money-txt2{
		color: #FFFFFF;
		line-height: 1.2rem;
		letter-spacing:0.04rem;
		padding-right:0.1rem;
		font-size: 0.35rem;
	}
	.mess-title{
		float: left;
		height: 0.8rem;
		width: 100%;
	}
	.mess-body{
		float: left;
		height: 0.8rem;
		width: 100%;
	}
	.mess-end{
		float: left;
		height: 0.8rem;
		width: 100%;
	}
	.mess-txt{
		font-size:0.26rem ;
		line-height: 0.8rem;
		padding-left:0.2rem ;
	}
	.mess-title-a{
		float: left;
		height: 100%;
		width: 75%;
	}
	
	.mess-title-b{
		float: left;
		height: 100%;
		width: 20%;
	}
	.mess-title-a-txt{
		line-height: 0.8rem;
		padding-left: 0.2rem;
	}
	.mess-title-b-img{
		float: right;
		width: 0.5rem;
		height: 0.5rem;
		padding-right: 0.2rem;
		padding-top: 0.15rem;
	}

</style>


