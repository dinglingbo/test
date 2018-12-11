/**
 * Created by Administrator on 2018/3/21.
 */ 
 var webBaseUrl = webPath + contextPath + "/";   
 var baseUrl = apiPath + repairApi + "/";       
 var mainGrid = null;  
 var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
 var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
 var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
 var cardTimesGridUrl = baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext";
 var memCardGridUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext";
 var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext"; 
 var getAccountUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryAccount.biz.ext";
  
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

 var rpsPackageGrid = null;
 var rpsItemGrid = null;
 var packageDetailGrid = null;
 var packageDetailGridForm = null;
 var FItemRow = {};
 var pkgRateEl = null;
 var itemRateEl = null;
 var partRateEl = null;
 var carSellPointInfo = null;

 var advancedMorePartWin = null;
 var advancedCardTimesWin = null;
 var advancedPkgRateSetWin = null;
 var advancedItemPartRateSetWin = null;
 var advancedPkgWorkersSetWin = null;
 var advancedPkgSaleMansSetWin = null;
 var advancedItemWorkersSetWin = null;
 var advancedItemPartSaleManSetWin = null;
 
 var cardTimesGrid = null;
 var advancedMemCardWin = null;
 var memCardGrid = null;
 var carSellPointGrid = null;
 var sellForm = null;
 var carCheckInfo = null;
 var checkMainData = null;
 var rdata = null;
 var isRecord = null;

 var fserviceId = 0;
 var fguestId = 0;
 var fcarId = 0;
 var mpackageRate = 0;
 var mitemRate = 0;
 var mpartRate = 0;
 var x = 0;
 var y = 0;
 var lastItemSubtotal = null;
 var lastItemQty = null;
 var lastItemRate = null;
 var lastItemUnitPrice = null;
 var lastPkgSubtotal = null;
 var lastPkgRate = null;
 var prdtTypeHash = {
    "1":"套餐",
    "2":"项目",
    "3":"配件"
};
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
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");
    billForm = new nui.Form("#billForm");
    sellForm = new nui.Form("#sellForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedCardTimesWin = nui.get("advancedCardTimesWin");
    advancedPkgRateSetWin = nui.get("advancedPkgRateSetWin");
    advancedItemPartRateSetWin = nui.get("advancedItemPartRateSetWin");
    advancedPkgWorkersSetWin = nui.get("advancedPkgWorkersSetWin");
    advancedPkgSaleMansSetWin = nui.get("advancedPkgSaleMansSetWin");
    advancedItemWorkersSetWin = nui.get("advancedItemWorkersSetWin");
    advancedItemPartSaleManSetWin = nui.get("advancedItemPartSaleManSetWin");
   
    carCheckInfo = nui.get("carCheckInfo");
    carSellPointInfo = nui.get("carSellPointInfo");
    cardTimesGrid = nui.get("cardTimesGrid");
    cardTimesGrid.setUrl(cardTimesGridUrl);
    advancedMemCardWin = nui.get("advancedMemCardWin");
    memCardGrid = nui.get("memCardGrid");
    memCardGrid.setUrl(memCardGridUrl);
    carSellPointGrid = nui.get("carSellPointGrid");
    var data = [{prdtName:'保养到期提醒',amt:'3850',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'保养到期提醒'},
                {prdtName:'商业险到期提醒',amt:'2600',status:'未联系',creator:'杨超越',doTimes:'2018-12-15',type:'商业险到期提醒'},
                {prdtName:'交强险到期提醒',amt:'3460',status:'未联系',creator:'杨超越',doTimes:'2018-12-26',type:'交强险到期提醒'},
                {prdtName:'更换机油',amt:'360',status:'意向明确',creator:'杨超越',doTimes:'2018-12-05',type:'车况检查'},
                {prdtName:'更换轮胎',amt:'5500',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-08',type:'车况检查'},
                {prdtName:'储值卡到期',amt:'1000',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'储值卡到期'},
                {prdtName:'贴膜',amt:'50',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'},
                {prdtName:'镀金',amt:'330',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'},
                {prdtName:'更换机油',amt:'35',status:'有兴趣',creator:'杨超越',doTimes:'2018-12-05',type:'计次卡到期'}];
    carSellPointGrid.setData(data);

    pkgRateEl = nui.get("pkgRateEl");
    itemRateEl = nui.get("itemRateEl");
    partRateEl = nui.get("partRateEl");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    searchNameEl = nui.get("search_name");
    servieIdEl = nui.get("servieIdEl");
    searchKeyEl = nui.get("search_key");
    searchKeyEl.setUrl(guestInfoUrl);
    searchKeyEl.on("beforeload",function(e){
        if(fserviceId){
            e.cancel = true;
            return;
        }
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
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
    searchKeyEl.on("valuechanged",function(e){
        var item = e.selected;
        if(fserviceId){
            return;
        }
        if (item) { 

            var carNo = item.carNo||"";
            var tel = item.guestMobile||"";
            var guestName = item.guestFullName||"";
            var carVin = item.vin||"";

            var params = {
              params:{
                carNo: carNo,
                isSettle: 0,
                orgid: currOrgId
            }

        }
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
                                    opt.text="洗车开单";
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
});
    searchKeyEl.focus();
    // innerItemGrid = nui.get("innerItemGrid");
    // innerPartGrid = nui.get("innerPartGrid");
    // innerItemGrid.setUrl(itemGridUrl);
    // innerPartGrid.setUrl(partGridUrl);

    // beginDateEl.setValue(getMonthStartDate());
    // endDateEl.setValue(addDate(getMonthEndDate(), 1));

    document.getElementById("formIframe").src=webPath + contextPath + "/repair/common/pipSelect.jsp?token"+token;

    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
        nui.get("checkManId").setData(memList);
        nui.get("combobox3").setData(memList);
        nui.get("pkgSale").setData(memList);
        nui.get("combobox4").setData(memList);
        nui.get("ItemSale1").setData(memList);
        nui.get("ItemSale2").setData(memList);
    });
  
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
/*    initMember("checkManId",function(){
       
    });*/
    
    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
    pkgRateEl.on("validation",function(e){
        if(!e.isValid){
            pkgRateEl.setValue(0);
        }
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
    rpsPackageGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
        	case "prdtName":
	            var cardDetailId = record.cardDetailId||0;
	            var billPackageId = record.billPackageId || 0;
	            if(cardDetailId>0){
	                e.cellHtml = e.value + "<font color='red'>(预存)</font>";
	            }
	            if(billPackageId != 0){
	            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
	            }
	            break;
            case "serviceTypeId":
                var type = record.type||0;
                if(type>1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "qty":
           	var type = record.type||0;
                if(type==1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "saleMan":
                var type = record.type||0;
                var cardDetailId = record.cardDetailId||0;
                if(type>1 || cardDetailId> 0){
                    e.cellHtml = "--";
                }
                break;
            case "type":
                if(e.value == 1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = prdtTypeHash[e.value];
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
            case "packageOptBtn":
                var pid = record.pid||0;

                if(pid == 0){
                    var s = '<a class="optbtn" href="javascript:editRpsPackage(\'' + uid + '\')">修改</a>'
                    + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';

                    if (grid.isEditingRow(record)) {
                        s = '<a class="optbtn" href="javascript:updateRpsPackage(\'' + uid + '\')">确定</a>'
                            + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';
                    }
                }else{
                    var s = '<a class="optbtn" href="javascript:editRpsPackage(\'' + uid + '\')">修改</a>';

                    if (grid.isEditingRow(record)) {
                        s = '<a class="optbtn" href="javascript:updateRpsPackage(\'' + uid + '\')">确定</a>';
                    }
                }
                
                e.cellHtml = s;
                 //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                           // '<span class="fa fa-plus" onClick="javascript:addPackNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                            //' <span class="fa fa-close" onClick="javascript:deletePackRow()" title="删除行"></span>';
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
    });
    rpsPackageGrid.on("cellbeginedit",function(e){
        var field=e.field; 
        var editor = e.editor;
        var row = e.row;
        var column = e.column;
        var editor = e.editor;

        if(field == 'serviceTypeId'){
            if(row.type > 1) {
                e.cancel = true;
            }
        }
        if(field == 'subtotal' || field == 'rate'){
            if(row.type > 1) {
                e.cancel = true;
            }else{
                if(row.cardDetailId > 0){
                    e.cancel = true;
                }
            }
        }
        if(field == 'workers'){
            if(row.type != 2){
                e.cancel = true;
            }
        }
        if(field == 'saleMan'){
            if(row.type != 1 || row.cardDetailId > 0){
                e.cancel = true;
            }
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
            	    var s = '<a class="optbtn" href="javascript:editRpsItem(\'' + uid + '\')">修改</a>'
                     + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
                  if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:updateRpsItem(\'' + uid + '\')">确定</a>'
                     + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
                   }
                 }else{
                	 //修改配件信息
                	 var s = '<a class="optbtn" href="javascript:editItemRpsPart(\'' + uid + '\')">修改</a>'
                            + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                     if (grid.isEditingRow(record)) {
                         s = '<a class="optbtn" href="javascript:updateItemRpsPart(\'' + uid + '\')">确定</a>'
                            + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                     }
                  }
                //e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                //            '<span class="fa fa-plus" onClick="javascript:addItemNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                //            ' <span class="fa fa-close" onClick="javascript:deleteItemRow()" title="删除行"></span>';
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
        if(field == 'unitPrice' || field == 'subtotal' || field == 'rate' || field == 'saleMan'){
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
            e.cellHtml = '<a class="optbtn" href="javascript:addCardTimesToBill()">添加</a>';
        }
    });
    memCardGrid.on("drawcell",function(e)
    {
        var row = e.row;
        if(e.field == "balaAmt")
        {
            var totalAmt = row.totalAmt || 0;
            var useAmt = row.useAmt||0;
            e.cellHtml = totalAmt - useAmt;
        }
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
    carSellPointGrid.on("drawcell",function(e)
    {
        if(e.field == 'cardTimesOpt'){
            e.cellHtml = '<a class="optbtn" href="javascript:void()">查看</a>';
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

	    // if((keyCode==80)&&(event.altKey))  {   //打印
		// 	onPrint();
	    // } 
	    // if((keyCode==113))  {  
		// 	addMorePart();
		// } 
	    /*if((keyCode==27))  {  //ESC
        	cardTimesGrid.hide();
	   };*/
	}
});

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
    maintain.recordDate = now;

    $("#lastComeKilometers").html(car.lastComeKilometers);  
    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;
    nui.get("contactorName").setText(car.contactName);
    billForm.setData(maintain);
    xyguest = maintain;
    fguestId = car.guestId||0;
    fcarId = car.id||0;

    doSearchCardTimes(fguestId);
    doSearchMemCard(fguestId);
    
    $("#guestNameEl").html(car.guestFullName);
    $("#showCarInfoEl").html(car.carNo);
    $("#guestTelEl").html(car.guestMobile);
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
            var lastEnterKilometers = data.lastEnterKilometers || 0;
            $("#lastComeKilometers").html(lastEnterKilometers);
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

                        var sk = document.getElementById("search_key");
                        sk.style.display = "none";
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

                        doSearchCardTimes(fguestId);
                        doSearchMemCard(fguestId);
                        xyguest = data;
                        nui.get("contactorName").setText(contactor.name);
                        billForm.setData(data);

                        var status = data.status||0;
                        var isSettle = data.isSettle||0;
                        doSetStyle(status, isSettle);

                        if(data.isOutBill){
                        	nui.get("ExpenseAccount").setVisible(false);
                        	nui.get("ExpenseAccount1").setVisible(true);
                        }else{
                        	nui.get("ExpenseAccount").setVisible(true);
                        	nui.get("ExpenseAccount1").setVisible(false);
                        }

                        var p1 = {
                            interType: "package",
                            data:{
                                serviceId: data.id||0
                            }
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
                        loadDetail(p1, p2, p3);

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
}
function add(){
    // $("#servieIdEl").html("综合开单详情");
    // $("#carNoEl").html("");
    // //$("#wechatTag").css("color","#62b900");
    // $("#guestNameEl").html("");
    // $("#guestTelEl").html("");
    // $("#cardPackageEl").html("次卡套餐(0)");
    // $("#clubCardEl").html("会员卡(0)");
    // $("#creditEl").html("挂账:0");
    // $("#carHealthEl").html("车况:0");
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户
    rpsPackageGrid.clearRows();
    rpsItemGrid.clearRows();
    billForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);
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
    nui.get("contactorName").setText("");
    sellForm.setData(data);
    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;


    document.getElementById("formIframe").contentWindow.doSetCardTimes([]);
    $("#lastComeKilometers").html("0");
    $("#servieIdEl").html("");
    $("#showCardTimesEl").html("次卡套餐(0)");
    $("#showCardEl").html("储值卡(0)");
    $("#creditEl").html("挂账:0");
    $("#showCarInfoEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");

    nui.get("ExpenseAccount").setVisible(true);
    nui.get("ExpenseAccount1").setVisible(false);

}
function save(){
	
	var data = billForm.getData();
	if(data.status == 2){
		showMsg("工单已完工","W");
        return;        
    }
	if(data.isSettle == 1){
		showMsg("工单已结算","W");
        return;        
    }
	
	//判断里程
	var last =  $("#lastComeKilometers").text() || 0;
	var enterKilometers = nui.get("enterKilometers").getValue();
	if(enterKilometers < last){
		showMsg("进厂里程不能小于上次里程","W");
		return;
	}
	
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){

        if(data.id){
            fserviceId = data.id;
            showMsg("保存成功!","S");
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
                var contactor = text.contactor||{};
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
                    var p1 = {
                        interType: "package",
                        data:{
                            serviceId: data.id||0
                        }
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
                    loadDetail(p1, p2, p3);

                }else{
                    showMsg("数据加载失败,请重新打开工单!","E");
                }

            }, function(){});

            
            
        }
        
    },function(){ 
        nui.unmask(document.body);
    });
}


function saveNoshowMsg(callback){
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
                        interType: "package",
                        data:{
                            serviceId: data.id||0
                        }
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
                    loadDetail(p1, p2, p3);
                    callback && callback();
                }else{
                    showMsg("数据加载失败,请重新打开工单!","E");
                }

            }, function(){});
        }
        
    });
}

