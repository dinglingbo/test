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

	//$("#query0").css("color","blue");
	//document.getElementById("mainFrame").src=webPath + contextPath + "/llq/vin/vinQuery.jsp";
    /*if(parent && parent.setBottomInit){
    	mainrow = parent.setBottomInit();
    	if(mainrow && mainrow.showTool == -1){
    		//document.getElementById("bottomFormIframeStock").contentWindow.setToolBar('hide');
    	}
    }*/

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
                e.cellHtml = brandHash[e.value].brandCn;
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
        "url": llq_pre_url + "/ppypart/parts_list",//ppypart/parts_baseinfo
        "params":{
            "brand":brand,
            "pid":pid
        },
        "token": token
    }
    callAjax(url, params, processAjax, setGridData);
      
}
function setGridData(data){
    dgbasic.setData(data);
}
function queryDg1(){    
    var params = {
        "url": llq_pre_url + "/ppycars/brand",
        "params":{
        },
        "token": token
    }
    
    //$(".groupButton").hide();
    callAjax(url, params, processAjax, setDg1);
}
function setDg1(data){
    applyCarBrandIdEl.setData(data);

    data.forEach(function(v) {
        brandHash[v.brand] = v;
    });
}
function openDetail(pid){ 
    var row = dgbasic.getSelected();
    var brand = row.brand;  
    try{
        nui.open({
            url : contextPath + "/com.hsweb.system.llq.vin.partDetail.flow?brand=" + brand + "&pid=" + pid,
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
        "url": llq_pre_url + "/ppypart/parts_brand_determination",
        "params":{
            "pid":pid
        },
        "token": token
    }
    
    //$(".groupButton").hide();
    callAjax(url, params, processAjax, setBrand);
}
function setBrand(data){
    var i = 0;
    advancedSearchWin.show();
    searchCarbrandIdEl.setData(data);
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