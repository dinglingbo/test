/**
 * Created by Administrator on 2018/4/25.
 */
 var baseUrl = apiPath + repairApi + "/";
 var leftGrid = null;
 var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext";
 var getInsuranceUrl=baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext";
 
 var statusHash = ["草稿","提交","完成"];
 var advancedSearchWin = null; 
 var advancedSearchForm = null;
 var advancedSearchFormData = null;
 
 var editFormDetail = null;
 var innerPartGrid = null;
 var settleTypeIdList=[{id :1,name :"保司直收"},{id :2,name :"门店代收全款"},{id :3,name :"代收减返点"}];
 $(document).ready(function ()
 {
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
    endDateEl.setValue(date);
    beginDateEl.setValue(sdate);
    
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getInsuranceUrl);

    
    leftGrid.on("drawcell", function (e) {
 
        if(e.field == "settleTypeId"){
        	 e.cellHtml = settleTypeIdList[e.value-1].name ||"";
        }
    });
    leftGrid.on("rowclick", function (e) {
        var row = e.record;

    });  
    quickSearch(4);
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
    
    beginDateEl.setValue(dateObj.startDate);
    endDateEl.setValue(dateObj.endDate);
    advancedSearchForm.setData(data);
    doSearch(params);
}
function getSearchParams()
{
    var params = {};
    var data = advancedSearchForm.getData();
    params.startDate = beginDateEl.getValue();
    params.endDate = endDateEl.getValue();
    params.carNo = nui.get("carNo-search").getValue();
    params.guestFullName = nui.get("guestName").getValue();
    params.isSettle=1;
    return params;
}
function onSearch()
{
	var params=getSearchParams();
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
    searchData.isSettle=1;
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

function onAdvancedSearchClear(){
	advancedSearchForm.setData([]);
	beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = leftGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerPartGrid.setData([]);
    
    var serviceId = row.id;
    innerPartGrid.load({
    	serviceId:serviceId,
        token: token
    });
}