var requiredField = {
    carNo : "车牌号",
    guestId : "客户",
    serviceTypeId : "业务类型",
    mtAdvisorId : "服务顾问",
    enterKilometers : "进厂里程",
};
var saveMaintainUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsMaintain.biz.ext";
function saveMaintain(callback,unmaskcall){
    var data = billForm.getData();
    for ( var key in requiredField) {
      if (!data[key] || $.trim(data[key]).length == 0) {
        unmaskcall && unmaskcall();
        showMsg(requiredField[key] + "不能为空!","W");
        return;
    }
  }
data.billTypeId = 2;
data.lastEnterKilometers = $("#lastComeKilometers").text() || 0;
var params = {
    data:{
        maintain:data
    }
};
svrSaveMaintain(params, function(text){
    var errCode = text.errCode||"";
    if(errCode == "S") {
        unmaskcall && unmaskcall();
        var main = text.data||{};
        fserviceId = main.id||0;
        callback && callback(main);
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
function sureMT(){
    var dataForm = billForm.getData();
    if(!dataForm.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(dataForm.status != 0){
            showMsg("工单已确定维修!","W");
            return;
        }
        var params = {
            data:{
                id:dataForm.id||0
            }
        };
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '处理中...'
        });
        svrSureMT(params, function(data){
            data = data||{};
            var errCode = data.errCode||"";
            var errMsg = data.errMsg||"";
            if(errCode == 'S'){
                var main = data.maintain||{};
                main.contactorName = dataForm.contactorName;
                main.guestMobile = dataForm.guestMobile;
                main.guestFullName = dataForm.guestFullName;
                main.mobile = dataForm.mobile;
                main.carModel = dataForm.carModel;
                billForm.setData([]);
                billForm.setData(main);
                nui.get("contactorName").setText(dataForm.contactorName);
                var status = main.status||0;
                var isSettle = main.isSettle||0;
                doSetStyle(status, isSettle);
                showMsg("确定开单成功!","S");
            }else{
                showMsg(errMsg||"确定开单失败!","E");
                nui.unmask(document.body);
            }
        }, function(){
            nui.unmask(document.body);
        });
    }
}
function finish(){
    var dataForm = billForm.getData();
    if(!dataForm.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(dataForm.status == 2){
            showMsg("工单已完工!","W");
            return;
        }
        var params = {
            serviceId:dataForm.id||0
        };
        doFinishWork(params, function(data){
            data = data||{};
            if(data.action){
                var action = data.action||"";
                data.contactorName = dataForm.contactorName;
                data.guestMobile = dataForm.guestMobile;
                data.guestFullName = dataForm.guestFullName;
                data.mobile = dataForm.mobile;
                data.carModel = dataForm.carModel;
                if(action == 'ok'){
                    billForm.setData([]);
                    billForm.setData(data);
                    nui.get("contactorName").setText(dataForm.contactorName);
                    var status = data.status||0;
                    var isSettle = data.isSettle||0;
                    doSetStyle(status, isSettle);
                    showMsg("完工成功!","S");
                }else{
                    if(data.errCode){
                        showMsg("完工失败!","E");
                        return;
                    }
                }
            }
        });
    }
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
                billForm.setData(olddata);
                nui.get("contactorName").setText(maintain.contactorName);
                var status = 1;
                var isSettle = maintain.isSettle||0;
                doSetStyle(status, isSettle);
                showMsg("返单成功!","S");
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
            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){

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
                            if(interType == 'package'){
                                rpsPackageGrid.clearRows();
                                rpsPackageGrid.addRows(data);
                            }else if(interType == 'item'){
                                rpsItemGrid.clearRows();
                                rpsItemGrid.addRows(data);
                            }
                        }
                    }, function(){});
                }else{
                    showMsg(errMsg||"添加预存信息失败!","E");
                    return;
                }
            });
        }else{
            showMsg("请选择记录!","W");
            return;
        }
    }else if(type == 1){
        var data = {};
        var pkg = {
            serviceId:main.id,
            packageId:rtnRow.id,
            cardDetailId:0
        };
        data.pkg = pkg;

        var params = {
            type:"insert",
            interType:'package',
            data:data
        };
        svrCRUD(params,function(text){
            var errCode = text.errCode||"";
            var errMsg = text.errMsg||"";
            if(errCode == 'S'){

                var params = {
                    interType: 'package',
                    data:{
                        serviceId: main.id||0
                    }
                }
                getBillDetail(params, function(text){
                    var errCode = text.errCode;
                    var data = text.data||[];
                    if(errCode == "S"){
                        rpsPackageGrid.clearRows();
                        rpsPackageGrid.addRows(data);
                    }
                }, function(){});
            }else{
                showMsg(errMsg||"添加套餐失败!","E");
                return;
            }
        });
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
        svrCRUD(params,function(text){
            var errCode = text.errCode||"";
            var errMsg = text.errMsg||"";
            if(errCode == 'S'){

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
                    }
                }, function(){});
            }else{
                showMsg(errMsg||"添加项目信息失败!","E");
                return;
            }
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
        svrCRUD(params,function(text){
            var errCode = text.errCode||"";
            var errMsg = text.errMsg||"";
            if(errCode == 'S'){

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
                return;
            }
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
            }
        }else{
            showMsg(errMsg||"删除配件信息失败!","E");
            return;
        }
    });

}
function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}
function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}
function deletePackRow(row_uid){
	
	
	
    var data = rpsPackageGrid.getData();
    var row = rpsPackageGrid.getRowByUID(row_uid);
    var prdtId = row.prdtId;
    if(data && data.length==1){
        row = data[0];
    }
    var pkg = {
        serviceId:row.serviceId,
        id:row.id,
        cardDetailId:row.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"package",
        data:{
            pkg: pkg
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            var rows = rpsPackageGrid.findRows(function(row){
                if(row.prdtId == prdtId || row.pid == prdtId){
                    return true;
                }
            });

            rpsPackageGrid.removeRows(rows);
        }else{
            showMsg(errMsg||"删除套餐信息失败!","E");
            return;
        }
    });
}
function deleteItemRow(row_uid){
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
    advancedMemCardWin.hide();
    carCheckInfo.hide();
    memCardGrid.clearRows();

    doSearchCardTimes(fguestId);
}
function showCard(){
    if(!fguestId || advancedMemCardWin.visible) {
        advancedMemCardWin.hide();
        
        memCardGrid.clearRows();
        return;
    }

    var atEl = document.getElementById("clubCardEl");  
    advancedMemCardWin.showAtEl(atEl, {xAlign:"right",yAlign:"below"});
    advancedCardTimesWin.hide();
    carCheckInfo.hide();
    cardTimesGrid.clearRows();

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
    advancedCardTimesWin.hide();
    advancedMemCardWin.hide();
}


