/**
 * Created by Administrator on 2018/4/25.
 */
 var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
 var leftGrid = null;
 var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext";

 var statusHash = ["草稿","预结算","已结算"];
 var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"}];
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
        if (e.field == "status") {
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

 var currType = 0;
 function quickSearch(type) {
	 var params = {};
	 if(type==0){
		 
	 }else if(type==1){
		 params.status = 0;
	 }else if(type==2){
		 params.status = 1;
	 }else if(type==3){
		 params.status = 2;
	 }
	    var type = nui.get("search-type").getValue();
	    var typeValue = nui.get("carNo-search").getValue();
	    if(type==0){
	        params.carNo = typeValue;
	    }else if(type==1){
	        params.guestFullName = typeValue;
	    }
    onSearch(params);
}
function getSearchParams()
{
    var params = {};
    var data = advancedSearchForm.getData();

    params.carNo = nui.get("carNo-search").getValue();
    params.guestFullName = nui.get("guestName").getValue();
    return params;
}
function onSearch(params)
{
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

function onAdvancedSearchClear(){
	advancedSearchForm.setData([]);
}