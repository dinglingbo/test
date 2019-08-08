<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>账户结算明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/accountDetail.js?v=1.0.0"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: "微软雅黑";
    }


</style>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
       	<label style="font-family:Verdana;">快速查询：</label>
    	<a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本周</a>
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
        
        <input id="rpDc" width="100px" data="dcList" textField="text" valueField="id" onvalueChanged="doSearch()" emptyText="收/支" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <input id="accountId" width="100px" textField="name" valueField="id" emptyText="结算账户" onvalueChanged="doSearch()" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择往来单位..." onvalueChanged="doSearch()" onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
        <span class="separator"></span> 
        <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client" 
             pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="20">序号</div>
                <div field="settAccountCode" name="code" width="60" summaryType="count" allowsort="true"  headeralign="center" >账户编码</div>
                <div field="settAccountName" name="name" width="100"  headeralign="center" allowsort="true" >账户名称</div>
                <div field="shortName" name="shortName" width="100"  headeralign="center" allowsort="true">客户简称</div>
                <div field="carNo" name="carNo" width="80"  headeralign="center" allowsort="true">车牌号</div>
                <div field="billTypeId" name="rpDc" width="70"  headeralign="center" allowsort="true">收支类型</div>
                <div field="rpDc" name="rpDc" width="50"  headeralign="center" allowsort="true">收/支</div>
                <div field="charOffAmt" name="charOffAmt" width="50" summaryType="sum" headeralign="center" allowsort="true" dataType="float">结算金额</div>
                <div field="auditor" name="auditor" width="60"  headeralign="center" allowsort="true">结算人</div>
                <div field="auditDate" name="auditDate" width="100" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowsort="true">结算日期</div>
                <div field="fullName" name="name" width="120"  headeralign="center" allowsort="true">客户全称</div>
                 <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
           
            </div>
        </div>

    </div>
<div id="exportDiv" style="display:none">  
</div>
</body>
</html>