function showSellPoint() {
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
    carCheckInfo.hide();
    advancedMemCardWin.hide();
    //SearchCheckMain(changeCheckInfoTab);
}

/*function showHealth(){
    window.open("http://www.baidu.com?backurl="+window.location.href); 
}*/
function doSearchCardTimes(guestId)
{
    cardTimesGrid.clearRows();
    if(!guestId) return;

    var p = {};
    p.detailFinish = 0;  
    p.guestId = guestId;
    p.notPast = 1; 
    p.status = 2; 
    cardTimesGrid.load({
    	token:token,
        p:p
    },function(){
        var data = cardTimesGrid.getData();
        var len = data.length||0;
        $("#showCardTimesEl").html("次卡套餐("+len+")");
        document.getElementById("formIframe").contentWindow.doSetCardTimes(data);
    });
}
function doSearchMemCard(guestId)
{
    memCardGrid.clearRows();
    if(!guestId) return;

    memCardGrid.load({
    	token:token,
        guestId:guestId
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

function closePkgRateSetWin(){
    advancedPkgRateSetWin.hide();
}
function surePkgRateSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedPkgRateSetWin.hide();
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
            var rate = pkgRateEl.getValue()||0;
            rate = rate/100;
            rate = rate.toFixed(4);
            var params = {
                data:{
                    serviceId:data.id||0,
                    rate: rate
                }
            };
            svrSetPkgRateBatch(params, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                    
                    var p1 = {
                        interType: "package",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    var p2 = {
                    }
                    var p3 = {
                    }
                    loadDetail(p1, p2, p3);

                    advancedPkgRateSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改优惠率失败!!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}

//施工员
function closePkgWorkersSetWin(){
    advancedPkgWorkersSetWin.hide();
}

//施工员
function setPkgWorkers(){
	nui.get("combobox3").setText("");
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	workerIdsBat = "";
        	workerNamesBat = "";
            advancedPkgWorkersSetWin.show();
        }
    }
}
//施工员
function surePkgWorkersSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedPkgRateSetWin.hide();
            return;
        }else{
            var isSettle = data.isSettle||0;
            if(isSettle == 1){
                showMsg("工单已结算,不能修改!","W");
                return;
            }
            if(workerIdsBat=="" || workerIdsBat==null){
            	showMsg("请选择施工员!","W");
                return;
            }
            serviceId = data.id||0;
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '处理中...'
            });
            var params = {
                data:{
                    serviceId:data.id||0,
                    workerIds:workerIdsBat,
                    workers:workerNamesBat,
                    type:"package"
                }
            };
            svrSetWorkersBatch(params, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                    var p1 = {
                        interType: "package",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    var p2 = {
                    }
                    var p3 = {
                    }
                    loadDetail(p1, p2, p3);

                    advancedPkgWorkersSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改施工员失败!!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}


//套餐销售员
function closePkgSaleMansSetWin(){
	advancedPkgSaleMansSetWin.hide();
}
function setPkgSaleMans(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	saleManIdBat = "";
        	saleManNameBat = "";
            advancedPkgSaleMansSetWin.show();
        }
    }
}

function surePkgSaleMansSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedPkgRateSetWin.hide();
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
            
            var params = {
                data:{
                    serviceId:data.id||0,
                    saleMan:saleManNameBat,
                    saleManId:saleManIdBat,
                    type:"package"
                }
            };
            svrSetPkgSaleMansBatch(params, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                    var p1 = {
                        interType: "package",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    var p2 = {
                    }
                    var p3 = {
                    }
                    loadDetail(p1, p2, p3);

                    advancedPkgSaleMansSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改销售员失败!!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}


//批量设置配件工时销售员
function setItemSaleMan(){
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	/*saleManIdBat="";
        	saleManBat="";
        	saleManIdBat2="";
        	saleManBat2="";*/
        	advancedItemPartSaleManSetWin.show();
        }
    }
}
function closeItemPartSaleManSetWin(){
	advancedItemPartSaleManSetWin.hide();
}
function sureItemPartSaleManSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedItemPartSaleManSetWin.hide();
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
           
            if(saleManIdBat){
            	if(saleManIdBat2){
            		var params = {
                            data:{
                                serviceId:data.id||0,
                                saleMan: saleManNameBat,
                                saleManId: saleManIdBat,
                                partSaleMan:saleManNameBat2,
                                partSaleManId:saleManIdBat2,
                                type:"itemPart"
                            }
                        };
            	}else{
            		var params = {
                            data:{
                                serviceId:data.id||0,
                                saleMan: saleManNameBat,
                                saleManId: saleManIdBat,
                                type:"item"
                            }
                        };
            	}
            }else{
            	if(saleManIdBat2){
            		var params = {
                            data:{
                            	 serviceId:data.id||0,
                                 partSaleMan:saleManNameBat2,
                                 partSaleManId:saleManIdBat2,
                                 type:"part"
                            }
                        };
            	}else{
            		showMsg("请选择销售员","W");
            		return;
            	}
            }
            svrSetPkgSaleMansBatch(params, function(data){
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
                        interType: "part",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    loadDetail(p1, p2, p3);

                    advancedItemPartSaleManSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改销售员失败!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}


//工时施工员
function closeItemWorkersSetWin(){
    advancedItemWorkersSetWin.hide();
}

function setItemWorkers(){
	nui.get("combobox4").setText("");
    var main =  billForm.getData();
    if(!main.id){
        return;
    }else{
        var status = main.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            return;
        }else{
        	workerIdsBat = "";
        	workerNamesBat = "";
            advancedItemWorkersSetWin.show();
        }
    }
}

