/**
 * Created by Administrator on 2018/3/21.
 */ 
 var webBaseUrl = webPath + contextPath + "/";   
 var baseUrl = apiPath + repairApi + "/";       
 var mainGrid = null;  
 var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
 var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
 var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
 var cardTimesGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestIdNopage.biz.ext";
 var itemTimesGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryItemTimesByUsable.biz.ext";
 var memCardGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCardByGuestIdNoPage.biz.ext";
 var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext"; 
 var getAccountUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryFrmAccount.biz.ext";
 var itemRpbGridUrl = baseUrl + "com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
 //var sellUrl = apiPath + crmApi + "/com.hsapi.crm.basic.crmBasic.querySellList.biz.ext";
 var sellUrl = apiPath + crmApi + "/com.hsapi.crm.basic.crmBasic.querySellListNoPage.biz.ext";
 var itemGrid = null;
 var sfData = {};
 var billForm = null;   
 var xyguest = null;  
 var brandList = []; 
 var brandHash = {};
 var servieTypeList = [];
 var servieTypeHash = {};
 var receTypeIdList = [];
 var receTypeIdHash = {};
 var memList = [];
 var serviceTypeIdEl = null; 
 var mtAdvisorIdEl = null;
 var searchNameEl = null;
 var servieIdEl = null;
 var searchKeyEl = null;
 var ycAmt = 0;
 var tcAmt = 0;
 var gsAmt = 0;
 var lastCheckParams = null;
 var itemTimesGrid = null;
 //var rpsPackageGrid = null;
 var rpsItemGrid = null;
 var packageDetailGrid = null;
 var packageDetailGridForm = null;
 var FItemRow = {};
 //var pkgRateEl = null;
 var itemRateEl = null;
 var partRateEl = null;
 var carSellPointInfo = null;

 //var advancedMorePartWin = null;
 var advancedCardTimesWin = null;
 var advancedPkgRateSetWin = null;
 var advancedItemPartRateSetWin = null;
 var advancedItemTimesWin = null;
 //var advancedPkgWorkersSetWin = null;
 //var advancedPkgSaleMansSetWin = null;
 //var advancedItemWorkersSetWin = null;
 var advancedItemPartSaleManSetWin = null;
 var advancedGuest = null;
 var cardTimesGrid = null;
 var advancedMemCardWin = null;
 var memCardGrid = null;
 var carSellPointGrid = null;
 var sellForm = null;
 var carCheckInfo = null;
 var checkMainData = null;
 var rdata = {};
 var isRecord = null;

 var fserviceId = 0;
 var fguestId = 0;
 var fcarId = 0;
 var mpackageRate = 0;
 var mitemRate = 0;
 var mpartRate = 0;
 var x = 0;
 var y = 0;
 var score = 0;
 var lcheckDate = '';
 var contactorF = null;
 var prdtTypeHash = {
    "1":"套餐",
    "2":"项目",
    "3":"配件"
};
 var hash = new Array("尚未联系", "有兴趣", "意向明确", "成交" ,"输单");
//document.onmousemove = function(e){
//
//    if(advancedMorePartWin.visible){
//        var mx = e.pageX;
//        var my = e.pageY;
//        var loc = "当前位置 x:"+e.pageX+",y:"+e.pageY
//        var x = advancedMorePartWin.x;
//        var y = advancedMorePartWin.y;
//        if(x - mx > 10 || mx - x > 180){
//            advancedMorePartWin.hide();
//            FItemRow = {};
//            return;
//        }
//        if(y - my > 10 || my - y > 130){
//            advancedMorePartWin.hide();
//            FItemRow = {};
//            return;
//        }
//    }
//   
//}
$(document).ready(function ()
{
    rpsItemGrid = nui.get("rpsItemGrid");
    billForm = new nui.Form("#billForm");
    sellForm = new nui.Form("#sellForm");
    advancedCardTimesWin = nui.get("advancedCardTimesWin");
    advancedItemTimesWin = nui.get("advancedItemTimesWin");
    advancedPkgRateSetWin = nui.get("advancedPkgRateSetWin");
    advancedItemPartRateSetWin = nui.get("advancedItemPartRateSetWin");
    advancedItemPartSaleManSetWin = nui.get("advancedItemPartSaleManSetWin");
    advancedGuest = nui.get("advancedGuest");
    carCheckInfo = nui.get("carCheckInfo");
    carSellPointInfo = nui.get("carSellPointInfo");
    cardTimesGrid = nui.get("cardTimesGrid");
    cardTimesGrid.setUrl(cardTimesGridUrl);
    itemTimesGrid = nui.get("itemTimesGrid");
    itemTimesGrid.setUrl(itemTimesGridUrl);
    advancedMemCardWin = nui.get("advancedMemCardWin");
    memCardGrid = nui.get("memCardGrid");
    memCardGrid.setUrl(memCardGridUrl);
    carSellPointGrid = nui.get("carSellPointGrid");
    /*    var data = [{prdtName:'保养到期提醒',amt:'3850',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'保养到期提醒'},
                    {prdtName:'商业险到期提醒',amt:'2600',status:'未联系',creator:'杨超越',doTimes:'2018-12-15',type:'商业险到期提醒'},
                    {prdtName:'交强险到期提醒',amt:'3460',status:'未联系',creator:'杨超越',doTimes:'2018-12-26',type:'交强险到期提醒'},
                    {prdtName:'更换机油',amt:'360',status:'意向明确',creator:'杨超越',doTimes:'2018-12-05',type:'车况检查'},
                    {prdtName:'更换轮胎',amt:'5500',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-08',type:'车况检查'},
                    {prdtName:'储值卡到期',amt:'1000',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'储值卡到期'},
                    {prdtName:'贴膜',amt:'50',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'},
                    {prdtName:'镀金',amt:'330',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'},
                    {prdtName:'更换机油',amt:'35',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'}];*/
        carSellPointGrid.setUrl(sellUrl);

   // pkgRateEl = nui.get("pkgRateEl");
    itemRateEl = nui.get("itemRateEl");
    partRateEl = nui.get("partRateEl");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    searchNameEl = nui.get("search_name");
    servieIdEl = nui.get("servieIdEl");
    searchKeyEl = nui.get("search_key");
    searchKeyEl.setUrl(guestInfoUrl);
    
    initDicts({
    	chanceType:SELL_TYPE//商机
    },function(data){
    	
    });
    searchKeyEl.on("beforeload",function(e){
        if(fserviceId){
            e.cancel = true;
            return;
        }
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        params.isDisabled = 0;
        if(value.length<3){
            e.cancel = true;
            return;
        }else{
            var reg = /^[0-9]*$/;//纯数字
            if(reg.test(value)){
                params.nums = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含字母
            var reg = /[a-z]/i;
            if(reg.test(value)){
                params.letters = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if(reg.test(value)){
                params.chis = value;

                data.params = params;
                e.data =data;
                return;
            }
        }
    });
    
    carSellPointGrid.on("drawcell", function(e) {
		switch (e.field) {
		case "status":
			e.cellHtml = hash[e.value];
			break;
		case "chanceType":
			for(var i=0;i<sfData.length;i++){
				if(e.value==sfData[i].customid){
					e.cellHtml =sfData[i].name;
					}
				}
			break;
		case "cardTimesOpt":
			e.cellHtml = '<a class="optbtn" href="javascript:void()" onclick="editSell()">跟进</a>';
			break;
		default:
			break;
		}

	});
    searchKeyEl.on("valuechanged",function(e){
    	var item = e.selected;
        if(fserviceId){
            return;
        }
        if (item) { 
        	setGuest(item);
        }
    });
    
    searchKeyEl.on("itemclick",function(e){
    	var item = e.item;
        if(fserviceId){
            return;
        }
        if (item) { 
        	setGuest(item);
        }
    });
    searchKeyEl.focus();
    //document.getElementById("formIframe").src=webPath + contextPath + "/repair/common/pipSelect.jsp?token"+token;
   
    initMember("checkManId",function(){
        memList = nui.get("checkManId").getData();
        //nui.get("checkManId").setData(memList);
    });
    
    getMtadvisor(function(text){
    	mtAdvisorIdEl.setData(text.data);
    });
  
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    
    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
    itemRateEl.on("validation",function(e){
        if(!e.isValid){
            itemRateEl.setValue(0);
        }
    });
    partRateEl.on("validation",function(e){
        if(!e.isValid){
            partRateEl.setValue(0);
        }
    });
    
    rpsItemGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        //获取到配件ID
    	var pid = record.pid||0;
        switch (e.field) {
	       case "prdtName":
	           var cardDetailId = record.cardDetailId||0;
	           var s = "";
	           if(cardDetailId>0){
	               s = "<font color='red'>(预存)</font>";
	           }
	           if(pid == 0){
	                //e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' +'<a href="javascript:showBasicDataPart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;标准配件</a>'+ e.value;
	            
	               e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value + s;	
	                			 //'<ul class="add_ul" style="z-index: 99; display: none;">' +
			            		 //'<li>< a href="javascript:choosePart(\'' + uid + '\')">添加配件</ a></li>' +
			            		 //'<li>< a href="javascript:showBasicDataPart(\'' + uid + '\')" class="xzpj">选择配件</ a></li>' +
	                             //'</ul>';
	            
	           }else{
	              e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
	           }
	            break;
            case "itemOptBtn":
            	if(pid == 0){
            		var cardDetailId = record.cardDetailId||0;
                  	s = ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
                  	if(cardDetailId<=0){
                  		s = s + ' <a class="optbtn" href="javascript:updateItemRow(\'' + uid + '\')">修改项目</a>';
                  	}
                    
                 }else{
                	 s = ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                  }
                 e.cellHtml = s;
                break;
            case "serviceTypeId":
                var type = record.type||0;
                if(type>2){
                    e.cellHtml = "--";
                    e.cancel = false;
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "workers":
                var type = record.type||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            case "saleMan":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId> 0){
                    e.cellHtml = "--";
                }
                break;
            default:
                break;
        }
    });
    rpsItemGrid.on("cellbeginedit",function(e){
        var field=e.field; 
        var editor = e.editor;
        var row = e.row;
        var column = e.column;
        var editor = e.editor;
        //配件type=3
        if(field == 'serviceTypeId'){
            if(row.type > 2) {
                e.cancel = true;
            }
        }
        if(field == 'workers'){
            if(row.type == 3){
                e.cancel = true;
            }
        }
        if(field == 'unitPrice' || field == 'subtotal' || field == 'rate' || field == 'saleMan' || field == 'qty'){
            if(row.cardDetailId > 0){
                e.cancel = true;
            }
        }
    });

    cardTimesGrid.on("drawcell",function(e)
    {
        if(e.field == "prdtType" && prdtTypeHash[e.value])
        {
            e.cellHtml = prdtTypeHash[e.value];
        }
        if(e.field == "doTimes")
        {
            var row = e.row;
            var balaTimes = row.balaTimes || 0;
            var canUseTimes = row.canUseTimes||0;
            e.cellHtml = balaTimes - canUseTimes;
        }
        if(e.field == 'cardTimesOpt'){
            e.cellHtml = '<a class="optbtn" href="javascript:addCardTimesToBill()">选择</a>';
        }
    });
    itemTimesGrid.on("drawcell",function(e){
	        if(e.field == "prdtType" && prdtTypeHash[e.value])
	        {
	            e.cellHtml = prdtTypeHash[e.value];
	        }
	        if(e.field == "doTimes")
	        {
	            var row = e.row;
	            var balaTimes = row.balaTimes || 0;
	            var canUseTimes = row.canUseTimes||0;
	            e.cellHtml = balaTimes - canUseTimes;
	        }
	        if(e.field == 'cardTimesOpt'){
	            e.cellHtml = '<a class="optbtn" href="javascript:addItemTimesToBill()">选择</a>';
	        }
    });
    memCardGrid.on("drawcell",function(e)
    {
        var row = e.row;
/*        if(e.field == "balaAmt")
        {
            var totalAmt = row.totalAmt || 0;
            var useAmt = row.useAmt||0;
            e.cellHtml = totalAmt - useAmt;
        }*/
        if(e.field == "periodValidity")
        {
            if(e.value == -1){
                e.cellHtml = "永久有效";
            }else{
                var st = row.modifyDate;
                e.cellHtml = AddMonthNumsDate(st,e.value);
            }
        }
    });


    document.getElementById("search_key$text").setAttribute("placeholder","请输入...(车牌号/客户名称/手机号/VIN码)");
    // document.onmousedown=function(event){ 
    //     var i = 0;
    // };
    document.onkeyup=function(event){
       var e=event||window.event;
       var keyCode=e.keyCode||e.which;

	    if((keyCode==78)&&(event.altKey))  {  //新建
         add();	
     } 

	    if((keyCode==83)&&(event.altKey))  {   //保存
         save();
     } 
	}
    document.getElementById("showA1").style.display = "";
	document.getElementById("showA").style.display='none';
	if(currIsOpenElectronics == "1") {
		document.getElementById("showE1").style.display = "";
		document.getElementById("showE").style.display='none';
	}
	/*if(currIsOpenOfferRemind == "1") {
		document.getElementById("carRemind").style.display = "";
	}else{
		document.getElementById("carRemind").style.display='none';
		
	}*/
	nui.get("enterDate").setValue(now);
    doSearchItem();
    //钣喷项目隐藏
	document.getElementById("chooseBlank").style.display = "none"; 
});

