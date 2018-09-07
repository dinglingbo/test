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

var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var packageDetailGrid = null;
var packageDetailGridForm = null;

var advancedCardTimesWin = null;
var cardTimesGrid = null;
var advancedMemCardWin = null;
var memCardGrid = null;

var fserviceId = 0;
var fguestId = 0;
var fcarId = 0;
var mpackageRate = 0;
var mitemRate = 0;
var mpartRate = 0;
var x = 0;
var y = 0;

var prdtTypeHash = {
    "1":"套餐",
    "2":"工时",
    "3":"配件"
};

$(document).ready(function ()
{
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");
    rpsPartGrid = nui.get("rpsPartGrid");

    billForm = new nui.Form("#billForm");
    advancedCardTimesWin = nui.get("advancedCardTimesWin");
    cardTimesGrid = nui.get("cardTimesGrid");
    cardTimesGrid.setUrl(cardTimesGridUrl);
    advancedMemCardWin = nui.get("advancedMemCardWin");
    memCardGrid = nui.get("memCardGrid");
    memCardGrid.setUrl(memCardGridUrl);

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
                carNo: carNo,
                isSettle: 0,
                orgid: currOrgId
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
    // initCustomDicts("receTypeId", "0415",function(data) {
    //     receTypeIdList = nui.get("receTypeId").getData();
    //     receTypeIdList.forEach(function(v) {
    //         receTypeIdHash[v.customid] = v;
    //     });
    // });

    // mainGrid.on("drawcell", function (e) {
    //     if (e.field == "status") {
    //         e.cellHtml = statusHash[e.value];
    //     }else if (e.field == "carBrandId") {
    //         if (brandHash && brandHash[e.value]) {
    //             e.cellHtml = brandHash[e.value].name;
    //         }
    //     }else if (e.field == "serviceTypeId") {
    //         if (servieTypeHash && servieTypeHash[e.value]) {
    //             e.cellHtml = servieTypeHash[e.value].name;
    //         }
    //     }
    // });

    // innerItemGrid.on("drawcell", function (e) {
    //     if (e.field == "receTypeId") {
    //         //e.cellHtml = receTypeIdHash[e.value].name;
    //     }
    // });
    // innerPartGrid.on("drawcell", function (e) {
    //     if (e.field == "receTypeId") {
    //         //e.cellHtml = receTypeIdHash[e.value].name;
    //     }
    // });

    //add();
    rpsPackageGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "prdtName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "(预存)";
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
            case "serviceTypeId":
                if(servieTypeHash[e.value])
                {
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value){
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

        switch (e.field) {
            case "itemName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "(预存)";
                }
                break;
            case "itemOptBtn":
                var s = '<a class="optbtn" href="javascript:editRpsItem(\'' + uid + '\')">修改</a>'
                        + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';

                if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:updateRpsItem(\'' + uid + '\')">确定</a>'
                        + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';
                }

                //e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                //            '<span class="fa fa-plus" onClick="javascript:addItemNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                //            ' <span class="fa fa-close" onClick="javascript:deleteItemRow()" title="删除行"></span>';
                e.cellHtml = s
                break;
            default:
                break;
        }
    });
    rpsPartGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "partName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "(预存)";
                }
                break;
            case "partOptBtn":
                var s = '<a class="optbtn" href="javascript:editRpsPart(\'' + uid + '\')">修改</a>'
                        + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';

                if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:updateRpsPart(\'' + uid + '\')">确定</a>'
                        + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';
                }
                e.cellHtml = s;
                //e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                            //'<span class="fa fa-plus" onClick="javascript:addPartNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                            //' <span class="fa fa-close" onClick="javascript:deletePartRow()" title="删除行"></span>';
                break;
            case "receTypeId":
                if (receTypeIdHash && receTypeIdHash[e.value]) {
                    e.cellHtml = receTypeIdHash[e.value].name;
                }
            default:
                break;
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

    mpackageRate = 0;
    mitemRate = 0;
    mpartRate = 0;

    billForm.setData(maintain);

    fguestId = car.guestId||0;
    fcarId = car.id||0;

    doSearchCardTimes(fguestId);
    doSearchMemCard(fguestId);
    
    $("#guestNameEl").html(car.guestFullName);
    $("#showCarInfoEl").html(car.carNo);
    $("#guestTelEl").html(car.guestMobile);
}
function setInitData(params){
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
                        data.mobile = contactor.mobile;

                        $("#guestNameEl").html(guest.guestFullName);
                        $("#showCarInfoEl").html(data.carNo);
                        $("#guestTelEl").html(guest.mobile);

                        fguestId = data.guestId||0;
                        fcarId = data.carId||0;

                        doSearchCardTimes(fguestId);
                        doSearchMemCard(fguestId);
    
                        billForm.setData(data);

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
    rpsPartGrid.clearRows();
    billForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    fguestId = 0;
    fcarId = 0;

    document.getElementById("formIframe").contentWindow.doSetCardTimes([]);
    $("#servieIdEl").html("");
    $("#showCardTimesEl").html("次卡套餐(0)");
    $("#showCardEl").html("储值卡(0)");
    $("#showCarInfoEl").html("");
    $("#guestNameEl").html("");
    $("#guestTelEl").html("");

}
function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    saveMaintain(function(data){
 
        if(data.id){
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
    data.billTypeId = 2;

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
    if(!fguestId){
        showMsg("请先保存工单!","E");
        return;
    }
    var type = data.type||-1;
    var rtnRow = data.rtnRow||{};
    var row = {};
    rpsPackageGrid.addRow(row);
    //rpsItemGrid.addRow(row);
    //rpsPartGrid.addRow(row);
}
function checkPrdt(data){
    if(!fguestId){
        showMsg("请先保存工单!","E");
        return;
    }
    var type = data.type||-1;
    var rtnRow = data.rtnRow||{};
    if(type == 0){

    }else if(type == 1){

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
function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}
function deletePackRow(row_uid){
    var data = rpsPackageGrid.getData();
    var row = rpsPackageGrid.getRowByUID(row_uid);
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
                if(row.prdtId == row.prdtId || row.pid == row.prdtID){
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
            if(data && data.length==1){
                rpsItemGrid.removeRow(data[0]);
                //var newRow = {};
                //rpsPartGrid.addRow(newRow);
            }else{
                rpsItemGrid.removeRow(row);
            }
        }else{
            showMsg(errMsg||"删除工时信息失败!","W");
            return;
        }
    });
}
function deletePartRow(row_uid){
    var data = rpsPartGrid.getData();
    var row = rpsPartGrid.getRowByUID(row_uid);
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
                rpsPartGrid.removeRow(data[0]);
                //var newRow = {};
                //rpsPartGrid.addRow(newRow);
            }else{
                rpsPartGrid.removeRow(row);
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
function showHealth(){
    window.open("http://www.baidu.com?backurl="+window.location.href); 
}
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
    var newRow = {workerIds:workerIds};
    rpsItemGrid.updateRow(row, newRow);
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
    rpsItemGrid.updateRow(row, newRow);
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
    var row = rpsPartGrid.getSelected();
    var newRow = {saleManId:saleManId};
    rpsPartGrid.updateRow(row, newRow);
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
                        }else if(interType == 'part'){
                            rpsPartGrid.clearRows();
                            rpsPartGrid.addRows(data);
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
    if(p3 && p3.interType){
        getBillDetail(p3, function(text){
            var errCode = text.errCode;
            var data = text.data||[];
            if(errCode == "S"){
                rpsPartGrid.clearRows();
                rpsPartGrid.addRows(data);
                rpsPartGrid.accept();
            }
        }, function(){});
    }

}
var __workerIds="";
var __saleManId="";
function editRpsPackage(row_uid){
    var row = rpsPackageGrid.getRowByUID(row_uid);
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
            var pkg = {
                serviceId:row.serviceId
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
                    }
                }else{
                    showMsg(errMsg||"修改数据失败!","W");
                    return;
                }
            });
        }
    }
}