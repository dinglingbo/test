<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-28 11:08:40
  - Description:
-->
<head>
<title>充值消费记录表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
                <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/tenant/js/sysCoinRecord.js?v=1.0.4" type="text/javascript"></script>
<!--    <script src="<%= request.getContextPath() %>/common/nui/boot.js?v=1.0.0" type="text/javascript"></script>-->
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
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
        <span class="separator"></span>
        <label style="font-family:Verdana;">开始日期 从：</label>
        <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>      
		<input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" onvalueChanged="onSearch()" allowInput="false"/>
        <input class="nui-textbox" id="productName" emptyText="产品名称" width="120"  onenter="onSearch()"/>

        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--          <input type="button" value="导出Excel" onclick="ExportExcel()" style="margin-left:50px;"/> -->
<!--         <a class="nui-button" iconCls="" plain="true" onclick="print()"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> -->
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client" 
             pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true" allowResize="true" multiSelect="true" >
            <div property="columns">   
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
<!--            <div type="checkcolumn" field="check" width="20" header="选择"></div> -->
                <div field="productName" name="productName" width="80"  headeralign="center" summaryType="count" allowsort="true" >产品名称</div>
                <div name="callStatus" field="callStatus"  width="60"  headeralign="center"  allowsort="true" >购买/调用结果  </div>         
                <div field="costPrice" name="costPrice" width="60"  headeralign="center" summaryType="sum" allowsort="true" >支付金额</div>              
                <div field="costCoin" name="costCoin" width="60" summaryType="sum" headeralign="center" allowsort="true" dataType="float">链车币数量</div>
                <div field="balaCoin" name="balaCoin" width="60"  headeralign="center" allowsort="true" dataType="float">链车币剩余数量</div>
                <div field="recordDate" name="recordDate" width="120" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowsort="true" >时间</div>
            </div>
        </div>
    </div>
<div id="exportDiv" style="display:none">  
</div>
<iframe id="exportIFrame" style="display:none;"></iframe> 

</body>
</html>