function setGuest(item){
	var carNo = item.carNo||"";
    var tel = item.guestMobile||"";
    var guestName = item.guestFullName||"";
    var carVin = item.vin||"";

    var data = {
        carNo: carNo,
        isSettle: 0,
        orgid: currOrgId,
        isDisabled : 0
    };
    var params = {	
    	"params":data
    };
    checkRpsMaintain(params, function(text){
        var data = text.data||[];
        if(data && data.length>0){
            nui.showMessageBox({
                showHeader: true,
                width: 255,
                title: "工单",
                buttons: ["继续", "查看"],
                message: "该客户存在未结算记录",
                iconCls: "mini-messagebox-warning",
                callback: function (action) {
                    if(action == "继续"){
                        var sk = document.getElementById("search_key");
                        sk.style.display = "none";
                        searchNameEl.setVisible(true);
                        
                        if(tel){
                            tel = "/"+tel;
                        }
                        if(guestName){
                            guestName = "/"+guestName;
                        }
                        if(carVin){
                            carVin = "/"+carVin;
                        }
                        var t = carNo + tel + guestName + carVin;
                        searchNameEl.setValue(t);
                        //searchNameEl.setEnabled(false);
            
                        doSetMainInfo(item);
                    }else if(action == "查看"){
                    	var list = data[0];
                    	var opt={};
                        opt.iconCls="fa fa-desktop";
                    	if(list.billTypeId == "0"){
                            opt.id="2082";
                            opt.text="综合开单";
                            opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.ReceptionMain.flow";
                    	}
                    	if(list.billTypeId == "2"){
                            opt.id="2083";
                            opt.text="洗美开单";
                            opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBillMgr.flow";
                    	}
                    	if(list.billTypeId == "4"){
                            opt.id="2084";
                            opt.text="理赔开单";
                            opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.claimMain.flow";
                    	}
                    	if(list.billTypeId == "3"){
                            opt.id="2087";
                            opt.text="销售开单";
                            opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.sellMain.flow";
                    	}
                    	if(list.billTypeId == "5"){
                            opt.id="2088";
                            opt.text="退货开单";
                            opt.url=webPath + contextPath + "/com.hsweb.RepairBusiness.sellReturn.flow";
                    	}
                    	if(list.billTypeId == "6"){
                            opt.id="2863";
                            opt.text="波箱开单";
                            opt.url=webPath + contextPath + "/com.hsweb.bx.waveBoxMain.flow";
                    	}
                    	var params = {
                                type: 'view',
                                carNo: carNo
                            };
                       window.parent.activeTabAndInit(opt,params);
                    }else{
                    	return;
                    }
                }
            });
        }else{
            var sk = document.getElementById("search_key");
            sk.style.display = "none";
            searchNameEl.setVisible(true);
            
            if(tel){
                tel = "/"+tel;
            }
            if(guestName){
                guestName = "/"+guestName;
            }
            if(carVin){
                carVin = "/"+carVin;
            }
            var t = carNo + tel + guestName + carVin;
            searchNameEl.setValue(t);
            //searchNameEl.setEnabled(false);

            doSetMainInfo(item);
        }
    });
}


var statusHash = {
    "0" : "制单",
    "1" : "维修",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};