function sureItemWorkersSetWin(){
    var data =  billForm.getData();
    var serviceId = 0;
    if(!data.id){
        return;
    }else{
        var status = data.status||0;
        if(status == 2){
            showMsg("工单已完工,不能修改!","W");
            advancedPkgRateSetWin.hide();
            return;
        }else{
            var isSettle = data.isSettle||0;
            if(isSettle == 1){
                showMsg("工单已结算,不能修改!","W");
                return;
            }
            if(workerIdsBat=="" || workerIdsBat==null){
            	showMsg("请选择施工员!","W");
                return;
            }
            serviceId = data.id||0;
            nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '处理中...'
            });
            var params = {
                    data:{
                        serviceId:data.id||0,
                        workerIds:workerIdsBat,
                        workers:workerNamesBat,
                        type:"item"
                    }
                };
            svrSetWorkersBatch(params, function(data){
                data = data||{};
                var errCode = data.errCode||"";
                var errMsg = data.errMsg||"";
                if(errCode == 'S'){
                    var p2 = {
                        interType: "item",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    var p1 = {
                    }
                    var p3 = {
                    }
                    loadDetail(p1, p2, p3);

                    advancedItemWorkersSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改施工员失败!!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}

function setItemPartRate(){
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
                        interType: "part",
                        data:{
                            serviceId: serviceId||0
                        }
                    }
                    loadDetail(p1, p2, p3);

                    advancedItemPartRateSetWin.hide();
                }else{
                    showMsg(errMsg||"批量修改优惠率失败!!","E");
                }
                nui.unmask(document.body);
            }, function(){
                nui.unmask(document.body);
            });
        }
    } 
}
function onCloseClick(e){
    var obj = e.sender;
    obj.setText("");
    obj.setValue("");
    var row = rpsPackageGrid.getSelected();
    var newRow = {workerIds:"",workers:""};
    rpsPackageGrid.updateRow(row, newRow);

}
function onworkerChanged(e){
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
    var row = rpsPackageGrid.getSelected();
    var newRow = {workerIds:workerIds};
    __workerIds = workerIds;
}
function onitemworkerChanged(e){
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
    var row = rpsItemGrid.getSelected();
    //var newRow = {workerIds:workerIds};
    //rpsItemGrid.updateRow(row, newRow);
    __workerIds = workerIds;
}
function onsalemanChanged(e){
    var obj = e.sender;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    var row = rpsPackageGrid.getSelected();
    __saleManId = saleManId;
    //rpsPackageGrid.updateRow(row, newRow);
}
function onitemsalemanChanged(e){
    var obj = e.sender;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    var row = rpsItemGrid.getSelected();
    var newRow = {saleManId:saleManId};
    //rpsItemGrid.updateRow(row, newRow);
    __saleManId = saleManId;
}
function onpartsalemanChanged(e){
    var obj = e.sender;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
   // var row = rpsPartGrid.getSelected();
    //var newRow = {saleManId:saleManId};
    //rpsPartGrid.updateRow(row, newRow);
    __saleManId = saleManId;
}
function addCardTimesToBill(){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","W");
        return;
    }
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
        svrCRUD(params,function(text){
            var errCode = text.errCode||"";
            var errMsg = text.errMsg||"";
            if(errCode == 'S'){
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
                        if(interType == 'package'){
                            rpsPackageGrid.clearRows();
                            rpsPackageGrid.addRows(data);
                        }else if(interType == 'item'){
                            rpsItemGrid.clearRows();
                            rpsItemGrid.addRows(data);
                        }
                    }
                }, function(){});
            }else{
                showMsg(errMsg||"添加预存信息失败!","E");
                return;
            }
        });
    }else{
        showMsg("请选择次卡记录!","W");
        return;
    }
}
function loadDetail(p1, p2, p3){
    if(p1 && p1.interType){
        getBillDetail(p1, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPackageGrid.clearRows();
                rpsPackageGrid.addRows(data);
                rpsPackageGrid.accept();
            }
        }, function(){});
    }
    if(p2 && p2.interType){
        getBillDetail(p2, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsItemGrid.clearRows();
                rpsItemGrid.addRows(data);
                rpsItemGrid.accept();
            }
        }, function(){});
    }
}
var __workerIds="";
var __saleManId="";
function editRpsPackage(row_uid){
	 var main = billForm.getData();
	 var isSettle = main.isSettle||0;
	 if(!main.id){
	     showMsg("请选择保存工单!","W");
	     return;
	 }
	 var status = main.status||0;
	 if(status == 2){
	     showMsg("工单已完工,不能修改套餐!","W");
	     return;
	 }
	 if(isSettle == 1){
	     showMsg("工单已结算,不能修改套餐!","W");
	     return;
	 }
    var row = rpsPackageGrid.getRowByUID(row_uid);
    lastPkgSubtotal = row.subtotal;
    lastPkgRate = row.rate;
    if (row) {
        __workerIds = "";
        __saleManId = "";
        rpsPackageGrid.cancelEdit();
        rpsPackageGrid.beginEditRow(row);      
    }
}
function updateRpsPackage(row_uid){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能修改套餐!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改套餐!","W");
        return;
    }
    var rowc = rpsPackageGrid.getRowByUID(row_uid);
    if (rowc) {
        rpsPackageGrid.commitEdit();
        var rows = rpsPackageGrid.getChanges();

        var isSubtotalModify = 0;
        if(rows && rows.length>0){
            var row = rows[0];
            if(row.type == 3){
                rpsPackageGrid.accept();
                return;
            }
            var serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            var rate = row.rate/100;
            rate = rate.toFixed(4);
            var pkg = {
                serviceId:row.serviceId,
                //优惠率除以100
                rate:rate
            };
            var itemList = [];
            if(row.type == 1){
                pkg.id = row.id||0;
                if(cardDetailId > 0){
                    pkg.serviceTypeId = row.serviceTypeId;
                }else{
                    pkg.subtotal = row.subtotal
                    pkg.serviceTypeId = row.serviceTypeId;
                    if(__saleManId){
                        pkg.saleMan = row.saleMan;
                        pkg.saleManId = __saleManId;
                    }
                    isSubtotalModify = 1;
                }
            }else{
                pkg.id = row.billPackageId||0;
                if(__workerIds){
                    var item = {
                        id: row.id,
                        serviceId: row.serviceId,
                        workerIds:__workerIds,
                        workers:row.workers
                    }
                    itemList.push(item);
                }
            }
            var params = {
                type:"update",
                interType:"package",
                data:{
                    pkg: pkg,
                    itemList : itemList
                }
            };

            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    __workerIds = "";
                    __saleManId = "";
                    rpsPackageGrid.accept();
                    if(isSubtotalModify == 1){
                        var p1 = {
                            interType: "package",
                            data:{
                                serviceId: serviceId
                            }
                        }
                        rpsPackageGrid.reject();
                        loadDetail(p1, {}, {});
                    }
                }else{
                	rpsPackageGrid.reject();
                    rpsPackageGrid.accept();
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}
function editRpsItem(row_uid){
	var main = billForm.getData();
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
    lastItemQty = row.qty;
    lastItemRate = row.rate;
    lastItemSubtotal = row.subtotal;
    lastItemUnitPrice = row.unitPrice;
    if (row) {
        __workerIds = "";
        __saleManId = "";
        rpsItemGrid.cancelEdit();
        rpsItemGrid.beginEditRow(row);
    }
}
function editItemRpsPart(row_uid){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能修改配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件!","W");
        return;
    }

    var row = rpsItemGrid.getRowByUID(row_uid);
    lastItemQty = row.qty;
    lastItemRate = row.rate;
    lastItemSubtotal = row.subtotal;
    lastItemUnitPrice = row.unitPrice;
    if (row) {
        __workerIds = "";
        __saleManId = "";
        rpsItemGrid.cancelEdit();
        rpsItemGrid.beginEditRow(row);
    }
}
function updateRpsItem(row_uid){
	
	var main = billForm.getData();
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
	
    var rowc = rpsItemGrid.getRowByUID(row_uid);
    if (rowc) {
        rpsItemGrid.commitEdit();
        var rows = rpsItemGrid.getChanges();

        if(rows && rows.length>0){
            var row = rows[0];
            var serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            
            var updList = [];
            if(cardDetailId > 0){ //预存的
                var item = {};
                item.id = row.id;
                item.serviceId = row.serviceId;
                item.serviceTypeId = row.serviceTypeId;
                if(__workerIds){
                    item.workerIds = __workerIds;
                    item.workers = row.workers;
                }
                updList.push(item);
            }else{
                var item = {};
                item.id = row.id;
                item.serviceId = row.serviceId;
                item.itemTime = row.qty;
                item.subtotal = row.subtotal;
                item.amt = row.amt;
                item.serviceTypeId = row.serviceTypeId;
                if(__workerIds){
                    item.workerIds = __workerIds;
                    item.workers = row.workers;
                }
                if(__saleManId){
                    item.saleMan = row.saleMan;
                    item.saleManId = __saleManId;
                }
                updList.push(item);
            }
            var params = {
                type:"update",
                interType:"item",
                data:{
                    serviceId: serviceId,
                    updList : updList
                }
            };

            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    __workerIds = "";
                    __saleManId = "";
                    rpsItemGrid.accept();
                }else{
                	rpsItemGrid.reject();
                    rpsItemGrid.accept();
                    showMsg(errMsg||"修改数据失败!","E");
                    return;
                }
            });
        }
    }
}

