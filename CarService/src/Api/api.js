export const WEB_ROOT =  "http://qxy.7xdr.com/dms"     // "http://124.172.221.179:2080/dms"             
export const API_ROOT =    "http://qxy.7xdr.com/wechatApi"   //"http://124.172.221.179:2080/wechatApi"           //http://qxy60.hszb.harsons.cn/wechatApi     ///api/default
export const REPAIR_API_ROOT = 	"http://qxy.7xdr.com/repairApi" 	//"http://124.172.221.179:2080/repairApi"		
export const SYSTEM_API_ROOT =    "http://qxy.7xdr.com/systemApi"  //"http://124.172.221.179:2080/systemApi"             
export const FRM_API_ROOT =  "http://qxy.7xdr.com/frmApi"  

// export const WEB_ROOT = "http://qxy60.hszb.harsons.cn/dms" 
// export const API_ROOT = "http://qxy60.hszb.harsons.cn/wechatApi"
// export const REPAIR_API_ROOT = "http://qxy60.hszb.harsons.cn/repairApi"
// export const SYSTEM_API_ROOT =  "http://qxy60.hszb.harsons.cn/systemApi"  
// export const FRM_API_ROOT = "http://qxy60.hszb.harsons.cn/frmApi"  


//获取token
			const getToken = WEB_ROOT+"/com.hsapi.system.auth.LoginManager.userLogin.biz.ext"
//获取七牛token
 			const getQNtoken = WEB_ROOT+"/dms/com.hs.common.login.getQNAccessToken.biz.ext"		
//获取七牛图片链接域名
const getQNImgUrl = WEB_ROOT+"/systemApi/com.hs.common.login.getCompanyLogoUrl.biz.ext"
//保存评论信息
const addComment = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.store.addComment.biz.ext"
//首页
			//查找车型
  			  const getCar =  API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.queryWbChat.biz.ext"
  			 //查找用户默认门店
  			  const getStore =API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.queryWxbStore.biz.ext"
  			 //查找默认门店的客服
  			  const getServiceUser = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.queryWxbStoreEmploye.biz.ext"
  			 //查找默认门店的轮播图
  			  const getSlidesShow = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.queryWxbSlideshow.biz.ext"
	         //查找所有订单评价
	         const evaluateList = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.queryEvaluate.biz.ext"
	         //轮播图活动详情
	         const SlideshowMess = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.store.querySlideshowMess.biz.ext" 
	       
//个人中心
			//查找用户信息
			const	getInfo = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatGarage.queryUserInfo.biz.ext"
			//查找用户余额
			const  getMoney = REPAIR_API_ROOT+"/com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext"

					//我的车库
					 const  getUserCars = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatGarage.queryUserGarageInfo.biz.ext"
					   		//设置默认车辆
					   		const  setCar = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatGarage.updateDefaultCar.biz.ext"
					   		//删除车俩
					   		const  deleteCar  = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatGarage.deleteUserCar.biz.ext"
	   				//我的预约
	   				const getAllBooking =API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatbookingdetails.querybooking.biz.ext"
	   				//我的套餐
	   				const getMeal = REPAIR_API_ROOT+"/com.hsapi.repair.baseData.cardTimes.queryMyCardTimesByGuestId.biz.ext"
	   				//我的车账本
	   				const getAccount = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.svr.qyeryComprehensiveNopage.biz.ext"
	   				//工单详情
	 				const orderDetails = REPAIR_API_ROOT+"/com.hsapi.repair.baseData.query.queryRpsPPIMaintainDetail.biz.ext"
	 						//项目配件明细
	 						const itemDetails = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext"

	 						//套餐配件明细
	 						const mealDetails = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext"
//门店
					//查找用户最后关注门店
					const finallyUserStore = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.store.queryFinallyStore.biz.ext"
					//模糊分页查询门店
					const searchStore = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.store.fuzzyQueryStore.biz.ext"
					//设置默认门店
					const setStore = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.store.updateFinallyStore.biz.ext"
//我的预约
					//查询车道所有预约
          const allMakeApponint = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.booking.queryPreBookByGuest.biz.ext"
          // 增加车辆
          const addCar = API_ROOT+'/com.hsapi.wechat.autoServiceBackstage.weChatUsers.addUserCart.biz.ext'
//我的优惠卷
          const getCoupon = API_ROOT +'/com.hsapi.wechat.autoServiceBackstage.store.queryCoupon.biz.ext'

