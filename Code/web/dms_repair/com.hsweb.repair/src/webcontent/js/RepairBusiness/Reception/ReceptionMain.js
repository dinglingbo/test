/**
 * Created by Administrator on 2018/3/21.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var tree1 = null;
var statusHash = ["", "在报价", "在维修","已完工","在结算"];
var itemGrid = null;
var itemGridUrl = baseUrl + "com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var stockGrid = null;
var mainTabs = null;
var reportTab = null;
var billTab = null;
var typeList = [{id:"0",name:"车牌号"},{id:"0",name:"VIN号"},{id:"0",name:"客户名称"},{id:"0",name:"手机号"}];
$(document).ready(function ()
{
    
});

function advancedSearch(){
    if(document.getElementById("advancedMore").style.display=='block'){
        document.getElementById("advancedMore").style.display='none';
    }else{
        document.getElementById("advancedMore").style.display='block';
    }
    
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    td.appendChild(editFormSellOutDetail);
    editFormSellOutDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerSellOutGrid.load({
        params:params,
        token: token
    });
}