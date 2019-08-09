<template>
  <div class="auto-service" style="display: flex;flex-direction:column;position:fixed;top:0;left:0;bottom:1.14rem;right:0;background-color: #EEEFF5;">
    <div class="service-main">
    <!--汽车服务业务列表-->
    <div class="service-listTable">
      <div id="dishesType" class style>
        <div
          :class=" serviceTypeData.choseClass ? 'listTd list_chose_td' : 'listTd' "
          v-for="(serviceTypeData,index) in serviceTypeArrayData"
          @click="clickServiceTypeStyle(index,serviceTypeData.serviceTypeId,serviceTypeData.cardId,serviceTypeData.serviceItemType)"
          :key="index"
          :serviceTypeId="serviceTypeData.serviceTypeId"
        >
          <a
            :class=" serviceTypeData.choseClass ? 'listTdFond listTdFond_choose' : 'listTdFond' "
            href="#"
          >{{serviceTypeData.serviceTypeName}}</a>
        </div>
        <div style="height: 0.6rem;color: #000000;text-align: center;">
          <a href="#" class="listTdFond"></a>
        </div>
      </div>
    </div>

    <!--汽车服务项目列表-->
    <div id="serviceItmeContext" class="main_container" style >
      <!--汽车服务项目-->
      <div class="serviceItme" v-for="(wxbServiceItem,index) in wxbServiceItemArray" :key="index" @click="clickServiceItmeInfo(wxbServiceItem.serviceItemId)">
        <div class="serviceItemImgContent" style>
          <img :src=" wxbServiceItem.serviceItemPicture " class="serviceItemImg" style>
        </div>
        <div class style="width: 60%;line-height: 0.64rem;">
          <div class="leftmage" style>
            <span style="font-weight: bold;letter-spacing: 0.02rem;">{{wxbServiceItem.serviceItemName}}</span>
          </div>

          <div class="leftmage" style="color: #959596;display: flex;">
            <div class="stock" style="letter-spacing: 0.02rem;" >
              <span class="fontItem" >库存量:{{ wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber : '不限' }}</span>
            </div>
            <div class="sold" style="letter-spacing: 0.02rem;" >
              <span class="fontItem" >销量:{{ wxbServiceItem.itemTotalNumber ? wxbServiceItem.itemTotalNumber : 0}}</span>
            </div>
          </div>
          <div class="numberprice leftmage" style="display: flex;">
            <div style="width: 25%;">
              <span style="font-size: 0.28rem;color: red;font-weight: bold;" >￥{{ parseFloat(wxbServiceItem.couponTotalAmt).toFixed(2) }}</span>
              <!--<span data-v-29613d96="" style="font-size: 0.21rem;color: #999999;font-weight: bold;margin-left: 0.05rem;text-decoration: line-through;">￥{{ parseFloat(wxbServiceItem.totalAmt).toFixed(2) }}</span>-->
            </div>
            <div class="serviceItmeNumber" :style="wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber == 0 ? 'display:none;' : 'display: flex;' : 'display: flex;' " >
              <div class="reducediv" :style="wxbServiceItem.shoppingNumberClass ? 'display:block' : 'display:none' " >
                <div class="reduceimg" style @click.stop="clickReduceimg(index,wxbServiceItem.serviceItemNum)" ></div>
              </div>
              <div class="numberFoods" :style="wxbServiceItem.shoppingNumberClass ? 'display:block' : 'display:none' " >
                <span style="font-size: 0.28rem;" >{{ wxbServiceItem.serviceItemNum ? wxbServiceItem.serviceItemNum : 0}}</span>
              </div>
              <div id="cs" class="plusdiv" style>
                <div class="plusimg" @click.stop="clickPlusimg(index,wxbServiceItem.serviceItemNum)" style ></div>
              </div>
            </div>
            <div class="serviceItmeNumber" :style="wxbServiceItem.itemNumberStatus == 1 ? wxbServiceItem.itemNumber - wxbServiceItem.itemTotalNumber == 0 ? 'display: flex;' : 'display:none;' : 'display:none;' " >
            	<span style="position: absolute;left: 60%;color: #828282;">已售馨</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
    <!--汽车购物车-->
    <div style="height: 0.89rem;">
      <div class="serviceItemPrice">
        <div class="wz_box" @click.stop="clickServiceItemShopping">
          <a href="javascript:void();" id="goods_cart" class="goods_cart">
            <img src="../assets/img/shoppingCartAdd.png" class="carImg">
            <span class="total_num">{{totalNumber}}</span>
          </a>
          <p class="fontcl1" >
            
            <big class="totalPrice" disabled="disabled">￥{{ parseFloat(totalMoney).toFixed(2) }}</big>
          </p>
          <p class="black9"></p>
        </div>
        <a @click.stop="cleanShoppingSettlement" id="order_create" class="btn">去结算</a>
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

          <!--<div class="car-order-item">
            <div class="car-item-name">Lorem ipsum dolor sit amet.</div>
            <div class="car-item-price">￥26</div>
            <div class="car-counter">
              <div class="img-reduce"></div>
              <div class="car-item-count">2</div>
              <div class="img-plus"></div>
            </div>
          </div>

          <div class="car-order-item">
            <div class="car-item-name">Lorem ipsum dolor sit amet.</div>
            <div class="car-item-price">￥26</div>
            <div class="car-counter">
              <div class="img-reduce"></div>
              <div class="car-item-count">2</div>
              <div class="img-plus"></div>
            </div>
          </div>

          <div class="car-order-item">
            <div class="car-item-name">Lorem ipsum dolor sit amet.</div>
            <div class="car-item-price">￥26</div>
            <div class="car-counter">
              <div class="img-reduce"></div>
              <div class="car-item-count">2</div>
              <div class="img-plus"></div>
            </div>
          </div>

          <div class="car-order-item">
            <div class="car-item-name">Lorem ipsum dolor sit amet.</div>
            <div class="car-item-price">￥26</div>
            <div class="car-counter">
              <div class="img-reduce"></div>
              <div class="car-item-count">2</div>
              <div class="img-plus"></div>
            </div>
          </div>-->

        </section>
      </div>
    </div>
  </div>
