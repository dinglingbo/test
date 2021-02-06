/**
 * Created by Administrator on 2018/4/10.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.query.queryMtHistoryList.biz.ext";
var guestId={};
$(document).ready(function (v)
{
    //setData({
    //    contactorId:1
    //});
	
	//init();
});
var basicInfoForm = null;
var guestInfoForm = null;
var serviceTypeIdEl = null;
function init(callback)
{
	//车辆维修信息
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    //客户基本信息
    guestInfoForm = new nui.Form("#guestInfoForm");
    guestInfoForm.setEnabled(false);
    //左邊表格
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    //不知道在那個地方
    leftGrid.on("drawcell",onDrawCell);
    //行双击时发生
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        onRowDblClick(e);
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            onRowDblClick({
                record:row
            });
        }
    });

    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initRoleMembers','getDatadictionaries',"initDicts","initComp","initCarBrand"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        //不懂
        nui.unmask();
        callback && callback();
    };
    initRoleMembers({
        mtAdvisorId:"010802"
    },function(){
        hash.initRoleMembers = true;
        checkComplete();
    });
    initDicts({
        identity:"DDT20130703000077",//客户身份
        receType1:"DDT20130706000013",//收费类型
        receType2:"DDT20130706000014"//免费类型
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    var pId = "DDT20130703000055";//业务类型
    serviceTypeIdEl = nui.get("serviceTypeId");
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        serviceTypeIdEl.setData(list);
        var pId2 = "DDT20130703000057";//工种
        getDatadictionaries(pId2, function (data) {
            data = data || {};
            var list = data.list || [];
            hash.getDatadictionaries = true;
            checkComplete();
        });
    });
    initComp("orgId",function(){
        hash.initComp = true;
        checkComplete();
    });
    initCarBrand("carBrandId",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
    serviceTypeIdEl.on("valuechanged", function (data)
    {
        var serviceTypeId = serviceTypeIdEl.getValue();
        var list = serviceTypeIdEl.getData();
        for(var i=0;i<list.length;i++)
        {
        	if(list[i].customid == serviceTypeId)
            {
                var mtTypeEl = nui.get("mtType");
                initDicts({
                    mtType:list[i].id
                });
                break;
            }
        }
    });
}

function getGuestInfoByContactorId(contactorId,callback)
{
    var url = baseUrl + "com.hsapi.repair.repairService.query.getGuestInfoByContactorId.biz.ext";
    doPost({
        url:url,
        data:{
            contactorId:contactorId
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
function setData(data)
{
	init(function(){
//		var params={};
//		params.guestId="";
        data = data||{};
//        params.guestId = data.guestId;
        var params = {
        		guestId: data.guestId
            };
        doSearch(params);
    });
}


function onRowDblClick(e)
{
    var row = e.record;
   
    loadRpsItemQuoteData(row);
    loadRpsPartQuoteData(row);
    loadRpsPartData(row);
    loadRpsItemData(row);
    loadRpsItemBillData(row);
    loadRpsPartBillData(row);
    loadAuxiliaryGridData(row);
    getMaintainById(row.id);
    getGuestInfoByContactorId(row.contactorId,function(data){
        data = data||{};
        var guest = data.guest||{};
        guestInfoForm.setData(guest);
    });
}

function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}
var statusHash2 = ["在报价", "在维修"];
var rpsItemQuoteGrid = null;
function loadRpsItemQuoteData(row) {
    if (!rpsItemQuoteGrid) {
     //估算项目/材料
        rpsItemQuoteGrid = nui.get("rpsItemQuoteGrid");
        rpsItemQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
        rpsItemQuoteGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemQuoteGrid.load({
        token:token,
        params: params
    });
}

var rpsPartQuoteGrid = null;
function loadRpsPartQuoteData(row) {
    if (!rpsPartQuoteGrid) {
        rpsPartQuoteGrid = nui.get("rpsPartQuoteGrid");
        rpsPartQuoteGrid.on("drawcell", function (e) {
            if (e.field == "status") {
                e.cellHtml = statusHash2[e.value];
            }
            else{
                onDrawCell(e);
            }
        });
        var rpsPartQuoteGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartQuoteByServiceId.biz.ext";
        rpsPartQuoteGrid.setUrl(rpsPartQuoteGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartQuoteGrid.load({
        token:token,
        params: params
    });
}
var rpsItemGrid = null;
function loadRpsItemData(row) {
    if (!rpsItemGrid) {
        rpsItemGrid = nui.get("rpsItemGrid");
        rpsItemGrid.on("drawcell",onDrawCell);
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";
        rpsItemGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
var rpsPartGrid = null;
function loadRpsPartData(row) {
    if (!rpsPartGrid) {
        rpsPartGrid = nui.get("rpsPartGrid");
        rpsPartGrid.on("drawcell",onDrawCell);
        var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
        rpsPartGrid.setUrl(rpsItemGridUrl);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartGrid.load({
        token:token,
        params: params
    });
}
var rpsItemBillGrid = null;
function loadRpsItemBillData(row)
{
    if(!rpsItemBillGrid)
    {
        rpsItemBillGrid = nui.get("rpsItemBillGrid");
        rpsItemBillGrid.on("drawcell",onDrawCell);
        var url = baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemBillByServiceId.biz.ext";
        rpsItemBillGrid.setUrl(url);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsItemBillGrid.load({
        token:token,
        params: params
    });
}
var rpsPartBillGrid = null;
function loadRpsPartBillData(row) {
    if (!rpsPartBillGrid) {
        rpsPartBillGrid = nui.get("rpsPartBillGrid");
        rpsPartBillGrid.on("drawcell",onDrawCell);
        var url = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartBillByServiceId.biz.ext";
        rpsPartBillGrid.setUrl(url);
    }
    if (!row.id) {
        return;
    }
    var params = {
        serviceId: row.id
    };
    rpsPartBillGrid.load({
        token:token,
        params: params
    });
}
function getMaintainById(id) {
    var getMaintainByIdUrl = baseUrl + "com.hsapi.repair.repairService.svr.getMaintainById.biz.ext";
    nui.mask({
        html: '数据加载中..'
    });
    doPost({
        url: getMaintainByIdUrl,
        data: {
            id: id
        },
        success: function (data) {
            nui.unmask();
            data = data || {};
            var maintain = data.maintain;
            if(!maintain)
            {
                return;
            }
            basicInfoForm.setData(maintain);
            serviceTypeIdEl.doValueChanged();
            nui.get("drawOutReport").setValue(maintain.drawOutReport);
            nui.get("guestDesc").setValue(maintain.guestDesc);
            nui.get("faultPhen").setValue(maintain.faultPhen);
            nui.get("solveMethod").setValue(maintain.solveMethod);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
var auxiliaryGrid = null;
function loadAuxiliaryGridData(maintain)
{
    if(!auxiliaryGrid)
    {
        auxiliaryGrid = nui.get("auxiliaryGrid");
        var url = window._rootPartUrl + "com.hsapi.part.purchase.repair.getRepairOutByServiceId.biz.ext";
        auxiliaryGrid.setUrl(url);
    }
    if (!maintain.id) {
        return;
    }
    var params = {
        pickType: "050210"
    };
    auxiliaryGrid.load({
        token:token,
        serviceId: maintain.id,
        params: params
    });
}