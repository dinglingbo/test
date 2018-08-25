/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryCustomerList.biz.ext";
var queryForm = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var carBrandIdEl = null;
var carModelIdEl = null;
var carBrandHash = [];
var carSeriesHash = [];
var mtAdvisorHash = [];
var carModelIdHash = {};


$(document).ready(function(v){

    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    queryForm = new nui.Form("#queryForm");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    carBrandIdEl = nui.get("carBrandId");
    carModelIdEl = nui.get("carModelId");
    init();
    advancedSearchForm.clear();
    advancedSearchForm.gusetId=null;


});
function init(){

    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    initCarBrand("carBrandId",function()
    {
    	var list = carBrandIdEl.getData();
		nui.get("carBrandId").setData(list);
		hash.initCarBrand = true;
		checkComplete();
    });

}
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    params.carNo=document.getElementsByName('carNo')[0].value;
    params.mobile=document.getElementsByName('mobile')[0].value;
    doSearch(params);
}
var currType = 0;
function quickSearch(type)
{
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    var params = {};
    switch(type)
    {
        case 0:
            params.todayEnter = 1;
            break;
        case 1:
            params.yesterdayEnter = 1;
            break;
        case 2:
            params.todayNew = 1;
            break;
        case 3:
            params.thisMonthNew = 1;
            break;
        case 4:
            params.thisMonthEnter = 1;
            break;
        case 5:
            params.thisMonthLoss = 1;
            break;
        case 6:
            params.lastMonthLoss = 1;
            break;
        default:
            break;
    }
    doSearch(params);
}
function doSearch(params)
{
    grid.load({
        token:token,
        params:params
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
    if(searchData.lastEnterStart)
    {
        searchData.lastEnterStart = searchData.lastEnterStart.substr(0,10);
    }
    if(searchData.lastEnterEnd)
    {
        searchData.lastEnterEnd = searchData.lastEnterEnd.substr(0,10);
    }

    if(searchData.firstEnterStart)
    {
        searchData.firstEnterStart = searchData.firstEnterStart.substr(0,10);
    }
    if(searchData.firstEnterEnd)
    {
        searchData.firstEnterEnd = searchData.firstEnterEnd.substr(0,10);
    }

    if(searchData.lastOutStart)
    {
        searchData.lastOutStart = searchData.lastOutStart.substr(0,10);
    }
    if(searchData.lastOutEnd)
    {
        searchData.lastOutEnd = searchData.lastOutEnd.substr(0,10);
    }

    if(searchData.recordStart)
    {
        searchData.recordStart = searchData.recordStart.substr(0,10);
    }
    if(searchData.recordEnd)
    {
        searchData.recordEnd = searchData.recordEnd.substr(0,10);
    }
    if(searchData.carBrandId){
    	searchData.carBrandId=document.getElementsByName('carBrandId')[0].value;
    }
    if(searchData.carModelId){
    	searchData.carModelId=document.getElementsByName('carModelId')[0].value;
    }
    if(searchData.mobile){
    	searchData.mobile=searchData.mobile;
    }
    if(searchData.guestId){
    	searchData.guestId=advancedSearchForm.gusetId;
    }
 
    advancedSearchWin.hide();
    doSearch(searchData);
    advancedSearchForm.gusetId=null;
  
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addOrEditCustomer(guest)
{
    var title = "新增客户资料";
    if(guest)
    {
        title = "修改客户资料";
    }
    nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
        title: title, width: 560, height: 570,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            if(guest)
            {
                params.guest = guest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                grid.reload();
            }
        }
    });
}

//打开会员卡充值页面
function toUp(callback){
	var row=grid.getSelected();
	if(row){
		nui.open({
			url:webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/CardUp.jsp?token"+token,
			title: "充值会员卡", width: 600, height: 500,
			onload: function(){
				var iframe=this.getIFrameEl();
				var params={
						data :row
				};
				
				iframe.contentWindow.SetData(params);
		
			},
			onedestroy: function(action){
				if("ok" == action){
					grid.reload();
				}
			}
		});
	}else{
		showMsg("请选择一条记录","W");
	}
}
function add()
{
    addOrEditCustomer();
}
function edit() {
    var row = grid.getSelected();
    if (row)
    {
        addOrEditCustomer(row);
    } else {
        showMsg("请选中一条数据", "W");
    }
}

function amalgamate() {
    nui.open({
        url:webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/Amalgamate.jsp?token="+token,
        title: "资料合并", width: 630, height: 420,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "amalgamate"};
//            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function split() {
    nui.open({
        url: webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/Split.jsp?token="+token,
        title: "资料拆分", width: 810, height: 430,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "split"};
//            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}
//显示车型的
function onCarBrandChange(e){     
	initCarModel("carModelId", e.value,"", function () {
        var data = nui.get("carModelId").getData();
        data.forEach(function (v) {
        	carModelHash[v.id] = v;
        });
    });
}

function history()
{
	var row = grid.getSelected();
	if(!row || !row.guestId)
    {
		showMsg("请选择一条记录");
        return;
    }
    nui.open({
        url: webPath + contextPath +"/com.hsweb.repair.common.repairHistory.flow?token="+token,
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
var customer = null;
function selectCustomer(guestId)
{
    customer = null;
    nui.open({
        targetWindow: window,
        url: webPath+contextPath+"/repair/common/Customer.jsp?token="+token,
        title: "客户资料", width: 980, height: 560,
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
                guest = data.guest;
                var value = guest.guestId;
                var text = guest.guestFullName;
                var el = nui.get(guestId);
                el.setValue(value);
                el.setText(text);
                advancedSearchForm.gusetId=value;
            }
        }
    });
}
