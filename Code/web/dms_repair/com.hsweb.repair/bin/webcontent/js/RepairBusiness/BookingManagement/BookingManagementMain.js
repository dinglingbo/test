/**
 * Created by Administrator on 2018/3/20.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function()
{
    init(function(){
    	quickSearch(2);
    });
});
var leftGrid = null;
var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryPrebookList.biz.ext";
var rightGrid = null;
var rightGridUrl = baseUrl+"com.hsapi.repair.repairService.svr.getScoutByBookId.biz.ext";
var basicInfoForm = null;
var carBrandIdEl = null;
var carSeriesIdEl = null;
var carSeriesIdHash = {};
var queryForm = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
function init(callback)
{
	advancedSearchWin = nui.get("advancedSearchWin");
	advancedSearchForm = new nui.Form("#advancedSearchWin");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("load",function(){
        var row = leftGrid.getSelected();
        if(row)
        {
            onLeftGridRowDblClick({
                record:row
            });
        }
    });
    leftGrid.on("rowdblclick",function(e)
    {
        onLeftGridRowDblClick(e);
    });
    leftGrid.on("drawcell",onDrawCell);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("drawcell",onDrawCell);
    basicInfoForm = new nui.Form("#basicInfoForm");
    queryForm = new nui.Form("#queryForm");
    carBrandIdEl = nui.get("carBrandId");
    carSeriesIdEl = nui.get("carSeriesId");
    carBrandIdEl.on("valuechanged",function()
    {
    	var carBrandId = carBrandIdEl.getValue();
        getCarModel("carSeriesId",{
            value:carBrandId
        });
    });
    var hash = {};
    nui.mask({
        html:'数据加载中..'
    });
    var checkComplete = function()
    {
        var keyList = ['initCarBrand','initDicts'];
        for(var i=0;i<keyList.length;i++)
        {
            if(!hash[keyList[i]])
            {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    initCarBrand("carBrandId",function()
    {
    	var list = nui.get("carBrandId").getData();
        nui.get("carBrandId-ad").setData(list);
        hash.initCarBrand = true;
        checkComplete();
    });
    initDicts({
        scoutMode: SCOUT_MODE,//跟进方式
        isUsabled: IS_USABLED,//跟踪状态
        prebookItem: PREBOOK_ITEM,//预约项目
        prebookCategory: PREBOOK_CATEGORY,//预约分类,
        bookStatus:BOOK_STATUS //预约状态
    },function(){
    	var list = nui.get("prebookItem").getData();
        nui.get("prebookItem-ad").setData(list);
        hash.initDicts = true;
        checkComplete();
    });
}
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function quickSearch(type)
{
    var params = {};
    switch (type)
    {
        case 0:
            params.today = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        default:
            break;
    }
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    doSearch(params);
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
	var showMeOnly = nui.get("showMeOnly").getValue();
    if(showMeOnly)
    {
        params.recorder = currUserName;
    }
    params.orgid = currOrgid;
    leftGrid.load({
    	token:token,
        params:params
    });
}
function resetBtn()
{
    nui.get("carId").disable();
    nui.get("addBtn").enable();
    nui.get("saveBtn").enable();
    nui.get("cancelBtn").enable();
    nui.get("fllowUpBtn").enable();
}
function onLeftGridRowDblClick(e)
{
    var row = e.record;
    if(row)
    {
        var enabled = nui.get("addBtn").getEnabled();
        if(!enabled)
        {
            cancel();
        }
        nui.mask({
            html:'数据加载中..'
        });
        getPrebookById(row.id,function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.prebook)
            {
                var prebook = data.prebook;
                basicInfoForm.setData(prebook);
                carBrandIdEl.doValueChanged();
                nui.get("carId").setText(prebook.carNo);
                resetBtn();
                if(prebook.bookStatus == "040901")
                {
                    nui.get("cancelBtn").disable();
                }
                else{
                    nui.get("fllowUpBtn").disable();
                }
            }
            else
            {
                nui.alert("数据加载失败");
            }
        });
        rightGrid.load({
        	token:token,
            bookId:row.id
        });
    }
}
var getPrebookByIdUrl = baseUrl+"com.hsapi.repair.repairService.svr.getPrebookById.biz.ext";
function getPrebookById(id,callback)
{
    var params = {
        id:id
    };
    doPost({
        url: getPrebookByIdUrl,
        data: params,
        success: function (data) {
            callback && callback(data);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
function history() 
{
	var row = leftGrid.getSelected();
	if(!row || !row.guestId)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.repair.common.repairHistory.flow",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
            	guestId:row.guestId
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
        }
    });
}
function onMore() {
    nui.open({
        url: "./subpage/More.jsp",
        title: "高级查询", width: 380, height: 180,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "more"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
function fllowUp()
{
    var prebook = basicInfoForm.getData();
    if(!prebook.id)
    {
        return;
    }
    prebook.carNo = nui.get("carId").getText();
    prebook.carBrandName = nui.get("carBrandId").getText();
    prebook.carSeriesName = nui.get("carSeriesId").getText();
    nui.open({
        url: "com.hsweb.RepairBusiness.ReservationTracking.flow",
        title: "预约跟踪", width:690, height: 530,
        allowResize:false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
                prebook:prebook
            };
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) 
        {
        	if("ok" == action)
            {
                rightGrid.reload();
            }
        }
    });
}
function getMaintainServiceCode(callback)
{
    callback = callback||function(){};
    var billTypeCode = "BJD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback && callback({
            code:code
        });
    });
}
function quote()
{
    var prebook = basicInfoForm.getData();
    if(!prebook.id && prebook)
    {
        return;
    }
    nui.mask({
        html: '保存中..'
    });
    getMaintainServiceCode(function (data) {
        var code = data.code;
        if (!code) {
            nui.unmask();
            nui.alert("获取单号失败");
            return;
        }
        var params = {};
        params.serviceCode = code;
        params.id = prebook.id;
        var url = baseUrl+"com.hsapi.repair.repairService.crud.prebookTransToQuote.biz.ext";
        doPost({
            url: url,
            data:params,
            success: function (data) {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("转入报价成功");
                    reload();
                }
                else{
                    nui.alert(data.errMsg||"转入报价失败");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                //  nui.alert(jqXHR.responseText);
                nui.unmask();
                console.log(jqXHR.responseText);
                nui.alert("网络出错，转入报价失败");
            }
        });
    });
}
function selectCar()
{
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户资料", width: 800, height:450,
        onload: function () {
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                nui.get("carId").setValue(guest.id);
                nui.get("carId").setText(guest.carNo);
                carBrandIdEl.setValue(guest.carBrandId);
                carBrandIdEl.doValueChanged();
                carSeriesIdEl.setValue(guest.carSeriesId);
                nui.get("tel").setValue(guest.mobile);
                nui.get("contactorName").setValue(guest.contactName);
                nui.get("contactorId").setValue(guest.contactorId);
                nui.get("guestId").setValue(guest.guestId);
            }
        }
    });
}
function reload()
{
	resetBtn();
    basicInfoForm.clear();
    rightGrid.clearRows();
    leftGrid.reload();
}
function add()
{
    basicInfoForm.clear();
    var data = {
        recorder:currUserName
    };
    basicInfoForm.setData(data);
    resetBtn();
    nui.get("carId").enable();
    nui.get("addBtn").disable();
}
function cancel()
{
    resetBtn();
    nui.get("cancelBtn").disable();
    var data = basicInfoForm.getData();
    nui.get("saveBtn").disable();
    basicInfoForm.clear();
}
var requiredField = {
    contactorName:"联系人",
    tel:"联系电话",
    predictComeDate:"预约来厂日期"
};
var saveUrl = baseUrl+".biz.ext";
function save()
{
    var prebook = basicInfoForm.getData();
    prebook.carNo = nui.get("carId").getText();
    for(var key in requiredField)
    {
        if(!prebook[key] || prebook[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    nui.mask({
        html:'保存中..'
    });
    var doSave = function()
    {
        doPost({
            url:saveUrl,
            data:{
                prebook:prebook
            },
            success:function(data)
            {
                nui.unmask();
                data = data||{};
                if(data.errCode == "S")
                {
                    nui.alert("保存成功");
                    reload();
                    var book = data.prebook;
                    basicInfoForm.setData(book);
                    resetBtn();
                    nui.get("cancelBtn").disable();
                    nui.get("saveBtn").disable();
                }
                else{
                    nui.alert(data.errMsg||"保存失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                //  nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        });
    };
    if(prebook.id)
    {
        doSave();
    }
    else
    {
        getServiceCode(function(data)
        {
            var code = data.code;
            if(code)
            {
                prebook.serviceCode = code;
                doSave();
            }
            else
            {
                nui.unmask();
                nui.alert("获取单号失败");
            }
        });
    }
}
function getServiceCode(callback)
{
    callback = callback||function(){};
    var billTypeCode = "YYD";
    getCompBillNO(billTypeCode,function(data)
    {
        data = data||{};
        var code = data.serviceno;
        callback && callback({
            code:code
        });
    });
}

function advancedSearch()
{
    advancedSearchWin.show();
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i,tmpList;
    if(!searchData.startDate || !searchData.endDate)
    {
        nui.alert("结算起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.serviceCodeList)
    {
        tmpList = searchData.serviceCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceCodeList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    searchData = getAnayType(searchData);
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
    advancedSearchWin.hide();
}
function onAdvancedSearchClear()
{
    advancedSearchForm.clear();
}
