/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainDetail.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var menuBtnDateQuickSearch = null;
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
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("drawcell",function(e)
    {
        var field = e.field;
        if("partBrandId" == field)
        {
        	if(partBrandIdHash[e.value])
            {
//                e.cellHtml = partBrandIdHash[e.value].name||"";
            	if(partBrandIdHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
            	}else{
            		e.cellHtml =partBrandIdHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
        }
        else if("billStatus" == field)
        {
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
        }
        else if("storeId" == field)
        {
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
        }
        else if("enterDayCount" == field)
        {
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
        }
    });
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["enterCode"]);
    });
    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
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
        initDicts({
            billTypeId:BILL_TYPE,//票据类型
            settType:SETT_TYPE, //结算方式
            enterTypeId:ENTER_TYPE //入库类型
        },function(){
            quickSearch(menuBtnDateQuickSearch, currType, '本日');
        });
    });
});


var currType = 0;
function quickSearch(ctlid, value, text){
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    onSearch();
}

function onSearch(){
    var params = getSearchParam();
    doSearch(params);
}

function getSearchParam(){
    var params = {};
    params.storeId = nui.get("storeId").getValue();
    params.guestId = nui.get("searchGuestId").getValue();
    var d = menuBtnDateQuickSearch.getValue();
    if (d == 0) {
        params.today = 1;
    } else if (d == 1) {
        params.yesterday = 1;
    }  else if (d == 2) {
        params.thisWeek = 1;
    } else if (d == 3) {
        params.lastWeek = 1;
    } else if (d == 4) {
        params.thisMonth = 1;
    } else if (d == 5) {
        params.lastMonth = 1;
    }
    var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }
    return params;
}

function doSearch(params)
{
    params.enterTypeId = '050101';
    rightGrid.load({
        params:params
    },function(){
        //rightGrid.mergeColumns(["enterId"]);
    });

    nui.get("searchGuestId").setText("");
    nui.get("searchGuestId").setValue("");
    nui.get("storeId").setText("");
    nui.get("storeId").setValue("");
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
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    var tmpList = [];
    if(searchData.outIdList)
    {
        tmpList = searchData.outIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.outIdList = tmpList.join(",");
        //console.log(tmpList);
    }
    if(searchData.partCodeList)
    {
        tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
        //console.log(tmpList);
    }
    if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.supplierSelect.flow?token=" + token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                console.log(elId);
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}
