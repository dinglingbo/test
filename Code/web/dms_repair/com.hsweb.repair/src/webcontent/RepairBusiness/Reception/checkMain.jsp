<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description: 
-->   

<head>
  <title>检查开单</title>  
  <style type="text/css">
  .title {
    width: 60px;
    text-align: right;
}

.form_label {
    width: 72px;
    text-align: right;
}

.required { 
    color: red;
}

.rmenu { 
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px; 
    background-size: 50%;
}
</style>

</head>

<body>
  <div class="nui-toolbar" id="toolbar1" style="padding:2px;border-bottom:0;">

    <table class="table" id="table1"> 
      <tr>
        <td>
         	 <label style="font-family:Verdana;">快速查询：</label>
                    
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                </ul>
          
          <input class="nui-textbox" id="guestName" name="guestName" emptyText="输入客户姓名" width="120"  onenter="onenterGuestName(this.value)"/>
          <input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="请输入单号" width="120" onenter="onenterServiceCode(this.value)"/>
          <input class="nui-textbox" id="carNo" name="carNo" emptyText="输入车牌号" width="120" onenter="onenterCarNo(this.value)"/>
          <label class="form_label">开单日期&nbsp;从：</label>
          <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="sRecordDate" id = "sRecordDate" value=""/>
          <label class="form_label">至：</label>
          <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="eRecordDate" id = "eRecordDate" value=""/>
        
          <a class="nui-button" iconCls="" plain="true" onclick="onSearch">
           <span class="fa fa-search fa-lg"></span>&nbsp;查询
        </a>
        <span class="separator"></span>
   <!--        <a class="nui-button" iconCls="" plain="true" onclick="newCheckPrecheck" id="">
     <span class="fa fa-plus fa-lg"></span>&nbsp;新建接车预检
 </a>-->
 <a class="nui-button" iconCls="" plain="true" onclick="add()" id="save">
   <span class="fa fa-plus fa-lg"></span>&nbsp;新增
</a> 
<a class="nui-button" iconCls="" plain="true" onclick="edit()" id="edit">
    <span class="fa fa-edit fa-lg"></span>&nbsp;修改
</a>
<!-- <a class="nui-button" iconCls="" plain="true" onclick="ToCheckDetail(3)" id="view">
    <span class="fa fa-file-text-o fa-lg"></span>&nbsp;查看
</a> -->
</td>
</tr>
</table> 
</div> 

<div class="nui-fit">
  <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
  totalField="page.count" sizeList=[20,50,100,200] dataField="list" onrowdblclick="" allowCellSelect="true" editNextOnEnterKey="true"
  onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
  <div property="columns">
	<div width="10" type="indexcolumn">序号</div>
    <div field="id" name="id" visible="false">id</div>
    <div field="carNo" name="carNo" width="40" headerAlign="center" align="center">车牌号</div>
    <div field="carModel" name="carModel" width="80" headerAlign="center" align="center">品牌车型</div>
    <div field="carVin" name="carVin" width="80px" headerAlign="center" align="center" header="">车架号(VIN)</div>
    <div field="checkMainName" name="checkMainName" width="80" headerAlign="center" align="center">检查模板</div>
    <div field="checkMan" name="checkMan" width="80" headerAlign="center" align="center">查车技师</div>
    <div field="checkManId" name="checkManId" width="60" headerAlign="center" align="center" visible="false">查车技师Id</div>
    <div field="checkPoint" name="checkPoint" width="60" headerAlign="center" align="center">本次检查得分</div>
    <div field="recordDate" name="recordDate" width="60" headerAlign="center" align="center" dateFormat="yyyy-MM-dd HH:mm">查车时间</div>
</div>
</div>
</div>