function advancedSearch(){
    if(document.getElementById("advancedMore").style.display=='block'){
        document.getElementById("advancedMore").style.display='none';
    }else{
        document.getElementById("advancedMore").style.display='block';
    }
    
}
function clear(){
    advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerItemGrid.setData([]);
    innerPartGrid.setData([]);

    var params = {};
    params.serviceId = row.id;
    innerItemGrid.load({
        params:params,
        token: token
    });

    innerPartGrid.load({
        params:params,
        token: token
    });
}
function onApplyClick(){
    doApplyCustomer({},function(action){
        if(action == 'ok'){
            var iframe = this.getIFrameEl();
            var guest = iframe.contentWindow.getSaveData();
            if(guest){
                var maintain = billForm.getData();
                maintain.carId = guest.carId||0;
                maintain.carNo = guest.carNo;
                maintain.carVin = guest.vin;
                maintain.engineNo = guest.engineNo;
                maintain.contactorId = guest.contactorId||0;
                maintain.contactorName = guest.contactName;
                maintain.identity = guest.identity;
                maintain.mobile = guest.mobile;
                maintain.guestFullName = guest.guestFullName;
                maintain.guestId = guest.guestId;
                maintain.carModel = guest.carModel;
                carNoEl.setText(guest.carNo);
                billForm.setData(maintain);
                nui.get("contactorName").setText(guest.contactName);
                fguestId = guest.guestId||0;
                fcarId = guest.carId||0;

                mpackageRate = 0;
                mitemRate = 0;
                mpartRate = 0;

                $("#carNoEl").html(car.carNo);
                $("#guestNameEl").html(car.guestFullName);
                $("#guestTelEl").html(car.mobile);
            }
        }
    });
}
function onSearchClick(){
    var maintain = billForm.getData();
    if(maintain.id){
        return;
    }
    selectCustomer(function (car) {
        doSetMainInfo(car);
    });
}
var lastComeKilometers = null;
function doSetMainInfo(car){
    var maintain = billForm.getData();
    maintain.carId = car.id;
    maintain.carNo = car.carNo;
    maintain.carVin = car.vin;
    maintain.carModelIdLy = car.carModelIdLy||"";
    maintain.engineNo = car.engineNo;
    maintain.contactorId = car.contactorId;
    maintain.contactorName = car.contactName;
    maintain.identity = car.identity;
    maintain.mobile = car.mobile;
    maintain.guestMobile = car.guestMobile;
    maintain.guestFullName = car.guestFullName;
    maintain.guestId = car.guestId;
    maintain.carModel = car.carModel;
    maintain.billTypeId = 2;
    maintain.serviceTypeId = 3;
    maintain.mtAdvisorId = currEmpId;
    maintain.mtAdvisor = currUserName;
    maintain.enterDate = now;

    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;
    nui.get("contactorName").setText(car.contactName);
    billForm.setData(maintain);
    xyguest = maintain;
    fguestId = car.guestId||0;
    fcarId = car.id||0;

    doSearchCardTimes(fguestId,fcarId);
    doSearchItemTimes(fguestId,fcarId);
    doSearchMemCard(fguestId);
    doSearchSell(fguestId);
    $("#guestNameEl").html(car.guestFullName);
    $("#showCarInfoEl").html(car.carNo);
    $("#guestTelEl").html(car.guestMobile);
    if(car.id){
    	var lastComeKilometersUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCarExtend.biz.ext";
    	var json = nui.encode({
    		carId:car.id,
    		token:token
    	});
    	 //查找上次里程
        nui.ajax({
    		url : lastComeKilometersUrl,
    		type : 'POST',
    		data : json,
    		cache : false,
    		contentType : 'text/json',
    		success : function(text) {
    			var returnJson = nui.decode(text);
    			if (returnJson.errCode == "S") {
    				var data = returnJson.data;
    				lastComeKilometers = data.lastComeKilometers || 0;
    				//$("#lastComeKilometers").html(lastComeKilometers);
    			} else {
    				showMsg(returnJson.errMsg||"查询上次里程失败","E");
    		    }
    		}
    	 });
    }
}
function setInitData(params){
    fserviceId = params.id;
    var data = {
			packageSubtotal:0,
			packagePrefAmt:0,
			itemSubtotal:0,
			itemPrefAmt:0,
			partSubtotal:0,
			partPrefAmt:0,
			totalAmt:0,
			totalPrefAmt:0,
			totalSubtotal:0,
			ycAmt:0
	};
	sellForm.setData(data);
    if(!params.id){
        add();
    }else{
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        var params = {
            data: {
                id: params.id
            }
        }
        getMaintain(params, function(text){
            var errCode = text.errCode||"";
            var data = text.maintain||{};
            /*var lastEnterKilometers = data.lastEnterKilometers || 0;
            $("#lastComeKilometers").html(lastEnterKilometers);*/
            if(errCode == 'S'){
            	//挂账
            	if(data.guestId){
                	var accAmt = {};
                	accAmt.guestId = data.guestId;
                	nui.ajax({
                        url : getAccountUrl,
                        type : "post",
                        data : JSON.stringify({
                            params : accAmt,
                            token : token
                        }),
                        success : function(data) {
                        	data = data || {};
                            if (data.errCode == "S") {
                                var account = data.account[0];
                                var Amt = account.accountAmt || 0;
                                $("#creditEl").html("挂账:"+Amt);
                            } else {
                                showMsg(data.errMsg || "获取挂账信息失败","E");
                            }
                        },
                        error : function(jqXHR, textStatus, errorThrown) {
                            unmaskcall && unmaskcall();
                            console.log(jqXHR.responseText);
                        }
                    });
                }
                var p = {
                    data:{
                        guestId: data.guestId||0,
                        contactorId: data.contactorId||0,
                        carId:data.carId || 0
                    }
                }
                getGuestContactorCar(p, function(text){
                    var errCode = text.errCode||"";
                    var guest = text.guest||{};
                    var car = text.car || {};
                    var contactor = text.contactor||{};
                    contactorF = contactor;
                    if(errCode == 'S'){
                        $("#servieIdEl").html(data.serviceCode);
                        if(currIsOpenElectronics == "1") {
	                        if(data.isElectronics == 1) {
		                        document.getElementById("showE1").style.display = 'none';
		                    	document.getElementById("showE").style.display="";
	                        }else {
	                        	document.getElementById("showE1").style.display = "";
	                        	document.getElementById("showE").style.display='none';
	                        }
                    	}
                        var carNo = data.carNo||"";
                        var tel = guest.mobile||"";
                        var guestName = guest.fullName||"";
                        var carVin = data.carVin||"";
                        if(tel){
                            tel = "/"+tel;
                        }
                        if(guestName){
                            guestName = "/"+guestName;
                        }
                        if(carVin){
                            carVin = "/"+carVin;
                        }
                        var t = carNo + tel + guestName + carVin;

                        var sk = document.getElementById("search_key");
                        sk.style.display = "none";
                        if(contactor.wechatOpenId){
                        	document.getElementById("showA").style.display = "";
                        	document.getElementById("showA1").style.display='none';
                        }else{
                        	document.getElementById("showA").style.display='none';
                        	document.getElementById("showA1").style.display = "";
                        }
                        searchNameEl.setVisible(true);

                        searchNameEl.setValue(t);
                        searchNameEl.setEnabled(false);

                        data.guestFullName = guest.fullName;
                        data.guestMobile = guest.mobile;
                        data.contactorName = contactor.name;
                        data.mobile = contactor.mobile;
                        data.carModel = car.carModel;
                        data.carModelIdLy = car.carModelIdLy||"";
                        $("#guestNameEl").html(data.guestFullName);
                        $("#showCarInfoEl").html(data.carNo);
                        $("#guestTelEl").html(guest.mobile);

                        fguestId = data.guestId||0;
                        fcarId = data.carId||0;

                        doSearchCardTimes(fguestId,fcarId);
                        doSearchItemTimes(fguestId,fcarId);
                        doSearchMemCard(fguestId);
                        doSearchSell(fguestId);
                        xyguest = data;
                        nui.get("contactorName").setText(contactor.name);
                        billForm.setData(data);

                        var status = data.status||0;
                        var balaAuditSign = data.balaAuditSign||0;
                        if(balaAuditSign==1){                    	
                        	doSetStyle(status, balaAuditSign);
                        }else{
                        	var isSettle = data.isSettle||0;
                        	doSetStyle(status, isSettle);                       	
                        }

                        /*if(data.isOutBill){
                        	nui.get("ExpenseAccount").setVisible(false);
                        	nui.get("ExpenseAccount1").setVisible(true);
                        }else{
                        	nui.get("ExpenseAccount").setVisible(true);
                        	nui.get("ExpenseAccount1").setVisible(false);
                        }*/

                        var p1 = {
                        }
                        var p2 = {
                            interType: "item",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        var p3 = {
                            interType: "part",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        loadDetail(p1, p2, p3,status,function(){
                        	var strId = forFrom();
                            if(strId!=null){
                            	showTab(strId);
                            }
                        });
                    }else{
                        showMsg("数据加载失败,请重新打开工单!","E");
                    }

                }, function(){});
            }else{
                showMsg('数据加载失败!','E');
            }
        }, function(){
            nui.unmask(document.body);
        });
    }
    //钣喷项目隐藏
	document.getElementById("chooseBlank").style.display = "none";
}
function add(){
	showcF = 1;
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
   // rpsPackageGrid.clearRows();
    rpsItemGrid.clearRows();
    billForm.setData([]);
    var data = {
			packageSubtotal:0,
			packagePrefAmt:0,
			packageAmt:0,
			itemSubtotal:0,
			itemPrefAmt:0,
			itemAmt:0,
			partSubtotal:0,
			partPrefAmt:0,
			partAmt:0,
			totalAmt:0,
			totalPrefAmt:0,
			totalSubtotal:0,
			ycAmt:0
	};
   document.getElementById("packageAmt1").innerHTML = data.packageAmt;
   document.getElementById("itemAmt1").innerHTML = data.itemAmt;
   document.getElementById("partAmt1").innerHTML = data.partAmt;
   document.getElementById("totalAmt1").innerHTML = data.totalAmt;
   document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
   document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
    nui.get("contactorName").setText("");
    sellForm.setData(data);
    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(1);
    nui.get("enterDate").setValue(now);

    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;
   // $("#lastComeKilometers").html("0");
    /*if(type=="ADD"){
    	document.getElementById("formIframe").contentWindow.doSetCardTimes([]);
    }*/
    $("#servieIdEl").html("");
    $("#showCardTimesEl").html("次卡套餐(0)");
    $("#showCardEl").html("储值卡(0)");
    $("#creditEl").html("挂账:0");
    $("#showCarInfoEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");

  /*  nui.get("ExpenseAccount").setVisible(true);
    nui.get("ExpenseAccount1").setVisible(false);*/
    $("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");
    var tabList = document.querySelectorAll('.xz');
	var natureId = null;
	for(var i=0;i<tabList.length;i++){
		natureId= tabList[i].id;
		var s = "#"+natureId;
		$(s).toggleClass("xz");
	}
	document.getElementById("showA1").style.display = "";
	document.getElementById("showA").style.display='none';
	if(currIsOpenElectronics == "1") {
	    document.getElementById("showE1").style.display = "";
		document.getElementById("showE").style.display='none';
	}
	advancedCardTimesWin.hide();
	advancedMemCardWin.hide();
	advancedItemTimesWin.hide();
	 //钣喷项目隐藏
	document.getElementById("chooseBlank").style.display = "none";
}
function save(){
	itemF = "S";
	partF = "S";
	var data = billForm.getData(true);
	if(data.status == 2){
		showMsg("工单已完工","W");
        return;        
    }
	if(data.isSettle == 1){
		showMsg("工单已结算","W");
        return;        
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){
        saveItem(function(){
        	setFrom(data);
        });
        
    },function(){ 
        nui.unmask(document.body);
    });
}

function setFrom(data){
	if(data.id){
        fserviceId = data.id;
        //showMsg("保存成功!","S");
      //查询挂账
        if(data.guestId){
        	var params = {};
            params.guestId = data.guestId;
        	nui.ajax({
                url : getAccountUrl,
                type : "post",
                data : JSON.stringify({
                    params : params,
                    token : token
                }),
                success : function(data) {
                	data = data || {};
                    if (data.errCode == "S") {
                        var account = data.account[0];
                        var Amt = account.accountAmt || 0;
                        $("#creditEl").html("挂账:"+Amt);
                    } else {
                        showMsg(data.errMsg || "获取挂账信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    unmaskcall && unmaskcall();
                    console.log(jqXHR.responseText);
                }
            });
        }
        var params = {
            data:{
                guestId: data.guestId||0,
                contactorId: data.contactorId||0,
                carId:data.carId || 0
            }
        };

        getGuestContactorCar(params, function(text){
            var errCode = text.errCode||"";
            var guest = text.guest||{};
            var car = text.car || {};
            var contactor = text.contactor||{};
            contactorF = contactor;
            var car = text.car || {};
            if(errCode == 'S'){
                $("#servieIdEl").html(data.serviceCode);
                var carNo = data.carNo||"";
                var tel = guest.mobile||"";
                var guestName = guest.fullName||"";
                var carVin = data.carVin||"";
                if(tel){
                    tel = "/"+tel;
                }
                if(guestName){
                    guestName = "/"+guestName;
                }
                if(carVin){
                    carVin = "/"+carVin;
                }
                var t = carNo + tel + guestName + carVin;
                if(contactor.wechatOpenId){
                 	document.getElementById("showA").style.display = "";
                 	document.getElementById("showA1").style.display='none';
                 }else{
                 	document.getElementById("showA").style.display='none';
                 	document.getElementById("showA1").style.display = "";
                }
                searchNameEl.setValue(t);
                searchNameEl.setEnabled(false);

                data.guestFullName = guest.fullName;
                data.guestMobile = guest.mobile;
                data.contactorName = contactor.name;
                data.mobile = contactor.mobile;
                data.carModel = car.carModel;
                data.carModelIdLy = car.carModelIdLy||"";
                billForm.setData(data);
                var status = data.status||0;
                var isSettle = data.isSettle||0;
                doSetStyle(status, isSettle);
                nui.get("contactorName").setText(contactor.name);
                //判断情况
                if(itemF=="S" && partF=="S"){
                	 showMsg("保存成功!","S");
                }else if(itemF=="S" && partF=="E"){
                	showMsg("配件修改失败!","E");
                }else if(itemF=="E" && partF=="S"){
                	showMsg("项目修改失败!","E");
                }else{
                	showMsg("修改数据失败!","E");
                }
                
                var p1 = {
                }
                var p2 = {
                    interType: "item",
                    data:{
                        serviceId: data.id||0
                    }
                }
                var p3 = {
                    interType: "part",
                    data:{
                        serviceId: data.id||0
                    }
                }
                loadDetail(p1, p2, p3,status);
                nui.unmask(document.body);
            }else{
            	nui.unmask(document.body)
                showMsg("数据加载失败,请重新打开工单!","E");
            }

        }, function(){});
    }
}

function saveNoshowMsg(callback,type){
	var setCStored = billForm.getData();
	var id = setCStored.id || 0;
	if(type && type=="addYC" && id!=0){
	    callback && callback();
	}else{
	  saveMaintain(function(data){
        if(data.id){
            fserviceId = data.id;
            //showMsg("保存成功!","S");
            //查询挂账
            if(data.guestId){
            	var params = {};
                params.guestId = data.guestId;
            	nui.ajax({
                    url : getAccountUrl,
                    type : "post",
                    data : JSON.stringify({
                        params : params,
                        token : token
                    }),
                    success : function(data) {
                    	data = data || {};
                        if (data.errCode == "S") {
                            var account = data.account[0];
                            var Amt = account.accountAmt || 0;
                            $("#creditEl").html("挂账:"+Amt);
                        } else {
                            showMsg(data.errMsg || "获取挂账信息失败","E");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown) {
                        unmaskcall && unmaskcall();
                        console.log(jqXHR.responseText);
                    }
                });
            }
            var params = {
                data:{
                    guestId: data.guestId||0,
                    contactorId: data.contactorId||0,
                    carId:data.carId || 0
                }
            };
            getGuestContactorCar(params, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
                var car = text.car || {};
                var contactor = text.contactor||{};
                contactorF = contactor;
                if(errCode == 'S'){
                    $("#servieIdEl").html(data.serviceCode);
                    if(currIsOpenElectronics == "1") {
	                    if(data.isElectronics == 1) {
	                        document.getElementById("showE1").style.display = 'none';
	                    	document.getElementById("showE").style.display="";
	                    }else {
	                    	document.getElementById("showE1").style.display = "";
	                    	document.getElementById("showE").style.display='none';
	                    }
                    }
                    
                    var carNo = data.carNo||"";
                    var tel = guest.mobile||"";
                    var guestName = guest.fullName||"";
                    var carVin = data.carVin||"";
                    if(tel){
                        tel = "/"+tel;
                    }
                    if(guestName){
                        guestName = "/"+guestName;
                    }
                    if(carVin){
                        carVin = "/"+carVin;
                    }
                    var t = carNo + tel + guestName + carVin;
                    searchNameEl.setValue(t);
                    searchNameEl.setEnabled(false);

                    data.guestFullName = guest.fullName;
                    data.guestMobile = guest.mobile;
                    data.contactorName = contactor.name;
                    data.mobile = contactor.mobile;
                    data.carModel = car.carModel;
                    data.carModelIdLy = car.carModelIdLy||"";
                    billForm.setData(data);
                    nui.get("contactorName").setText(contactor.name);
                    var status = data.status||0;
                    var isSettle = data.isSettle||0;
                    doSetStyle(status, isSettle);

                    var p1 = {
                     };
                    var p2 = {
                        interType: "item",
                        data:{
                            serviceId: data.id||0
                        }
                    };
                    var p3 = {
                        interType: "part",
                        data:{
                            serviceId: data.id||0
                        }
                    };
                    loadDetail(p1, p2, p3,status);
                    callback && callback();
                }else{
                    showMsg("数据加载失败,请重新打开工单!","E");
                }

            }, function(){});
        }
        
     });
	}
}

var elecUrl = baseUrl + "com.hsapi.repair.repairService.crud.updateMainElectronics.biz.ext";
function signElectronics(){
	var data = billForm.getData();
	if(!data.id){
		return;
	}
	var type = document.getElementById("showE").style.display;
	var json = {
		id:data.id,
		status:type==""?0:1,
		token:token
	};
	nui.ajax({
		url : elecUrl,
		type : "post",
		data : json,
		success : function(data) {
			if(data.errCode=="S"){
				if(type == "") {
					document.getElementById("showE1").style.display = "";
					document.getElementById("showE").style.display='none';
				}else {
					document.getElementById("showE1").style.display = 'none';
					document.getElementById("showE").style.display="";
				}
			}else{
				nui.alert(data.errMsg||"更新失败","提示");
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}

var requiredField = {
    carNo : "车牌号",
    guestId : "客户",
    serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问"
};
var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData(true);
    for ( var key in requiredField) {
	      if (!data[key] || $.trim(data[key]).length == 0) {
	        unmaskcall && unmaskcall();
	        showMsg(requiredField[key] + "不能为空!","W");
	        return;
	    }
	}
    if (data.planFinishDate) {
		data.planFinishDate = format(data.planFinishDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if (data.enterDate) {
		data.enterDate = format(data.enterDate, 'yyyy-MM-dd HH:mm:ss');
	}
    /*if(data.id) {
    	delete data.enterDate;
    }*/
    data.billTypeId = 2;
    if(data.enterKilometers == 0){
    	data.enterKilometers = lastComeKilometers;
    }
	var params = {
	    data:{
	        maintain:data
	    }
	};
svrSaveMaintain(params, function(text){
    var errCode = text.errCode||"";
    if(errCode == "S") {
    	 var main = text.data||{};
    	 /*var carModel = nui.get("carModel").value || "";
     	 if(carModel != ""){
     	 	main.carModel = carModel;
     	 }*/
    	 fserviceId = main.id||0;
         var status = main.status;
    	 var oldData = billForm.getData(true);
    	 oldData.id = fserviceId;
     	 billForm.setData(oldData);
     	 if(currIsOpenElectronics == "1") {
	     	 if(main.isElectronics == 1) {
	            document.getElementById("showE1").style.display = 'none';
	        	document.getElementById("showE").style.display="";
	         }else {
	        	document.getElementById("showE1").style.display = "";
	        	document.getElementById("showE").style.display='none';
	         }
     	 }
     	
         var params1 = {
                 data:{
                     id:main.id||0
                 }
             };
    	//保存成功之后，执行确定维修接口，执行一次
        if(!status){
        	svrSureMT(params1, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                	var maintain = data.maintain;
                	//保存项目
                	//saveItem();
                	//unmaskcall && unmaskcall();
                    callback && callback(maintain);
                }else{
                	unmaskcall && unmaskcall();
                	showMsg("数据操作有误，请重新操作!","E");
                }
            }, function(){
                //nui.unmask(document.body);
            });
        }else{
        	//保存项目
        	//saveItem();
        	//unmaskcall && unmaskcall();
            callback && callback(main);
        }
    } else {
        unmaskcall && unmaskcall();
        showMsg(data.errMsg || "保存单据失败","E");
    }
}, function(){
    unmaskcall && unmaskcall();
})

    // nui.ajax({
    //     url : saveMaintainUrl,
    //     type : "post",
    //     data : JSON.stringify({
    //         maintain : data,
    //         token : token
    //     }),
    //     success : function(data) {
    //         data = data || {};
    //         if (data.errCode == "S") {
    //             unmaskcall && unmaskcall();
    //             var main = data.data;
    //             fserviceId = main.id||0;
    //             callback && callback(main);
    //         } else {
    //             unmaskcall && unmaskcall();
    //             showMsg(data.errMsg || "保存单据失败","W");
    //         }
    //     },
    //     error : function(jqXHR, textStatus, errorThrown) {
    //         unmaskcall && unmaskcall();
    //         console.log(jqXHR.responseText);
    //     }
    // });
}
function unfinish(){
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        var isSettle = data.isSettle||0;
        if(isSettle == 1){
            showMsg("工单已结算,不能返单!","W");
            return;
        }
        if(data.status != 2){
            showMsg("工单未完工,不能返单!","W");
            return;
        }
        
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '处理中...'
        });
        var params = {
            data:{
                id:data.id||0
            }
        };
        svrUnRepairAudit(params, function(data){
            data = data||{};
            var errCode = data.errCode||"";
            var errMsg = data.errMsg||"";
            if(errCode == 'S'){
                var maintain = data.main||{};
                var olddata = billForm.getData();
                olddata.status = 1;
                billForm.setData([]);
                if(olddata.balaAuditSign == 1){
                   olddata.balaAuditSign = 0;
                }
                billForm.setData(olddata);
                nui.get("contactorName").setText(maintain.contactorName);
                var status = 1;
                var isSettle = maintain.isSettle||0;
                doSetStyle(status, isSettle);
                showMsg("返单成功!","S");
                var p1 = {
                }
                var p2 = {
                    interType: "item",
                    data:{
                        serviceId: maintain.id ||0
                    }
                }
                var p3 = {
                    interType: "part",
                    data:{
                        serviceId: maintain.id||0
                    }
                }
                loadDetail(p1, p2, p3,status);
            }else{
                showMsg(errMsg||"返单失败!","E");
            }
            nui.unmask(document.body);
        }, function(){
            nui.unmask(document.body);
        });

    }
}
var loadMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function loadMaintain(callback,unmaskcall){
    var data = billForm.getData();
    for ( var key in requiredField) {
      if (!data[key] || $.trim(data[key]).length == 0) {
        unmaskcall && unmaskcall();
        showMsg(requiredField[key] + "不能为空!","W");
        return;
     }
   }
   data.billTypeId = 2;
   nui.ajax({
		url : saveMaintainUrl,
		type : "post",
		data : JSON.stringify({
		    maintain : data,
		    token : token
		}),
		success : function(data) {
		    data = data || {};
		    if (data.errCode == "S") {
		        unmaskcall && unmaskcall();
		        var main = data.data;
		        fserviceId = main.id||0;
		        callback && callback(main);
		    } else {
		        unmaskcall && unmaskcall();
		        showMsg(data.errMsg || "保存单据失败","E");
		    }
		},
		error : function(jqXHR, textStatus, errorThrown) {
		    unmaskcall && unmaskcall();
		        // nui.alert(jqXHR.responseText);
		        console.log(jqXHR.responseText);
		    }
    });
}


function addPrdt(data){
    var main = billForm.getData();
    if(!main.id){
       showMsg("请先保存工单!","E");
       return;
    }
    var type = data.type;
    var rtnRow = data.rtnRow||{};
    if(type == 0){
        if(rtnRow){
            var t = rtnRow.prdtType||0;
            var interType = "";
            if(t == 1){
                interType = "package";
            }else if(t == 2){
                interType = "item";
            }else if(t == 3){
                interType = "part";
            }
            if(!interType){
                showMsg("次卡类型有误!","W");
                return;
            }
            var data = {};
            if(interType == 'package'){
                var pkg = {
                    serviceId:main.id,
                    packageId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0
                };
                data.pkg = pkg;
            }else if(interType == 'item'){
                var insItem = {
                    serviceId:main.id||0,
                    itemId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0
                };
                data.insItem = insItem;
                data.serviceId = main.id||0;
            }else if(interType == 'part'){
                var insPart = {
                    serviceId:main.id||0,
                    partId:rtnRow.prdtId,
                    cardDetailId:rtnRow.id||0,
                    partCode:rtnRow.prdtCode
                };
                data.insPart = insPart;
                data.serviceId = main.id||0;
            }
            var params = {
                type:"insert",
                interType:interType,
                data:data
            };
            
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '数据加载中...'
            });
            saveItem(function(){
            	nui.unmask(document.body);
            	svrCRUD(params,function(text){
                    var errCode = text.errCode||"";
                    var errMsg = text.errMsg||"";
                    if(errCode == 'S'){
                    	nui.unmask(document.body);
                        var params = {
                            interType: interType,
                            data:{
                                serviceId: main.id||0
                            }
                        }
                        getBillDetail(params, function(text){
                            var errCode = text.errCode;
                            var data = text.data||[];
                            if(errCode == "S"){
                                /*if(interType == 'package'){
                                    rpsPackageGrid.clearRows();
                                    rpsPackageGrid.addRows(data);
                                }else*/ 
                            	if(interType == 'item'){
                                    rpsItemGrid.clearRows();
                                    rpsItemGrid.addRows(data);
                                    rpsItemGrid.accept();
                                    if(main.status<2){
                                    	var row = rpsItemGrid.findRow(function(row){
                                    		rpsItemGrid.beginEditRow(row);
                                        });
                                    }
                                }
                            }
                        }, function(){});
                    }else{
                        showMsg(errMsg||"添加预存信息失败!","E");
                        nui.unmask(document.body);
                        return;
                    }
                });
           });  
        }else{
            showMsg("请选择记录!","W");
            return;
        }
    }else if(type == 2){
        var data = {};
        var insItem = {
            serviceId:main.id||0,
            itemId:rtnRow.id,
            cardDetailId:0
        };
        data.insItem = insItem;
        data.serviceId = main.id||0;

        var params = {
            type:"insert",
            interType:'item',
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	 svrCRUD(params,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){
                	 nui.unmask(document.body);
                     var params = {
                         interType: 'item',
                         data:{
                             serviceId: main.id||0
                         }
                     }
                     getBillDetail(params, function(text){
                         var errCode = text.errCode;
                         var data = text.data||[];
                         if(errCode == "S"){
                             rpsItemGrid.clearRows();
                             rpsItemGrid.addRows(data);
                             rpsItemGrid.accept();
                             if(main.status<2){
                             	var row = rpsItemGrid.findRow(function(row){
                             		rpsItemGrid.beginEditRow(row);
                                 });
                             }
                         }
                     }, function(){});
                 }else{
                     showMsg(errMsg||"添加项目信息失败!","E");
                     nui.unmask(document.body);
                     return;
                 }
             });
        });
    }else if(type == 3){
        var data = {};
        var insPart = {
            serviceId:main.id||0,
            partId:rtnRow.id,
            cardDetailId:0,
            partCode:rtnRow.code
        };
        data.insPart = insPart;
        data.serviceId = main.id||0;

        var params = {
            type:"insert",
            interType:'part',
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	 svrCRUD(params,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 
                 if(errCode == 'S'){
                	 nui.unmask(document.body);
                     var params = {
                         interType: 'part',
                         data:{
                             serviceId: main.id||0
                         }
                     }
                     getBillDetail(params, function(text){
                         var errCode = text.errCode;
                         var data = text.data||[];
                         if(errCode == "S"){
                            // rpsPartGrid.clearRows();
                            // rpsPartGrid.addRows(data);
                         }
                     }, function(){});
                 }else{
                     showMsg(errMsg||"添加预存信息失败!","E");
                     nui.unmask(document.body);
                     return;
                 }
             });
        });
       
    }
}
function checkPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","W");
        return;
    }
    var type = data.type||-1;
    var rtnRow = data.rtnRow||{};
    if(type == 0){
        var prdtType = rtnRow.prdtType;
        var oldId = rtnRow.id;
        rtnRow.id = rtnRow.prdtId||0;
        if(prdtType == 1){
            var rs = checkFromBillPackage(rtnRow);
            if(rs){
                return "此套餐已经添加!";
            }
        }else if(prdtType == 2){
            var rs = checkFromBillItem(rtnRow);
            if(rs){
                return "此项目已经添加!";
            }
        }else if(prdtType == 3){
            var rs = checkFromBillPart(rtnRow);
            if(rs){
                return "此配件已经添加!";
            }
        }
        rtnRow.id = oldId;
    }else if(type == 1){
        var rs = checkFromBillPackage(rtnRow);
        if(rs){
            return "此套餐已经添加!";
        }
    }else if(type == 2){
        var rs = checkFromBillItem(rtnRow);
        if(rs){
            return "此项目已经添加!";
        }
    }else if(type == 3){
        var rs = checkFromBillPart(rtnRow);
        if(rs){
            return "此配件已经添加!";
        }
    }
}
function deletePartRow(row_uid){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能删除配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能删除配件!","W");
        return;
    }
    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    if(data && data.length==1){
        row = data[0];
    }
    var part = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"part",
        data:{
            part: part
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            if(data && data.length==1){
                rpsItemGrid.removeRow(data[0]);
                //var newRow = {};
                //rpsPartGrid.addRow(newRow);
            }else{
                rpsItemGrid.removeRow(row);
               // rpsItemGrid.accept();
            }
        }else{
            showMsg(errMsg||"删除配件信息失败!","E");
            return;
        }
    });

}
/*function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}*/
function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}


