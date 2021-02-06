var mainFrame = null;
var partForm = null;
var applyCarBrandIdEl = null;
var dgbasic = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var searchCarbrandIdEl = null;
var brandList = null;
var brandHash = {};

$(document).ready(function(v) {

    partForm = new nui.Form("#partForm");
    applyCarBrandIdEl = nui.get("applyCarBrandId");
    dgbasic = nui.get("dgbasic");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    searchCarbrandIdEl = nui.get("searchCarbrandId");

    queryDg1();

    dgbasic.on("drawcell", function (e) { //表格绘制
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        if(field == "action"){
            var html = '<a class="" href="javascript:openDetail(\'' + record.pid + '\')">查看</a>';
            e.cellHtml = html;
        }else if(field == "brand"){
            if (brandHash && brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name;
            }
        }else if(field == "opt"){
            var html = '<a class="b" href="javascript:addDPart()"><i class="fa fa-shopping-cart"></i></a>';
            e.cellHtml = html; 
        }
    });

    $("#partCode").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            queryPartInfo();
        }
    });
    
});
/*
*添加购物车
*/
function addDPart(){   
    try{
        if(parent.showPanel){
            parent.showPanel('PART');
        }
        if(parent.addToCartGrid){
            parent.addToCartGrid('PART', dgbasic.getSelected());
        }
    }finally{}
}
function queryPartInfo(){
    var data = partForm.getData();
    if (!data.partCode) {
        /*var tmpList = data.partCodeList.split("\n");
        for (i = 0; i < tmpList.length; i++) {
            tmpList[i] = "'" + tmpList[i] + "'";
        }
        data.partCodeList = tmpList.join(",");*/
        nui.alert("请输入零件号!");
        return;
    }
   
    var brand = data.applyCarbrandId||'';

    if(!brand) {
        queryPartBrand(data.partCode);
        return;
    }else{
        if(data.partCode){
            queryBasic(brand,data.partCode);
        } 
    }
}
function queryPartWithBrand(data){
    
    advancedSearchWin.show();
}
function queryBasic(brand,pid){
    var params = {
        "url": llq_pre_url + "/parts/engine_search",//ppypart/parts_baseinfo
        "params":{
            "brand":brand,
            "code":brand,
            "parts":pid
        },
        "method": "post",
        "token": token
    }
    callAjax(url, params, processAjax, setGridData);
      
}
function setGridData(data){
    var tData = [];
    for(var i=0; i<data.length; i++){
        tData = tData.concat(data[i]);
    }
    dgbasic.setData(tData);
}
function queryDg1(){    
    var params = {
        "url": llq_pre_url + "/brandsdict",
        "token": token
    }
    
    //$(".groupButton").hide();
    callAjax(url, params, processAjax, setDg1);
}
function setDg1(data){
    var tData = [];
    var n = 1;
    for(var i in data){
        data[i].name = n++ + "、" + data[i].name;
        tData.push(data[i]);
    }
    applyCarBrandIdEl.setData(tData);

    tData.forEach(function(v) {
        brandHash[v.brand] = v;
    });
}
function openDetail(pid){ 
    var row = dgbasic.getSelected();
    var brand = row.brand;  
    try{
        nui.open({
            url : contextPath + "/com.hsweb.system.llqv2.partDetail.flow?brand=" + brand + "&pid=" + pid,
            title : "零件详情",
            width : "900px",
            height : "600px",
            showHeader:true,
            onload : function() {
                //var iframe = this.getIFrameEl();
                //iframe.contentWindow.setInitData(row, e);
            },
            ondestroy : function(action) {
                //gridParts.reload();
            }
        });
    }finally{}
}
function queryPartBrand(pid){    
    var params = {
        "url": llq_pre_url + "/parts/search",
        "params":{
            "parts":pid,
            "brand": ""
        },
        "method": "post",
        "token": token
    }
    
    //$(".groupButton").hide();
    callAjax(url, params, processAjax, setBrand);//setBrand
}
function setBrand(data){
    var tData = [];
    for(var i=0; i<data.length; i++){
        tData = tData.concat(data[i]);
    }
    
    if(tData && tData.length==1){
        var inData = partForm.getData();
        queryBasic(tData[0].brand, inData.partCode);
    }else if(tData && tData.length>1){
        advancedSearchWin.show();
        searchCarbrandIdEl.setData(tData);
    }
}
function onAdvancedSearchOk(){
    var data = advancedSearchForm.getData()
    var brand = data.searchCarbrandId;
    if(!brand){
        nui.alert("请选择品牌!");
        return;
    }

    var data = partForm.getData();
    var partCode = data.partCode;

    queryBasic(brand,partCode);

    onAdvancedSearchCancel();
}
function onAdvancedSearchCancel(){
    searchCarbrandIdEl.setData([]);
    advancedSearchWin.hide();
}