</template>
<script>
import { Group, Cell,AlertModule,Flow, FlowState, FlowLine } from "vux";
import api from '../Api/api.js';
export default {
  components: {
    Group,
    Cell,
    AlertModule,
    Flow,
    FlowState,
    FlowLine
  },

  data() {
    //存放数据对象，以此在元素标签里使用
    return {
    	apiUrl:"",
    	imgShow:false,
      msg: "",
      serviceTypeArrayData: [],
      wxbServiceItemArray: [],
      shoppingItemArray:[],//购物车
      addItemArray:[],//需要添加的项目
      totalMoney: 0.0, //总金额
      totalNumber: 0, //总数
      showShoppingNullBool: true,
      showOrderCar: false,
      paramServiceItemType:null,//点击项目传参 项目类型：普通项目，套餐项目
      paramServiceTypeId:null, //点击项目传参 业务id
    };
  },
  created: function() {
  	var _this = this;
  	if( !localStorage.storeId || localStorage.storeId == "undefined" || localStorage.storeId == "null" ){//判断当前用户是否关联门店
  			_this.$vux.confirm.show({
		        title: '温馨提示',
		        content: '你还没有认证，请先认证。',
		        onCancel () {
		          
		        },
		        onConfirm () {
		        	_this.$router.push({
  							path:"/mapLocation?openid="+localStorage.openId
							})
		        }
		      })
		}
//	this.getToken();
    //初始化数据
    console.log("加载");
   
		_this.apiUrl = api.getDms;
    //查询购物车
    var maps = {
      storeId: localStorage.storeId,
      userId: localStorage.userId
    };
    _this.$http.post(api.shoppingCartTotalQueryApi,{ map: maps,token:localStorage.token}).then(function(resDatas) {
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
  	  //删除锁定超时订单
			_this.$http.post(api.deleteOrderByTimeOutApi,{token:localStorage.token}).then(res => {}).catch(res =>{}),
	    function(resDatas) {
	      console.log(resDatas);
	    }
	  );

    var nowDate = new Date();
    var nowDateString = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate();
    var map = {
      storeId: localStorage.storeId,
      nowData: nowDateString
    };
    //查询业务类型 发送 post 请求
    _this.$http.post(api.serviceTypeQueryApi,{ map: map ,token:localStorage.token}).then(
        function(res) {
          console.log(res);
          var dataArray = res.data.wxbServiceTypeArray;
          if (dataArray.length > 0) {
            var array = [];
            var itemName=_this.$route.query.itemName;//首页传入参数
            var indexItem="";
            console.log(itemName);
            for (var a = 0; a < dataArray.length; a++) {
              dataArray[a].choseClass = false;
              if (a == 0 && !itemName){
              	dataArray[a].choseClass = true;
              	indexItem=a;
              }else if( itemName && dataArray[a].serviceTypeName == itemName && itemName != ""){
              	dataArray[a].choseClass = true;
              	indexItem=a;
              }

              array.push(dataArray[a]);
              if (a == dataArray.length - 1) {
                _this.serviceTypeArrayData = array;
                console.log("业务类型", _this.serviceTypeArrayData);
								
								//项目类型传参的数据
								_this.paramServiceItemType=dataArray[indexItem].serviceItemType;
								_this.paramServiceTypeId=dataArray[indexItem].serviceTypeId;
								
                //查询服务项目
                var serviceItemMap = {
                  storeId: localStorage.storeId, //门店
                  nowData: nowDateString, //当前日期
                  serviceItemType: dataArray[indexItem].serviceItemType, //项目类型：普通项目，套餐项目
                  carModelId: localStorage.carModelId, //车型id
                  userId: localStorage.userId //用户id
                };
                serviceItemMap.serviceTypeId = dataArray[indexItem].serviceTypeId; //业务id

                _this.$http.post(api.serviceItemQueryApi,{
                      map: serviceItemMap,
                      orgId: localStorage.orgid,
                      tenantId: localStorage.tenantId,
                      token:localStorage.token
                }).then(
                  function(ress) {
		                var wxbServiceItemArray = ress.data.wxbServiceItemArray;
		                _this.wxbServiceItemArray = wxbServiceItemArray;
		                console.log("微信服务项目", wxbServiceItemArray);
                  },
	                function(ress) {
	                  console.log(ress);
	                }
                );
                
              }
            }
          }
        },
        function(res) {
          console.log(res);
        }
      );
  },
  //离开页面触发事件
	destroyed: function () {
    console.log("离开页面");
    var _this = this;
		if( _this.wxbServiceItemArray || _this.wxbServiceItemArray.length > 0){//如果此业务下没有项目则不添加购物车
			_this.addServiceItemShoppingCart("addShopping")//将选择的项目添加到购物车
		}
    
	},
  methods: {
		//点击进行结算
		cleanShoppingSettlement: function(){
			console.log("结算");
			var _this = this;
			if( (_this.wxbServiceItemArray || _this.wxbServiceItemArray.length > 0) && _this.totalNumber > 0 ){//如果此业务下没有项目则不添加购物车
				_this.addServiceItemShoppingCart("shoppingCarAddOrder")//将选择的项目添加到购物车
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
		      		for(var a=0;a<_this.wxbServiceItemArray.length; a++){
		      			_this.wxbServiceItemArray[a].serviceItemNum=0;
		      			_this.wxbServiceItemArray[a].shoppingNumberClass=false;
		      		}
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
  		var _this = this;
  		var deleteMap={
  			storeId: localStorage.storeId,
	      userId: localStorage.userId
  		}
  		_this.$http.post(api.userShoppingCartDeleteApi,{deleteMap: deleteMap,token:localStorage.token}).then(function(resDatas) {
          _this.shoppingItemArray=[];
  				_this.showShoppingNullBool=true;
  				_this.totalMoney=0.0;
      		_this.totalNumber=0;
      		for(var a=0;a<_this.wxbServiceItemArray.length; a++){
      			_this.wxbServiceItemArray[a].serviceItemNum=0;
      			_this.wxbServiceItemArray[a].shoppingNumberClass=false;
      		}
          console.log("清空微信购物车", resDatas);
          document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
        },
        function(resDatas) {
            console.log(resDatas);
        }
      );
  	},
  	//点击进入项目详情页面
  	clickServiceItmeInfo: function(serviceItemId){
  		var _this = this;
			if( _this.wxbServiceItemArray || _this.wxbServiceItemArray.length > 0){//如果此业务下没有项目则不添加购物车
				_this.addServiceItemShoppingCart("clickItemInfo",serviceItemId)//将选择的项目添加到购物车
			}
  	},
  	//点击显示的购物车触发事件
  	clickServiceItemShopping: function(){
  		this.imgShow = !this.imgShow;
  		var _this = this;
  		_this.addServiceItemShoppingCart("queryShopping");
  	},
  	//隐藏显示的购物车事件
  	hideShoppingCart: function(){
  		this.imgShow = !this.imgShow;
  		var _this = this;
  		_this.showOrderCar = false;
  		var _this = this;
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
                token:localStorage.token
          }).then(function(resDatas) {
                console.log("离开购物车时添加到微信购物车", resDatas);
              },
              function(resDatas) {
                console.log(resDatas);
              }
           );
          
        }
      }
  	},
  	//在购物车里加项目数量
  	addShoppingItemNum: function(index,serviceItemNum){
  		var _this = this;
  		var num = _this.shoppingItemArray[index].itemNumber - _this.shoppingItemArray[index].itemTotalNumber
  		if( ( Number(serviceItemNum)+1 ) <= num || _this.shoppingItemArray[index].itemNumberStatus == 0){//小于库存量
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
        if (_this.totalNumber <= 0){//判断购物车是否有项目存在
        	document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
        }
        _this.totalNumber > 0 ? _this.showShoppingNullBool=false :_this.showShoppingNullBool=true ;
  		}
  		
  	},
  	//操作购物车里的项目和业务类别里的项目数量同步
  	synchronizationItemNum: function(data){
  		var _this = this;
  		if(_this.wxbServiceItemArray.length>0){
					for(var a=0; a < _this.wxbServiceItemArray.length;a++){
						if( _this.wxbServiceItemArray[a].serviceItemId == data.serviceItemId){
							_this.wxbServiceItemArray[a].serviceItemNum=data.serviceItemNum;
							if(data.serviceItemNum <= 0 )_this.wxbServiceItemArray[a].shoppingNumberClass = false;
						}
					}
			}
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
  	//查询出购物车
  	queryShoppingList:function(){
  		var _this = this;
  		_this.showOrderCar = !_this.showOrderCar;
  		//查询购物车
	    var maps = {
	      storeId: localStorage.storeId,
	      userId: localStorage.userId
	    };
	    _this.$http.post(api.shoppingCartTotalQueryApi,{ map: maps ,token:localStorage.token}).then(function(resDatas) {
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
  	//点击业务类型触发事件
    clickServiceTypeStyle: function(index, serviceTypeId) {
      var _this = this;
			if( !_this.wxbServiceItemArray || _this.wxbServiceItemArray.length < 0){//如果此业务下没有项目则不添加购物车
				_this.queryServiceGetType(index,serviceTypeId);//根据业务类型查询项目
			}else{
				_this.addServiceItemShoppingCart("addShopping")//将选择的项目添加到购物车
				_this.queryServiceGetType(index,serviceTypeId);//根据业务类型查询项目
			}
    },
		//添加到购物车
		addServiceItemShoppingCart:function(judeString,serviceItemId){
			var _this = this;
			var shoppingCartArray = [];
			for (var b = 0; b < _this.wxbServiceItemArray.length; b++) {
        var shoppingCartData = {
          storeId: localStorage.storeId,
          serviceItemId: _this.wxbServiceItemArray[b].serviceItemId,
          serviceItemPrice: parseFloat( _this.wxbServiceItemArray[b].couponTotalAmt ).toFixed(2),
          serviceItemNum: _this.wxbServiceItemArray[b].serviceItemNum,
          userId: localStorage.userId,
          userOpid: localStorage.openId,
          shoppingCartTotal: _this.totalMoney
        };
        shoppingCartArray.push(shoppingCartData);
        if (b == _this.wxbServiceItemArray.length - 1) {
          _this.$http.post(api.itemShoppingCartAddApi,{
                shoppingCartArray: shoppingCartArray,
                shoppingCartTotal: _this.totalMoney,
                token:localStorage.token
           }).then(function(resDatas) {
                console.log("添加到微信购物车", resDatas);
                if(judeString == "queryShopping"){
                	_this.queryShoppingList();//查询出购物车
                }else if(judeString == "clickItemInfo"){//点击进入项目详情时
                	_this.$router.push({
										path:'/serviceMess',
										query: {
											serviceItemId:serviceItemId,
											serviceItemType:_this.paramServiceItemType,
											serviceTypeId:_this.paramServiceTypeId
										}
									});
                	
                }else if(judeString == "shoppingCarAddOrder"){//将购物车的项目生成订单，清空购物车
                	if( !localStorage.carid || localStorage.carid == "undefined" || localStorage.carid == "null" ){//判断当前是否绑定用户
										
										_this.$vux.confirm.show({
							        title: '温馨提示',
							        content: '你还没有认证，请先认证。',
							        onCancel () {
							          
							        },
							        onConfirm () {
							          _this.$router.push({
			  	  							path:"/registered"
												})
							        }
							      })
										
									}else{
										_this.shoppingCarAddItemOrder();
									}
									
                }
                
              },
              function(resDatas) {
                console.log(resDatas);
              }
           );
          
        }
      }
		},
		//根据点击的业务类型查项目
		queryServiceGetType:function(index,serviceTypeId){
			var _this = this;
			for (var a = 0; a < _this.serviceTypeArrayData.length; a++) {
        _this.serviceTypeArrayData[a].choseClass = false;
        if (a == _this.serviceTypeArrayData.length - 1) {
          _this.serviceTypeArrayData[index].choseClass = true;
          //查询服务项目
          var nowDate = new Date();
          var nowDateString = nowDate.getFullYear() + "-" + (nowDate.getMonth() + 1) + "-" + nowDate.getDate();
          var serviceItemMap = {
            storeId: localStorage.storeId, //门店
            nowData: nowDateString, //当前日期
            serviceItemType: _this.serviceTypeArrayData[index].serviceItemType, //项目类型：普通项目，套餐项目
            carModelId: localStorage.carModelId, //车型id
            userId: localStorage.userId //用户id
          };
          serviceItemMap.serviceTypeId = _this.serviceTypeArrayData[index].serviceTypeId; //业务id
          //项目类型传参的数据
					_this.paramServiceItemType=_this.serviceTypeArrayData[index].serviceItemType;
					_this.paramServiceTypeId=_this.serviceTypeArrayData[index].serviceTypeId;
          
					console.log("点击传参",{
                map: serviceItemMap,
                orgId: localStorage.orgid,
                tenantId: localStorage.tenantId,
                token: localStorage.token
              });
          _this.$http .post(api.serviceItemQueryApi, {
                map: serviceItemMap,
                orgId: localStorage.orgid,
                tenantId: localStorage.tenantId,
                token:localStorage.token
              }
           ).then(
	              function(ress) {
	                _this.wxbServiceItemArray = ress.data.wxbServiceItemArray;
	                console.log("点击查询的微信服务项目", _this.wxbServiceItemArray);
	              },
	              function(ress) {
	                console.log(ress);
	              }
          );
        }
      }
		},

    clickPlusimg: function(index, num) {
      //加
      var _this = this;
      var num = _this.wxbServiceItemArray[index].itemNumber - _this.wxbServiceItemArray[index].itemTotalNumber
      if ( _this.wxbServiceItemArray[index].serviceItemNum + 1 <= num || _this.wxbServiceItemArray[index].itemNumberStatus == 0 ) {
        _this.wxbServiceItemArray[index].serviceItemNum += 1;
        //总数加和总价格加
        _this.totalNumber += 1;
        var totalMoneyss = Number(_this.totalMoney) + Number( parseFloat(_this.wxbServiceItemArray[index].couponTotalAmt).toFixed( 2 ) );
        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
        //购物车总数的样式判断
        if (_this.totalNumber == 10) document.getElementsByClassName("total_num")[0].style.padding = "0 0.04rem";
        if (_this.wxbServiceItemArray[index].serviceItemNum == 1) {
          _this.wxbServiceItemArray[index].shoppingNumberClass = true;
        }
        if (_this.totalNumber > 0){//判断购物车是否有项目存在
        	document.getElementsByClassName("btn")[0].style.background="#3087f7";
        }
        
      }
    },

    clickReduceimg: function(index, num) {
      //减
      var _this = this;
      if (_this.wxbServiceItemArray[index].serviceItemNum - 1 >= 0) {
        _this.wxbServiceItemArray[index].serviceItemNum -= 1;
        //总数减和总价格减
        _this.totalNumber -= 1;
        var totalMoneyss = Number(_this.totalMoney) - Number( parseFloat(_this.wxbServiceItemArray[index].couponTotalAmt).toFixed( 2 ) );
        _this.totalMoney = Number(parseFloat(totalMoneyss).toFixed(2));
        //购物车总数的样式判断
        if (_this.totalNumber == 9) document.getElementsByClassName("total_num")[0].style.padding = "0 0.1rem";
        if (_this.wxbServiceItemArray[index].serviceItemNum == 0) {
          _this.wxbServiceItemArray[index].shoppingNumberClass = false;
        }
        if (_this.totalNumber <= 0){//判断购物车是否有项目存在
        	document.getElementsByClassName("btn")[0].style.background="#CCCCCC";
        }
      }
    }
    
  }
  
};
</script>

<style lang="less" scoped="scoped">
	.totalPrice{
		font-size: 0.4rem;
	}
	.messShow{
		    visibility: hidden;
	}
.car-item-tips{
	text-align: center;
	font-size: 0.28rem;
	width: 100%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	letter-spacing: 0.16rem;
}
.car_shoppingCart{
	padding-left: 0.2rem;
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
/*服务项目*/
.fontItem{
	font-size: 0.24rem;
}
.stock {
  margin-right: 0.2rem;
}
.plusimg {
  height: 0.4rem;
  width: 0.4rem;
  background-repeat: no-repeat;
  background-size: contain;
  background-image: url(../assets/img/plus.png);
}
.plusdiv {
  border-radius: 0.26rem;
  position: absolute;
  left: 85%;
  height: 0.4rem;
  width: 0.4rem;
}
.numberFoods {
  width: 0.44rem;
  position: absolute;
  left: 68%;
  text-align: center;
}
.reducediv {
  border-radius: 0.26rem;
  position: absolute;
  left: 50%;
}
.reduceimg {
  height: 0.4rem;
  width: 0.4rem;
  background-repeat: no-repeat;
  background-size: contain;
  background-image: url(../assets/img/reduce.png);
}
.serviceItmeNumber {
  position: relative;
  width: 75%;
  display: flex;
  justify-content: center;
  align-items: center;
}
.leftmage {
  margin-left: 4%;
}
.main_container {
  overflow-y: auto;
  flex: 1;
  padding-left: 0.1rem;
  padding-top: 0.1rem;
}
.serviceItme {
  padding-top: 0.1rem;
  padding-left: 0.1rem;
  display: flex;
  padding-bottom: 0.04rem;
  border-bottom: 0.02rem solid #eaeaea;
  background-color: #ffffff;
  height: 2rem;
}
.serviceItemImgContent {
  width: 35%;
  height: auto;
  margin-bottom: 0.1rem;
  text-align: center;
  border: 0.02rem solid #eeeff5;
  border-radius: 0.12rem;
  display: flex;
  justify-content: center;
  align-items: center;
}
.serviceItemImg {
  width: 90%;
  height: 90%;
}

.fontcl1 {
  color: red;
  margin-left: 0.8rem;
  margin-top: 0.24rem;
  font-size:0.36rem;
}
.wz_box {
  display: flex;
  width: 70%;
  height:1rem;
}
.auto-service .serviceItemPrice {
  position: static;
}
.serviceItemPrice {
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
.auto-service .shoppingCar {
  /*float: unset;
  height: unset;*/
}
.btn {
  width: 30%;
  display: block;
  height: 1rem;
  line-height: 0.98rem;
  color: #fff;
  font-size: 0.32rem;
  background: #ccc;
  text-align: center;
  position: relative;
}
.goods_cart {
  display: block;
  width: 1.1rem;
  height: 1rem;
  position: relative;
  left: 0.24rem;
  bottom: 0.3rem;
  z-index: 9;
}
.carImg {
  max-width: 100%;
  vertical-align: top;
}
.total_num {
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

/*购物车*/
.class1 {
  background-color: red;
}

.service-main {
  flex: 1;
  display: flex;
}
.service-listTable {
  width: 25%;
  background: #ffffff;
  line-height: 0.84rem;
  overflow: auto;
}
.listTd {
  color: #000000;
  text-align: center;
  border-bottom: 0.02rem solid #eeeff5;
}
.listTdFond_choose {
  color: #3087f7 !important;
}
.listTdFond {
  color: black;
  font-family: "Microsoft YaHei" !important;
}
.list_chose_td {
  background: #eeeff5 !important;
  border-left: 0.04rem solid #3087f7;
}
.list_chose_Fond {
  color: #3087f7 !important;
}
/*购物车样式*/
.car-mask {
  position: fixed;
  top: 0;
  bottom: 2rem;
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
  letter-spacing: 0.02rem;
  padding: 0 0.24rem;
}

.car-order-list {
  max-height: 4.86rem;
  overflow: auto;
  background: #fff;
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
</style>