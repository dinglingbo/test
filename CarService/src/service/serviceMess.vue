<template>
	<div class="serviceMess">
		<div v-transfer-dom>
  			<x-dialog v-model="showHideOnBlur" hide-on-blur>
  				<div class="img-box">
          			<img :src=" tempImgUrl " style="max-width:100%">
        		</div>
  			</x-dialog>
		</div>
		<div class="show">
				<div class="mess-title" @click="showItemImager(wxbServiceItem.serviceItemPicture)" >
					<img class="mess-title-img" :src=" wxbServiceItem.serviceItemPicture " />
				</div>
				<!--服务信息-->
				<div class="service-mess">
					<div class="service-mess-title" style="display: flex;">
						<div style="width: 50%;">
							<span class="service-mess-title-txt">{{wxbServiceItem.serviceItemName}}</span>
						</div>



					</div>
					<div class="service-show">
						<div class="service-money">
							<span class="service-money-txt">￥{{ parseFloat(wxbServiceItem.couponTotalAmt).toFixed(2) }}</span>
						</div>
						<div class="service-sell">
							<span class="service-sell-txt">库存量:{{ wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber : '不限' }}</span >
						</div>
            			<div class="service-num" :style="wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber == 0 ? 'display:none;' : 'display: flex;' : 'display: flex;' " >
					        <div class="reducediv" :style="wxbServiceItem.shoppingNumberClass ? 'display:block' : 'display:none' " >
					          <div class="reduceimg" style @click="clickReduceimg" ></div>
					        </div>
					        <div class="numberFoods" :style="wxbServiceItem.shoppingNumberClass ? 'display:block' : 'display:none' " >
					          <span  >{{ wxbServiceItem.serviceItemNum ? wxbServiceItem.serviceItemNum : 0}}</span>
					        </div>
					        <div id="cs" class="plusdiv" style>
					          <div class="plusimg"  @click="clickPlusimg" style ></div>
					        </div>
				      	</div>
				      	<div class="service-num" :style="wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber == 0 ? 'display: flex;' : 'display:none;' : 'display:none;' " >
            				<span style="position: absolute;left: 80%;color: #828282;">已售馨</span>
            			</div>
					</div>
				</div>
				<!--商品详情-->
				<div class="mess-body">
					<div class="mess-body-title">
						<span class="mess-body-title-txt">商品详情</span >
					</div>
					<div class="mess-body-details" v-for="(serviceItemPicture,index) in serviceItemPictureArray" :key="index" >
						<img class="mess-details-img" :src=" serviceItemPicture.pictureUrl " @click="showItemImager(serviceItemPicture.pictureUrl)"/>
					</div>
					<!--<div class="mess-body-details">
						<img class="mess-details-img" src="../assets/imgCs/1551962795(1).jpg" />
					</div>
					<div class="mess-body-details">
						<img class="mess-details-img" src="../assets/imgCs/1551962848(1).jpg"/>
					</div>-->

				</div>
		</div>
		<!--购物-->
		<div class="shoppingCar" >
			<div class="serviceItemPrice" >
				<div class="wz_box" @click.stop="clickServiceItemShopping">
					<a href="javascript:void();" id="goods_cart" class="goods_cart">
						<img src="../assets/img/shoppingCartAdd.png" class="carImg" >
						<span class="total_num">{{totalNumber}}</span>
					</a>
					<p class="fontcl1">
						￥<big class="totalPrice" disabled="disabled">{{ parseFloat(totalMoney).toFixed(2) }}</big>
					</p>
					<p class="black9"></p>
				</div>
				<a @click.stop="cleanShoppingSettlement" id="order_create" class="btn" >去结算</a>
			</div>

			<div class="car-mask" v-if="showOrderCar" @click.self="hideShoppingCart">
		        <header class="car-title">
		        	<div class="car_shoppingCart"><i class="car_lit" ></i>购物车</div>
		          <div class="car-empty" @click.stop="cleanShoppingItem" >清空</div>
		        </header>
		        <section class="car-order-list">

				  <div class="car-order-item" :style=" Boolean(showShoppingNullBool) ? 'display:block' : 'display:none' ">
		            <div class="car-item-tips">~~空空如也~~</div>
		          </div>

		          <div class="car-order-item" v-for="(shoppingItem,index) in shoppingItemArray" :key="index" :style=" Boolean( shoppingItem.showShoppingBool ) ? 'display:flex' : 'display:none' ">
		            <div class="car-item-name">{{shoppingItem.serviceItemName}}</div>
		            <div class="car-item-price">￥{{shoppingItem.serviceItemPrice}}</div>
		            <div class="car-counter">
		              <div class="img-reduce" @click="reduceShoppingItemNum(index,shoppingItem.serviceItemNum)" ></div>
		              <div class="car-item-count">{{shoppingItem.serviceItemNum}}</div>
		              <div class="img-plus" @click="addShoppingItemNum(index,shoppingItem.serviceItemNum)" ></div>
		            </div>
		          </div>

		        </section>
		    </div>

		</div>


	</div>
