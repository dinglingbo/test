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

var billForm = null;
var sendGuestForm = null;
var insuranceForm = null;
var describeForm = null;
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
var carCheckInfo = null;
//var rpsPartGrid = null;

var rpsPackageGrid = null;
var rpsItemGrid = null;
var packageDetailGrid = null;
var packageDetailGridForm = null;
var FItemRow = {};
var pkgRateEl = null;
var itemRateEl = null;
var partRateEl = null;

var advancedMorePartWin = null;
var advancedCardTimesWin = null;
var advancedPkgRateSetWin = null;
var advancedItemPartRateSetWin = null;
var cardTimesGrid = null;
var advancedMemCardWin = null;
var memCardGrid = null;
var sellForm = null;
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
    "2":"工时",
    "3":"配件"
};
document.onmousemove = function(e){

    if(advancedMorePartWin.visible){
        var mx = e.pageX;
        var my = e.pageY;
        var loc = "当前位置 x:"+e.pageX+",y:"+e.pageY
        var x = advancedMorePartWin.x;
        var y = advancedMorePartWin.y;
        if(x - mx > 10 || mx - x > 180){
            advancedMorePartWin.hide();
            FItemRow = {};
            return;
        }
        if(y - my > 10 || my - y > 130){
            advancedMorePartWin.hide();
            FItemRow = {};
            return;
        }
    }
}
$(document).ready(function ()
{
	
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");

    billForm = new nui.Form("#billForm");
    sellForm = new nui.Form("#sellForm");
    sendGuestForm = new nui.Form("#sendGuestForm");
    insuranceForm = new nui.Form("#insuranceForm");
    describeForm = new nui.Form("#describeForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedCardTimesWin = nui.get("advancedCardTimesWin");
    advancedPkgRateSetWin = nui.get("advancedPkgRateSetWin");
    advancedItemPartRateSetWin = nui.get("advancedItemPartRateSetWin");
    carCheckInfo = nui.get("carCheckInfo");
    cardTimesGrid = nui.get("cardTimesGrid");
    cardTimesGrid.setUrl(cardTimesGridUrl);
    advancedMemCardWin = nui.get("advancedMemCardWin");
    memCardGrid = nui.get("memCardGrid");
    memCardGrid.setUrl(memCardGridUrl);

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

            var data = {
                carNo: carNo,
                isSettle: 0,
                orgid: currOrgId
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
                                var opt={};
                                opt.iconCls="fa fa-desktop";
                                opt.id="1104";
                                opt.text="洗车开单";
                                opt.url=webPath + contextPath + "/repair/RepairBusiness/Reception/carWashMgr.jsp";
                                
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

    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
        nui.get("checkManId").setData(memList);
    });
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    initDicts({
        enterOilMass: "DDT20130703000051"//进厂油量
    },null);
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
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
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
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                if(pid == 0){
                    //e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' +'<a href="javascript:showBasicDataPart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;标准配件</a>'+ e.value;
                
                    e.cellHtml = '<a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' + e.value;	
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
                e.cellHtml = s
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
                sendGuestForm.setData(maintain);

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
    maintain.sex = car.sex;
    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;

    billForm.setData(maintain);
    sendGuestForm.setData(maintain);
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
			mtAmt:0
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
            if(errCode == 'S'){
            	xyguest = data;
                var p = {
                    data:{
                        guestId: data.guestId||0,
                        contactorId: data.contactorId||0
                    }
                }
                getGuestContactorCar(p, function(text){
                    var errCode = text.errCode||"";
                    var guest = text.guest||{};
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
                        data.sex = contactor.sex;
                        data.mobile = contactor.mobile;

                        $("#guestNameEl").html(guest.fullName);
                        $("#showCarInfoEl").html(data.carNo);
                        $("#guestTelEl").html(guest.mobile);

                        fguestId = data.guestId||0;
                        fcarId = data.carId||0;

                        doSearchCardTimes(fguestId);
                        doSearchMemCard(fguestId);
                        
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
                        sendGuestForm.setData(data);

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
                        showMsg("数据加载失败,请重新打开工单!","W");
                    }
    
                }, function(){});
            }else{
                showMsg('数据加载失败!','W');
            }
        }, function(){
            nui.unmask(document.body);
        })
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


    rpsPackageGrid.clearRows();
    rpsItemGrid.clearRows();
    billForm.setData([]);
    sendGuestForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);
    nui.get("enterDate").setValue(now);

    fguestId = 0;
    fcarId = 0;
    fserviceId = 0;

    $("#servieIdEl").html("");
    $("#showCardTimesEl").html("次卡套餐(0)");
    $("#showCardEl").html("储值卡(0)");
    $("#showCarInfoEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");
    $("#statustable").find("span[name=statusvi]").attr("class", "nvstatusview");

    nui.get("ExpenseAccount").setVisible(true);
    nui.get("ExpenseAccount1").setVisible(false);

}
function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){
 
        if(data.id){
            fserviceId = data.id;
            showMsg("保存成功!","S");

            var params = {
                data:{
                    guestId: data.guestId||0,
                    contactorId: data.contactorId||0
                }
            }

            getGuestContactorCar(params, function(text){
                var errCode = text.errCode||"";
                var guest = text.guest||{};
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

                    billForm.setData(data);

                    var status = data.status||0;
                    var isSettle = data.isSettle||0;
                    doSetStyle(status, isSettle);

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
                    showMsg("数据加载失败,请重新打开工单!","W");
                }

            }, function(){});

            
            
        }
        
    },function(){ 
        nui.unmask(document.body);
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
    var data = billForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            unmaskcall && unmaskcall();
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
    }
    data.billTypeId = 0;

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
            showMsg(data.errMsg || "保存单据失败","W");
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
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(data.status != 0){
            showMsg("本工单已经确定维修!","W");
            return;
        }
        var params = {
            data:{
                id:data.id||0
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
                billForm.setData([]);
                billForm.setData(main);
                var status = main.status||0;
                var isSettle = main.isSettle||0;
                doSetStyle(status, isSettle);
                showMsg("确定维修成功!","S");
            }else{
                showMsg(errMsg||"确定维修失败!","W");
                nui.unmask(document.body);
            }
        }, function(){
            nui.unmask(document.body);
        });
    }
}
function finish(){
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(data.status == 2){
            showMsg("本工单已经完工!","W");
            return;
        }
        var params = {
            serviceId:data.id||0
        };
        doFinishWork(params, function(data){
            data = data||{};data = data||{};
            if(data.action){
                var action = data.action||"";
                if(action == 'ok'){
                    billForm.setData([]);
                    billForm.setData(data);
                    var status = data.status||0;
                    var isSettle = data.isSettle||0;
                    doSetStyle(status, isSettle);
                    showMsg("完工成功!","S");
                }else{
                    if(data.errCode){
                        showMsg("完工失败!","W");
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
            showMsg("本工单已经结算,不能返工!","W");
            return;
        }
        if(data.status != 2){
            showMsg("本工单未未完工,不能返工!!","W");
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
                var status = 1;
                var isSettle = maintain.isSettle||0;
                doSetStyle(status, isSettle);
                showMsg("返工成功!","S");
            }else{
                showMsg(errMsg||"返工失败!","W");
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
                showMsg(data.errMsg || "保存单据失败","W");
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
                    showMsg(errMsg||"添加预存信息失败!","W");
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
                showMsg(errMsg||"添加套餐失败!","W");
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
                showMsg(errMsg||"添加工时信息失败!","W");
                return;
            }
        });
    }
}
function checkPrdt(data){
    var main = billForm.getData();
    if(!main.id){
        showMsg("请先保存工单!","E");
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
                return "此工时已经添加!";
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
            return "此工时已经添加!";
        }
    }else if(type == 3){
        var rs = checkFromBillPart(rtnRow);
        if(rs){
            return "此配件已经添加!";
        }
    }
}
function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}
function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}
/*function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}*/
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
            showMsg(errMsg||"删除套餐信息失败!","W");
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
            showMsg(errMsg||"删除工时信息失败!","W");
            return;
        }
    });
}
function deletePartRow(row_uid){
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
            showMsg(errMsg||"删除配件信息失败!","W");
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
    cardTimesGrid.clearRows();
    doSearchMemCard(fguestId);
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
            showMsg("本单已完工,不能修改!","W");
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
            showMsg("本单已完工,不能修改!","W");
            advancedPkgRateSetWin.hide();
            return;
        }else{
            var isSettle = data.isSettle||0;
            if(isSettle == 1){
                showMsg("本工单已经结算,不能修改!","W");
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
                    showMsg(errMsg||"批量修改优惠率失败!!","W");
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
            showMsg("本单已完工,不能修改!","W");
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
            showMsg("本单已完工,不能修改!","W");
            advancedItemPartRateSetWin.hide();
            return;
        }else{
            var isSettle = data.isSettle||0;
            if(isSettle == 1){
                showMsg("本工单已经结算,不能修改!","W");
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
                    showMsg(errMsg||"批量修改优惠率失败!!","W");
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
    //var row = rpsPartGrid.getSelected();
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
                showMsg(errMsg||"添加预存信息失败!","W");
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
   /* if(p3 && p3.interType){
        getBillDetail(p3, function(text){
        }, function(){});
    }*/
}
var __workerIds="";
var __saleManId="";
function editRpsPackage(row_uid){
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
                        loadDetail(p1, {}, {});
                        rpsPackageGrid.reject();
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
                item.amt = row.amt;
                item.subtotal = row.subtotal;
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
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}

function editItemRpsPart(row_uid){
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
function updateItemRpsPart(row_uid){
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
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}

function chooseItem(){
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("本工单已完工,不能添加工时!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加工时!","S");
        return;
    }

    doSelectItem(addToBillItem, delFromBillItem, checkFromBillItem, function(text){
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
        showMsg("请选择保存套餐!","S");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("本工单已完工,不能添加套餐!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加套餐!","S");
        return;
    }
                                                       
    doSelectPackage(addToBillPackage, delFromBillPackage, checkFromBillPackage, function(text){
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
            showMsg(errMsg||"添加套餐失败!","W");
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
            showMsg(errMsg||"删除套餐信息失败!","W");
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
            showMsg(errMsg||"添加工时失败!","W");
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
            showMsg(errMsg||"删除工时信息失败!","W");
            return;
        }
    });
}



function checkFromBillItem(data){
    var itemId= data.id;
    var rows = rpsItemGrid.findRows(function(row){
        if(row && row.prdtId == itemId){
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
        if(row && row.prdtId == partId){
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
    advancedMorePartWin.showAtEl(atEl, {xAlign:"right",yAlign:"above"});
   	
}
//配件
function choosePart(){
    //var row = rpsItemGrid.getRowByUID(row_uid);
    //获取到工时中的ID
    var row = FItemRow||{};
    var itemId = null;
    if(row){
    	itemId = row.id;
    }else{
        return;
    }
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("本工单已完工,不能添加配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加配件!","S");
        return;
    }
    advancedMorePartWin.hide();
    doSelectPart(itemId,addToBillPart, delFromBillPart, null, function(text){
        var p1 = { };
        var p2 = {
            interType: "item",
            data:{
                serviceId: main.id||0
            }
        };
        var p3 = {};
        /*var p2 = { };
        var p3 = {
			 interType: "part",
	         data:{
	             serviceId: main.id||0
	         }
        };*/
        
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
        cardDetailId:0
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
            showMsg(errMsg||"添加配件失败!","W");
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
            showMsg(errMsg||"删除配件信息失败!","W");
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

function showHealth(){
	showCarCheckInfo();
}

function showCarCheckInfo(){
    if(!fguestId || carCheckInfo.visible) {
        advancedMemCardWin.hide();
        carCheckInfo.hide();
        advancedCardTimesWin.hide();
        return;
    }

    var atEl = document.getElementById("carHealthEl");  
    carCheckInfo.showAtEl(atEl, {xAlign:"left",yAlign:"below"});
    advancedCardTimesWin.hide();
    advancedMemCardWin.hide();
    MemSelectCancel(1);
    SearchCheckMain(changeCheckInfoTab);
}

function pay(){
	
	var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","W");
        return;
    }else{
        if(data.status != 2){
            showMsg("本工单未完工,不能结算!","W");
            return;
        }
        var params = {
            serviceId:data.id||0,
            data:data
        };
        doBillPay(params, function(data){
            data = data||{};
            if(data.action){
                var action = data.action||"";
                if(action == 'ok'){
                    billForm.setData([]);
                    billForm.setData(data);
                    var status = data.status||0;
                    var isSettle = data.isSettle||0;
                    doSetStyle(status, isSettle);
                    showMsg("完工成功!","S");
                }else{
                    if(data.errCode){
                        showMsg("完工失败!","W");
                        return;
                    }
                }
            }
        });
    }
}

function showBasicData(type){
    var maintain = billForm.getData();
    var isSettle = maintain.isSettle||0;
    var BasicDataUrl = null;
    var title = null;
    if(!maintain.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能录入!","S");
        return;
    }
    var carVin = billForm.carVin;
    var params = {
        vin:carVin,
        serviceId:maintain.id
    };
    if(type=="pkg"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPkg.flow?token=";
    	title = "标准套餐查询";
    }
    if(type=="item"){
    	BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryItem.flow?token=";
    	title = "标准工时查询";
    }
    
    
    //添加回调函数，进行显示
    doSelectBasicData(BasicDataUrl,title,params,function(p1,p2,p3){
       /* var p1 = { }
        var p2 = {
            interType: "item",
            data:{
                serviceId: main.id||0
            }
        };
        var p3 = {};*/
        loadDetail(p1, p2, p3);
    });
}

function showBasicDataPart(){
    var row = FItemRow;//rpsItemGrid.getRowByUID(row_uid);
	//获取到工时中的ID,不确定是否是这个字段,把工时ID传到添加配件的页面中,考虑能不能直接在本页面把ID传到addToBillPart函数中
    var itemId = null;
    if(row){
   	 itemId = row.id;
    }else{
        return;
    }
    var main = billForm.getData();
    var isSettle = main.isSettle||0;
    if(!main.id){
        showMsg("请选择保存工单!","S");
        return;
    }
    var status = main.status||0;
    if(status == 2){
        showMsg("本工单已完工,不能添加配件!","W");
        return;
    }
    if(isSettle == 1){
        showMsg("此单已结算,不能添加配件!","S");
        return;
    }  
    var BasicDataUrl = "/com.hsweb.RepairBusiness.ProductEntryPart.flow?token=";
    var title = "标准配件查询";
    //添加回调函数，进行显示
    doSelectBasicData(BasicDataUrl,title,params,function(p1,p2,p3){
        loadDetail(p1, p2, p3);
    });
   
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
				editor2.setValue(packageDiscountRate);
				var amt = row.amt||0;
				var subtotal = 0;
			    if(amt>0){
			    	subtotal = amt - packageDiscountRate*1.0*amt;
				    subtotal = subtotal.toFixed(2);
			    }
			    editor1.setValue(subtotal);
			    lastPkgRate = packageDiscountRate;
			    lastPkgSubtotal = subtotal;
				
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
		//设置工时总金额
		if(unitPrice>0 && itemTime>0){
		   itamt = itemTime*unitPrice;
		   itamt = itamt.toFixed(2);
		   row.amt = itamt;
		}
		//设置小计金额
		var rate = 0;
	    if(itamt>0){
	    	rate = (itamt - subtotal)*1.0/itamt;
	    } 
	    rate = rate * 100;
		rate = rate.toFixed(2);    
	    setRate.setValue(rate);
	    setSubtotal.setValue(subtotal);
	    lastItemSubtotal = subtotal;
	    lastItemRate = rate;
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
				setRate.setValue(itemDiscountRate);
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
			    setSubtotal.setValue(subtotal);
			    lastItemSubtotal = subtotal;
			    lastItemRate = itemDiscountRate;
				
			} else {
				//showMsg("出库失败");
			}			
		}
	});
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
		  for (var i = 0; i < rows.length; i++)
		  {
			  if(rows[i].billPackageId=="0"){
				  sumPkgSubtotal += parseFloat(rows[i].subtotal);
				  sumPkgAmt  += parseFloat(rows[i].amt);
			  }
		  }
	  } 
	  if(sumPkgAmt>0 && sumPkgSubtotal>=0)
	  {   sumPkgPrefAmt = sumPkgAmt - sumPkgSubtotal;
		  sumPkgSubtotal = sumPkgSubtotal.toFixed(2);
		  sumPkgPrefAmt = sumPkgPrefAmt.toFixed(2);
		  
		  data.packageSubtotal = sumPkgSubtotal;
		  data.packagePrefAmt = sumPkgPrefAmt;
		  var mtAmt = parseFloat(data.packageSubtotal)+parseFloat(data.itemSubtotal)+parseFloat(data.partSubtotal);
		  data.mtAmt = mtAmt.toFixed(2);
		  sellForm.setData(data);
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
		  for (var i = 0; i < rows.length; i++)
		  {
			 if(rows[i].billItemId=="0"){
				 sumItemSubtotal += parseFloat(rows[i].subtotal);
				 sumItemAmt  += parseFloat(rows[i].amt); 
			 }else{
				 sumPartSubtotal += parseFloat(rows[i].subtotal);
				 sumPartAmt  += parseFloat(rows[i].amt); 
			 }
			   
		  }
	  } 
	  if( sumItemSubtotal>0 && sumItemAmt>=0  )
	  {   
		  sumItemPrefAmt = sumItemAmt - sumItemSubtotal;
		  sumItemSubtotal = sumItemSubtotal.toFixed(2);
		  sumItemPrefAmt = sumItemPrefAmt.toFixed(2);
		  data.itemSubtotal = sumItemSubtotal;
		  data.itemPrefAmt = sumItemPrefAmt;
		  var mtAmt = parseFloat(data.itemSubtotal)+parseFloat(data.packageSubtotal)+parseFloat(data.partSubtotal);
		  data.mtAmt = mtAmt.toFixed(2);
		  sellForm.setData(data);
	  }
	  if(sumPartSubtotal>0 && sumPartAmt>=0)
	  {   
		  sumPartPrefAmt = sumPartAmt - sumPartSubtotal;
		  sumPartSubtotal = sumPartSubtotal.toFixed(2);
		  sumPartPrefAmt = sumPartPrefAmt.toFixed(2);
		  data.partSubtotal = sumPartSubtotal;
		  data.partPrefAmt = sumPartPrefAmt;
		  var mtAmt = parseFloat(data.itemSubtotal)+parseFloat(data.packageSubtotal)+parseFloat(data.partSubtotal);
		  data.mtAmt = mtAmt.toFixed(2);
		  sellForm.setData(data);
	  }  
}

function addExpenseAccount(){
	var data = billForm.getData();
	var data1 = sendGuestForm.getData();
	if(data.id){
		var item={};
		item.id = "123321";
	    item.text = "报销单";
		item.url =webBaseUrl+  "com.hsweb.print.ExpenseAccount.flow?sourceServiceId="+data.id;
		item.iconCls = "fa fa-cog";
		data.guestTel = $("#guestTelEl").text();
		data.guestName = $("#guestNameEl").text();
		data.contactorTel = data1.mobile;
		data.serviceCode = $("#servieIdEl").text();
		window.parent.activeTabAndInit(item,data);
	}else{
		showMsg("请先保存后再进行操作!","W");
	}
}

function newCheckMain() {  
    var data = billForm.getData();
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "查车单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkDetail.jsp";
    item.iconCls = "fa fa-cog";
    //window.parent.activeTab(item);
    var params = {};
    params = { 
        id:data.id,
        row: rdata
    };

    window.parent.activeTabAndInit(item,params);
    carCheckInfo.hide();
}  


function MemSelectOk(){ 
    var form = new nui.Form("#show2");
    form.validate();
    if (form.isValid() == false) {
        showMsg("请先选择派工人！","W");
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
        showMsg("请先保存工单!","E");
        return;
    }

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
        if(detailList.checkMan && detailList.checkStatus == 0){
            $("#checkStatus2").css("color","#32b400");
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show();

        }
        if(detailList.checkMan && detailList.checkStatus == 1){
            $("#checkStatus3").css("color","#32b400");
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show();
        }
        if(detailList.checkMan && detailList.checkStatus == 2){ 
            $("#checkStatus4").css("color","#32b400");   
            $("#checkStatusButton1").hide();
            $("#checkStatusButton2").show(); 
        }
    }

    
}

function SaveCheckMain() {
    var data = billForm.getData();
    if(!data.id){
        showMsg("请先保存工单!","E");
        return;
    }
    if(isRecord == "0"){
        var temp ={
            serviceId:data.id, 
            carId:data.carId,
            carNo:data.carNo,
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