<script type="text/javascript">
  nui.parse();
  var form = new nui.Form("#table1");
  var webBaseUrl = webPath + contextPath + "/";
  var baseUrl = apiPath + repairApi + "/";
  var gridUrl = baseUrl + "com.hsapi.repair.repairService.repairInterface.QueryCheckMainList.biz.ext";
  var mainGrid = nui.get("mainGrid"); 
  mainGrid.setUrl(gridUrl);
  beginDateEl = nui.get("sRecordDate");
  endDateEl = nui.get("eRecordDate");
  var searchFlag=0;
	if(searchFlag==0){	
		quickSearch(2);
	}
  	mainGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "serviceCode":
                e.cellHtml='<a href="##" onclick="edit()">'+e.value+'</a>';
                break;
                case "carNo":
                e.cellHtml ='<a href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
            default:
                break;
        }

    });
  	
  
//   var date = new Date();
//   var sdate = new Date();
//   sdate.setMonth(date.getMonth()-3);
//   endDateEl.setValue(date);
//   beginDateEl.setValue(sdate);

 

/*  function selectModel(){
    nui.open({
      url:"com.hsweb.repair.DataBase.checkMainSelect.flow",
      title:"选择模板",
      height:"300px",
      width:"400px",
      onload:function(){ 

      },
      ondestroy:function(action){

      } 

    });
}*/
	
	
function getSearchParam(){
	var params = form.getData();
    params.orgid = currOrgId;
    params.sRecordDate = beginDateEl.getFormValue().substr(0,10);
    params.eRecordDate = addDate(endDateEl.getValue(),1);
    return params;
}
function doSearch(params){
	mainGrid.load({ 
      params:params,
      token:token
  });
}
  function onSearch(){
  	var params = getSearchParam();
    doSearch(params);
}
function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "所有";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sRecordDate = getNowStartDate();
            params.eRecordDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sRecordDate = getPrevStartDate();
            params.eRecordDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sRecordDate = getWeekStartDate();
            params.eRecordDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sRecordDate = getLastWeekStartDate();
            params.eRecordDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sRecordDate = getMonthStartDate();
            params.eRecordDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sRecordDate = getLastMonthStartDate();
            params.eRecordDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sRecordDate = getYearStartDate();
            params.eRecordDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sRecordDate = getPrevYearStartDate();
            params.eRecordDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;       
        default:      	
            break;
    }
    
    beginDateEl.setValue(params.sRecordDate);
    endDateEl.setValue(addDate(params.eRecordDate,-1));
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
   
    doSearch(params);
}
function setInitData(params){
 searchFlag=1;
  params.orgid=currOrgId;
  mainGrid.load({ 
      params:params, 

      token:token 
  });
}


function newCheckPrecheck() {
    var item={};
    item.id = "checkPrecheckDetail";
    item.text = "接车预检单";
    item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/checkPrecheckDetail.jsp";
    item.iconCls = "fa fa-cog";
    window.parent.activeTab(item);
}

mainGrid.on("celldblclick",function(e){
    edit();
});

function add(){
    var part={};
    part.id = "checkPrecheckDetail";
    part.text = "查车开单详情";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {
        isCheckMain:"Y"
    };
    window.parent.activeTabAndInit(part,params);

}
function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var part={};
    part.id = "checkPrecheckDetail";
    part.text = "查车开单详情";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id,
        isCheckMain:"Y"
    };
    window.parent.activeTabAndInit(part,params);
}



function onenterServiceCode(){
     onSearch();
}

function onenterGuestName(){
     onSearch();
}

function onenterCarNo(){
     onSearch();
}

function showCarInfo(row_uid){
	var row = mainGrid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.carId,
				carNo : row.carNo,
				guestId : row.guestId,
				contactorId:row.contactorId
		};
		doShowCarInfo(params);
	}
}

function doShowCarInfo(params) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.carDetails.flow?token="+token,
        width: 800, height: 500,
		allowResize: false,
		showHeader: true,
        onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action) {
            if ("ok" == action) {
            }
        }
    });
}



</script>

</body>

</html>