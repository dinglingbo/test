<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
  <title>微信素材</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<%@include file="/common/commonRepair.jsp"%>
</head>
<body>
  <div class="nui-toolbar" style="padding:2px;border-bottom: 0" id="queryForm">
    <table style="width:100%;">
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
         上传时间:
         <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
         <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
         <label>类型：</label>
         <input class="nui-textbox" name="" id="" enabled="true"/>
         <label>名字：</label>
         <input class="nui-combobox" name="" id="" enabled="true"/>

         <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
       </tr>
     </table>
   </div>

   <div class="nui-fit">
    <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
    pageSize="50"
    multiSelect="false"
    totalField="page.count"
    sizeList=[20,50,100,200]
    dataField="list"
    onrowdblclick=""
    allowCellSelect="true"
    allowCellWrap = true
    ondrawcell=""
    >
    <div property="columns">
      <div type="checkcolumn" ></div>    
      <div type="indexcolumn" headerAlign="center" header="序号"></div>
      <div field="" name="" width="80" headerAlign="center" header="文件名字"></div>
      <div field="" name="" width="80" headerAlign="center" header="文件类型"></div>
      <div field="" name="" width="80" headerAlign="center" header="上传地址"></div>
      <div field="" name="" width="80" headerAlign="center" header="缩略图"></div>
      <div field="" name="" width="80" headerAlign="center" header="上传时间" dateFormat="yyyy-MM-dd HH:mm"></div>
    </div>
  </div>


</div>

<script type="text/javascript">
  nui.parse();

  var startDateEl =nui.get('startDate');
  var endDateEl = nui.get('endDate');
  var currType = 2;
  quickSearch(1);
  function quickSearch(type){
    //var params = getSearchParams();
    var params = {};
    var queryname = "本日";
    switch (type)
    {
      case 0:
      params.today = 1;
      params.startDate = getNowStartDate();
      params.endDate = addDate(getNowEndDate(), 1);
      queryname = "本日";
      break;
      case 1:
      params.yesterday = 1;
      params.startDate = getPrevStartDate();
      params.endDate = addDate(getPrevEndDate(), 1);
      queryname = "昨日";
      break;
      case 2:
      params.thisWeek = 1;
      params.startDate = getWeekStartDate();
      params.endDate = addDate(getWeekEndDate(), 1);
      queryname = "本周";
      break;
      case 3:
      params.lastWeek = 1;
      params.startDate = getLastWeekStartDate();
      params.endDate = addDate(getLastWeekEndDate(), 1);
      queryname = "上周";
      break;
      case 4:
      params.thisMonth = 1;
      params.startDate = getMonthStartDate();
      params.endDate = addDate(getMonthEndDate(), 1);
      queryname = "本月";
      break;
      case 5:
      params.lastMonth = 1;
      params.startDate = getLastMonthStartDate();
      params.endDate = addDate(getLastMonthEndDate(), 1);
      queryname = "上月";
      break;

      case 10:
      params.thisYear = 1;
      params.startDate = getYearStartDate();
      params.endDate = getYearEndDate();
      queryname="本年";
      break;
      case 11:
      params.lastYear = 1;
      params.startDate = getPrevYearStartDate();
      params.endDate = getPrevYearEndDate();
      queryname="上年";
      break;
      default:
      break;
    }
    currType = type;
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    //doSearch(params);
  }



</script>
</body>
</html>