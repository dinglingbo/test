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
 var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"客户名称"},{id:"2",name:"手机号"}];
 var editFormDetail = null;
 var innerPartGrid = null;
 var orgidsEl = null;
 var settleTypeIdList=[{id :1,name :"保司直收"},{id :2,name :"门店代收全款"},{id :3,name :"代收减返点"}];
 $(document).ready(function ()
 {
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");     
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    nui.get("search-type").setData(statusList);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getInsuranceUrl);

	  var filter = new HeaderFilter(leftGrid, {
	        columns: [
	            { name: 'saleMans' },
	            { name: 'guestName' },
		        { name: 'mtAdvisor' },
	            { name: 'insureTypeName' },
	            { name: 'carModel' },
	            { name: 'insureCompName' },
	            { name: 'carNo' },
	            {name: 'serviceCode'}
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
    leftGrid.on("drawcell", function (e) {
 
        if(e.field == "settleTypeId"){
        	 e.cellHtml = settleTypeIdList[e.value-1].name ||"";
        }else if(e.field == "drtnCompRate"){
        	e.cellHtml = e.value + "%";
        }else if(e.field == "drtnGuestRate"){
        	e.cellHtml = e.value + "%";
        }else if(e.field == "grossProfitRate"){
        	var rate = e.value * 100;
        	rate = rate.toFixed(2);
        	e.cellHtml = rate + "%";
        }else if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });
    leftGrid.on("rowclick", function (e) {
        var row = e.record;

    });  
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
        if((keyCode==27))  {  //ESC
        	advancedSearchWin.hide();
	   };
     };
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
    var data = advancedSearchForm.getData();
    params.soutDate = beginDateEl.getFormValue();
    params.eoutDate = addDate(endDateEl.getFormValue(),1);
  /*  params.carNo = nui.get("carNo-search").getValue();
    params.guestFullName = nui.get("guestName").getValue();*/
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    params.isSettle=1;
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
	
    leftGrid.load({
        token:token, 
        params: params
    },function(){
    	mergeCells();
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
function carNoSearch(){
	onSearch();
}
function guestNameSearch(){
	onSearch();
}


function mergeCells(){//动态合并行
	var dataAll = leftGrid.getData();
       var arr = new Array;
        for(var i = 0 ; i < dataAll.length ;i ++){
    		if(arr.indexOf(dataAll[i].id) == -1){
    			arr[arr.length] = dataAll[i].id;
    		}
        }
        var brr = new Array;
       		for(var i = 0 ; i < arr.length ; i ++){
       			var row = leftGrid.findRow(function(row){
       				if(arr[i] == row.id){
       					var index = leftGrid.indexOf(row);
       					brr[i] = index;
       				}
       			});    
       		}
	var cells = [];
	for(var i = 0 ; i < arr.length;i ++){
		 var index = brr[i];
		 index = parseInt(index);
		 if(i == 0){
			 cells[0] = { rowIndex: 0, columnIndex: 1, rowSpan: index + 1, colSpan: 0 };
			 cells[1] = { rowIndex: 0, columnIndex: 2, rowSpan: index + 1, colSpan: 0 };
			 cells[2] = { rowIndex: 0, columnIndex: 3, rowSpan: index + 1, colSpan: 0 };
			 cells[3] = { rowIndex: 0, columnIndex: 4, rowSpan: index + 1, colSpan: 0 };
			 cells[4] = { rowIndex: 0, columnIndex: 5, rowSpan: index + 1, colSpan: 0 };
			 cells[5] = { rowIndex: 0, columnIndex: 6, rowSpan: index + 1, colSpan: 0 };
			 cells[6] = { rowIndex: 0, columnIndex: 7, rowSpan: index + 1, colSpan: 0 };
			 cells[7] = { rowIndex: 0, columnIndex: 8, rowSpan: index + 1, colSpan: 0 };
			 cells[8] = { rowIndex: 0, columnIndex: 9, rowSpan: index + 1, colSpan: 0 };
			 cells[9] = { rowIndex: 0, columnIndex: 10, rowSpan: index + 1, colSpan: 0 };
			 cells[10] = { rowIndex: 0, columnIndex: 11, rowSpan: index + 1, colSpan: 0 };
			 cells[11] = { rowIndex: 0, columnIndex: 12, rowSpan: index + 1, colSpan: 0 };
			 cells[12] = { rowIndex: 0, columnIndex: 13, rowSpan: index + 1, colSpan: 0 };
			 cells[13] = { rowIndex: 0, columnIndex: 14, rowSpan: index + 1, colSpan: 0 };
			 cells[14] = { rowIndex: 0, columnIndex: 15, rowSpan: index + 1, colSpan: 0 };
			 cells[15] = { rowIndex: 0, columnIndex: 16, rowSpan: index + 1, colSpan: 0 };
			 cells[16] = { rowIndex: 0, columnIndex: 17, rowSpan: index + 1, colSpan: 0 };
			 cells[17] = { rowIndex: 0, columnIndex: 18, rowSpan: index + 1, colSpan: 0 };
			 cells[18] = { rowIndex: 0, columnIndex: 19, rowSpan: index + 1, colSpan: 0 };
			 cells[19] = { rowIndex: 0, columnIndex: 20, rowSpan: index + 1, colSpan: 0 };
		 }else{
		 	 var last = brr[i-1];
		 	 last = parseInt(last);
		 	 var one = brr[i];
		 	 one = parseInt(one);
		 	 cells[20*i+0] = { rowIndex: last + 1, columnIndex: 1, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+1] = { rowIndex: last + 1, columnIndex: 2, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+2] = { rowIndex: last + 1, columnIndex: 3, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+3] = { rowIndex: last + 1, columnIndex: 4, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+4] = { rowIndex: last + 1, columnIndex: 5, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+5] = { rowIndex: last + 1, columnIndex: 6, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+6] = { rowIndex: last + 1, columnIndex: 7, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+7] = { rowIndex: last + 1, columnIndex: 8, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+8] = { rowIndex: last + 1, columnIndex: 9, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+9] = { rowIndex: last + 1, columnIndex: 10, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+10] = { rowIndex: last + 1, columnIndex: 11, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[20*i+11] = { rowIndex: last + 1, columnIndex: 12, rowSpan: one - last, colSpan: 0 };
		 	 cells[20*i+12] = { rowIndex: last + 1, columnIndex: 13, rowSpan: one - last, colSpan: 0 };
		 	 cells[20*i+13] = { rowIndex: last + 1, columnIndex: 14, rowSpan: one - last, colSpan: 0 };
		 	 cells[20*i+14] = { rowIndex: last + 1, columnIndex: 15, rowSpan: one - last, colSpan: 0 };
		 	 cells[20*i+15] = { rowIndex: last + 1, columnIndex: 16, rowSpan: one - last, colSpan: 0 };
		 	cells[20*i+16] = { rowIndex: last + 1, columnIndex: 17, rowSpan: one - last, colSpan: 0 };
		 	cells[20*i+17] = { rowIndex: last + 1, columnIndex: 18, rowSpan: one - last, colSpan: 0 };
		 	cells[20*i+18] = { rowIndex: last + 1, columnIndex: 19, rowSpan: one - last, colSpan: 0 };
		 	cells[20*i+19] = { rowIndex: last + 1, columnIndex: 20, rowSpan: one - last, colSpan: 0 };
		 }
	}
	leftGrid.mergeCells(cells);
}




function onExport(){
	var detail = leftGrid.getData();
//多级
	exportMultistage(leftGrid.columns)
//单级
       //exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		detail[i].settleTypeId=settleTypeIdList[detail[i].settleTypeId-1].name;
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,leftGrid.columns,"车险开单明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
}