</template>

<script>
import api from '../Api/api.js';
import { AlertModule,XDialog,TransferDomDirective as TransferDom } from "vux";
export default {
	directives: {
    	TransferDom
  	},
	components: {
    	XDialog,
    	AlertModule
  	},
 	data(){
  		return{
  			tempImgUrl : '',
  			showHideOnBlur:false,
  			wxbServiceItem: {},
  			serviceItemPictureArray:[],
  			totalMoney: 0.0, //总金额
      		totalNumber: 0, //总数
      		showShoppingNullBool: true,
      		showOrderCar: false,
      		shoppingItemArray:[],
      		addItemArray:[],
  			apiUrl: ""
  		}
 	},
  	created() {
//		this.getToken();
  		var _this = this;
  		_this.apiUrl = api.getDms;
  		var nowDate = new Date();
    	var nowDateString = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate();
  		//查询服务项目
        var serviceItemMap = {
          storeId: localStorage.storeId, //门店
          nowData: nowDateString, //当前日期
          serviceItemType: _this.$route.query.serviceItemType, //项目类型：普通项目，套餐项目
          carModelId: localStorage.carModelId, //车型id
          userId: localStorage.userId, //用户id
          serviceItemId:_this.$route.query.serviceItemId
        };
        serviceItemMap.serviceTypeId = _this.$route.query.serviceTypeId; //业务id
        _this.$http.post(api.serviceItemQueryApi,{
              map: serviceItemMap,
              orgId: localStorage.orgid,
              tenantId: localStorage.tenantId,
              token: localStorage.token
        }).then(
			function(ress) {
				var wxbServiceItemArray = ress.data.wxbServiceItemArray || [];
				console.log(23, wxbServiceItemArray)
				_this.wxbServiceItem = wxbServiceItemArray[0];
				console.log("微信服务项目", _this.wxbServiceItem);
			},
	        function(ress) {
	          console.log(ress);
	        }
        );


        //查询项目简介的图片
        var map={serviceItemId:_this.$route.query.serviceItemId};
        _this.$http.post(api.serviceItemPictureQueryApi,{map: map,token: localStorage.token}).then(
			function(ress) {
				var serviceItemPictureData = ress.data.serviceItemPictureData;
				_this.serviceItemPictureArray = serviceItemPictureData;
				console.log("微信服务项目图片", _this.serviceItemPictureArray);
			},
	        function(ress) {
	          console.log(ress);
	        }
        );

        //查询购物车
	    var maps = {
	      storeId: localStorage.storeId,
	      userId: localStorage.userId
	    };
	    _this.$http.post(api.shoppingCartTotalQueryApi,{ map: maps ,token: localStorage.token}).then(function(resDatas) {
		      var shoppingData = resDatas.data.shoppingCartTotal[0];
		      _this.totalMoney = Number( parseFloat( shoppingData.shoppingCartTotal? shoppingData.shoppingCartTotal : 0 ).toFixed(2) );
		      _this.totalNumber = shoppingData.totalNumber ? shoppingData.totalNumber : 0;
		      if (_this.totalNumber > 0){//判断购物车是否有项目存在
	        	document.getElementsByClassName("btn")[0].style.background="#3087f7";
	          }else{
	        	document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
	          }
		      
		      console.log("微信购物车总数", shoppingData);
		      var shoppingDataArray = resDatas.data.shoppingCartList;
		       shoppingDataArray.length > 0 ? _this.showShoppingNullBool=false :_this.showShoppingNullBool=true ;
		      _this.shoppingItemArray=shoppingDataArray;
		      console.log("微信购物车", shoppingDataArray);

		    },
		    function(resDatas) {
		      console.log(resDatas);
		    }
		  );
		  
	},
	//离开页面触发事件
	destroyed: function () {
    	var _this = this;
		//_this.clickServiceItemShopping();
	},
	
	methods: {
		//点击进行结算
		cleanShoppingSettlement: function(){
			var _this = this;
			if( _this.totalNumber > 0 ){//如果此业务下没有项目则不添加购物车
				_this.clickServiceItemShopping("shoppingCarAddOrder")//将选择的项目添加到购物车
			}else{
				AlertModule.show({
					title: '温馨提示',
					content: "请选择项目添加进购物车",
					onHide(){
				
	        		}
	    		});
			}
			
			
		},
		//将购物车的项目生成订单
		shoppingCarAddItemOrder: function(){
			var _this = this;
	  		var shoppingMap={
	  			storeId: localStorage.storeId,
		      	userId: localStorage.userId,
		      	tenantId:localStorage.tenantId,
		      	carId:localStorage.carid
	  		}
	  		_this.$http.post(api.queryUserShoppingAddUserOrderApi,{
	  			storeId: localStorage.storeId,
		      	userId: localStorage.userId,
		      	tenantId:localStorage.tenantId,
		      	carId:localStorage.carid,
		      	token:localStorage.token}).then(function(resDatas) {
		      	var data = resDatas.data;
		      	if(data.errCode == "S"){//订单生成成功
		      		//清空购物车的操作
		      		_this.shoppingItemArray=[];
		  			_this.showShoppingNullBool=true;
		  			_this.totalMoney=0.0;
		      		_this.totalNumber=0;
		      		_this.wxbServiceItem.serviceItemNum=0;
		      		_this.wxbServiceItem.shoppingNumberClass=false;
		      		document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
          			//跳转订单详情页面
		      		_this.$router.push({
						path:'/myOrderMess',
						query: {
							orderId:resDatas.data.userOrderData.orderId
						}
					});
		      	}else if(data.errCode == "E"){//订单生产失败
		      		AlertModule.show({
								title: '温馨提示',
	        			content: data.errMsg,
	        			onHide(){
	        				
				        }
		        	});
		      		
		      	}
	          
	        },
	        function(resDatas) {
	            console.log(resDatas);
	        }
	      );
		},
		//清空购物车
	  	cleanShoppingItem : function(){
	  		console.log("清除");
	  		var _this = this;
	  		var deleteMap={
	  			storeId: localStorage.storeId,
		      	userId: localStorage.userId
	  		}
	  		_this.$http.post(api.userShoppingCartDeleteApi,{deleteMap: deleteMap,token: localStorage.token}).then(function(resDatas) {
	          	_this.shoppingItemArray=[];
	  			_this.showShoppingNullBool=true;
	  			_this.totalMoney=0.0;
	      		_this.totalNumber=0;
	      		_this.wxbServiceItem.serviceItemNum=0;
	      		_this.wxbServiceItem.shoppingNumberClass=false;
	      		document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
	          	console.log("清空微信购物车", resDatas);
	        },
	        function(resDatas) {
	            console.log(resDatas);
	        }
	      );
	  	},
		//操作购物车里的项目和业务类别里的项目数量同步
	  	synchronizationItemNum: function(data){
	  		var _this = this;
			_this.wxbServiceItem.serviceItemNum=data.serviceItemNum;
			if(data.serviceItemNum <= 0 )_this.wxbServiceItem.shoppingNumberClass = false;
	  	},
		//需要添加到数据库的项目
	  	addItemArrayData: function(data){
	  		var _this = this;
	  		if(_this.addItemArray.length>0){
  				var bool=true;
				for(var a=0; a < _this.addItemArray.length;a++){
					if( _this.addItemArray[a].serviceItemId == data.serviceItemId){
						bool=false;
						_this.addItemArray[a]=data;
					}
					if(bool && a == _this.addItemArray.length-1 ){
						_this.addItemArray.push(data);
					}
				}
			}else{
				_this.addItemArray.push(data);
			}
	  	},
		//在购物车里加项目数量
	  	addShoppingItemNum: function(index,serviceItemNum){
	  		var _this = this;
	  		var num = _this.shoppingItemArray[index].itemNumber - _this.shoppingItemArray[index].itemTotalNumber
	  		if( ( Number(serviceItemNum)+1 ) <= num || _this.shoppingItemArray[index].itemNumberStatus == 0 ){//小于库存量
	  			_this.shoppingItemArray[index].serviceItemNum = Number(serviceItemNum) + 1 ;
	  			_this.synchronizationItemNum(_this.shoppingItemArray[index]);//操作购物车里的项目和业务类别里的项目数量同步
	  			_this.addItemArrayData(_this.shoppingItemArray[index]);//将项目添加到要添加到数据的购物车数组里
	  			//总数加和总价格加
		        _this.totalNumber += 1;
		        var totalMoneyss = Number(_this.totalMoney) + Number( parseFloat(_this.shoppingItemArray[index].serviceItemPrice).toFixed( 2 ) );
		        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
		        //购物车总数的样式判断
		        if (_this.totalNumber == 10) document.getElementsByClassName("total_num")[0].style.padding = "0 0.04rem";
		        if (_this.shoppingItemArray[index].serviceItemNum == 1) {
		          _this.shoppingItemArray[index].showShoppingBool = true;
		        }
		        if (_this.totalNumber > 0){//判断购物车是否有项目存在
        			document.getElementsByClassName("btn")[0].style.background="#3087f7";
        		}
	  		}
	  	},
		//在购物车里减项目数量
	  	reduceShoppingItemNum: function(index,serviceItemNum){
	  		var _this = this;
	  		if( ( Number(serviceItemNum) - 1 ) >= 0 ){
	  			_this.shoppingItemArray[index].serviceItemNum = Number(serviceItemNum) - 1 ;
	  			_this.synchronizationItemNum(_this.shoppingItemArray[index]);//操作购物车里的项目和业务类别里的项目数量同步
	  			_this.addItemArrayData(_this.shoppingItemArray[index]);//将项目添加到要添加到数据的购物车数组里
	  			//总数减和总价格减
		        _this.totalNumber -= 1;
		        var totalMoneyss = Number(_this.totalMoney) - Number( parseFloat(_this.shoppingItemArray[index].serviceItemPrice).toFixed( 2 ) );
		        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
		        //购物车总数的样式判断
		        if (_this.totalNumber == 9) document.getElementsByClassName("total_num")[0].style.padding = "0 0.1rem";
		        if (_this.shoppingItemArray[index].serviceItemNum == 0) {
		          _this.shoppingItemArray[index].showShoppingBool = false;
		        }
		        _this.totalNumber > 0 ? _this.showShoppingNullBool=false :_this.showShoppingNullBool=true ;
		        if (_this.totalNumber <= 0){//判断购物车是否有项目存在
		        	document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
		        }
	  		}

	  	},
		clickPlusimg: function() {
	      //加
	      var _this = this;
	      var num = _this.wxbServiceItem.itemNumber - _this.wxbServiceItem.itemTotalNumber;
	      if ( _this.wxbServiceItem.serviceItemNum + 1 <= num || _this.wxbServiceItem.itemNumberStatus == 0 ) {
	        _this.wxbServiceItem.serviceItemNum += 1;
	        //总数加和总价格加
	        _this.totalNumber += 1;
	        var totalMoneyss = Number(_this.totalMoney) + Number( parseFloat(_this.wxbServiceItem.couponTotalAmt).toFixed( 2 ) );
	        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
	        //购物车总数的样式判断
	        if (_this.totalNumber == 10) document.getElementsByClassName("total_num")[0].style.padding = "0 0.04rem";
	        if (_this.wxbServiceItem.serviceItemNum == 1) {
	          _this.wxbServiceItem.shoppingNumberClass = true;
	        }
	        if (_this.totalNumber > 0){//判断购物车是否有项目存在
        		document.getElementsByClassName("btn")[0].style.background="#3087f7";
        	}
	        _this.clickServiceItemShopping("addItemShopping");//加入购物车
	        
	      }
	    },
		clickReduceimg: function() {
	      //减
	      var _this = this;
	      if (_this.wxbServiceItem.serviceItemNum - 1 >= 0) {
	        _this.wxbServiceItem.serviceItemNum -= 1;
	        //总数减和总价格减
	        _this.totalNumber -= 1;
	        var totalMoneyss = Number(_this.totalMoney) - Number( parseFloat(_this.wxbServiceItem.couponTotalAmt).toFixed( 2 ) );
	        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
	        //购物车总数的样式判断
	        if (_this.totalNumber == 9) document.getElementsByClassName("total_num")[0].style.padding = "0 0.1rem";
	        if (_this.wxbServiceItem.serviceItemNum == 0) {
	          _this.wxbServiceItem.shoppingNumberClass = false;
	        }
	        if (_this.totalNumber <= 0){//判断购物车是否有项目存在
        		document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
        	}
	        _this.clickServiceItemShopping("addItemShopping");//加入购物车
	      }
	   },
		showItemImager: function(e){
			this.showHideOnBlur=true;
			this.tempImgUrl = e;
		},
		clickServiceItemShopping: function(judeString){
			var _this = this;
			var shoppingCartArray = [];
	        var shoppingCartData = {
	          storeId: localStorage.storeId,
	          serviceItemId: _this.wxbServiceItem.serviceItemId,
	          serviceItemPrice: parseFloat( _this.wxbServiceItem.couponTotalAmt ).toFixed(2),
	          serviceItemNum: _this.wxbServiceItem.serviceItemNum,
	          userId: localStorage.userId,
	          userOpid: localStorage.openId,
	          shoppingCartTotal: _this.totalMoney
	        };
	        shoppingCartArray.push(shoppingCartData);
	        _this.$http.post(api.itemShoppingCartAddApi,{
	            shoppingCartArray: shoppingCartArray,
	            shoppingCartTotal: _this.totalMoney,
	            token: localStorage.token
	        }).then(function(resDatas) {
	        	if(judeString && judeString == "shoppingCarAddOrder"){//将购物车的项目生成订单，清空购物车
	        		_this.shoppingCarAddItemOrder();
	        	}else if(judeString && judeString == "addItemShopping"){
	        		
	        	}else{
	        		_this.queryShoppingList();//查询出购物车
	        	}
	        },function(resDatas) {
	            console.log(resDatas);
	          }
	        );


		},
		//查询出购物车
	  	queryShoppingList:function(){
	  		var _this = this;
	  		_this.showOrderCar = !_this.showOrderCar;
	  		//查询购物车
		    var maps = {
		      storeId: localStorage.storeId,
		      userId: localStorage.userId
		    };
		    _this.$http.post(api.shoppingCartTotalQueryApi,{ map: maps ,token: localStorage.token}).then(function(resDatas) {
			      var shoppingData = resDatas.data.shoppingCartTotal[0];
			      _this.totalMoney = Number( parseFloat( shoppingData.shoppingCartTotal? shoppingData.shoppingCartTotal : 0 ).toFixed(2) );
			      _this.totalNumber = shoppingData.totalNumber ? shoppingData.totalNumber : 0;
			      console.log("微信购物车总数", shoppingData);
			      var shoppingDataArray = resDatas.data.shoppingCartList;
			       shoppingDataArray.length > 0 ? _this.showShoppingNullBool=false :_this.showShoppingNullBool=true ;
			      _this.shoppingItemArray=shoppingDataArray;
			      console.log("微信购物车", shoppingDataArray);
			    },
			    function(resDatas) {
			      console.log(resDatas);
			    }
			  );
	  	},
		hideShoppingCart: function(){
			var _this = this;
	  		_this.showOrderCar = false;
			var shoppingCartArray = [];
		   	for (var b = 0; b < _this.addItemArray.length; b++) {
		        var shoppingCartData = {
		          storeId: localStorage.storeId,
		          serviceItemId: _this.addItemArray[b].serviceItemId,
		          serviceItemPrice: parseFloat( _this.addItemArray[b].serviceItemPrice ).toFixed(2),
		          serviceItemNum: _this.addItemArray[b].serviceItemNum,
		          userId: localStorage.userId,
		          userOpid: localStorage.openId,
		          shoppingCartTotal: _this.totalMoney
		        };
	        	shoppingCartArray.push(shoppingCartData);
		        if (b == _this.addItemArray.length - 1) {
		          _this.$http.post(api.itemShoppingCartAddApi,{
		                shoppingCartArray: shoppingCartArray,
		                shoppingCartTotal: _this.totalMoney,
		                token: localStorage.token
		          }).then(function(resDatas) {
		                console.log("离开购物车时添加到微信购物车", resDatas);
		              },
		              function(resDatas) {
		                console.log(resDatas);
		              }
		           );

		        }
	        }
		}
	}
}
</script>

