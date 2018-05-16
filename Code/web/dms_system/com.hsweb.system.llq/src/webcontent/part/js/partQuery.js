var mainFrame = null;
var partForm = null;
var applyCarBrandIdEl = null;
var dgbasic = null;

$(document).ready(function(v) {

    partForm = new nui.Form("#partForm");
    applyCarBrandIdEl = nui.get("applyCarBrandId");
    dgbasic = nui.get("dgbasic");
    queryDg1();

	//$("#query0").css("color","blue");
	//document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
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
        }
    });
    
});
function queryPartInfo(type){
    var data = partForm.getData();
    if (data.partCodeList) {
        var tmpList = data.partCodeList.split("\n");
        /*for (i = 0; i < tmpList.length; i++) {
            tmpList[i] = "'" + tmpList[i] + "'";
        }*/
        data.partCodeList = tmpList.join(",");
    }
   
    var brand = data.applyCarbrandId||'';

    if(!brand) {
        //queryPartBrand(data.partCodeList);
        nui.alert("请选择品牌!");
        return;
    }

    if(data.partCodeList){
        queryBasic(brand,data.partCodeList);
    }

	/*switch (type)
    {
        case 0:
            //document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
            break;
        case 1:
            //document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/brand/brandQuery.jsp";
            break;
        case 2:
            //document.getElementById("mainFrame").src=webPath + sysDomain + "/common/embedJsp/containBottomStock.jsp";
            break;
        default:
        	//document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
            break;
    }

    $("#query0").css("color","black");
    $("#query1").css("color","black");
    $("#query2").css("color","black");

    if($("#query"+type).length>0)
    {
        $("#query"+type).css("color","blue");
        $("#query"+type).css("font-weight","true");
    }*/
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
}
function openDetail(pid){ 
    var row = dgbasic.getSelected();
    var brand = row.brand;  
    try{
        nui.open({
            url : sysDomain + "/com.hsweb.system.llq.vin.partDetail.flow?brand=" + brand + "&pid=" + pid,
            title : "零件详情",
            width : "600px",
            height : "400px",
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
    callAjax(url, params, processAjax, getBrand);
}
function getBrand(data){
    var i = 0;
}