function updateItemRow(row_uid){
	 var main = billForm.getData();
	 var serviceId = main.id;
    var isSettle = main.isSettle||0;
    if(!main.id){
       showMsg("请选择保存工单!","W");
       return;
    }
    var status = main.status||0;
    if(status == 2){
       showMsg("工单已完工,不能修改项目!","W");
       return;
    }
    if(isSettle == 1){
       showMsg("工单已结算,不能修改项目!","W");
       return;
    }
   var row = rpsItemGrid.getRowByUID(row_uid);
   var params = {}; 
   params.id = row.id;
   params.serviceId = serviceId;
   params.item = 1;
   nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
   saveItem(function(){
   	nui.unmask(document.body);
   	nui.open({
   		url : webPath + contextPath + "/com.hsweb.repair.DataBase.itemChoose.flow?token=" + token,
   		title : "维修项目",
   		width : 1000,
   		height : 560,
   		allowDrag : true,
   		allowResize : true,
   		onload : function() {
   			var iframe = this.getIFrameEl();
               iframe.contentWindow.updatRowSetData(params);//显示该显示的功能
              // iframe.contentWindow.setViewData(dock, dodelck, docck);
   		},
   		ondestroy : function(action) {
   			if(action=="ok"){
   			   main = billForm.getData();
   			   var p1 = { }
    		       var p2 = {
    		       interType: "item",
    		           data:{
    		             serviceId: main.id||0
    		           }
    		        };
    		       var p3 = {};
    		       loadDetail(p1, p2, p3,main.status);
   			}
   			
   		}
   	});
   });
   
}



function deleteItemRow(row_uid){
	var data2 = billForm.getData();
	var isSettle = data2.isSettle||0;
    if(isSettle == 1){
        showMsg("工单已结算,不能删除!","W");
        return;
    }
    if(data2.status == 2){
        showMsg("工单已完工,不能删除!","W");
        return;
    } 
    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
        row = data[0];
    }
    var item = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"item",
        data:{
            item: item
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            /*if(data && data.length==1){
                rpsItemGrid.removeRow(data[0]);
                var newRow = {};
                rpsPartGrid.addRow(newRow);
            }else{
                rpsItemGrid.removeRow(row);
            }*/
        	var rows = rpsItemGrid.findRows(function(row){
                if(row.id == id || row.billItemId == id){
                    return true;
                }
            });
        	rpsItemGrid.removeRows(rows);
        	//rpsItemGrid.accept();
        	var strId = forFrom();
            if(strId!=null){
            	showTab(strId);
            }
        }else{
            showMsg(errMsg||"删除项目信息失败!","E");
            return;
        }
    });
}
function showCardTimes(){
    if(!fguestId || advancedCardTimesWin.visible) {
        advancedCardTimesWin.hide();
        cardTimesGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("cardPackageEl");  
    advancedCardTimesWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
     //储值卡
    advancedMemCardWin.hide();
    memCardGrid.clearRows();

    //销售机会
    carSellPointInfo.hide();
    carSellPointGrid.clearRows();
    //服务项目
    advancedItemTimesWin.hide();
    itemTimesGrid.clearRows();
    //车况
    carCheckInfo.hide();

    doSearchCardTimes(fguestId,fcarId);
}


function showItemTimes(){
    if(!fguestId || advancedItemTimesWin.visible) {
    	advancedItemTimesWin.hide();
        itemTimesGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("itemTimesEl");  
    advancedItemTimesWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    
    //储值卡
    advancedMemCardWin.hide();
    memCardGrid.clearRows();

    //销售机会
    carSellPointInfo.hide();
    carSellPointGrid.clearRows();
    //次卡项目
    advancedCardTimesWin.hide();
    cardTimesGrid.clearRows();
    //车况
    carCheckInfo.hide();
    
    doSearchItemTimes(fguestId,fcarId);
}

function showCard(){
    if(!fguestId || advancedMemCardWin.visible) {
        advancedMemCardWin.hide();
        
        memCardGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("clubCardEl");  
    advancedMemCardWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    //服务项目
    advancedItemTimesWin.hide();
    itemTimesGrid.clearRows();

    //销售机会
    carSellPointInfo.hide();
    carSellPointGrid.clearRows();
    //次卡项目
    advancedCardTimesWin.hide();
    cardTimesGrid.clearRows();
    //车况
    carCheckInfo.hide();
    
    doSearchMemCard(fguestId);
}


function showCarCheckInfo(){
    if(!fguestId || carCheckInfo.visible) {
        advancedMemCardWin.hide();
        carCheckInfo.hide();
        advancedCardTimesWin.hide();
        return;
    }

    MemSelectCancel(1);
    SearchCheckMain(changeCheckInfoTab);
  /*  advancedCardTimesWin.hide();
    advancedMemCardWin.hide();*/
    //储值卡
    advancedMemCardWin.hide(); 
    //服务项目
    advancedItemTimesWin.hide();
    //销售机会
    carSellPointInfo.hide();
    //次卡项目
    advancedCardTimesWin.hide();
}


function showSellPoint() {
	 sfData = nui.get("chanceType").data;
	showCarSellPointInfo();
}

function showCarSellPointInfo(){
    if(!fguestId || carSellPointInfo.visible) {
        advancedMemCardWin.hide();
        carCheckInfo.hide();
        advancedCardTimesWin.hide();
        carSellPointInfo.hide();
        return;
    }

    var atEl = document.getElementById("carSellInfoEl");  
    carSellPointInfo.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedCardTimesWin.hide();
    advancedItemTimesWin.hide();
    carCheckInfo.hide();
    advancedMemCardWin.hide();
    doSearchSell(fguestId);
}

function doSearchSell(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;
    var params = {
    		 guestId:guestId
    }
    carSellPointGrid.load({
    	token:token,
    	params:params
    },function(){
        var data = carSellPointGrid.getData();
        var len = data.length||0;
        $("#showSellEl").html("销售机会("+len+")");
    });
}

/*function showHealth(){
    window.open("http://www.baidu.com?backurl="+window.location.href); 
}*/
var showcF = 1;
function doSearchCardTimes(guestId,fcarId)
{
    cardTimesGrid.clearRows();
    if(!guestId) return;
    var p = {};
    p.detailFinish = 0;  
    p.guestId = guestId;
    p.notPast = 1; 
    p.status = 2; 
    p.type = 2;
    p.isRefund = 0;
    p.carId = fcarId;
    p.orgid = currOrgid;
    cardTimesGrid.load({
    	token:token,
        p:p
    },function(){
        var data = cardTimesGrid.getData();
        var len = data.length||0;
        $("#showCardTimesEl").html("次卡套餐("+len+")");
       // document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
        if(len>0 && !fserviceId && showcF){
        	showcF = 0;
        	var atEl = document.getElementById("cardPackageEl");  
            advancedCardTimesWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
        }
    });
}

function doSearchItemTimes(guestId,fcarId)
{
    itemTimesGrid.clearRows();
    if(!guestId) return;

    var p = {};
    p.detailFinish = 0;  
    p.guestId = guestId;
    p.notPast = 1; 
    p.status = 2; 
    p.isRefund = 0;
    p.carId = fcarId;
    p.orgid = currOrgid;
    itemTimesGrid.load({
    	token:token,
        p:p
    },function(){
        var data = itemTimesGrid.getData();
        var len = data.length||0;
        $("#showItemTimesEl").html("线上订单("+len+")");
       // document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}

function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
    	token:token,
        guestId:guestId,
        orgid:currOrgid
    },function(){
        var data = memCardGrid.getData();
        var len = data.length||0;
        $("#showCardEl").html("储值卡("+len+")");
    });
}
function addGuest(){
    doApplyCustomer({},function(adction){
        if("ok" == action)
        {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getSaveData();
            var carNo = data.carNo||"";
            var mobile = data.mobile||"";
            var guestName = data.guestFullName||"";
            if(carNo){
                searchKeyEl.setValue(carNo);
                searchKeyEl.setText(carNo);
                searchKeyEl.doQuery();
                return;
            }
            if(mobile){
                searchKeyEl.setValue(mobile);
                searchKeyEl.setText(mobile);
                searchKeyEl.doQuery();
                return;
            }
            if(guestName){
                searchKeyEl.setValue(guestName);
                searchKeyEl.setText(guestName);
                searchKeyEl.doQuery();
                return;
            }

        }
    });
    // var title = "新增客户资料";
    // nui.open({
    //     url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
    //     title: title, width: 560, height: 570,
    //     onload: function () {
    //         var iframe = this.getIFrameEl();
    //         var params = {};
    //         iframe.contentWindow.setData(params);
    //     },
    //     ondestroy: function (action)
    //     {

    //     }
    // });
}
function setPkgRate(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
            advancedPkgRateSetWin.show();
        }
    }
}
//批量设置配件工时销售员
function setItemSaleMan(){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	saveItem(function(){
		nui.unmask(document.body);
		openSetItemSaleMan();
		
	});
}
function openSetItemSaleMan(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	saleManIdBat="";
        	saleManBat="";
        	saleManIdBat2="";
        	saleManBat2="";
        	nui.get("itemSaleMan").setValue("");
        	nui.get("partSaleMan").setValue("");
        	advancedItemPartSaleManSetWin.show();
        }
    }
}

function closeItemPartSaleManSetWin(){
	advancedItemPartSaleManSetWin.hide();
}
function sureItemPartSaleManSetWin(){
    var main =  billForm.getData();
    //var serviceId = 0;
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedItemPartSaleManSetWin.hide();
            return;
        }else{
            var isSettle = main.isSettle||0;
            if(isSettle == 1){
                showMsg("工单已结算,不能修改!","W");
                return;
            }
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '数据保存中...'
           });
            var data = {};
            data.serviceId = main.id;
            
            if(saleManIdBat && saleManIdBat2){
            	 data.saleManId = saleManIdBat;
                 data.saleMan =  saleManNameBat;
                 data.partSaleManId = saleManIdBat2;
                 data.partSaleMan = saleManNameBat2; 
                 data.type = "itemPart";
            }else if(saleManIdBat){
            	 data.saleManId = saleManIdBat;
                 data.saleMan =  saleManNameBat;
                 data.type = "item";
            }else{
            	data.partSaleManId = saleManIdBat2;
                data.partSaleMan = saleManNameBat2; 
                data.type = "part";
            }
		   var params = {};
		   params.data = data;
		   svrSetPkgSaleMansBatch(params,function(text){
		    	if(text.errCode == "S"){
		    		advancedItemPartSaleManSetWin.hide();
		    		var p1 = { }
			        var p2 = {
			        interType: "item",
			           data:{
			             serviceId: main.id||0
			          }
			       };
			       var p3 = {};
			       loadDetail(p1, p2, p3,main.status);
		      }else{
		    	   showMsg("保存失败","E");
		    	}
		     nui.unmask(document.body);
		    });
        }
    } 
}
/*//工时施工员
function closeItemWorkersSetWin(){
    advancedItemWorkersSetWin.hide();
}*/

//新批量派工
function setItemWorkers(){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	saveItem(function(){
		nui.unmask(document.body);
		openSetItemWorkers();
	});
}
function openSetItemWorkers(){
	var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	nui.open({
        		url :  webPath + contextPath + "/com.hsweb.repair.DataBase.dispatchWorkers.flow?token="+token,
        		title : "派工处理",
        		width : 600,
        		height : 630,
        		allowResize: false,
        		onload : function() {
        			var iframe = this.getIFrameEl(); 
        			var data = {
        					type : "item",
        					serviceId : fserviceId
        			};// 传入页面的json数据
        			iframe.contentWindow.setData(data);
        		},
        		ondestroy : function(action){// 弹出页面关闭前
        			if (action=="ok"){
        			   //main = billForm.getData();
         			   var p1 = { }
          		       var p2 = {
          		       interType: "item",
          		           data:{
          		             serviceId: main.id||0
          		           }
          		        };
          		       var p3 = {};
          		       loadDetail(p1, p2, p3,main.status);
        			}
        		}
        	});
        }
    }
}