function updateItemRpsPart(row_uid){
	var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","W");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能修改配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能修改配件!","W");
        return;
    }
    var rowc = rpsItemGrid.getRowByUID(row_uid);
    if (rowc) {
    	rpsItemGrid.commitEdit();
        var rows = rpsItemGrid.getChanges();

        if(rows && rows.length>0){
            var row = rows[0];
            var serviceId = row.serviceId||0;
            var cardDetailId = row.cardDetailId||0;
            
            var updList = [];
            if(cardDetailId > 0){ //预存的
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.serviceTypeId = row.serviceTypeId;
                updList.push(part);
            }else{
                var part = {};
                part.id = row.id;
                part.serviceId = row.serviceId;
                part.qty = row.qty;
                part.subtotal = row.subtotal;
                part.serviceTypeId = row.serviceTypeId;
                part.unitPrice = row.unitPrice;
                part.amt = row.amt;
                var rate = row.rate/100;
                rate = rate.toFixed(4);
                part.rate = rate;
                if(__saleManId){
                    part.saleMan = row.saleMan;
                    part.saleManId = __saleManId;
                }
                updList.push(part);
            }
            var params = {
                type:"update",
                interType:"part",
                data:{
                    serviceId: serviceId,
                    updList : updList
                }
            };

            svrCRUD(params,function(text){
                var errCode = text.errCode||"";
                var errMsg = text.errMsg||"";
                if(errCode == 'S'){   
                    __workerIds = "";
                    __saleManId = "";
                    rpsItemGrid.accept();
                }else{
                	rpsItemGrid.reject();
                	rpsItemGrid.accept();
                    showMsg(errMsg||"修改数据失败!","E");
                    return;
                }
            });
        }
    }
}
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
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
       // showMsg("请选择保存工单!","S");
       // return;
    	var data = billForm.getData();
        for ( var key in requiredField) {
          if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
      }
      var last =  $("#lastComeKilometers").text() || 0;
      var enterKilometers = nui.get("enterKilometers").getValue();
      if(enterKilometers < last){
    	  showMsg("进厂里程不能小于上次里程","W");
    	  return;
    	}
	  saveNoshowMsg();
    }
    var param = {};
    param.carModelIdLy = main.carModelIdLy;
    param.serviceId = main.id;
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
	        loadDetail(p1, p2, p3);
	    }); 
}

function choosePackage(){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
       // showMsg("请选择保存套餐!","S");
       // return;
    	var data = billForm.getData();
        for ( var key in requiredField) {
          if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
      }
       saveNoshowMsg();
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("工单已完工,不能添加套餐!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能添加套餐!","W");
        return;
    }

    var param = {};
    param.carModelIdLy = main.carModelIdLy;   
    param.serviceId = main.id;                                       
    doSelectPackage(addToBillPackage, delFromBillPackage, checkFromBillPackage, param, function(text){
        main = billForm.getData();
        var p1 = { 
    		interType: "package",
            data:{
                serviceId: main.id||0
            }
        };
        var p2 = {};
        var p3 = {};
        loadDetail(p1, p2, p3);
    });
}

function addToBillPackage(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var pkg = {
        serviceId:main.id,
        packageId:row.id,
        cardDetailId:0
    };
    data.pkg = pkg;
    data.serviceId = main.id||0;
    
    var params = {
        type:"insert",
        interType:'package',
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
            showMsg(errMsg||"添加套餐失败!","E");
            return;
        }
    },function(){
        unmaskcall && unmaskcall();
    });
}


function delFromBillPackage(data, callback){
    var pkg = {
        serviceId:data.serviceId,
        id:data.id,
        cardDetailId:data.cardDetailId||0
    };
    var params = {
        type:"delete",
        interType:"package",
        data:{
        	pkg: pkg
        }
    };
    svrCRUD(params,function(text){
        var errCode = text.errCode||"";
        var errMsg = text.errMsg||"";
        if(errCode == 'S'){   
            callback && callback();
        }else{
            showMsg(errMsg||"删除套餐信息失败!","E");
            return;
        }
    });
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
        if(row && row.itemId == itemId){
            return true;
        }
    });
    if(rows && rows.length>0){
        return true;
    }
    return false;
}