//验证码
 const verificationCode = SYSTEM_API_ROOT+"/com.hsapi.system.tenant.register.sendMsg.biz.ext";
 //车辆品牌查询
 const carBrand = SYSTEM_API_ROOT+"/com.hsapi.system.dict.dictMgr.queryCarBrand.biz.ext";
 //查找车系
 const getcarBrandId = SYSTEM_API_ROOT+"/com.hsapi.system.dict.dictMgr.queryCarSeries.biz.ext"
//查找车型
 const carSeries = SYSTEM_API_ROOT+"/com.hsapi.system.dict.dictMgr.queryCarModel.biz.ext"
 //新增预约
 const makeApponint = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.booking.updateBooking.biz.ext"
 //查找预约项目
 const makeApponintItem = REPAIR_API_ROOT+"/com.hsapi.repair.baseData.item.queryRepairItemListNopage.biz.ext"
 //预约日期
 const makeApponintDate = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.booking.getAppointmentDate.biz.ext"
  //预约时间段
 const makeApponintTime = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.booking.getAppointmentTimes.biz.ext"
 //预约业务类型
 const serciveType = SYSTEM_API_ROOT+"/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext"
 //预约项目
 const serciveItem = REPAIR_API_ROOT+"/com.hsapi.repair.baseData.item.queryRepairItemListNopage.biz.ext"
 //新增预约
 const addMakeApponint = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.booking.updateBooking.biz.ext"
//通过userid查询客户所有信
  const findUserAll = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatInquire.findUserAll.biz.ext"
//查询客户所有信息
 const inquireAll = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatInquire.inquirebiz.biz.ext "
//新增客户信息
const addClient = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.crud.saveWechatCustomerInfo.biz.ext"

//认证和车辆添加的车道接口
const addNewUserorCar = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.crud.saveWechatCustomerInfo.biz.ext"

//修改客户id
const upAddGuestId = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatInquire.upDataGuestId.biz.ext"
// 修改个人资料
const updateUserInfo = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.store.updateUser.biz.ext"
//修改用户的服务外键
const updateUserByService = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.homePage.updateUserByService.biz.ext"
//查找车道用户车辆id
const  findcarId = API_ROOT+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryCarId.biz.ext"
// 查找车俩保险，保养里程，驾驶证到期
const carMess = REPAIR_API_ROOT+"/com.hsapi.repair.repairService.query.getGuestData.biz.ext"
//查询首页项目活动
const itemActity = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatInterface.queryStoreItemActivity.biz.ext";
//优惠劵查询
const couponUser = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryCardCouponAll.biz.ext";
//查询我的订单
const orderInfoByUser = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryOrderInfoByUser.biz.ext";
//删除锁定超时订单
const deleteOrderByTimeOut = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.deleteOrderByTimeOut.biz.ext";
//删除订单
const deleteOrderById = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.deleteOrderByOrderId.biz.ext";
//添加门店和用户的关系
const storeUserAdd = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatUsers.addStoreUser.biz.ext";
//地图定位查询门店
const mapStoreQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryMapLocationStoreInfo.biz.ext";
//查询用户当前的地理位置
const mapUser = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStore.getWeChatMapParamData.biz.ext";
//查询购物车
const shoppingCartTotalQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryShoppingCartTotalMo.biz.ext";
//查询业务类型
const serviceTypeQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryWechatServiceType.biz.ext";
//查询服务项目
const serviceItemQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryUserCarServiceItem.biz.ext";
//清空购物车
const userShoppingCartDelete = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.deleteUserShoppingCart.biz.ext";
//添加项目到购物车
const itemShoppingCartAdd = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.addItemShoppingCart.biz.ext";
//查询项目简介的图片
const serviceItemPictureQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatAutoServiceItem.queryServiceItemPicture.biz.ext";
//查询门店信息和技师信息和门店评分信息
const stoerAndEmpQuery = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryStoresAndEmp.biz.ext";
//查询门店门店评分信息
const queryCommentByStore = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStore.queryCommentByStore.biz.ext";
//添加优惠劵给用户
const addUserCoupon = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.addUserCouponCard.biz.ext";
//根据手机号查询客户
const queryCustomer = REPAIR_API_ROOT +"/com.hsapi.repair.repairService.svr.queryCustomerListByMobile.biz.ext"
//生成项目的订单
const queryUserShoppingAddUserOrder = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryUserShoppingAddUserOrder.biz.ext";
//订单的详情查询
const queryUserOrdersList = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryUserOrdersList.biz.ext";
//查询订单截至时间和数据库当前时间
const queryOrderExpirationTime = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.queryOrderExpirationTime.biz.ext";
//微信订单生成参数的逻辑流
const weChatPay = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.weChatPay.biz.ext";
//订单的锁定
const updateUserOrderLocking = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder.updateUserOrderLocking.biz.ext";
//车帐本的照片查询
const orderCommentPhoto = REPAIR_API_ROOT + "/com.hsapi.repair.repairService.waveBox.searchUploadPhoto.biz.ext";
//通过业务字典查询点击菜单的url 
const menuDic = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryWeChatMenuDic.biz.ext";
//查询可分享的优惠劵
const queryShareUseCouponList = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryShareUseCouponList.biz.ext";
//根据优惠劵编码查询出具体分享的优惠劵
const queryShareUseCouponMain = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryShareUseCouponMain.biz.ext";
//用户领取可分享优惠劵
const addUserShareUseCoupon = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.addUserShareUseCoupon.biz.ext";
//查询门店营销活动
const queryStoreActivityList = API_ROOT + "/com.hsapi.wechat.autoServiceBackstage.weChatStoreActivity.queryStoreActivityList.biz.ext";
//车道账号验证
const authentication = SYSTEM_API_ROOT + "/com.hsapi.system.auth.LoginManager.authentication.biz.ext";
//更新员工的微信openId
const saveMemberOpenID = SYSTEM_API_ROOT + "/com.hsapi.system.tenant.employee.saveMemberOpenID.biz.ext";
//获取微信待支付单信息
const queryFisPreBill = FRM_API_ROOT + '/com.hsapi.frm.frmService.crud.queryFisPreBill.biz.ext'

