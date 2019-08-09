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
          <load-more
            class="scroller"
            :on-loadmore="[getAllBooking, getYetBooking, finishBooking][tabIndex]"
            :is-empty="![allList, yetList, finishList][tabIndex].length"
            ref="loadmore"
          >
            <div
              class="myAppment-mess-s"
              v-for="(listItem,innerIndex) in [allList, yetList, finishList][tabIndex]"
              :key="innerIndex"
            >
              <div class="mess-head-s">
                <div class="mess-head-ri-s-ap">
                	<span style="line-height: 0.64rem;width: 5.8rem">{{storeName}}</span>
                  <span class="mess-head-ri-txt-s">{{['已预约', '已完成'][listItem.status]}}</span>
                </div>
              </div>
              <div class="mess-body-s1">
                <div class="mess-body-mess-s">
                  <span class="mess-txt-s"style="line-height: 0.48rem;">车牌号码：{{listItem.carNo}}</span>
                </div>
                <div class="mess-body-time-s">
                  <span class="mess-txt-s"style="line-height: 0.48rem;">预约时间：{{splitData(listItem.predictComeDate)}}</span>
                </div>
                <div class="mess-body-order-s">
                  <span class="mess-txt-s" style="line-height: 0.48rem;">订单号：{{listItem.serviceCode}}</span>
                </div>
              </div>
              <div class="mess-end-s-but" v-if="listItem.status === 0">
               
                <div
                  class="mess-end-but4"
                  @click="remove(listItem, [allList, yetList, finishList][tabIndex], innerIndex)"
                >
                  <span class="but">取消</span>
                </div>
                 <div class="mess-end-but3" @click="modify(listItem)">
                  <span class="but">更改时间</span>
                </div>
              </div>
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
import { XButton, Tab, TabItem, Swiper, SwiperItem } from 'vux';
export default {
  components: {
    LoadMore,
    XButton,
    Tab,
    TabItem,
    Swiper,
    SwiperItem
  },
  data() {
    const clientHeight =
      document.body.clientHeight ||
      document.documentElement.clientHeight ||
      window.innerHeight ||
      0;
    return {
    	apiUrl:"",
      height: clientHeight - 44,
      index: 0,
      list: ['全部', '已预约', '已完成'],
      demo2: 'all',
      allList: [],
      yetList: [],
      finishList: [],
      tabKeys: ['all', 'yet', 'finish'],
      tabValueMap: {},
      storeName:localStorage.storeName,
    };
  },
  mounted() {
    this.$refs.loadmore.forEach(item => item.loadmore());
  },
   created() {
//		this.getToken();
			LoadMore.props.emptyText.default = "暂无预约";
			if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前是否绑定用户
    		LoadMore.props.normalText.default = "暂无预约";
    		return; 
    	}else{
    		LoadMore.props.normalText.default = "点击加载更多";
    	}
			this.apiUrl = api.getDms;
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
    changeIndex(index) {},
    // 加载更多
    async onLoadmore(index) {
    	if( !localStorage.guestId || localStorage.guestId == "undefined" || localStorage.guestId == "null" ){//判断当前是否绑定用户
    		LoadMore.props.normalText.default = "暂无预约";
    		return; 
    	}else{
    		LoadMore.props.normalText.default = "点击加载更多";
    	}
      const list = [this.allList, this.yetList, this.finishList][index];
      const pageSize = 10;
      const page = {
        begin: list.length,
        length: pageSize
      };
      const params = {
        //客户id
        guestId: localStorage.guestId,
        //门店id
        orgid: localStorage.orgid,
        // 状态  0：全部 ：1：已预约 2： 已完成
        status: index
      };
      const { data } = await axios.post(api.allMakeApponintApi, {
        page,
        params,
        token: localStorage.token
      });
      if (data.errCode === 'E') {
        throw new Error("暂无数据");
      }
      list.push(...data.data);
      return data.page.isLast;
    },
    //全部预约
    getAllBooking() {
      return this.onLoadmore(0);
    },
    //已预约
    getYetBooking() {
      return this.onLoadmore(1);
    },
    //已完成
    finishBooking() {
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
							 return  b[0]+"-"+b[1] + "-" + b[2] + " " +c[0]+":"+c[1]
							} 
					
		},

    // 更改预约时间
    modify(item) {
    	item.carNum=item.carNo;
      this.$router.push({
        path: './makeAppointTime',
        query: {
          ...item,
          type: 'time'
        }
      });
    },
    // 取消预约
    remove(item, list, index) {
    this.showPlugin(item, list, index);
    },
    
    showPlugin (item, list, index) {
      const _this=this;
      this.$vux.confirm.show({
        title: '系统提示',
        content: '确定取消预约？',
        onCancel () {
          console.log('plugin cancel');
        },
        onConfirm () {
           axios.post(api.addMakeApponintApi, {
		        rpsPrebook: {
		          ...item,
		          status: 2
		        },
		        openid: localStorage.openId,
		        token: localStorage.token,
		        action: 'cancel'
		      }).then(res=>{
	      		  if (res.data.errCode === 'S') {
			        _this.$vux.toast.text('取消成功');
			        _this.yetList = [];
			        _this.allList = [];
			        _this.finishList = [];
			        _this.getYetBooking();
			        _this.getAllBooking();
			        _this.finishBooking();
			      } else {
			        _this.$vux.toast.text(res.data.errMsg || '取消失败');
			      }
		      }).catch(res=>{
		      	// _this.$vux.toast.text('取消失败');
		      })
        }
      })
    }
  }
};
</script>
 <style >
 .mess-head-s{
 	margin-top: 0.2rem;
 	background: #FFFFFF;
 	border-bottom: #EDEDED 0.02rem solid; 
 }
 .mess-body-s1{
 		display: flex;
 		flex-direction:column-reverse;
 		background: #FFFFFF;
 		height: 1.55rem;
    padding-bottom: 0.15rem;
 	}
 .mess-head-ri-s-ap{
 		padding-left: 0.32rem;
 		height: 0.64rem;
 		display: flex;
    flex-direction: row;
 	}
 	.mess-body-order-s{
 		height: 0.48rem;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-body-mess-s{
 		height: 0.48rem;
 		font-size:0.26rem ;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-body-time-s{
 		height: 0.48rem;
 		font-size:0.26rem ;
 		display: flex;
    flex-direction: row;
    padding-left: 0.32rem;
 	}
 	.mess-txt-s{
 		line-height: 0.48rem;
 		}
 	.mess-end-s-but{
 		border-top: 0.02rem solid #EDEDED;
 		background: #FFFFFF;
 		height: 0.9rem;
 		display: flex;
 		 flex-direction: row-reverse;
 		 padding-right: 0.3rem;
    align-items: center;
 	}
 	.mess-end-but3{
 		padding-left: 0.2rem;
    padding-right: 0.2rem;
 		border:0.02rem solid #878786;
 		/*width: 1.2rem;*/
 		height: 0.54rem;
 		/*align-items: center;*/
 		text-align: center;
 		border-radius:0.1rem ;
 		margin-right: 0.3rem;
 			
 		
 	}
 	.mess-end-but4{
 		padding-left: 0.2rem;
    padding-right: 0.2rem;
 		height: 0.54rem;
 		/*width: 1.2rem;*/
		/*align-items: center;*/
		border:0.02rem solid #878786;
		text-align: center;
		border-radius:0.1rem ;
 	}
 	.but{
 		font-size: .26rem;
 		color:#878786 ;
 			line-height: 0.54rem;
 	}
 	.scroller {
  height: 100%;
  overflow: auto;
}
.mess-head-ri-txt-s{
	line-height: 0.64rem;
	color: #3087F7;
} 
.myAppment-txt{
	}

</style>