function checkFromBillPackage(data){
    var packageId= data.id;
    var rows = rpsPackageGrid.findRows(function(row){
        if(row && row.prdtId == packageId){
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
function showMorePart(row_uid){
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
   	
}
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

    doSelectPart(itemId,addToBillPart, delFromBillPart, null, function(text){
        var p1 = { };
        var p2 = {
            interType: "item",
            data:{
                serviceId: main.id||0
            }
        };
        var p3 = {};
        loadDetail(p1, p2, p3);
    });
}


function showBasicData(type){
    var maintain = billForm.getData();
    var isSettle = maintain.isSettle||0;
    var status = maintain.status||0;
    if(status==2){
        showMsg("工单已完工,不能录入!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("工单已结算,不能录入!","W");
        return;
    }
    var BasicDataUrl = null;
    var title = null;
    if(!maintain.id){
        //showMsg("请选择保存工单!","W");
        //return;
    	var data = billForm.getData();
        for ( var key in requiredField) {
          if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
      }
      var last =  $("#lastComeKilometers").text() || 0;
      var enterKilometers = nui.get("enterKilometers").getValue();
      if(enterKilometers < last){
      	showMsg("进厂里程不能小于上次里程","W");
      	return;
      }
	  saveNoshowMsg(function(){
		maintain = billForm.getData();
		var carVin = maintain.carVin;
	    var params = {
	        vin:carVin,
	        serviceId:maintain.id,
	        carNo:maintain.carNo
	    };
	    if(type=="pkg"){
	    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPkg.flow?token=";
	    	title = "标准套餐查询";
	    }
	    if(type=="item"){
	    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryItem.flow?token=";
	    	title = "标准项目查询";
	    }
	  //添加回调函数，进行显示
	    doSelectBasicData(BasicDataUrl,title,params,function(p1,p2,p3){
	        loadDetail(p1, p2, p3);
	    });
	  });
    }else{
    	    var carVin = maintain.carVin;
    	    var params = {
    	        vin:carVin,
    	        serviceId:maintain.id,
    	        carNo:maintain.carNo
    	    };
    	    if(type=="pkg"){
    	    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPkg.flow?token=";
    	    	title = "标准套餐查询";
    	    }
    	    if(type=="item"){
    	    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryItem.flow?token=";
    	    	title = "标准项目查询";
    	    }
    	  //添加回调函数，进行显示
    	    doSelectBasicData(BasicDataUrl,title,params,function(p1,p2,p3){
    	        loadDetail(p1, p2, p3);
    	    });
    }  
 }
function showBasicDataPart(row_uid){
    var row = rpsItemGrid.getRowByUID(row_uid);
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
    var BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPart.flow?token=";
    var title = "标准配件查询";
    //添加回调函数，进行显示
    doSelectBasicData(BasicDataUrl,title,params,function(p1,p2,p3){
        loadDetail(p1, p2, p3);
    });
   
}

function addToBillPart(row, callback, unmaskcall){
    var main = billForm.getData();
    var data = {};
    var insPart = {
        serviceId:main.id||0,
        partId:row.id,
        billItemId:row.billItemId,     
        cardDetailId:0,
        qty:1
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
	doAddcardTime(xyguest);
	
}



function addcard(){

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
        
        doPrint(params);
	}else{
        showMsg("请先保存工单,再打印!","W");
        return;
    }
}

function showBillInfo(){
	var main = billForm.getData();
	var params = {
        carId : main.carId,
        guestId : main.guestId
    };
    if(main.id){
        doShowCarInfo(params);
    }
}

//数据改变时触发
function onPkgSubtotalValuechanged(e) {
	var el = e.sender;
	var flag = isNaN(e.value);
	var row = rpsPackageGrid.getEditorOwnerRow(el);
    var setPKgSubtotal = rpsPackageGrid.getCellEditor("pkgSubtotal", row);
    var subtotal = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不能小于0","W");
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){	
		setPKgSubtotal.setValue(lastPkgSubtotal);
		e.cancel = true; 
		return;
	}else{
	    //获取指定列和行的编辑器控件对象
	    var editor = rpsPackageGrid.getCellEditor("pkgRate", row);
	    var amt = row.amt||0;
	    var rate = 0;
	    if(amt>0){
	    	rate = (amt - subtotal)*1.0/amt;
	    }
	    rate = rate * 100;
	    rate = rate.toFixed(2);
	    editor.setValue(rate);
	    setPKgSubtotal.setValue(subtotal);
	    lastPkgSubtotal = subtotal;
	    lastPkgRate = rate;
	}
}

function onPkgRateValuechanged(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rate = el.getValue();
	var row = rpsPackageGrid.getEditorOwnerRow(el);
    var setPkgRate = rpsPackageGrid.getCellEditor("pkgRate", row);
	if (flag) {
		showMsg("请输入数字!","W");
		e.cancel = true; 
		setPkgRate.setValue(lastPkgRate);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setPkgRate.setValue(lastPkgRate);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setPkgRate.setValue(lastPkgRate);
		e.cancel = true; 
		return;
	}else{
	    //获取指定列和行的编辑器控件对象
	    var editor = rpsPackageGrid.getCellEditor("pkgSubtotal", row);
	    var amt = row.amt||0;
	    var subtotal = 0;
	    if(amt>0){
	    	subtotal = amt - rate*1.0/100*amt;
	        subtotal = subtotal.toFixed(2);
	    }
	    editor.setValue(subtotal);
	    setPkgRate.setValue(rate);
	    lastPkgRate = rate;
	    lastPkgSubtotal = subtotal;
	}
}

var scTyIdUrl = baseUrl + "com.hsapi.repair.repairService.query.getCardDiscount.biz.ext";
function onPkgTypeIdValuechanged(e){
   var maintain = billForm.getData();
   var el = e.sender;
   var row = rpsPackageGrid.getEditorOwnerRow(el);
    //获取指定列和行的编辑器控件对象
   var editor1 = rpsPackageGrid.getCellEditor("pkgSubtotal", row);
   var editor2 = rpsPackageGrid.getCellEditor("pkgRate", row);
   var json = nui.encode({
		"serviceTypeId" : el.getValue(),
		"guestId":maintain.guestId,
		token : token
	});
	//package_discount_rate
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
                var packageDiscountRate = cardRate.packageDiscountRate;
				var amt = row.amt||0;
				var subtotal = 0;
			    if(amt>0){
			    	subtotal = amt - packageDiscountRate*1.0*amt;
				    subtotal = subtotal.toFixed(2);
			    }
			    editor1.setValue(subtotal);
			    lastPkgRate = packageDiscountRate;
                lastPkgSubtotal = subtotal;
                packageDiscountRate = (packageDiscountRate*100).toFixed(2);
				editor2.setValue(packageDiscountRate);
				
			} else {
				//showMsg("出库失败");
			}
				
		}
	});	
}

