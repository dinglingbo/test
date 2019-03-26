/**
 * Created by Administrator on 2018/3/17.
 */
var webBaseUrl = webPath + contextPath + "/";
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
var guestTypeList = [];
var guestTypeHash = {};
var carModelHash = {};
var jumpUrl = "";//跳转连接
var xs = 0;
var isDisabledHash=[{name:"启用"},{name:"禁用"}];
$(document).ready(function(v){
	nui.get("mergeBtn").hide();
	nui.get("splitBtn").hide();
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("drawcell",function(e){
    	 var field = e.field;
         var record = e.record;
         var column = e.column;
         var id = record.id;
         if(column.field == "carNo"){
         	e.cellHtml ='<a id="car" href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
         }else if(column.field == "isDisabled"){
         	e.cellHtml =isDisabledHash[e.value].name;
         }
    });
    queryForm = new nui.Form("#queryForm");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    carBrandIdEl = nui.get("carBrandId");
    carModelIdEl = nui.get("carModelId");
    init();
    advancedSearchForm.clear();
    advancedSearchForm.gusetId=null;
    
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
        	advancedSearchWin.hide();
        }
      };
      initGuestType("guestTypeId",function(data) {
        	guestTypeList = nui.get("guestTypeId").getData();
        	guestTypeList.forEach(function(v) {
        		guestTypeHash[v.id] = v;
            });
     });
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
        //如果是首页数据连接进来，不执行onSearch()
        if(jumpUrl!="newCarQty"&&jumpUrl!="isDisabledCar"){
            onSearch();
        }
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
    if((nui.get("isDisabled").getValue())!=999){
    	params.isDisabled = nui.get("isDisabled").getValue();
    }else{
    	params.isDisabled = null;
    }
    return params;
}
function onSearch()
{
	var params = getSearchParams();
    params.guestFullName=document.getElementsByName('guestFullName')[0].value;
    params.carNo=document.getElementsByName('carNo')[0].value || null;
    params.mobile=document.getElementsByName('mobile')[0].value || null;
    params.vin=document.getElementsByName('carVin')[0].value || null;
    doSearch(params);
}


var currType = 0;
function quickSearch(type)
{
	var queryname = "所有";
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
            queryname = "本日来厂";
            break;
        case 1:
            params.yesterdayEnter = 1;
            queryname = "昨日来厂";
            break;
        case 2:
            params.todayNew = 1;
            queryname = "本日新来厂客户";
            break;
        case 3:
            params.thisMonthNew = 1;
            queryname = "本月新来厂客户";
            break;
        case 4:
            params.thisMonthEnter = 1;
            queryname = "本月所有来厂客户";
            break;
        case 5:
            params.thisMonthLoss = 1;
            queryname = "本月流失回厂";
            break;
        case 6:
            params.lastMonthLoss = 1;
            queryname = "所有";
            break;
        case 7:
            params.insurance = 1;
            queryname = "本日所有保险开单客户";
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
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
    var searchData = advancedSearchForm.getData(true);
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

    if(guest)
    {
        title = "修改客户资料";
        nui.open({
            url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditGuest.flow?token="+token,
            title: title, width: 750, height: 570,
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
    }else{
        var title = "新增客户资料";
        nui.open({
            url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditGuest.flow?token="+token,
            title: title, width: 750, height: 570,
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

}
//打开会员卡充值页面
function toUp(callback){
	var row=grid.getSelected();
	if(row==null){
		showMsg("请选择客户!","W");
		return;
	}
	row.guestMobile = row.mobile;
	if(row){
		nui.open({
			url:webPath + contextPath +"/repair/RepairBusiness/CustomerProfile/CardUp.jsp?token"+token,
			title: "充值会员卡", width: 600, height: 460,
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
		showMsg("请选中一条数据","W");
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
		showMsg("请选中一条数据","W");
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
        // targetWindow: window,
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



function selectionChanged() {
	var rows = grid.getSelecteds();
	if(xs==1){
		mini.get("updateBtn").setVisible(false);
		mini.get("addBtn").setVisible(false);
		mini.get("onBuy").setVisible(true);
	}
}

function importGuest(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.importGuest.flow?token="+token,
        title: "客户导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
        	grid.load();
        }
    });
}

function importCardByMobile(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.importCardByMobile.flow?token="+token,
        title: "客户储值卡导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
        	grid.load();
        }
    });
}

function importCardByCarNo(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.importCardByCarNo.flow?token="+token,
        title: "客户储值卡导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
        	grid.load();
        }
    });
}

function importTimesCard(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.importTimesCard.flow?token="+token,
        title: "客户计次卡导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
        	grid.load();
        }
    });
}

function showCarInfo(row_uid){
	var row = grid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.id,
				carNo : row.carNo,
				guestId : row.guestId
		};
		doShowCarInfo(params);
	}
}
function carChange(){
    var row = grid.getSelected();
    if (row)
    {
        nui.open({
            // targetWindow: window,
            url: webPath + contextPath + "/com.hsweb.RepairBusiness.carChange.flow?token="+token,
            title: "车牌车主变更", 
            width: 550, 
            height: 320,
            allowDrag:true,
            allowResize:true,
            onload: function () {
                var iframe = this.getIFrameEl();
                var params = {};
                if(row)
                {
                    params.guest = row;
                }
                iframe.contentWindow.setData(params);
            },
            ondestroy: function (action)
            {
                if("ok" == action)
                {
                	showMsg("变更信息成功!","S");
                    grid.reload();
                    
                }
            }
        });
    } else {
        showMsg("请选中一条数据", "W");
    }

}

function cancelData(){
	advancedSearchForm.setData([]);
}

function setInitData(params) {
	
    if (params.id == 'newCarQty') {//首页首修车辆
    	jumpUrl = "newCarQty";
    	var p={};
        p.todayNew = 1;
        var menunamestatus = nui.get("menunamestatus");
        menunamestatus.setText("本日新来厂客户");
        doSearch(p);
    }else if(params.id == 'isDisabledCar'){//客户报表 禁用车辆
    	var p={};
    	p.lastMonthLoss = 1;
    	p.isDisabled = 1;
        var menunamestatus = nui.get("menunamestatus");
        menunamestatus.setText("所有客户");
        doSearch(p);
    }
}
