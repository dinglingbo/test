/**
 * Created by Administrator on 2018/4/25.
 */
 var baseUrl = apiPath + repairApi + "/";
 var leftGrid = null;
 var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.repairInterface.queryCheckMainDetailList.biz.ext";
 var getInsuranceUrl=baseUrl+"com.hsapi.repair.baseData.query.QueryRpsCheckDetailList.biz.ext";
 
 var statusHash = ["草稿","提交","完成"];
 var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"},{id:"2",name:"手机号"}];
 var editFormDetail = null;
 var innerPartGrid = null;
 var checkTypeList = [];
 var checkTypeHash = {};
 var settleTypeIdList=[{id :1,name :"保司直收"},{id :2,name :"门店代收全款"},{id :3,name :"代收减返点"}];
 var statusHash = {
		    "0":"未检",
		    "1":"正常",
		    "-1":"异常"
};
 $(document).ready(function ()
 {
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    nui.get("search-type").setData(statusList);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getInsuranceUrl);
    innerPartGrid.on("drawcell",function (e){
    	if(e.field == "status"){
       	 e.cellHtml = statusHash[e.value] || "";
        }
    	if(e.field == "settleType"){
    		e.cellHtml = e.value = 1?"本次处理":"下次处理";
    	}
    	if(e.field == "checkType"){
    		e.cellHtml = checkTypeHash[e.value].name;
    	}
    })
    
    leftGrid.on("drawcell", function (e) {
 
        if(e.field == "settleTypeId"){
        	 e.cellHtml = settleTypeIdList[e.value-1].name ||"";
        }
    });
    leftGrid.on("rowclick", function (e) {
        var row = e.record;

    });  
    var dictDefs ={"checkTypeA":"10081"};
    initDicts(dictDefs, function(e){
    	checkTypeList=nui.get('checkTypeA').getData(); 
    	checkTypeList.forEach(function(v) {
    		checkTypeHash[v.customid] = v;
        });
    });
    initMember("mtAdvisorId",function(){
    });
    quickSearch(4);
}); 

 var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
 var currType = 0;
/* function quickSearch(type) {

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
    if(type==2){
    	beginDateEl.setValue(addDate(dateObj.startDate,1));
        endDateEl.setValue(addDate(dateObj.endDate,1));
    }else{
    	beginDateEl.setValue(dateObj.startDate);
        endDateEl.setValue(dateObj.endDate);
    }
    advancedSearchForm.setData(data);
    var params = getSearchParams();
    
    doSearch(params);
}*/
 
 function quickSearch(type){
    var params = getSearchParams();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 6:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 7:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    onSearch();
}
function getSearchParams()
{
    var params = {};
    params.sRecordDate = beginDateEl.getFormValue();
    params.eRecordDate = addDate(endDateEl.getFormValue(),1);
    params.checkMan = nui.get("mtAdvisorId").getText();
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.name = typeValue;
    }else if(type==2){
        params.mobile = typeValue;
    }
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

/*function onAdvancedSearchOk()
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
*/
/*function onAdvancedSearchClear(){
	advancedSearchForm.setData([]);
	beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}*/
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = leftGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerPartGrid.setData([]);
    
    var serviceId = row.id;
    innerPartGrid.load({
    	mainId:row.id,
        token: token
    });
}