function setItemPartRate(){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	saveItem(function(){
		nui.unmask(document.body);
		openSetItemPartRate();
	});
}
function openSetItemPartRate(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
            advancedItemPartRateSetWin.show();
        }
    }
}
function closeItemPartRateSetWin(){
    advancedItemPartRateSetWin.hide();
}
function sureItemPartRateSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedItemPartRateSetWin.hide();
            return;
        }else{
            var isSettle = data.isSettle||0;
            if(isSettle == 1){
                showMsg("工单已结算,不能修改!","W");
                return;
            }
            serviceId = data.id||0;
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '处理中...'
            });
            var rate1 = itemRateEl.getValue()||0;
            rate1 = rate1/100;
            rate1 = rate1.toFixed(4);
            var rate2 = partRateEl.getValue()||0;
            rate2 = rate2/100;
            rate2 = rate2.toFixed(4);
            var p = {
                irate: rate1,
                prate: rate2
            };
            var params = {
                data:{
                    serviceId:data.id||0,
                    params: p
                }
            };
            svrSetItemPartRateBatch(params, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                    
                    var p1 = {
                    }
                    var p2 = {
                        interType: "item",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    var p3 = {
                        
                    }
                    loadDetail(p1, p2, p3,status);
                    advancedItemPartRateSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改优惠率失败!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}

function addCardTimesToBill(){
    var main = billForm.getData();
    if(!main.id){
        /*showMsg("请先保存工单!","W");
        return;*/
    	saveNoshowMsg(function(){
    	    var mainData = billForm.getData();
    		selecCardTimes(mainData);
    	});
    }else{
    	if(main.status == 2){
            showMsg("工单已完工,不能添加项目!","W");
            return;
        }
    	if(main.isSettle == 1){
            showMsg("工单已结算,不能添加项目!","W");
            return;
        }
    	selecCardTimes(main);
    }   
}

function selecCardTimes(main){
	var row = cardTimesGrid.getSelected();
    if(row){
        var t = row.prdtType||0;
        var interType = "";
        if(t == 1){
            interType = "package";
        }else if(t == 2){
            interType = "item";
        }else if(t == 3){
            interType = "part";
        }
        if(!interType){
            showMsg("次卡类型有误!","W");
            return;
        }
        var data = {};
        if(interType == 'package'){
            var pkg = {
                serviceId:main.id,
                packageId:row.prdtId,
                cardDetailId:row.id||0
            };
            data.pkg = pkg;
        }else if(interType == 'item'){
            var insItem = {
                serviceId:main.id||0,
                itemId:row.prdtId,
                cardDetailId:row.id||0
            };
            data.insItem = insItem;
            data.serviceId = main.id||0;
        }else if(interType == 'part'){
            var insPart = {
                serviceId:main.id||0,
                partId:row.prdtId,
                cardDetailId:row.id||0,
                partCode:row.prdtCode
            };
            data.insPart = insPart;
            data.serviceId = main.id||0;
        }
        var params = {
            type:"insert",
            interType:interType,
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){
                	nui.unmask(document.body);
                    //showMsg("添加次卡信息成功!","W");
                    //根据工单ID查询套餐,隐藏次卡信息
                    advancedCardTimesWin.hide();
                    cardTimesGrid.clearRows();

                    var params = {
                        interType: interType,
                        data:{
                            serviceId: main.id||0
                        }
                    }
                    getBillDetail(params, function(text){
                        var errCode = text.errCode;
                        var data = text.data||[];
                        if(errCode == "S"){
                        	if(interType == 'item'){
                                rpsItemGrid.clearRows();
                                rpsItemGrid.addRows(data);
                                rpsItemGrid.accept();
                                if(main.status<2){
                                	var row = rpsItemGrid.findRow(function(row){
                                		rpsItemGrid.beginEditRow(row);
                                    });
                                }
                        		//显示项目颜色
                        		var strId = forFrom();
                                if(strId!=null){
                                	showTab(strId);
                                }
                            }
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加预存信息失败!","E");
                    nui.unmask(document.body);
                    return;
                }
            });
        });
        
    }else{
        showMsg("请选择次卡记录!","W");
        return;
    }
}

function addItemTimesToBill(){
    var main = billForm.getData();
    if(!main.id){
        /*showMsg("请先保存工单!","W");
        return;*/
    	saveNoshowMsg(function(){
    	    var mainData = billForm.getData();
    		selecItemTimes(mainData);
    	});
    }else{
    	if(main.status == 2){
            showMsg("工单已完工,不能添加项目!","W");
            return;
        }
    	if(main.isSettle == 1){
            showMsg("工单已结算,不能添加项目!","W");
            return;
        }
    	selecItemTimes(main);
    }   
}

function selecItemTimes(main){
	var row = itemTimesGrid.getSelected();
    if(row){
        var t = row.prdtType||0;
        var interType = "";
        if(t == 1){
            interType = "package";
        }else if(t == 2){
            interType = "item";
        }else if(t == 3){
            interType = "part";
        }
        if(!interType){
            showMsg("次卡类型有误!","W");
            return;
        }
        var data = {};
        if(interType == 'package'){
            var pkg = {
                serviceId:main.id,
                packageId:row.prdtId,
                cardDetailId:row.id||0
            };
            data.pkg = pkg;
        }else if(interType == 'item'){
            var insItem = {
                serviceId:main.id||0,
                itemId:row.prdtId,
                cardDetailId:row.id||0,
                cardDetailType:2
            };
            data.insItem = insItem;
            data.serviceId = main.id||0;
        }else if(interType == 'part'){
            var insPart = {
                serviceId:main.id||0,
                partId:row.prdtId,
                cardDetailId:row.id||0,
                partCode:row.prdtCode
            };
            data.insPart = insPart;
            data.serviceId = main.id||0;
        }
        var params = {
            type:"insert",
            interType:interType,
            data:data
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        saveItem(function(){
        	nui.unmask(document.body);
        	svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){
                	nui.unmask(document.body);
                    //showMsg("添加次卡信息成功!","W");
                    //根据工单ID查询套餐,隐藏次卡信息
                    advancedItemTimesWin.hide();
                    itemTimesGrid.clearRows();

                    var params = {
                        interType: interType,
                        data:{
                            serviceId: main.id||0
                        }
                    }
                    getBillDetail(params, function(text){
                        var errCode = text.errCode;
                        var data = text.data||[];
                        if(errCode == "S"){
                        	if(interType == 'item'){
                                rpsItemGrid.clearRows();
                                rpsItemGrid.addRows(data);
                                rpsItemGrid.accept();
                                if(main.status<2){
                                	var row = rpsItemGrid.findRow(function(row){
                                		rpsItemGrid.beginEditRow(row);
                                    });
                                }
                        		//显示项目颜色
                        		var strId = forFrom();
                                if(strId!=null){
                                	showTab(strId);
                                }
                            }
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加预存信息失败!","E");
                    nui.unmask(document.body);
                    return;
                }
            });
        });
        
    }else{
        showMsg("请选择次卡记录!","W");
        return;
    }
}


function loadDetail(p1, p2, p3,status,callback){
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                for(var i=0;i<data.length;i++){
                	if(data[i].qty==0){
                  		data[i].qty=1;
                  	}
                }
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
                if(status<2){
                	var row = rpsPackageGrid.findRow(function(row){
                		rpsPackageGrid.beginEditRow(row);
                    });
                }
            }
        }, function(){});
    }
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                for(var i=0;i<data.length;i++){
                	if(data[i].qty==0){
                  		data[i].qty=1;
                  	}
                }
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
                if(status<2){
                	 var row = rpsItemGrid.findRow(function(row){
                		 rpsItemGrid.beginEditRow(row);
                     });
                }
                callback && callback();
            }
        }, function(){});
    }
}

var falg="Y";
var openIF = 1;
function chooseItem(){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    var status = main.status||0;
    if(isSettle == 1){
        showMsg("工单已结算,不能添加项目!","W");
        return;
    }
    if(status == 2){
        showMsg("工单已完工,不能添加项目!","W");
        return;
    }
    var data = billForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
	        nui.get(key).focus();
	        showMsg(requiredField[key] + "不能为空!","W");
	        falg="N";
			return;
		}
	 }
	 nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '数据加载中...'
	});
    if(!main.id || falg=="N"){
      falg="Y";
     // openIF = 0;
	  saveNoshowMsg(function(){
		var param = {};
	    param.carModelIdLy = main.carModelIdLy;
	    param.serviceId = "xm"+main.id;//洗美开单默认查询洗美项目
	    saveItem(function(){
	    	doSelectItem(addToBillItem, delFromBillItem, checkFromBillItem, param, function(text){
				//openIF = 1;    
				main = billForm.getData();
		        var p1 = { }
		        var p2 = {
		            interType: "item",
		            data:{
		                serviceId: main.id||0
		            }
		        };
		        var p3 = {};
		        loadDetail(p1, p2, p3,main.status);
		        nui.unmask(document.body);
		    });
	    });
			  
	  });
    }else{
        var param = {};
	    param.carModelIdLy = main.carModelIdLy;
	    param.serviceId = "xm"+main.id;//洗美开单默认查询洗美项目
	    saveItem(function(){
	    	doSelectItem(addToBillItem, delFromBillItem, checkFromBillItem, param, function(text){
			    main = billForm.getData();
		        var p1 = { }
		        var p2 = {
		            interType: "item",
		            data:{
		                serviceId: main.id||0
		            }
		        };
		        var p3 = {};
		        loadDetail(p1, p2, p3,main.status);
		        nui.unmask(document.body);
		    }); 
	    });
		
    }
}

function addToBillItem(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var insItem = {
        serviceId:main.id||0,
        itemId:row.id,
        cardDetailId:0
    };
    data.insItem = insItem;
    data.serviceId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'item',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加项目失败!","E");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}

function delFromBillItem(data, callback){
    var item = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"item",
        data:{
            item: item
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除工时信息失败!","E");
            return;
        }
    });
}

function checkFromBillItem(data){
    var itemId= data.id;
    var rows = rpsItemGrid.findRows(function(row){
        /*if(row && row.itemId == itemId){
            return true;
        }*/
       if(row && row.prdtId == itemId){
        return true;
       }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}
function checkFromBillPart(data){
    var partId= data.id;
    var rows = rpsItemGrid.findRows(function(row){
        if(row && row.partId == partId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}

/*function showMorePart(row_uid){
    if(!fguestId) {
        advancedMorePartWin.hide();
        FItemRow = {};
        return;
    }

    var row = rpsItemGrid.getRowByUID(row_uid); 
    if(FItemRow == row) {
        advancedMorePartWin.hide();
        FItemRow = {};
        return;
    }      
    FItemRow = row;    
    var atEl = rpsItemGrid._getCellEl(row,"prdtName");
    advancedMorePartWin.showAtEl(atEl, {xAlign:"left",yAlign:"above"});
   	
}*/
//配件
function choosePart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid);//FItemRow||{};//
    //获取到工时中的ID,不确定是否是这个字段,把工时ID传到添加配件的页面中,考虑能不能直接在本页面把ID传到addToBillPart函数中
    var itemId = null;
    if(row){
    	itemId = row.id;
    }
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能添加配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能添加配件!","W");
        return;
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
    saveItem(function(){
    	doSelectPart(itemId,addToBillPart, delFromBillPart, null, function(text){
       	 var p1 = {
            }
            var p2 = {
                interType: "item",
                data:{
                    serviceId: main.id||0
                }
            }
            var p3 = {
                interType: "part",
                data:{
                    serviceId: main.id||0
                }
            }
           loadDetail(p1, p2, p3,main.status);
       	   nui.unmask(document.body);
       });
    });
    
}

function addToBillPart(row, callback, unmaskcall){
	 var main = billForm.getData();
     var data = {};
     var subtotal = row.newestSellPrice || 0;
     var insPart = {
        serviceId:main.id||0,
        partId:row.id,
        billItemId:row.billItemId,     
        cardDetailId:0,
        qty:1,
        subtotal:subtotal,
	    amt:subtotal,
	    unitPrice:subtotal
     };
    data.insPart = insPart;
    data.serviceId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'part',
        data:data
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        var res = text.data||{};
        if(errCode == 'S'){
            unmaskcall && unmaskcall();
            callback && callback(res);
        }else{
            unmaskcall && unmaskcall();
            showMsg(errMsg||"添加配件失败!","E");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}
function delFromBillPart(data, callback){
    var part = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"part",
        data:{
        	part: part
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除配件信息失败!","E");
            return;
        }
    });
}
function addcardTime(){
	var data =  billForm.getData();
	if(data.guestMobile=="10000"){
		buyCard("card");
		return;
	}
	if(contactorF){
		xyguest.wechatOpenId = contactorF.wechatOpenId;
	}
	doAddcardTime(xyguest);
	
}

function addcard(){
	var data =  billForm.getData();
	if(data.guestMobile=="10000"){
		buyCard("store");
		return;
	}
  
  doAddcard(xyguest);
}

function onPrint(e){
	var main = billForm.getData();
	var openUrl = null;
	if(main.id){
		var params = {
            source : e,
            serviceId : main.id,
            isSettle : main.isSettle
		};
		if(e==3 || e==4 || e==9 || e==10){
			if(main.status==2){
				doPrint(params);
			}else{
				showMsg("工单未完工，不能打印","W");
				return;
			}
		}else{
			 doPrint(params);
		}
	}else{
        showMsg("请先保存工单,再打印!","W");
        return;
    }
}

function showBillInfo(){
	var main = billForm.getData();
	var params = {
			carId : main.carId,
			carNo : main.carNo,
			guestId : main.guestId,
			contactorId:main.contactorId
    };
    if(main.id){
        doShowCarInfo(params);
    }
}

//数据改变时触发
function onValueChangedComQty(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsItemGrid.getEditorOwnerRow(el);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", rowtime);
	var itemTime = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
	}else if(itemTime<0){
		showMsg("工时/数量不能小于0","W");
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(itemTime == "" || itemTime == null){	
		setItemTime.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{		
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", rowtime);
		var setRate = rpsItemGrid.getCellEditor("itemRate", rowtime);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", rowtime);
		var unitPrice = setUnitPrice.getValue()||0;
		var itamt = 0;
		var subtotal = 0;
		/*var type = row.type;
		if(type==2){
			
		}*/
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   rowtime.amt = itamt;
		   subtotal = itamt;
		}else{
			rowtime.amt = 0;
		}
		//设置小计金额
		var rate = setRate.getValue()||0;
		if(rate>0 && itamt>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}
		setSubtotal.setValue(subtotal);
		setItemTime.setValue(itemTime);
  }
}

function onValueChangedItemUnitPrice(e){
	var el = e.sender;
	var unitPrice = el.getValue();
	var flag = isNaN(e.value);
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);
	if (flag) {
		showMsg("请输入数字!","W");
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
	}else if(unitPrice<0){
		
		showMsg("单价不能小于0","W");
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(unitPrice == "" || unitPrice == null){	
		setUnitPrice.setValue(e.oldValue);
		e.cancel = true; 
		return;
   }else{
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
		
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var itemTime = setItemTime.getValue()||0;
		var itamt = 0;
		var subtotal = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		   subtotal = itamt;
		}else{
		   row.amt = 0;
		}
		//设置小计金额
		var rate = setRate.getValue()||0;
		if(rate>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}		
		setSubtotal.setValue(subtotal);
		setUnitPrice.setValue(unitPrice);
  }
	
}

function onValueChangedItemRate(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rate = el.getValue();
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setRate = rpsItemGrid.getCellEditor("itemRate", row);
	if (flag) {
		showMsg("请输入数字!","W");
		e.cancel = true; 
		setRate.setValue(e.oldValue);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setRate.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setRate.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{
		//获取指定列和行的编辑器控件对象
		var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);	
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);	
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);	
		var unitPrice = setUnitPrice.getValue()||0;
		var itemTime = setItemTime.getValue()||0;

		var itamt = 0;
		var subtotal = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		   subtotal = itamt;
		}else{
			row.amt = 0;
		}
		//设置小计金额
		if(rate>0){
			subtotal = itamt - rate*1.0/100*itamt;
			subtotal = subtotal.toFixed(2);
		}
		setSubtotal.setValue(subtotal);
		setRate.setValue(rate);			
  }	
}

