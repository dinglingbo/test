/**
 * Created by Administrator on 2018/3/27.
 */

var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";

var cardTimesGridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext";
//var packageGridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.rpb_package.queryPackage.biz.ext";
var packageDetailUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.rpb_package.getPackageDetail.biz.ext";
var itemGridUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
//var partGridUrl = apiPath + partApi + "/com.hsapi.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var itemTypeUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDictTypeTree.biz.ext";

var queryItemEl = null;
var queryValueEL = null;
var queryTabIdEl = null;
var mainTabEl = null;
var cardTimesGrid = null;
var cardTimesDetail = null;
var cardDetailGrid_Form = null;
//var packageGrid = null;
//var packageDetail = null;
//var detailGrid_Form = null;
var itemGrid = null;
//var partGrid = null;
var servieTypeList = [];
var servieTypeHash = {};
var typeList = [];
var typeHash = {};
var brandList = [];
var brandHash = {};

var callback = null;
var checkcallback = null;

var prdtTypeHash = {
    "1":"套餐",
    "2":"项目",
    "3":"配件"
};
$(document).ready(function ()
{
    init();
});
function init()
{
    cardTimesGrid = nui.get("cardTimesGrid");
    cardTimesGrid.setUrl(cardTimesGridUrl);
    cardTimesDetail = nui.get("cardTimesDetail");
    cardTimesDetail.setUrl(packageDetailUrl);
    cardDetailGrid_Form = document.getElementById("cardDetailGrid_Form");

    //packageGrid = nui.get("packageGrid");
   // packageGrid.setUrl(packageGridUrl);
   // packageDetail = nui.get("packageDetail");
  //  packageDetail.setUrl(packageDetailUrl);
   // detailGrid_Form = document.getElementById("detailGrid_Form");

    cardTimesGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
    });
    cardTimesGrid.on("drawcell",function(e)
    {
        if(e.field == "prdtType" && prdtTypeHash[e.value])
        {
            e.cellHtml = prdtTypeHash[e.value];
        }
    });
    cardTimesGrid.on("showrowdetail",function(e)
    {
        var grid = e.sender;
        var row = e.record;
        if(row.prdtType != 1) return;

        var td = grid.getRowDetailCellEl(row);
        td.appendChild(cardDetailGrid_Form);
        cardDetailGrid_Form.style.display = "block";
        cardTimesDetail.clearRows();
        loadCardTimesDetailByPkgId(row.prdtId,function(){});
    });
    cardTimesDetail.on("drawcell",function(e)
    {
        if(e.field == "prdtType" && prdtTypeHash[e.value])
        {
            e.cellHtml = prdtTypeHash[e.value];
        }
    });
    cardTimesGrid.on("drawcell",function(e)
    {
        if(e.field == "doTimes")
        {
            var row = e.row;
            var balaTimes = row.balaTimes || 0;
            var canUseTimes = row.canUseTimes||0;
            e.cellHtml = balaTimes - canUseTimes;
        }
    });
    cardTimesGrid.on("rowdblclick",function(e)
    {
        onOk();
    });

    /*packageGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    packageGrid.on("drawcell",function(e)
    {
        if(e.field == "serviceTypeId" && servieTypeHash[e.value])
        {
            e.cellHtml = servieTypeHash[e.value].name;
        }
    });
    packageGrid.on("rowdblclick",function(e)
    {
        onOk();
    });*/
    /*packageDetail.on("drawcell",function(e)
    {
        if(e.field == "prdtType" && prdtTypeHash[e.value])
        {
            e.cellHtml = prdtTypeHash[e.value];
        }
    });
    */
    /*packageGrid.on("showrowdetail",function(e)
    {
        var grid = e.sender;
        var row = e.record;

        var td = grid.getRowDetailCellEl(row);
        td.appendChild(detailGrid_Form);
        detailGrid_Form.style.display = "block";
        packageDetail.clearRows();
        loadPackageDetailByPkgId(row.id,function(){});
    });*/
    
    itemGrid = nui.get("itemGrid");
    itemGrid.setUrl(itemGridUrl);
    itemGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    itemGrid.on("drawcell",function(e)
    {
        if(e.field == "type" && typeHash[e.value])
        {
            e.cellHtml = typeHash[e.value].name;
        }
        if(e.field == "serviceTypeId" && servieTypeHash[e.value])
        {
            e.cellHtml = servieTypeHash[e.value].name;
        }
    });
    itemGrid.on("rowdblclick",function(e)
    {
        onOk();
    });
    
    /*partGrid = nui.get("partGrid");
    partGrid.on("rowdblclick",function(e)
    {
        //onOk();
    });
    partGrid.on("beforeload",function(e)
    {
        e.data["token"] = "";
        e.data["page/isCount"] = true;
    });
    partGrid.setUrl(partGridUrl);    
    partGrid.on("drawcell",function(e)
    {
        if(e.field == "partBrandId" && brandHash[e.value])
        {
            e.cellHtml = brandHash[e.value].name;
        }
    });*/
  
    //queryTabIdEl = nui.get("queryTabId");
    mainTabEl = nui.get("mainTab");

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
		
    });

    var dictDefs ={"type":"DDT20130703000063"};
	initTreeDicts(dictDefs,function(){
		typeList = nui.get('type').getData();
		typeList.forEach(function(v) {
			typeHash[v.customid] = v;
		});
    });
	initPartBrand('partBrand',function(data){
		brandList = nui.get('partBrand').getData();
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    //onSearch();
}
function loadCardTimesDetailByPkgId(pkgId,callback)
{
    cardTimesDetail.load({
        packageId:pkgId
    },callback);
}
/*function loadPackageDetailByPkgId(pkgId,callback)
{
    packageDetail.load({
        packageId:pkgId
    },callback);
}*/
function queryType(t){
    var menuqueryItemTab = nui.get("itemTab");
    if(t == 1){
        menuqueryItemTab.setText("套餐");
    }else if(t == 2){
        menuqueryItemTab.setText("项目");
    }else if(t == 3){
        menuqueryItemTab.setText("配件");
    }else if(t == 0){
        menuqueryItemTab.setText("客户已购买");
    }
    var index = parseInt(t);
    var tab = mainTabEl.getTab(index);
    mainTabEl.activeTab(tab);
}
function onTabChanged(e){
	var tab = e.tab;
	var title = tab.title;
    var menuqueryItemTab = nui.get("itemTab");
    menuqueryItemTab.setText(title);
    var tabIdx = mainTabEl.activeIndex;
    if(tabIdx == 1)
    {
    	doSearchItem(params);
    }
}
function getSearchParams()
{
    var params = {};
    var queryValue = nui.get("queryValue").getValue();
    params.name = queryValue.replace(/\s+/g, "");
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    var tabIdx = mainTabEl.activeIndex;
    if(tabIdx == 1)
    {
    	doSearchItem(params);
    }
}
function doSetCardTimes(data)
{
    cardTimesGrid.clearRows();
    cardTimesGrid.setData(data);
}
/*function doSearchPackage(params)
{
    var p = {};
    p.name = params.name;
    p.serviceTypeId = params.serviceTypeId;
    p.isDisabled = 0;
    p.serviceTypeId = 3;
    packageGrid.clearRows();
    packageGrid.load({
    	token:token,
        params:p
    });
    var param = {};
    param.name = params.name;
    param.serviceTypeId = params.serviceTypeId;
    param.isDisabled = 0;
    param.serviceTypeId = 6;//洗车开单显示洗车和保养的
	var json={
			params: param,
			token:token
	}
	nui.ajax({
		url : packageGridUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(data) {
			for(var i=0;i<data.list.length;i++){
				packageGrid.addRow(data.package1[i]);
			}
			
		}
	 });
}*/
function doSearchItem(params)
{
    var p = {};
    p.isDisabled = 0;
    p.name = params.name||"";
    p.ltype = params.ltype||"";
    //查询洗美业务类型工时
    p.serviceTypeIds = "1,2";
   
    itemGrid.clearRows();
    itemGrid.load({
    	token:token,
        params:p
    });
    var param = {};
    param.isDisabled = 0;
    param.name = params.name||"";
    param.ltype = params.ltype||"";
    param.serviceTypeId = 6;//洗车开单显示洗车和保养的
	var json={
			params: param,
			token:token
	}
	nui.ajax({
		url : itemGridUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(data) {
			for(var i=0;i<data.list.length;i++){
				itemGrid.addRow(data.list[i]);
			}
			
		}
	 });
}
/*function doSearchPart(params)
{
    var p = {};
    p.orgids = currOrgId;
    p.isDisabled = 0;
    p.PNP = params.name||"";
    p.carTypeIdF = params.carTypeIdF||"";
    p.serviceTypeId = 3;
    partGrid.clearRows();
    partGrid.load({
    	token:token,
        params:p
    });
}*/
var resultData = {};
function onOk()
{
    var node = {};
    var tabIdx = mainTabEl.activeIndex;
    var type = "";
    if(tabIdx == 0)
    {
        type = 0;
        node = cardTimesGrid.getSelected();
    }
    /*else if(tabIdx == 1)
    {
        type = 1;
        node = packageGrid.getSelected();
    }*/
    else if(tabIdx == 1)
    {
        type = 2;
        node = itemGrid.getSelected();
    }
   /* else if(tabIdx == 3)
    {
        type = 3;
        node = partGrid.getSelected();
    }*/
    var nodec = nui.clone(node);
    
    if(!nodec)
    {
        return;
    }
    resultData = {
            type:type,
            rtnRow:nodec
    };
    if(parent && parent.saveNoshowMsg){
    	parent.saveNoshowMsg(function(){
    		if(parent && parent.addPrdt){
                //需要判断是否已经添加相同 套餐，工时或是配件
                if(parent && parent.checkPrdt){
                    var checkMsg = parent.checkPrdt(resultData);
                    if(checkMsg) {
                        parent.showMsg(checkMsg,"W");
                    }else{
                        //弹出数量，单价和金额的编辑界面
                        parent.addPrdt(resultData);
                    }
                }else{
                    parent.addPrdt(resultData);
                }
            }
    	},"addYC");
    	
    }
}
function getData(){
    return resultData;
}
// function doSelect(idx)
// {
//     var result = {};
//     var row = null;
//     if(idx == 0)
//     {
//         result.pkg = packageGrid.getSelected();
//         row = result.pkg;
//     }
//     else if(idx == 1){
//         result.item = itemGrid.getSelected();
//         row = result.item;
//     }
//     if(!row)
//     {
//         return;
//     }
//     if(result.pkg)
//     {
//         var list = packageDetail.getData();
//         var doCallback = function()
//         {
//             list.forEach(function(v)
//             {
//                 if(v.itemKind)
//                 {
//                     var item_kind = getItemKind(v.itemKind);
//                     v.itemKind = item_kind;
//                 }
//             });
//             var itemList = list.filter(function(v)
//             {
//                 return v.type == "工时";
//             });
//             var partList = list.filter(function(v){
//                 return v.type == "配件";
//             });
//             result.itemList = itemList;
//             result.partList = partList;
//             callback && callback(result,function(){
//                 nui.showTips({
//                     content: "<b>成功</b> <br/>套餐添加成功",
//                     state: "success",
//                     x: "center",
//                     y: "top",
//                     timeout: 3000
//                 });
//             });
//         };
//         if(list.length > 0)
//         {
//             doCallback();
//         }
//         else{
//             loadPackageDetailByPkgId(row.id,function()
//             {
//                 list = packageDetail.getData();
//                 doCallback();
//             });
//         }
//     }
//     else{
//         callback && callback(result);
//     }
// }
// function onOk()
// {
//     var getActiveTab = mainTabEl.getActiveTab();
//     var _id = getActiveTab._id;
//     doSelect(_id-1);
// }

// //关闭窗口
// function CloseWindow(action) {
//     if (action == "close" && form.isChanged()) {
//         if (confirm("数据被修改了，是否先保存？")) {
//             saveData();
//         }
//     }
//     if (window.CloseOwnerWindow)
//         return window.CloseOwnerWindow(action);
//     else window.close();
// }
// //取消
// function onCancel() {
//     CloseWindow("cancel");
// }
