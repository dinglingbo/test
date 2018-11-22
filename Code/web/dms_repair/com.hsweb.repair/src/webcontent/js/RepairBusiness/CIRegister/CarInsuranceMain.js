/**
 * Created by Administrator on 2018/4/25.
 */
 var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
 var leftGrid = null;
 var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext";

 var statusHash = ["草稿","预结算","已结束"];
 var advancedSearchWin = null; 
 var advancedSearchForm = null;
 var advancedSearchFormData = null; 
 $(document).ready(function ()
 {
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.load();
    leftGrid.on("drawcell", function (e) {
        if (e.field == "STATUS") {
            e.cellHtml = statusHash[e.value];
        }
        else {
            onDrawCell(e);
        }
    });
    leftGrid.on("rowclick", function (e) {
        var row = e.record;

    });  
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) { 

        }
    });

    leftGrid.on("rowdblclick",function(e){
    	view();
	});
}); 

 var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
 var currType = 0;
 function quickSearch(type) {
    var params = {};
    currType = type;

    var btn = nui.get("searchByDateBtn");
    if(btn)
    {
        var text = searchByDateBtnTextHash[type];
        btn.setText(text);
    }
    var dateObj = getDate(type);
    var data = advancedSearchForm.getData();
    data.startDate = dateObj.startDate;
    data.endDate = dateObj.endDate;
    advancedSearchForm.setData(data);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    var data = advancedSearchForm.getData();
    params.startDate = data.startDate.substr(0,10);
    params.endDate = data.endDate.substr(0,10);
    params.carNo = nui.get("carNo-search").getValue();
    params.guestFullName = nui.get("guestName").getValue();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
} 
function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token, 
        params: params
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
        nui.alert("起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.carNoList)
    {
        tmpList = searchData.carNoList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.carNoList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}


function view() {
    var row = leftGrid.getSelected();
    if(row){ 
        editInsuranceDetail(row);
    }else{
        nui.alert("请先选择一条记录！");
    }
}


function onenterGuestName(){
    onSearch();
}

function onenterCarNo(){
    onSearch();
}


function onAdvancedSearchCancel(){
    advancedSearchWin.hide();
}
function editInsuranceDetail(row) {
    var item={};
    item.id = "InsuranceDetail";
    item.text = "保险开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CarInsuranceDetail.flow?token="+token;
    item.iconCls = "fa fa-cog";
    var params = {};
    params = { 
        id:row.id,
        data:row,
        actionType:"edit"
    };
    window.parent.activeTabAndInit(item,params);
}

function newInsuranceDetail() {
    var item={};
    item.id = "InsuranceDetail";
    item.text = "保险开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.CarInsuranceDetail.flow?token="+token;
    item.iconCls = "fa fa-cog";
    var params = {};
    window.parent.activeTabAndInit(item,params);
    
    //var params = {};
    //window.parent.activeTabAndInit(item,params);
}