function onValueChangedItemSubtotal(e){	
	var el = e.sender;
	var flag = isNaN(e.value);
	var subtotal = el.getValue();
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		setSubtotal.setValue(e.oldValue);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不小于0","W");
		setSubtotal.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){
		setSubtotal.setValue(e.oldValue);
		e.cancel = true; 
		return;
	}else{
		//获取指定列和行的编辑器控件对象
		var setRate = rpsItemGrid.getCellEditor("itemRate", row);
		var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);	
		var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);	

		var unitPrice = setUnitPrice.getValue()||0;
		var itemTime = setItemTime.getValue()||0;
		var itamt = 0;
		var rate = 0;
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		 //设置小计金额
		    if(itamt>0){
		    	rate = (itamt - subtotal)*1.0/itamt;
		    } 
		    rate = rate * 100;
			rate = rate.toFixed(2);    
		    setRate.setValue(rate);
		    setSubtotal.setValue(subtotal);
		}else{
			subtotal = 0;
			setSubtotal.setValue(subtotal);
		}
		
	}	
}

var scTyIdUrl = baseUrl + "com.hsapi.repair.repairService.query.getCardDiscount.biz.ext";
//选择配件业务，修改优惠率和小计金额
function onValueChangedItemTypeId(e){
   var maintain = billForm.getData();
   var el = e.sender;
   var row = rpsItemGrid.getEditorOwnerRow(el);
	//获取指定列和行的编辑器控件对象
	var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	var setUnitPrice = rpsItemGrid.getCellEditor("itemUnitPrice", row);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", row);
	var setRate = rpsItemGrid.getCellEditor("itemRate", row);	  
	var json = nui.encode({
		"serviceTypeId" : el.getValue(),
		"guestId":maintain.guestId,
		token : token
	});
	//item_discount_rate
	nui.ajax({
		url : scTyIdUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				var cardRate = returnJson.cardRate;
				var itemDiscountRate = cardRate.itemDiscountRate;
				var unitPrice = setUnitPrice.getValue()||0;
				var itemTime = setItemTime.getValue()||0;
				var amt = 0;
				if(unitPrice>0 && itemTime>0){
					amt = unitPrice*itemTime;
					amt = amt.toFixed(2);
				}	
				var subtotal = 0;
			    if(amt>0){
			    	subtotal = amt - itemDiscountRate*1.0*amt;
			    	subtotal = subtotal.toFixed(2);
			    }
			    itemDiscountRate = (itemDiscountRate*100).toFixed(2);
			    setRate.setValue(itemDiscountRate);
			    setSubtotal.setValue(subtotal);				
			} else {
				//showMsg("出库失败");
			}			
		}
	});
}

/*function onPkgRateValuechangedBath(){
	var rate = pkgRateEl.getValue();
	var pkgOk = nui.get("pkgOk");
	var flag = isNaN(rate);
	if (flag) {
		showMsg("请输入数字!","W");
		pkgRateEl.setValue(0);
		pkgOk.disable();
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		pkgRateEl.setValue(0);
		pkgOk.disable();
		return;
	}else{
		pkgOk.enable();
	}
}*/
function onPartRateValuechangedBath(){
	var partRate = partRateEl.getValue();
	var itemOk = nui.get("itemOk");
	var flag = isNaN(partRate);
	if (flag) {
		showMsg("请输入数字!","W");
		partRateEl.setValue(0);
		itemOk.disable();
		return;
	} else if(partRate<0 || partRate>100){	
		showMsg("请输入0到100之间的数!","W");
		partRateEl.setValue(0);
		itemOk.disable();
		return;
	}else{
		itemOk.enable();
	}
}

function onItemRateValuechangedBath(){
	var itemRate = itemRateEl.getValue();
	var itemOk = nui.get("itemOk");
	var flag = isNaN(itemRate);
	if (flag) {
		showMsg("请输入数字!","W");
		itemRateEl.setValue(0);
		itemOk.disable();
		return;
	} else if(itemRate<0 || itemRate>100){	
		showMsg("请输入0到100之间的数!","W");
		itemRateEl.setValue(0);
		itemOk.disable();
		return;
	}else{
		itemOk.enable();
	}
}


var sumPkgSubtotal = 0;
var sumPkgPrefAmt = 0;
var sumItemSubtotal = 0;
var sumItemPrefAmt = 0;
var sumPartSubtotal = 0;
var sumPartPrefAmt = 0;
function onDrawSummaryCellPack(e){ 	  
	  var data = sellForm.getData();
	  var rows = e.data;
	  sumPkgSubtotal = 0;
	  sumPkgPrefAmt = 0;
	  var sumPkgAmt = 0;
	  //|| e.field == "amt"
	  if(e.field == "subtotal") 
	  {   
		  tcAmt = 0;
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].cardDetailId>0){
				  tcAmt=tcAmt+rows[i].subtotal;
			  }
			  if(rows[i].billPackageId=="0"){
				  sumPkgSubtotal += parseFloat(rows[i].subtotal);
				  sumPkgAmt  += parseFloat(rows[i].amt);
			  }
		  }
		  
		  if(sumPkgAmt>0 && sumPkgSubtotal>=0)
		  {   sumPkgPrefAmt = sumPkgAmt - sumPkgSubtotal;
			  sumPkgSubtotal = sumPkgSubtotal.toFixed(2);
			  sumPkgPrefAmt = sumPkgPrefAmt.toFixed(2);
			  data.packageAmt = sumPkgAmt;
			  data.packageSubtotal = sumPkgSubtotal;
			  data.packagePrefAmt = sumPkgPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }else{
			  data.packageSubtotal = 0;
			  data.packagePrefAmt = 0;
			  data.packageAmt = sumPkgAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }
	  } 
}


function onDrawSummaryCellItem(e){ 	  
	  var data = sellForm.getData();
	  data.packageAmt = 0;
	  var rows = e.data;
	  sumItemSubtotal = 0;
	  sumItemPrefAmt = 0;
	  var sumItemAmt = 0;
	  sumPartSubtotal = 0;
	  sumPartPrefAmt = 0;
	  var sumPartAmt = 0;
	  // || e.field == "amt"
	  if(e.field == "subtotal") 
	  {   
		  gsAmt = 0;
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].cardDetailId>0){
				  gsAmt=gsAmt+rows[i].subtotal;
			  }
			 if(rows[i].billItemId=="0"){
				 sumItemSubtotal += parseFloat(rows[i].subtotal);
				 sumItemAmt  += parseFloat(rows[i].amt); 
			 }else{
				 sumPartSubtotal += parseFloat(rows[i].subtotal);
				 sumPartAmt  += parseFloat(rows[i].amt); 
			 }
			   
		  }
		  
		  if( sumItemSubtotal>0 && sumItemAmt>=0  )
		  {   
			  sumItemPrefAmt = sumItemAmt - sumItemSubtotal;
			  sumItemSubtotal = sumItemSubtotal.toFixed(2);
			  sumItemPrefAmt = sumItemPrefAmt.toFixed(2);
			  data.itemSubtotal = sumItemSubtotal;
			  data.itemPrefAmt = sumItemPrefAmt;
			  data.itemAmt = sumItemAmt;
			  data.partAmt = sumPartAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }else{
			  data.itemSubtotal = 0;
			  data.itemPrefAmt = 0;
			  data.itemAmt = sumItemAmt;
			  data.partAmt = sumPartAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }
		  if(sumPartSubtotal>0 && sumPartAmt>=0)
		  {   
			  sumPartPrefAmt = sumPartAmt - sumPartSubtotal;
			  sumPartSubtotal = sumPartSubtotal.toFixed(2);
			  sumPartPrefAmt = sumPartPrefAmt.toFixed(2);
			  data.partSubtotal = sumPartSubtotal;
			  data.partPrefAmt = sumPartPrefAmt;
			  data.itemAmt = sumItemAmt;
			  data.partAmt = sumPartAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }else{
			  data.partSubtotal = 0;
			  data.partPrefAmt = 0;
			  data.itemAmt = sumItemAmt;
			  data.partAmt = sumPartAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
			  document.getElementById("packageAmt1").innerHTML = data.packageAmt;
			  document.getElementById("itemAmt1").innerHTML = data.itemAmt;
			  document.getElementById("partAmt1").innerHTML = data.partAmt;
			  document.getElementById("totalAmt1").innerHTML = data.totalAmt;
			  document.getElementById("totalPrefAmt1").innerHTML = data.totalPrefAmt;
			  document.getElementById("totalSubtotal1").innerHTML = data.totalSubtotal;
		  }  
	  }  
}

function addExpenseAccount(){
	var data = billForm.getData();
	data.lastComeKilometers = lastComeKilometers;
	if(data.id){
		var item={};
		item.id = "123321";
	    item.text = "报销单详情";
		item.url =webBaseUrl+  "com.hsweb.print.ExpenseAccount.flow?sourceServiceId="+data.id;
		item.iconCls = "fa fa-file-text";
		data.guestMobile = $("#guestTelEl").text();
		data.guestTel = $("#guestNameEl").text();
		data.contactorTel = data.mobile;
		window.parent.activeTabAndInit(item,data);
	}else{
		showMsg("请先保存后再进行操作!","W");
	}
}

function showHealth(){
    showCarCheckInfo();
	//window.open(webBaseUrl+"repair/RepairBusiness/Reception/checkDetail.jsp")
	/*nui.open({
        url: webBaseUrl+"repair/RepairBusiness/Reception/checkDetail.jsp",
        width: "800",
        height: "1000",
        showMaxButton: false,
		allowResize: false,
        showHeader: true,
        onload: function() {
            var iframe = this.getIFrameEl();
        },
    });*/
}
//var doFinishF = 1;
function pay(){
	var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
    	if(data.isSettle == 1||data.balaAuditSign == 1){
          	 showMsg("工单已结算!","W");
               return;
          }
        if(data.status != 2 ){
        	 nui.mask({
        	        el: document.body,
        	        cls: 'mini-mask-loading',
        	        html: '数据加载中...'
        	 });
            //showMsg("工单未完工,不能结算!","W");
            //return;
        	var params = {
        	        data:{
        	            id:data.id||0,
        	            "drawOutReport":""
        	        }
        	    };
        	    svrRepairAudit(params, function(data1){
        	        data1 = data1||{};
        	        var errCode = data1.errCode||"";
        	        var errMsg = data1.errMsg||"操作失败,请重新操作";
        	        if(errCode == 'S'){
        	        	//成功之后，重新设置表单值*******************
                        var olddata = billForm.getData();
                        olddata.status = 2;
                        billForm.setData([]);
                        billForm.setData(olddata);
                        nui.get("contactorName").setText(olddata.contactorName);
                        var status = 2;
                        var isSettle = olddata.isSettle||0;
                        doSetStyle(status, isSettle);
                        //重新加载界面
                        var p1 = {
                        }
                        var p2 = {
                            interType: "item",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        var p3 = {
                            interType: "part",
                            data:{
                                serviceId: data.id||0
                            }
                        }
                        loadDetail(p1, p2, p3,status);
                        nui.unmask(document.body);
                        onPay(data);
        	        }else{
        	        	nui.unmask(document.body)
        	        	showMsg(errMsg,"E");
        	        }
        	    }, function(){
        	    });
        }else {
        	onPay(data);
        }  
    }
}
function onPay(data){
	var sellData = sellForm.getData();
    ycAmt = parseFloat(tcAmt)+parseFloat(gsAmt);
    sellData.ycAmt = ycAmt;
    sellData.mtAmt = sellData.totalSubtotal;
    var params = {  
        serviceId:data.id||0,
        guestId:data.guestId||0,
        carNo:data.carNo||0,
        guestName:$("#guestNameEl").text(),
        data:sellData,
        contactor:contactorF,
        carId:fcarId,
        billTypeId:2
    };
    doBillPay(params, function(data){
        data = data||{};
        if(data.action){
            var action = data.action||"";
            if(action == "ok"){
            	nui.get("isSettle").setValue(1);
                var status = data.status||2;
                var isSettle = data.isSettle||1;
                doSetStyle(status, isSettle);
                showMsg("结算成功!","S");
            }else if(action == "onok"){
            	/*nui.get("isSettle").setValue(1);
                var status = data.status||2;
                var balaAuditSign = data.balaAuditSign||1;
                doSetStyle(status, balaAuditSign);
                var main = billForm.getData();
                main.balaAuditSign = 1;
                showMsg("转预结算成功!","S");*/
                var status = data.status||2;
                var balaAuditSign = data.balaAuditSign||1;
                doSetStyle(status, balaAuditSign);
                var main = billForm.getData();
                main.balaAuditSign = 1;
                billForm.setData(main);
                showMsg("转预结算成功!","S");
            }else{
                if(data.errCode){
                    showMsg("结算失败!","E");
                    return;
                }
            }
        }
    });
}

function newCheckMain() {  
    var data = billForm.getData();
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    params = {
        id:data.id,
        actionType:"new",
        row: rdata,
        isCheckMain:"N"//是否是直接开单
    };

    window.parent.activeTabAndInit(item,params);
    carCheckInfo.hide();
}  