<style scoped="scoped">
	/*购物车样式*/
	.car-item-tips{
	text-align: center;
	width: 100%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	letter-spacing: 0.16rem;
}
.car_shoppingCart{
	padding: 0 0.24rem;
	margin-right: 4.44rem;
	letter-spacing: 0.02rem;
	display:  flex;
	align-items: center;
}
	.car_lit{
 display: inline-block;
  width: 0.06rem;
  margin-right: 0.1rem;
	height: 50%;
	background-color: #3087F7;
}
.car-mask {
  position: fixed;
  top: 0;
  bottom: 1rem;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

.car-title {
    height: 0.62rem;
	line-height: 0.62rem;
	background-color: #EDF2F5;
	display: -webkit-box;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: space-between;
	-webkit-justify-content: space-between;
	justify-content: space-between;
}

.car-empty {
	font-size: 0.26rem;
  letter-spacing: 0.02rem;
  padding: 0 0.24rem;
}

.car-order-list {
  max-height: 4.86rem;
  overflow: auto;
  background: #fff;
  padding-bottom: 0.1rem;
}

.car-order-item {
  height: 0.84rem;
  line-height: 0.8rem;
  overflow: hidden;
  display: flex;
  padding: 0 0.24rem;
}

.car-order-item + .car-order-item {
  border-top: 0.02rem solid #ededed;
}

.car-item-name {
  width: 50%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  letter-spacing: 0.02rem;
}

.car-item-price {
  flex: 1;
  margin: 0 0.4rem;
}

.car-counter {
  display: flex;
  align-items: center;
}

.img-reduce {
  background-image: url(../assets/img/reduce.png);
}

.img-plus {
  background-image: url(../assets/img/plus.png);
}

.img-reduce,
.img-plus {
  width: 1.4em;
  height: 1.4em;
  background-repeat: no-repeat;
  background-size: contain;
  position: relative;
}

.img-reduce::after,
.img-plus::after {
  content: '';
  position: absolute;
  left: -0.1rem;
  right: -0.1rem;
  top: -0.1rem;
  bottom: -0.1rem;
}

.car-item-count {
  min-width: 3ch;
  text-align: center;
}



	.service-num .reducediv {
    position: unset;
	}
	.reduceimg {
	  height: 0.4rem;
	  width: 0.4rem;
	  background-repeat: no-repeat;
	  background-size: contain;
	  background-image: url(../assets/img/reduce.png);
	}
	.service-num .numberFoods {
    position: static;
	  width: 4ch;
	  text-align: center;
	}
	.service-num .plusdiv {
    position: unset;
	}
	.plusimg {
	  height: 0.4rem;
	  width: 0.4rem;
	  background-repeat: no-repeat;
	  background-size: contain;
	  background-image: url(../assets/img/plus.png);
	}
	.serviceMess{
		width: 100%;
		height: 100%;
		overflow-x: hidden;
	}
	.mess-title{
		height: 4rem;
		width: 100%;
	}
	.mess-title-img{
		
		width: 100%;
		height: 100%;
	}
	/*服务信息*/
	.service-mess{
		display: block;
    	padding: 0.1rem 0.16rem;
		background-color: #FFFFFF;
	}
	.service-mess-title{
		width: 100%;
		height: 0.7rem;
	}
	.service-mess-title-txt{
    	width: 100%;
    	line-height: 0.7rem;
    	padding-left: 0.02rem;
    	letter-spacing: 0.04rem;
    	font-weight: bold;
	}
/*服务价格*/
	.service-show{
    clear: both;
		height: 0.52rem;
    line-height: 0.52rem;
    display: flex;
	}
	.service-money{
		width: 30%;
	}
	.service-sell{
    flex: 1;
	}
	.service-num{
    display: flex;
    align-items: center;
	}
	.service-money-txt{
	    color: red;
	    letter-spacing: 0.02rem;
	}
	.service-sell-txt{
		
	    width: 100%;
	    line-height: 0.44rem;
	    color: #828282;
	    letter-spacing: 0.02rem;
	}
		/*商品详情*/
	.mess-body{
		background-color: #FFF;
		width: 100%;
		margin-top:0.2rem;
	}
	.mess-body-title{
		
		width: 100%;
		height: 1rem;
		border-bottom:0.02rem solid  #DEDEDE ;
	}
	.mess-body-title-txt{
		
		width: 100%;
		font-size: 0.32rem;
		letter-spacing: 0.04rem;
		line-height: 1rem;
		padding-left: 0.2rem;
		background: #FFFFFF;

	}

	/*图片*/
	.mess-body-details{
		
		width: 100%;
		background-color: #FFFFFF;
	}
	.mess-details-img{
		
		width: 100%;
	}
	/*购物车*/
	.shoppingCar{
		/*position: fixed;
	    top: 0;
	    bottom: 0;
	    left: 0;
	    right: auto;*/
	}
	.serviceItemPrice{
		position: fixed;
	    left: 0;
	    bottom:0;
	    width: 100%;
	    border-top: 0.02rem solid #eee;
	    background: #fff;
	    z-index: 99;
	    height: 0.98rem;
	    display: -webkit-box;
	    display: -webkit-flex;
	    display: flex;
	    -webkit-box-align: center;
	    -webkit-align-items: center;
	    align-items: center;

	}
	.wz_box{
		display: flex;
    	width: 70%;
	}
	.goods_cart{
		display: block;
	    width: 1.1rem;
	    height: 1rem;
	    position: relative;
	    left: 0.24rem;
	    bottom: 0.3rem;
	}
	.carImg{
		max-width: 100%;
    	vertical-align: top;
	}

	.fontcl1{
		color: red;
    	margin-left: 0.4rem;
    	margin-top: 0.24rem;
	}
	.btn{
		width: 30%;
	    display: block;
	    /*width: 2.4rem;*/
	    height: 1rem;
	    line-height: 0.98rem;
	    color: #fff;
	    background: #ccc;
	    text-align: center;
	    position: relative;
	}
	.total_num{
		position: absolute;
	    left: 0.8rem;
	    top: 0.02rem;
	    line-height: 0.3rem;
	    padding: 0 0.1rem;
	    border-radius: 0.5rem;
	    color: #fff;
	    background: red;
	    font-size: 0.2rem;
	}
	.class1{
		background-color: red;
	}
	.listTable{
	   	height: 90%;
	    width: 25%;
	    background: #ffffff;
	    line-height: 0.84rem;
	    overflow: auto;
	}
	.listTd{
	    color: #000000;
    	text-align: center;
    	border-bottom: 0.02rem solid #EEEFF5;
	}
	.listTdFond_choose{
		color: #3087F7 !important;
	}
	.listTdFond{
		color: black;
    	font-family: "Microsoft YaHei" ! important;
	}
	.list_chose_td{
		background: #EEEFF5 !important;
    	border-left: 0.04rem solid #3087F7;
	}
	.list_chose_Fond{
		color: #3087F7 !important;
	}
	/*固定bottom*/
	.show{
		
		height: 90%;
		width: 100%;
	}
	.shoppingCar{
		
		height: 10%;
		width: 100%;
		/*position: fixed;
	    top: 0;
	    bottom: 0;
	    left: 0;
	    right: auto;*/
	}
</style>