function onValueChangedComQty(e){
	var el = e.sender;
	var flag = isNaN(e.value);
	var rowtime = rpsItemGrid.getEditorOwnerRow(el);
	var setItemTime = rpsItemGrid.getCellEditor("itemItemTime", rowtime);
	var itemTime = el.getValue();
	if (flag) {
		showMsg("请输入数字!","W");
		setItemTime.setValue(lastItemQty);
		e.cancel = true; 
	}else if(itemTime<0){
		showMsg("工时/数量不能小于0","W");
		setItemTime.setValue(lastItemQty);
		e.cancel = true; 
		return;
	}else if(itemTime == "" || itemTime == null){	
		setItemTime.setValue(lastItemQty);
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
		lastItemSubtotal = subtotal;
		lastItemQty = itemTime;
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
		setUnitPrice.setValue(lastItemUnitPrice);
		e.cancel = true; 
	}else if(unitPrice<0){
		
		showMsg("单价不能小于0","W");
		setUnitPrice.setValue(lastItemUnitPrice);
		e.cancel = true; 
		return;
	}else if(unitPrice == "" || unitPrice == null){	
		setUnitPrice.setValue(lastItemUnitPrice);
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
		lastItemSubtotal = subtotal;
		lastItemUnitPrice = unitPrice;
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
		setRate.setValue(lastItemRate);
		return;
	} else if(rate<0 || rate>100){	
		showMsg("请输入0到100之间的数!","W");
		setRate.setValue(lastItemRate);
		e.cancel = true; 
		return;
	}else if(rate == "" || rate == null){	
		setRate.setValue(lastItemRate);
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
		lastItemSubtotal = subtotal;
		lastItemRate = rate;
		
  }	
}

//修改了小计，只会修改优惠率
function onValueChangedItemSubtotal(e){	
	var el = e.sender;
	var flag = isNaN(e.value);
	var subtotal = el.getValue();
	var row = rpsItemGrid.getEditorOwnerRow(el);
	var setSubtotal = rpsItemGrid.getCellEditor("itemSubtotal", row);
	if (flag) {
		showMsg("请输入数字!","W");
		setSubtotal.setValue(lastItemSubtotal);
		e.cancel = true; 
	}else if(subtotal<0){
		showMsg("金额不小于0","W");
		setSubtotal.setValue(lastItemSubtotal);
		e.cancel = true; 
		return;
	}else if(subtotal == "" || subtotal == null){
		setSubtotal.setValue(lastItemSubtotal);
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
		    lastItemSubtotal = subtotal;
		    lastItemRate = rate;
		}else{
			subtotal = 0;
			setSubtotal.setValue(subtotal);
		    lastItemSubtotal = subtotal;
		    lastItemRate = rate;
		}
		
	}	
}

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
			    lastItemSubtotal = subtotal;
			    lastItemRate = itemDiscountRate;
				
			} else {
				//showMsg("出库失败");
			}			
		}
	});
}

function onPkgRateValuechangedBath(){
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
}
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
			  
			  data.packageSubtotal = sumPkgSubtotal;
			  data.packagePrefAmt = sumPkgPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }else{
			  data.packageSubtotal = 0;
			  data.packagePrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }
	  } 
}


function onDrawSummaryCellItem(e){ 	  
	  var data = sellForm.getData();
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
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }else{
			  data.itemSubtotal = 0;
			  data.itemPrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }
		  if(sumPartSubtotal>0 && sumPartAmt>=0)
		  {   
			  sumPartPrefAmt = sumPartAmt - sumPartSubtotal;
			  sumPartSubtotal = sumPartSubtotal.toFixed(2);
			  sumPartPrefAmt = sumPartPrefAmt.toFixed(2);
			  data.partSubtotal = sumPartSubtotal;
			  data.partPrefAmt = sumPartPrefAmt;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }else{
			  data.partSubtotal = 0;
			  data.partPrefAmt = 0;
			  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
			  var totalPrefAmt = parseFloat(data.packagePrefAmt) + parseFloat(data.itemPrefAmt)+parseFloat(data.partPrefAmt);
			  data.totalSubtotal = mtAmt.toFixed(2);
			  data.totalPrefAmt = totalPrefAmt.toFixed(2);
			  var totalAmt = parseFloat(data.totalSubtotal) + parseFloat(data.totalPrefAmt);
			  data.totalAmt = totalAmt.toFixed(2);
			  sellForm.setData(data);
		  }  
	  }  
}

function addExpenseAccount(){
	var data = billForm.getData();
	if(data.id){
		var item={};
		item.id = "123321";
	    item.text = "报销单";
		item.url =webBaseUrl+  "com.hsweb.print.ExpenseAccount.flow?sourceServiceId="+data.id;
		item.iconCls = "fa fa-cog";
		window.parent.activeTabAndInit(item,data);
		data.guestTel = $("#guestTelEl").text();
		data.guestName = $("#guestNameEl").text();
		data.contactorTel = data.guestMobile;
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

function pay(){
	
	var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(data.status != 2){
            showMsg("工单未完工,不能结算!","W");
            return;
        }
        if(data.isSettle == 1){
       	 showMsg("工单已结算!","W");
            return;
       }
        var sellData = sellForm.getData();
        ycAmt = parseFloat(tcAmt)+parseFloat(gsAmt);
        sellData.ycAmt = ycAmt;
        sellData.mtAmt = sellData.totalSubtotal;
        var params = {
            serviceId:data.id||0,
            guestId:data.guestId||0,
            carNo:data.carNo||0,
            guestName:$("#guestNameEl").text(),
            data:sellData
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
                	nui.get("isSettle").setValue(1);
                    var status = data.status||2;
                    var isSettle = data.isSettle||1;
                    doSetStyle(status, isSettle);
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
}


function newCheckMain() {  
    var data = billForm.getData();
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow";
    item.iconCls = "fa fa-cog";
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
        endDate:nui.get("recordDate").text
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
                var score = ldata.check_point || 0;
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

function setEnterKilometers(e){
	var last =  $("#lastComeKilometers").text() || 0;
	if(e.value < last){
		showMsg("进厂里程不能小于上次里程","W");
		nui.get("enterKilometers").setValue("");
	}
}

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
function saleManChangedBat(e){
	saleManNameBat = e.value;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    saleManIdBat = saleManId;
}


var saleManIdBat2 = "";
var saleManNameBat2 = "";
function saleManChangedBatP(e){
	saleManNameBat2 = e.value;
    var row = e.selected;
    var saleManId = 0;
    if(!row){
        saleManId = 0;
    }else{
        saleManId = row.empId;
    }
    saleManIdBat2 = saleManId;
}


