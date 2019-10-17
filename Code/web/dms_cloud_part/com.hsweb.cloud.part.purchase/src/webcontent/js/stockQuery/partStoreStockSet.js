/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPartStoreStock.biz.ext";
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var partBrandId = null;
var storeId = null;
var storeShelf = null;
var partId = null;
var showAll = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var UpOrDownList=[{id:1,"name" :"低于下限"},{id:2,"name" :"高于上限"}];
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);

    comPartNameAndPY = nui.get("comPartNameAndPY");
    comPartCode = nui.get("comPartCode");
    partBrandId = nui.get("partBrandId");
    storeId = nui.get("storeId");
    storeShelf = nui.get("storeShelf");
    partId = nui.get("partId");
    showAll = nui.get("showAll");
    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        nui.get("partBrandId").setData(partBrandList);
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });

    comPartNameAndPY.focus();

    $("#comPartCode").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#comPartNameAndPY").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#partBrandId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeShelf").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    onSearch();
});
function getSearchParam(){
	var date =new Date();
	var mongth = date.getMonth()+1;
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
  
    var showZero = nui.get("showAll").getValue();
    var upOrDown=nui.get('upOrDown').getValue();
    if(showZero == 0){
        params.notShowAll = 1;
    }
   
    if(upOrDown == 2){
    	//夏(4-9)
    	if(mongth>= 4 && mongth<=9){
    		params.showUp = 1;
    	}else{
    		params.showUpWinter = 1;
    	}
        
    }
    if(upOrDown ==1){
    	//夏(4-9)
    	if(mongth>= 4 && mongth<=9){
    		params.showDown = 1;
    	}else{
    		params.showDownWinter = 1;
    	}
    }
    params.partNameAndPY = nui.get("comPartNameAndPY").getValue();
	params.partCode = (nui.get("comPartCode").getValue()).replace(/\s+/g, "");
	params.partBrandId = nui.get("partBrandId").getValue();
	params.storeId = nui.get("storeId").getValue();
	params.storeShelf = nui.get("storeShelf").getValue().replace(/\s+/g, "");
	params.partId = nui.get("partId").getValue();
    return params;
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	//params.sortField = "audit_date";
	//params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token:token
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
	var searchData = advancedSearchForm.getData();
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sOrderDate)
    {
        searchData.sOrderDate = formatDate(searchData.sOrderDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
//        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onDrawCell(e)
{
    switch (e.field)
    {
	    case "wain" :
			if( e.record.upLimit){
				if(e.record.stockQty>e.record.upLimit){
	    			e.cellHtml = "<span style='color : red'>高<span>";
	    		}
			}
			if(e.record.downLimit){
				if(e.record.stockQty<e.record.downLimit){
	    			e.cellHtml = "<span style='color : orange'>低<span>";
	    		}
			}	
			break;
	    case "partBrandId":
	        if(partBrandIdHash[e.value])
	        {
	//            e.cellHtml = partBrandIdHash[e.value].name||"";
	        	if(partBrandIdHash[e.value].imageUrl){
	        		
	        		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
	        	}else{
	        		e.cellHtml =partBrandIdHash[e.value].name||"";
	        	}
	        }
	        else{
	            e.cellHtml = "";
	        }
	        break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        default:
            break;
    }
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    } else {
        var newRow = {};
        if (e.field == "upLimit" || e.field == "downLimit" ||e.field == "upLimitWinter" || e.field == "downLimitWinter"
        	|| e.field == "minOrderQty" || e.field == "minPackQty") {
            var qty = e.value;
           

            if (e.value == null || e.value == '') {
            } else if (e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }
        } 
    }
}
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveStoreStockSet.biz.ext";
function save(){
    var gridData = rightGrid.getChanges("modified");
    if(gridData && gridData.length > 0){
        var data = [];
        for(var i=0; i<gridData.length; i++){
            var newObj = {};
            newObj.orgid = gridData[i].orgid;
            newObj.storeId = gridData[i].storeId;
            newObj.partId = gridData[i].partId;
            newObj.shelf = gridData[i].shelf;
            newObj.upLimit = gridData[i].upLimit;
            newObj.downLimit = gridData[i].downLimit;
            newObj.upLimitWinter = gridData[i].upLimitWinter;
            newObj.downLimitWinter = gridData[i].downLimitWinter;
            newObj.minOrderQty = gridData[i].minOrderQty;
            newObj.minPackQty = gridData[i].minPackQty;
            data.push(newObj);
        }

        nui.mask({
            el : document.body,
            cls : 'mini-mask-loading',
            html : '保存中...'
        });

        nui.ajax({
            url : saveUrl,
            type : "post",
            data : JSON.stringify({
                partStoreStock : data,
                token: token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    showMsg("保存成功!","S");
                    onSearch();
                } else {
                    showMsg(data.errMsg || "保存失败!","E");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    }
}

function  importStockSet(){
	 nui.open({
	        // targetWindow: window,
	        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.importPart.flow?token="+token,
	        title: "库存设置导入", 
	        width: 930, 
	        height: 560,
	        allowDrag:true,
	        allowResize:true,
	        onload: function ()
	        {
	            var iframe = this.getIFrameEl();
	            var carBrandList = nui.get("applyCarBrandId").getData();
	            iframe.contentWindow.initData({
	                    partBrandIdList:brandList,
	                    carBrandList: carBrandList
	                });
	        },
	        ondestroy: function (action)
	        {
	            onSearch();
	        }
	    });
}