export default {
	//账号
	getUserId : "syswechat",//正式
	// getUserId : "yx001",//测试
	//密码
	getPassword:"qxy.123",//正式
    // getPassword:"000000",//测试
	//获取dms的url
	getDms:WEB_ROOT,
	//home主页的链接地址
	getHome:"http://tomato.harsonserver.com/app/chedaoWeixin/home",
	//mapLocation用户认证选择门店的链接地址
	getMapLocation:"http://tomato.harsonserver.com/app/chedaoWeixin/mapLocation",
	//store门店选择页面的链接地址
	getStore:"http://tomato.harsonserver.com/app/chedaoWeixin/store",
	//storeDetails门店详情页面的链接地址
	getStoreDetails:"http://tomato.harsonserver.com/app/chedaoWeixin/storeDetails",
	//订单详情页面
	getOrderInfoUrl:"http://tomato.harsonserver.com/app/chedaoWeixin/myOrderMess?orderId=",
	//我的订单页面
	getMyOrderUrl:"http://tomato.harsonserver.com/app/chedaoWeixin/myOrder",
	//优惠劵分享页面
	shareCouponUseUrl:"http://tomato.harsonserver.com/app/chedaoWeixin/shareCouponUseMain?couponCode=",
	//优惠劵分享领用页面的
	shareCouponPageUrl:"/shareCouponUseMain",
	//优惠劵分享 页面前获取用户信息页面
	useUserShareCouponTransferPageUrl:"http://qxy.7xdr.com/dms/autoServiceSys/weChatServicer/useUserShareCouponTransfer.jsp",
	//首页
	getCarApi :getCar,
	getStoreApi :getStore,
	getServiceUserApi :getServiceUser,
	getSlidesShowApi : getSlidesShow,
	//工单评价  图片
	getQNImgUrl: getQNImgUrl,
	evaluateListApi : evaluateList,
	addComment: addComment,
      		
//    queryWxsOrderMainApi: queryWxsOrderMain,
	//个人中心
	getInfoApi : getInfo,
	//用户余额
			getMoneyApi : getMoney,
	//我的车库
	        getUserCarsApi : getUserCars,
	//设置默认车辆
	        setCarApi :setCar,
	//删除车俩
			deleteCarApi : deleteCar,
	//全部预约
			getAllBookingApi :getAllBooking,
	//我的套餐
			getMealApi:getMeal,
	//我的车账本
			getAccountApi : getAccount,
	//工单详情
	orderDetailsApi : orderDetails,
	//项目配件明细
	itemDetailsApi : itemDetails,
	//套餐项目明细
	mealDetailsApi : mealDetails,
	//门店
    setStoreApi :setStore,
    finallyUserStoreApi:finallyUserStore,
	//我的预约
    allMakeApponintApi : allMakeApponint,
    //增加车辆      
    addCarApi: addCar,
	verificationCodeApi : verificationCode,
	carBrandApi : carBrand,
	getcarBrandIdApi : getcarBrandId,
	carSeriesApi : carSeries,
	makeApponintApi : makeApponint,
	makeApponintDateApi : makeApponintDate,
	serciveTypeApi : serciveType,
	makeApponintTimeApi :  makeApponintTime,
	serciveItemApi : serciveItem,
	addMakeApponintApi:addMakeApponint,
	inquireAllApi : inquireAll,
	addClientApi : addClient,
	upAddGuestIdApi :upAddGuestId,
    findUserAllApi:findUserAll,
  	updateUserInfoApi: updateUserInfo,
  	updateUserByServiceApi:updateUserByService,

	searchStoreApi: searchStore,
	getTokenApi: getToken,
	//查找车道用户车辆id
	findcarIdApi : findcarId,
	// 查找车俩保险，保养里程，驾驶证到期
	carMessApi:carMess,
	//查询项目活动
	itemActityApi:itemActity,
	//优惠劵查询
	couponUserApi:couponUser,
	//查询我的订单
	orderInfoByUserApi:orderInfoByUser,
	//删除锁定超时订单
	deleteOrderByTimeOutApi:deleteOrderByTimeOut,
	//删除订单
	deleteOrderByIdApi:deleteOrderById,
	//添加门店和用户的关系
	storeUserAddApi:storeUserAdd,
	//地图定位查询门店
	mapStoreQueryApi:mapStoreQuery,
	//查询用户当前的地理位置
	mapUserApi:mapUser,
	//查询购物车
	shoppingCartTotalQueryApi:shoppingCartTotalQuery,
	//查询业务类型
	serviceTypeQueryApi:serviceTypeQuery,
	//查询服务项目
	serviceItemQueryApi:serviceItemQuery,
	//清空购物车
	userShoppingCartDeleteApi:userShoppingCartDelete,
	//添加项目到购物车
	itemShoppingCartAddApi:itemShoppingCartAdd,
	//查询项目简介的图片
	serviceItemPictureQueryApi:serviceItemPictureQuery,
	//查询门店信息和技师信息和门店评分信息
	stoerAndEmpQueryApi:stoerAndEmpQuery,
	//查询门店评价信息
	queryCommentByStoreApi:queryCommentByStore,
	//获取七牛token
	getQNtokenApi : getQNtoken,
	getCouponApi :getCoupon,
	//添加优惠劵给用户
	addUserCouponApi:addUserCoupon,
	//轮播图详情
	SlideshowMessApi:SlideshowMess,
	//用户认证和用户车辆添加
	addNewUserorCarApi:addNewUserorCar,
	//根据手机号查询客户
	queryCustomerApi : queryCustomer,
	//生成项目的订单
	queryUserShoppingAddUserOrderApi:queryUserShoppingAddUserOrder,
	//订单的详情查询
	queryUserOrdersListApi : queryUserOrdersList,
	//查询订单截至时间和数据库当前时间
	queryOrderExpirationTimeApi : queryOrderExpirationTime,
	//微信订单生成参数的逻辑流
	weChatPayApi : weChatPay,
	//订单的锁定
	updateUserOrderLockingApi : updateUserOrderLocking,
	//查询车帐本的照片
	orderCommentPhotoApi : orderCommentPhoto,
	//过业务字典查询点击菜单的url 
	menuDicApi :menuDic,
	//查询可分享的优惠劵
	queryShareUseCouponListApi : queryShareUseCouponList,
	//根据优惠劵编码查询出具体分享的优惠劵
	queryShareUseCouponMainApi : queryShareUseCouponMain,
	//用户领取可分享优惠劵
	addUserShareUseCouponApi : addUserShareUseCoupon,
	//查询门店营销活动
	queryStoreActivityListApi : queryStoreActivityList,
	//车道账号验证
	authenticationApi : authentication,
	//更新员工的微信openId
	saveMemberOpenIDApi: saveMemberOpenID,
	    //获取微信待支付单信息
	queryFisPreBillApi:queryFisPreBill
}






