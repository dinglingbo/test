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
            var sk = document.getElementById("search_key");
            sk.style.display = "none";

            searchNameEl.setVisible(true);

            var carNo = item.carNo||"";
            var tel = item.guestMobile||"";
            var guestName = item.guestFullName||"";
            var carVin = item.vin||"";
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
            case "packageOptBtn":
                var s = '<a class="optbtn" href="javascript:newRow()">修改</a>'
                        + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';

                if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:newRow()">确定</a>'
                        + ' <a class="optbtn" href="javascript:deletePackRow(\'' + uid + '\')">删除</a>';
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
    rpsItemGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;

        switch (e.field) {
            case "itemOptBtn":
                var s = '<a class="optbtn" href="javascript:newRow()">修改</a>'
                        + ' <a class="optbtn" href="javascript:deleteItemRow(\'' + uid + '\')">删除</a>';

                if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:newRow()">确定</a>'
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
            case "partOptBtn":
                var s = '<a class="optbtn" href="javascript:newRow()">修改</a>'
                        + ' <a class="optbtn" href="javascript:deletePartRow(\'' + uid + '\')">删除</a>';

                if (grid.isEditingRow(record)) {
                    s = '<a class="optbtn" href="javascript:newRow()">确定</a>'
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
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title:"新增客户资料",
        width:500,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {
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
    $("#guestTelEl").html(car.mobile);
}
function selectCustomer(callback) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.Customer.flow?token="+token,
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}
function setInitData(params){
    if(!params.id){
        add();
    }else{
        showMsg("加载");
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
        billForm.setData(data);
        showMsg("保存成功!");

        if(data.id){
            $("#servieIdEl").html(data.serviceCode);
            var carNo = data.carNo||"";
            var tel = nui.get("mobile").getValue()||"";
            var guestName = nui.get("guestFullName").getValue()||"";
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
function deletePackRow(){
    var data = rpsPackageGrid.getData();
    if(data && data.length==1){
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
        var newRow = {};
        rpsPackageGrid.addRow(newRow);
    }else{
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
    }
}
function deleteItemRow(row_uid){
    var data = rpsItemGrid.getData();
    var row = rpsItemGrid.getRowByUID(row_uid);
    if(data && data.length==1){
        rpsItemGrid.removeRow(data[0]);
        var newRow = {};
        rpsItemGrid.addRow(newRow);
    }else{
        rpsItemGrid.removeRow(row);
    }
}
function deletePartRow(){
    var data = rpsPartGrid.getData();
    if(data && data.length==1){
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
        var newRow = {};
        rpsPartGrid.addRow(newRow);
    }else{
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
    }
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
    var title = "新增客户资料";
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title: title, width: 560, height: 570,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
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
        }
    });
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
        for(var i=i; i<rows.length; i++){
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
    rpsPackageGrid.updateRow(row, newRow);
}