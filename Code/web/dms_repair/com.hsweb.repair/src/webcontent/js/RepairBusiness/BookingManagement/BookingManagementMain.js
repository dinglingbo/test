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
function init(callback)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("rowdblclick",function(e)
    {
        onLeftGridRowDblClick(e);
    });
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    basicInfoForm = new nui.Form("#basicInfoForm");
    queryForm = new nui.Form("#queryForm");
    carBrandIdEl = nui.get("carBrandId");
    carSeriesIdEl = nui.get("carSeriesId");
    carBrandIdEl.on("valuechanged",function()
    {
        var carBrandId = carBrandIdEl.getValue();
        console.log(carBrandId);
        if(carSeriesIdHash[carBrandId])
        {
         //   console.log(carSeriesIdHash[carBrandId]);
            carSeriesIdEl.setData(carSeriesIdHash[carBrandId]);
        }
        else
        {
         //   console.log("getCarSeriesByBrandId");
            getCarSeriesByBrandId(carBrandId,function(data)
            {
                var list = data.list||[];
                carSeriesIdHash[carBrandId] = list;
                carSeriesIdEl.setData(carSeriesIdHash[carBrandId]);
            });
        }
    });
    var hash = {};
    nui.mask({
        html:'数据加载中..'
    });
    var checkComplete = function()
    {
        var keyList = ['getAllCarBrand','getDictItems'];
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
    getAllCarBrand(function(data)
    {
        var list = data.carBrands;
        carBrandIdEl.setData(list);
        hash.getAllCarBrand = true;
        checkComplete();
    });
    var dictIdList = [];
    dictIdList.push("DDT20130705000001");//预约项目
    dictIdList.push("DDT20140315000001");//预约分类
    getDictItems(dictIdList,function(data)
    {
        data = data||{};
        var itemList = data.dataItems||[];
        var prebookItemList = itemList.filter(function(v){
            return  "DDT20130705000001" == v.dictid;
        });
        nui.get("prebookItem").setData(prebookItemList);
        var prebookCategoryList = itemList.filter(function(v){
            return  "DDT20140315000001" == v.dictid;
        });
        nui.get("prebookCategory").setData(prebookCategoryList);
        hash.getDictItems = true;
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
function history() {
    nui.open({
        url: "../../common/History.jsp",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "history"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
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

function quote() {
    nui.open({
        url: "../../common/subpage/customerSubpage/AddEditCustomer.jsp",
        title: "客户资料", width: 450, height: 650,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "add"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
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
var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveRpsPreBook.biz.ext";
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