function MemSelectOk(){ 
    var form = new nui.Form("#show2");
            form.validate();
            if (form.isValid() == false) {
                showMsg("请先选择被派工人！","W");
                return;
            }
    SaveCheckMain();
}



function SearchCheckMain(callback) {
    var data = billForm.getData();
    var  t = null;
    var ydata = {
        serviceId:data.id
    }
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.repairInterface.queryCheckMainbyServiceId.biz.ext",
        type:"post",
        async: false,
        data:{ 
            params:ydata
        },
        cache: false,
        success: function (text) {  
            callback && callback(text);
            checkMainData = text;
            isRecord = text.isRecord;
        }
    });

}


function changeCheckInfoTab(resultdata) {

    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }
    var atEl = document.getElementById("carHealthEl");  
    carCheckInfo.showAtEl(atEl, {xAlign:"left",yAlign:"below"});
    SearchLastCheckMain();

    $("#checkStatus1").css("color","#9e9e9e");
    $("#checkStatus2").css("color","#9e9e9e");
    $("#checkStatus3").css("color","#9e9e9e");
    $("#checkStatus4").css("color","#9e9e9e");
    
    if(resultdata.list.length > 0){
        var detailList =  resultdata.list[0];
        rdata= detailList;
    }

    //detailList.checkMan  =1;
    //detailList.checkStatus = 0;

    if(resultdata.list.length < 1){
        $("#checkStatus1").css("color","#32b400");
        $("#checkStatusButton1").show();
        $("#checkStatusButton2").hide();
    }else{
        if((detailList.checkMan || detailList.checkManId)&& detailList.checkStatus == 0){
            $("#checkStatus2").css("color","#32b400");
            $("#checkStatusButton1").hide(); 
            $("#checkStatusButton2").show();

        }
        if((detailList.checkMan || detailList.checkManId) && detailList.checkStatus == 1){
            $("#checkStatus3").css("color","#32b400");
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show();
        }
        if((detailList.checkMan || detailList.checkManId) && detailList.checkStatus == 2){ 
            $("#checkStatus4").css("color","#32b400");   
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show(); 
        }
    }
}

function SaveCheckMain() {
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }
    if(isRecord == "0"){
    var temp ={
        serviceId:data.id, 
        carId:data.carId,
        carNo:data.carNo,
        carVin:data.carVin,
        guestId:data.guestId,
        contactorId:data.contactorId,
        serviceCode:document.getElementById("servieIdEl").innerText.trim(),
        lastKilometers:data.enterKilometers,
        lastPoint:score,
        lastCheckDate:lcheckDate,
        checkStatus:0,
        enterKilometers:data.enterKilometers,
        mtAdvisorId:data.mtAdvisorId,
        mtAdvisor:data.mtAdvisor,
        checkManId:nui.get("checkManId").value,
        checkMan:nui.get("checkManId").text
    };
    var mtemp = {
        id:data.id
    } ;

    nui.ajax({
        url:baseUrl + "com.hsapi.repair.repairService.repairInterface.saveCheckMain.biz.ext",
        type:"post",
        async: false,
        data:{ 
            data:temp,
            rpsMain:mtemp,
            token:token   
        },   
        success:function(text){   
            var errCode = text.errCode;
            if(errCode == "S"){
                rdata  = text.mainData;
                //newCheckMain();
                //CloseWindow('close');
                carCheckInfo.hide();
                showMsg('派工成功!','S'); 
            }else{
                //showMsg('保存失败!','E'); 
            }
        }  
    }); 
    }else{
        newCheckMain();
        carCheckInfo.hide();
}
}


function MemSelectCancel(e) {
    if(e == 1){
        $("#show1").show();
        $("#show2").hide();
    }

    if(e == 2){
        $("#show1").hide();
        $("#show2").show();
    }
}


    function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }


function SearchLastCheckMain() { 

    $("#lastCheckInfo1").html('');
    $("#lastCheckInfo2").html('');
    $("#lastCheckInfo3").html("");
    $("#lastCheckInfo4").hide();

    var  tempParams = {
        carNo:nui.get("carNo").value,
        endDate:nui.get("enterDate").text
    };
    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.repairInterface.QueryLastCheckMain.biz.ext",
        type:"post",
        //async: false,
        data:{ 
            params:tempParams
        },
        cache: false,
        success: function (text) {  
            
            var isRec = text.isRecord;
            if(isRec == "1"){
                var ldata = text.list[0];
                lastCheckParams = ldata;
                score = ldata.check_point || 0;
                lcheckDate = ldata.checkDate ;
                var rdate = nui.formatDate(nui.parseDate(ldata.record_date),"yyyy-MM-dd HH:mm:ss")

                $("#lastCheckInfo1").html('上次检查');
                $("#lastCheckInfo2").html(score+"分");
                $("#lastCheckInfo3").html(rdate);
                $("#lastCheckInfo4").show();
            }else{
                $("#lastCheckInfo1").html('暂无相关历史检查数据！');
            }

        }
    });
 
}

function newCheckMainMore() {  
    var cNo = nui.get("carNo").value;
    var item={};
    item.id = "1103";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkMain.jsp?cNo="+cNo;
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);

}  

//费用登记
function updateBillExpense(){
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }
    var params = {
        serviceId:data.id||0
    };
    doBillExpenseDetail(params, function(data){
        data = data||{};
        if(data.action){
            var action = data.action||"";
            if(action == 'ok'){
            }else{
            }
        }
    });
}
//出车报告登记
function outCarMainExpense(){
	var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }
    var params = { };
    params = data;
    doOutCarMainExpenseDetail(params, function(data){
        data = data||{};
        if(data.action){
            var action = data.action||"";
            if(action == 'ok'){
            }else{
            }
        }
    });
}

function checkGuest(){
	var data = billForm.getData();
	 nui.open({
         url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditGuest.flow?token="+token,
         title: '客户详情',
         width: 750, height: 570,
         onload: function () {
             var iframe = this.getIFrameEl();
             var params = {};	
             params.guest=data;
             iframe.contentWindow.setData(params);
         },
         ondestroy: function (action)
         {
             if("ok" == action)
             {
                 grid.reload();
             }
         }
     });
}

function chooseContactor(){
	var data = billForm.getData();
	var guestId = data.guestId;
	if(!guestId){
		showMsg("请填写客户信息!","W");
        return; 
	}
	if(data.status == 2){
		showMsg("工单已完工,不能修改联系人!","W");
        return;        
    }
	if(data.isSettle == 1){
		showMsg("工单已结算,不能修改联系人!","W");
        return;        
    }
	
	 nui.open({
         url: webPath + contextPath + "/com.hsweb.repair.DataBase.SelectContactor.flow?token="+token,
         title: '选择联系人',
         width: 700, height: 300,
         onload: function () {
             var iframe = this.getIFrameEl();
             var params = {};	
             params.guestId=guestId;
             iframe.contentWindow.setData(params);
         },
         ondestroy: function (action)
         {
        	 var iframe = this.getIFrameEl();
        	 var row = iframe.contentWindow.getData();
        	 contactorF = row;
        	 nui.get("contactorName").setText(row.name);
        	 if(data.id){
        		 var maintain = billForm.getData();
        		 maintain.contactorId = row.id;
        		 maintain.contactorName = row.name;
        		 maintain.mobile = row.mobile;
        		 billForm.setData(maintain);
        		 saveNoshowMsg();
        	 }
         }
     });
}

/*function setEnterKilometers(e){
	var last =  $("#lastComeKilometers").text() || 0;
	if(e.value < last){
		showMsg("进厂里程不能小于上次里程","W");
		nui.get("enterKilometers").setValue("");
	}
}*/

var workerIdsBat = "";
var workerNamesBat = "";
function onworkerChangedBat(e){
	workerNamesBat = e.value;
    var obj = e.sender;
    var rows = e.selecteds;
    var workerIds = "";
    var workerIdList = [];
    if(!rows || rows.length==0){
        workerIds = "";
    }else{
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var empId = row.empId;
            workerIdList.push(empId);
        }

        if(workerIdList&&workerIdList.length>0){
            workerIds = workerIdList.join(",");
        }else{
            workerIds = "";
        }
    }
    workerIdsBat = workerIds;
}

var saleManIdBat = "";
var saleManNameBat = "";
/*function saleManChangedBat(e){
	saleManNameBat = e.value;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    saleManIdBat = saleManId;
}*/


var saleManIdBat2 = "";
var saleManNameBat2 = "";
function setSaleManBat(type){
	nui.open({
		url :  webPath + contextPath + "/com.hsweb.repair.DataBase.Salesperson.flow?token="+token,
		title : "批量设置销售员",
		width : 600,
		height : 380,
		allowResize: false,
		onload : function() {
			var iframe = this.getIFrameEl(); 
			var data = {
			};// 传入页面的json数据
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "ok") {
				var iframe = this.getIFrameEl();
	        	var data = iframe.contentWindow.getData();
	        	if(type=="item"){
	        		saleManNameBat = data.emlpszName;
		        	saleManIdBat = data.emlpszId;
		        	nui.get("itemSaleMan").setValue(saleManNameBat);
	        	}
	        	if(type=="part"){
	        		saleManNameBat2 = data.emlpszName;
		        	saleManIdBat2 = data.emlpszId;
		        	nui.get("partSaleMan").setValue(saleManNameBat2);
	        	}
	        	
			}
		}
	});
}
/*function saleManChangedBatP(e){
	saleManNameBat2 = e.value;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    saleManIdBat2 = saleManId;
}*/

function viewLastCheck(){
    var params = lastCheckParams;
    params.viewType = 1;
    params.actionType = 'view';
    params.isCheckMain = "Y";
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow";
    item.iconCls = "fa fa-file-text";
    window.parent.activeTabAndInit(item,params);
}
/*
function transferImages(){
	document.getElementById("search").style.display="block";
	
	var i=500;
    var search = document.getElementById("search");
    search.style.top = '6px';
    search.style.position='absolute';    
    var timer = setInterval(
        function(){
            if(search.style.left=='200px')
                clearInterval(timer);
        i = i-10;
        search.style.left = i+'px';
        },60);  
    
    setTimeout(
    		function(){
    			document.getElementById("search").style.display="none";
    			},2500);
}*/


function GuestTabShow(){
	var data = billForm.getData();
	if(!data.contactorId){
		showMsg("联系人不能为空!","W");
		return;
	}
	 nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/Reception/guestTabShow.jsp?token="+token,
        title: '客户标签',
        width: 300, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
           // var params = sendGuestForm.getData();
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action)
        {
            /*if("ok" == action)
            {
                grid.reload();
            }*/
        }
    });
}
function openItemWorkers(e){
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	saveItem(function(){
		nui.unmask(document.body);
		saveOpenItemWorkers(e);
	});
}
function saveOpenItemWorkers(e){
	var el = e.sender;
    var row = rpsItemGrid.getEditorOwnerRow(el);
	var workers = rpsItemGrid.getCellEditor("workers", row);
	//var setPlanFinishDate = rpsItemGrid.getCellEditor("planFinishDate", row);
	var itemList = {};
	itemList.id = row.id;
    var data = {};
    data = {
    	serviceId:fserviceId,
    	workers:row.workers,
    	workersId:row.workersId,
    	type:"item",
    	itemList:itemList
    };
 	 $('.mini-textbox-input').blur();
     nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.Workers.flow?token="+token,
        title: '选择施工员',
        width: 600, height: 550,
        onload: function () {
            var iframe = this.getIFrameEl();
           // var params = sendGuestForm.getData();
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action)
        {
        	if(action=="ok"){
        		var main = billForm.getData();
        		var p1 = { }
		        var p2 = {
		        interType: "item",
		           data:{
		             serviceId: main.id||0
		          }
		       };
		       var p3 = {};
		       loadDetail(p1, p2, p3,main.status);
		       nui.unmask(document.body);
        	}
        }
    });
}

//销售员
function openItemSaleMans(e){
	var el = e.sender;
    var row = rpsItemGrid.getEditorOwnerRow(el);
	var saleMan = rpsItemGrid.getCellEditor("saleMan", row);
    var data = {};
    data = {
    	saleMan:row.saleMan,
    	saleManId:row.saleManId
    };
 	 $('.mini-textbox-input').blur();
     nui.open({
 		url :  webPath + contextPath + "/com.hsweb.repair.DataBase.Salesperson.flow?token="+token,
 		title : "设置销售员",
 		width : 600,
 		height : 380,
 		allowResize: false,
 		onload : function() {
 			var iframe = this.getIFrameEl(); 
 			iframe.contentWindow.setData(data);
 		},
 		ondestroy : function(action) {// 弹出页面关闭前
 			if (action == "ok") {
 			    var iframe = this.getIFrameEl();
		        var data = iframe.contentWindow.getData();
		       // __saleManId = data.emlpszId;
		        saleMan.setValue(data.emlpszName);
		        row.saleManId = data.emlpszId;
 			}
 		}
 	});
}
//0,综合 2,洗美 4,理赔
function toChangBillTypeId(billTypeId){
	var data =  billForm.getData();
	var serviceId = data.id;
	if(data.status == 2){
		showMsg("工单已完工，不能转单!","W");
		return;
	}
	if(data.guestMobile=="10000" && serviceId){
		showMsg("请完善散客信息","W");
		addOrEdit(serviceId,billTypeId);
		return;
	}
	if(serviceId){
		toChangBill(serviceId,billTypeId);
	}	 
}

