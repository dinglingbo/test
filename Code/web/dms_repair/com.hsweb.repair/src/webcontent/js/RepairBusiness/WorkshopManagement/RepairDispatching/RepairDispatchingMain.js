/**
 * Created by Administrator on 2018/3/28.
 */
window._rootPartUrl = "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var statusHash = ["", "在报价", "在维修","已完工"];
var rpsItemGrid = null;
var rpsItemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemByServiceId.biz.ext";

$(document).ready(function (v)
{

    rpsItemGrid = nui.get("itemGrid");
    rpsItemGrid.on("beforeload",function(e){
        e.data.token = "";
    });
    rpsItemGrid.on("load",function(e){
        itemKindEl.doValueChanged();
    });
    rpsItemGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value+1];
        }
    });
    rpsItemGrid.setUrl(rpsItemGridUrl);

    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
    });
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        getMaintainById(row.id);
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            getMaintainById(row.id);
        }
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    init(function () {
        onSearch();
    });
});
var mtType = [];
var mtTypeHash = {};
var serviceTypeIdHash = {};
var serviceTypeIdEl = null;
var mtTypeEl = null;
var teamEl = null;
var teamMemberEl = null;
var teamMemberList = [];
var itemKindEl = null;
var teamList = [];
function init(callback)
{
    itemKindEl = nui.get("itemKind");
    itemKindEl.on("valuechanged",function()
    {
        var selectUnDispatchingOnly = false;
        var ck1Value = nui.get("ck1").getValue();
        if(ck1Value == 1)
        {
            selectUnDispatchingOnly = true;
        }
        var type = itemKindEl.getValue();
        var list = teamList;
        rpsItemGrid.deselectAll();
        if(type != "all")
        {
            list = teamList.filter(function(v){
                return v.type == type;
            });
            var rows = rpsItemGrid.findRows(function(row)
            {
                if(selectUnDispatchingOnly)
                {
                    if(row.beginDate)
                    {
                        return false;
                    }
                }
                return row.itemKind == type;
            });
            rpsItemGrid.selects(rows);
        }
        else
        {
            if(selectUnDispatchingOnly)
            {
                var rows1 = rpsItemGrid.findRows(function(row)
                {
                    return !row.beginDate;
                });
                rpsItemGrid.selects(rows1);
            }
            else{
                rpsItemGrid.selectAll();
            }
        }
        teamEl.setData(list);
        if(list.length>0)
        {
            teamEl.setValue(list[0].id);
        }
        teamEl.doValueChanged();

    });
    teamEl = nui.get("team");
    teamMemberEl = nui.get("teamMember");
    teamEl.on("valuechanged",function()
    {
        var classId = teamEl.getValue();
        var members = teamMemberList.filter(function(v){
            return v.classId == classId;
        });
        teamMemberEl.setData(members);
        if(members.length>0)
        {
            teamMemberEl.setValue(members[0].emplId);
        }
    });
    var ck1 = nui.get("ck1");
    ck1.on("valuechanged",function(){
        itemKindEl.doValueChanged();
    });

    serviceTypeIdEl = nui.get("serviceTypeId");
    mtTypeEl = nui.get("mtType");
    serviceTypeIdEl.on("valuechanged", function (data) {
        var serviceTypeId = serviceTypeIdEl.getValue();
        if(serviceTypeIdHash[serviceTypeId])
        {
            var id = serviceTypeIdHash[serviceTypeId].id;
            if (mtTypeHash[id]) {
                mtTypeEl.setData(mtTypeHash[id]);
            }
            else {
                var dictIdList = [];
                dictIdList.push(id);
                getDictItems(dictIdList, function (data) {
                    data = data || {};
                    var itemList = data.dataItems || [];
                    mtTypeHash[id] = itemList;
                    mtTypeEl.setData(mtTypeHash[id]);
                });
            }
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDatadictionaries', 'getDictItems','getAllCarBrand','getTeamByTypeList'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var pId = "DDT20130703000055";
    getDatadictionaries(pId, function (data) {
        data = data || {};
        var list = data.list || [];
        list.forEach(function (v) {
            serviceTypeIdHash[v.customid] = v;
        });
        serviceTypeIdEl.setData(list);
        hash.getDatadictionaries = true;
        checkComplete();
    });
    var dictIdList = [];
    dictIdList.push("DDT20130703000051");//进厂油量
    getDictItems(dictIdList, function (data) {
        data = data || {};
        var itemList = data.dataItems || [];
        var enterOilMassList = itemList.filter(function (v) {
            return "DDT20130703000051" == v.dictid;
        });
        nui.get("enterOilMass").setData(enterOilMassList);

        hash.getDictItems = true;
        checkComplete();
    });
    getAllCarBrand(function(data)
    {
        data = data||[];
        var carBrandList = data.carBrands||[];
        nui.get("carBrand").setData(carBrandList);
        hash.getAllCarBrand = true;
        checkComplete();
    });

    var typeList = [];
    typeList.push("040701");//  机电
    typeList.push('040702');//钣金
    typeList.push('040703');//喷漆
    getTeamByTypeList(typeList,function(data)
    {
        data = data||{};
        var list = data.list;
        var idList = list.map(function(v){
            return v.id;
        });
        teamEl.setData(list);
        teamList = list;
        getTeamMemberByTeamIdList(idList,function(data){
            data = data||{};
            var list = data.list;
            teamMemberEl.setData(list);
            teamMemberList = list;
            if(teamList.length>0)
            {
                teamEl.setValue(teamList[0].id);
                teamEl.doValueChanged();
            }
            hash.getTeamByTypeList = true;
            checkComplete();
        });
    });
}
function getMaintainById(id)
{
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
            basicInfoForm.setData(maintain);
            serviceTypeIdEl.doValueChanged();
            loadRpsItemData();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
function reloadLeftGrid()
{
    leftGrid.reload();
}

function getSearchParams()
{
    var params = {};
    params.carNo = nui.get("carNo-search").getValue();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}
function loadRpsItemData()
{
    var maintain = basicInfoForm.getData();
    if (!maintain.id) {
        return;
    }
    var params = {
        serviceId: maintain.id
    };
    rpsItemGrid.load({
        token:token,
        params: params
    });
}
//派工
function dispatching()
{
    var classId = teamEl.getValue();
    var classObj = null;
    for(var i=0;i<teamList.length;i++)
    {
        var tmp = teamList[i];
        if(tmp.id == classId)
        {
            classObj = tmp;
            break;
        }
    }
    if(!classObj)
    {
        nui.alert("请选择维修班组");
    }
    var workerId = teamMemberEl.getValue();
    if(!workerId)
    {
        nui.alert("请选择维修人");
    }
    var worker = teamMemberEl.getText();
    var rows = rpsItemGrid.getSelecteds();
    var itemList = [];
    if(rows && rows.length>0)
    {
        itemList = rows.map(function(v)
        {
            return {
                serviceId:v.serviceId,
                itemId:v.itemId,
                classCode:classObj.code,
                className:classObj.name,
                captainId:classObj.captainId,
                captainName:classObj.captainName,
                workerId:workerId,
                worker:worker
            };
        });
    }
    else
    {
        nui.alert("请选择要派工的项目");
    }
    nui.mask({
        html:'保存中...'
    });
    var dispatchingUrl = baseUrl+"com.hsapi.repair.repairService.work.dispatching.biz.ext";
    doPost({
        url:dispatchingUrl,
        data:{
            itemList:itemList
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("派工成功");
                loadRpsItemData();
            }
            else{
                nui.alert(data.errMsg||"派工失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function cancelDispatching()
{
    var rows = rpsItemGrid.getSelecteds();
    var itemList = [];
    if(rows && rows.length>0)
    {
        itemList = rows.map(function(v)
        {
            return {
                serviceId:v.serviceId,
                itemId:v.itemId
            };
        });
    }
    else
    {
        nui.alert("请选择要取消派工的项目");
    }
    nui.mask({
        html:'保存中...'
    });
    var Url = baseUrl+"com.hsapi.repair.repairService.work.cancelDispatching.biz.ext";
    doPost({
        url:Url,
        data:{
            itemList:itemList
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("取消派工成功");
                loadRpsItemData();
            }
            else{
                nui.alert(data.errMsg||"取消派工失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
