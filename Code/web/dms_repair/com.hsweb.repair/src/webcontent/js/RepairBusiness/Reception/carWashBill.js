/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";

var billForm = null;

var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var serviceTypeIdEl = null;
var mtAdvisorIdEl = null;
var searchNameEl = null;
var servieIdEl = null;

var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var packageDetailGrid = null;
var packageDetailGridForm = null;

var fguestId = 0;
var fcarId = 0;
var mpackageRate = 0;
var mitemRate = 0;
var mpartRate = 0;

$(document).ready(function ()
{
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");
    rpsPartGrid = nui.get("rpsPartGrid");

    billForm = new nui.Form("#billForm");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    searchNameEl = nui.get("search_name");
    servieIdEl = nui.get("servieIdEl");
    
    // innerItemGrid = nui.get("innerItemGrid");
    // innerPartGrid = nui.get("innerPartGrid");
    // innerItemGrid.setUrl(itemGridUrl);
    // innerPartGrid.setUrl(partGridUrl);

    // beginDateEl.setValue(getMonthStartDate());
    // endDateEl.setValue(addDate(getMonthEndDate(), 1));

    document.getElementById("formIframe").src=webPath + contextPath + "/repair/common/pipSelect.jsp";

    initMember("mtAdvisorId",null);
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

    add();
    rpsPackageGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "packageOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPackNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePackRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsItemGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "itemOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addItemNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deleteItemRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsPartGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "partOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPartNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePartRow()" title="删除行"></span>';
                    break;
            case "receTypeId":
                if (receTypeIdHash && receTypeIdHash[e.value]) {
                    e.cellHtml = receTypeIdHash[e.value].name;
                }
            default:
                break;
        }
    });   
    //doSearch(p);
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

        mpackageRate = 0;
        mitemRate = 0;
        mpartRate = 0;

        billForm.setData(maintain);

        fguestId = car.guestId||0;
        fcarId = car.id||0;

    });
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
    searchNameEl.setEnabled(true);
    searchNameEl.setText("");

    rpsPackageGrid.setData([]);
    rpsItemGrid.setData([]);
    rpsPartGrid.setData([]);
    billForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
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
            var tel = data.carNo||"";
            var guestName = data.carNo||"";
            var carVin = data.carVin||"";
            if(tel){
                tel += "/"+tel;
            }
            if(guestName){
                guestName += "/"+guestName;
            }
            if(carVin){
                carVin += "/"+carVin;
            }
            var t = carNo + tel + guestName + carVin;
            searchNameEl.setText(t);
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
function addPrdt(){
    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
}
function checkPrdt(){
    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
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
function deleteItemRow(){
    var data = rpsItemGrid.getData();
    if(data && data.length==1){
        var row = rpsItemGrid.getSelected();
        rpsItemGrid.removeRow(row);
        var newRow = {};
        rpsItemGrid.addRow(newRow);
    }else{
        var row = rpsItemGrid.getSelected();
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