function toChangBill(serviceId,billTypeId){
	nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.crud.transformBill.biz.ext",
        type:"post",
        //async: false,
        data:{ 
        	serviceId:serviceId,
        	billTypeId:billTypeId
        },
        cache: false,
        success: function (data) {  
            if(data.errCode=="S"){
            	//showMsg("转为洗美开单成功","S");
            	add();
            	var item={};
            	var main = data.main;
                if(billTypeId==0){
                	item.id = "2000";
                    item.text = "综合开单详情";
                    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow";
                    item.iconCls = "fa fa-file-text";
            	    //window.parent.activeTab(item);
                }
                if(billTypeId==4){
                	//showMsg("转为理赔开单成功","S");
                	item.id = "4000";
                    item.text = "理赔开单详情";
                    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow";
                    item.iconCls = "fa fa-file-text";
                }
                var params = {
            	        id: main.id
            	    };
            	window.parent.activeTabAndInit(item,params);
            }else{
            	if(billTypeId==0){
                	showMsg(data.errMsg || "转为综合开单失败","E");
                }
                if(billTypeId==4){
                	showMsg(data.errMsg || "转为理赔开单失败","E");
                }
            }
        }
    });
}
var itemF = "S";
var partF = "S";
function saveItem(callback){
	var main = billForm.getData();
	var status = main.status||0;
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    if(status == 2){
        showMsg("工单已完工,不能修改项目!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改项目!","W");
        return;
    }
    rpsItemGrid.commitEdit();
    var rows = rpsItemGrid.getChanges("modified");
    if(status<2){
    	var row = rpsItemGrid.findRow(function(row){
    		rpsItemGrid.beginEditRow(row);
        });
    }
    var updList = [];
    var updPartList = [];
    if(rows && rows.length>0){
    	var serviceId = null;
    	for(var i = 0;i<rows.length;i++){
    		var row = rows[i];
    		serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            if(cardDetailId > 0){ //预存的
                var item = {};
                item.id = row.id;
                item.remark = row.remark;
                item.serviceId = row.serviceId;
                item.serviceTypeId = row.serviceTypeId;
                item.workerIds = row.workersId;
                item.workers = row.workers;
                if(row.planFinishDate){
                	item.planFinishDate = row.planFinishDate;
                }
                if(row.billItemId == "0"){
                	updList.push(item);
                }else{
                	updPartList.push(item);
                }
                
            }else{
                var item = {};
                item.id = row.id;
                item.remark = row.remark;
                item.serviceId = row.serviceId;
                item.amt = row.amt;
                item.subtotal = row.subtotal;
                var rate = row.rate/100;
                rate = rate.toFixed(4);
                item.rate = rate;
                item.unitPrice = row.unitPrice;
                item.serviceTypeId = row.serviceTypeId;
                if(row.workersId){
                	item.workerIds = row.workersId;
                    item.workers = row.workers;
                }
                item.saleMan = row.saleMan;
                item.saleManId = row.saleManId;
                if(row.planFinishDate){
                	item.planFinishDate = row.planFinishDate;
                }
                if(row.billItemId == "0"){
                	item.itemTime = row.qty;
                	updList.push(item);
                }else{
                	item.qty = row.qty;
                	updPartList.push(item);
                }
            }
            
    	}
    	var params = {
                type:"update",
                interType:"item",
                data:{
                    serviceId: serviceId,
                    updList : updList
                }
        };
    	 var params1 = {
                 type:"update",
                 interType:"part",
                 data:{
                     serviceId: serviceId,
                     updList : updPartList
                 }
             };
    	/* console.log("updItem:");
 	     console.log(updList);
 	     console.log("updPartList:");
 	     console.log(updPartList);*/
    	 if(updList && updList.length>0){
    		 svrCRUD(params,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){   
                	 itemF = "S";
                 }else{
                	 itemF = "E";
                 	/*rpsItemGrid.reject();
                     rpsItemGrid.accept();
                     showMsg(errMsg||"修改数据失败!","E");
                     return;*/
                 }
                 if(updPartList && updPartList.length>0){
                	 svrCRUD(params1,function(text){
                         var errCode = text.errCode||"";
                         var errMsg = text.errMsg||"";
                         if(errCode == 'S'){   
                        	 partF = "S";
                         }else{
                        	 partF = "E";
                         }
                         callback && callback();
                     }); 
                 }else{
                	 callback && callback();
                 }
             });
    	 }else if(updPartList && updPartList.length>0){
    		 svrCRUD(params1,function(text){
                 var errCode = text.errCode||"";
                 var errMsg = text.errMsg||"";
                 if(errCode == 'S'){   
                	 partF = "S";
                 }else{
                	 partF = "E";
                 }
                 callback && callback();
             });
    	 }
      }else{
    	  callback && callback();
      }
  /*  var endData = rpsItemGrid.getData();
    console.log("end:");
    console.log(endData);*/
}


var itemGridHash = {};
function doSearchItem()
{
    var p = {};
    p.isDisabled = 0;
    //查询洗美业务类型工时
    p.serviceTypeIds = "1,2";   
	var json={
			params: p,
			token:token
	}
	nui.ajax({
		url : itemRpbGridUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(data) {
			var temp = "";
			var list = nui.clone(data.list);
			for(var i=0;i<data.list.length;i++){
				var key = list[i].id;
				itemGridHash[key] = list[i];
				var aEl = "<a href='##' id='"+list[i].id+"' value="+list[i].name+"  name='HotWord' class='hui'>"+list[i].name+"</a>";
				 temp +=aEl;
			}
			$("#addAEl").html(temp);
			selectclick();
		}
	 });
}

//删除项目
/*function hideTab(str){
	var tabList = document.querySelectorAll('.xz');
	var natureId = null;
	for(var i=0;i<tabList.length;i++){
		natureId= tabList[i].id;
		if(str==natureId){
			var s = "#"+natureId;
			$(s).toggleClass("xz");
		}
	}
}*/
//回显颜色
function showTab(str){
	var tabList = document.querySelectorAll('.xz');
	var natureId = null;
	for(var i=0;i<tabList.length;i++){
		natureId= tabList[i].id;
		var s = "#"+natureId;
		$(s).toggleClass("xz");
	}
	var list = str.split(",");
	if(list.length>0){
		if(list.length > 1){
			list = unique(list);
		}
		for(var i = 0 ;i<list.length;i++){
			var id = list[i];
			var s = "#"+id;
			$(s).toggleClass("xz");
		}
	}
}


function forFrom(){
	var strId = "";
	var data = [];
	var row = rpsItemGrid.findRow(function(row){
		if(row.billItemId && row.billItemId==0){
			if(strId==""){
				strId =  ""+row.prdtId;
        	}else{
        		strId = strId+","+row.prdtId;
        	}
		}
    });
	return strId;
}

var addF = 0;
function selectclick() {
    $("a[name=HotWord]").click(function () {
//        $(this).siblings().removeClass("xz");
    	addF = 0;
    	var main = billForm.getData();
        var isSettle = main.isSettle||0;
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能添加项目!","W");
            return;
        }else if(isSettle == 1){
            showMsg("工单已结算,不能添加项目!","W");
            return;
        }else{
        	if($(this)[0].classList.length==1){
        		addF = 1;
            	$(this).toggleClass("xz");
            }
            var rpbId = $(this)[0].id;
            //等于2添加，1删除
            if($(this)[0].classList.length==2 && addF == 1){
            	//if(itemGridHash)
            	addF = 0;
            	var row = itemGridHash[rpbId];
            	var type = 2;
    			var resultData = {
    		            type:type,
    		            rtnRow:row
    		    };
    			saveNoshowMsg(function(){
    				addPrdt(resultData);
    		    	},"addYC");
            }
        }
    	
    });
}
function unique(arr) {
    var result = [], hash = {};
    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
        if (!hash[elem]) {
            result.push(elem);
            hash[elem] = true;
        }
    }
    return result;
}



function addFit(){
	var addFitEl = document.getElementById("addFit");  
	advancedGuest.showAtEl(addFitEl, {xAlign:"right",yAlign:"below"});
	var carNo = nui.get("search_key").getValue();
	if(carNo!="carNo"){
		nui.get("guestCarNo").setValue(carNo);
	}
	
}

function closeAdvancedGuest(){
	advancedGuest.hide();
}

//新增散客
var FitUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveCustomerInfo.biz.ext";
function sureAdvancedGuest(){
	//获取输入框的值
	var data = billForm.getData();
	if(data.id || data.guestId){
		add();
	}
	var carNo = nui.get("guestCarNo").getValue();
    //判断车牌号,返回是否正确，和转化后的车牌
	var falge = isVehicleNumber(carNo);
	nui.get("guestCarNo").setValue(falge.vehicleNumber);
	if(!falge.result){
		showMsg("请输入正确的车牌号","W");
		return;
	}else{
		carNo = falge.vehicleNumber;
	var name = "散客";
	 var guest = { 
			 fullName:name,
			 shortName:name,
			 mobile:"10000"
	 };
	 var insCarList = [];
	 var insCar = {
			 carNo : carNo
	 };
	 insCarList.push(insCar);
	 var insContactList = [];
	 var insContact = {
			 mobile:"10000",
			 name:name
	 };
	 insContactList.push(insContact);
	 nui.mask({
         el: document.body,
         cls: 'mini-mask-loading',
         html: '保存中...'
     });
	 var json = nui.encode({
		 guest:guest,
		 insCarList:insCarList,
		 insContactList:insContactList,
 		 token:token
 	  });
	 nui.ajax({
 		url : FitUrl,
 		type : 'POST',
 		data : json,
 		cache : false,
 		contentType : 'text/json',
 		success : function(text) {
 			var returnJson = nui.decode(text);
 			if (returnJson.errCode == "S") {
 				nui.get("search_key").setValue("");
 				nui.get("search_key").setText("");
 				var sk = document.getElementById("search_key");
 	            sk.style.display = "none";
 	            searchNameEl.setVisible(true);
 	            var tel = "/"+"10000";
 	            var guestName = "/"+"散客";
 	            var t = carNo + tel + guestName;
 	            searchNameEl.setValue(t);
 	            var item = text.retData;
 	            item.guestMobile = "10000";
 	            item.id = item.carId;
 	            item.vin = item.carVin;
 	            doSetMainInfo(item);
 	            showMsg("新增成功","S");
 				nui.unmask(document.body);
 				advancedGuest.hide();
 				return;
 			} else {
 				nui.unmask(document.body);
 				showMsg(returnJson.errMsg || "新增失败","E");
 				return;
 		    }
 		}
 	 });
	}
}

/*function isVehicleNumber(vehicleNumber) {
    var result = false;
    if (vehicleNumber.length == 7){
      var express = /^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
      result = express.test(vehicleNumber);
    }
    return result;
}*/

function addOrEdit(serviceId,billTypeId)
{
	var data = billForm.getData();
    title = "完善散客信息";
    var guest = {};
    guest.guestId = data.guestId;
    guest.carNo = nui.get("carNo").getValue();
    if(!data.guestId){
    	showMsg("数据获取失败,请重新操作!","W");
    	return;
    }
    nui.open({
        url: webBaseUrl + "com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:560,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            params.guest = guest;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {
            	if(serviceId){
            		toChangBill(serviceId,billTypeId);
            	}
            }
        }
    });
}

function buyCard(str)
{
	var data = billForm.getData();
    title = "完善散客信息";
    var guest = {};
    guest.guestId = data.guestId;
    var carNo = nui.get("carNo").getValue();
    var carId = data.carId;
    guest.carNo = carNo;
    if(!data.guestId){
    	showMsg("数据获取失败,请重新操作!","W");
    	return;
    }
    nui.open({
        url: webBaseUrl + "com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:560,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            params.guest = guest;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
        	var iframe = this.getIFrameEl();
            var guestData = {};
            guestData = iframe.contentWindow.getWalkGuest();
            guestData.carNo = carNo;
            guestData.carId = carId;
            if(action  == "ok")
            {
            	if(str=="store"){
            		//addcard();
            		doAddcard(guestData);
            	}
            	if(str=="card"){
            		//addcardTime();
            		doAddcardTime(guestData);
            	}
            }
        }
    });
}


function addSell() {
	
	nui.open({
		url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
		title : "添加商机",
		width : 550,
		height : 410,
		onload : function() {
			var iframe = this.getIFrameEl();
			//工单页面添加商机信息直接带过去
			var data = xyguest;
			//新增页面商机的姓名字段是guestName
			data.guestName = data.guestFullName;
			data.type = "add";
			iframe.contentWindow.setData(data);
		},
		ondestroy : function(action) {
			if (action == "saveSuccess") {
				carSellPointInfo.hide();
				showSellPoint();
			}
		}
	});
}

function editSell() {
		var row = carSellPointGrid.getSelected();
		if (row) {
			nui.open({
				url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
				title : "更新商机",
				width : 550,
				height : 410,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = row;
					data.type = 'editT';
					// 直接从页面获取，不用去后台获取
					iframe.contentWindow.setData(data);
				},
				ondestroy : function(action) {
					if (action == "saveSuccess") {
						carSellPointInfo.hide();
						showSellPoint();
					}
				}
			});
		} else {
			showMsg("请选中一条记录!", "W");
		}
	}



var binUrl = webBaseUrl + "repair/RepairBusiness/Reception/bindWechatContactor.jsp";
function bindWechat(){
	var data = billForm.getData();
	//var guestId = data.guestId;
	if(!data.guestId){
		return;
	}
	nui.open({
        url:binUrl,
        title:"绑定联系人",
        width:750, 
        height:300,
        onload:function(){
        	var iframe = this.getIFrameEl();
            var params = {};	
            params.guestId=data.guestId;
            params.carNo = data.carNo;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
        	var iframe = this.getIFrameEl();
            var params = {};	
            var params = iframe.contentWindow.getData();
            if(params){
            	if(params.success && params.success==1){
            		document.getElementById("showA").style.display = "";
                	document.getElementById("showA1").style.display='none';
            	}
            }
        	
        }
    });
}
 
function remarkChang(e){
	var el = e.sender;
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var remark = rpsItemGrid.getCellEditor("remark", row);
	remark.setValue(e.value);
}


function upload(){
	var formData = billForm.getData();
	var serviceId = formData.id;
	var serviceCode = $("#servieIdEl").html();
	var state = null;
	if(formData.status == 0){
		state = 1;
    }else if(formData.status == 1 || formData.status == 2){
    	if(formData.isSettle != 1 && formData.balaAuditSign != 1){
    		state = 2;
    	}
    }
	var uploadUrl = "/com.hsweb.RepairBusiness.maintenancePicture.flow";
	if(serviceId){
		nui.open({
	        url: webPath + contextPath+uploadUrl,
	        title: "上传图片",
			width: "700px",
			height: "610px",
			allowResize : false,
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.SetData(serviceId,serviceCode,state);
	        },
	        ondestroy: function (action){
	        }
	    });
	}else{
		showMsg("请先保存工单","W");
	}
}

function saleReminding(){
    var data = billForm.getData();
	if(data.status != 0){
		showMsg("工单不是报价状态，不能提醒报价！","W");
        return;        
    }
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
    	nui.open({
    		url : webPath + contextPath + "/com.hsweb.RepairBusiness.offerRemind.flow?token=" + token,
    		title : "报价提醒",
    		width : 800,
    		height : 500,
    		allowDrag : true,
    		allowResize : true,
    		onload : function() {
    			var iframe = this.getIFrameEl();
    			data.serviceId = fserviceId;
                iframe.contentWindow.setData(data);
    		},
    		ondestroy : function(action) {
    			if(action=="ok"){
    			   main = billForm.getData();
    			   var p1 = { }
     		       var p2 = {
     		       interType: "item",
     		           data:{
     		             serviceId: main.id||0
     		           }
     		        };
     		       var p3 = {};
     		       loadDetail(p1, p2, p3,main.status);
    			}
    			
    		}
    	});
    }

/*    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '消息推送中...'
    });
	nui.ajax({
		url : pushInfoUrl,
		type : "post",
		data : {
			serviceId:fserviceId
		},
		success : function(data) {
			nui.unmask(document.body);
			if(data.errCode == "S"){
				showMsg("推送成功","S");
			}else{
				showMsg("推送失败","E");
			}
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			
		}
	});*/	
}