<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>供应商欠款明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/accountPBillDetail.js?v=1.0.2"></script>
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
        
        <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." onvalueChanged="doSearch()" onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
        <input id="settleStatus" width="100px" data="settleStatusList" textField="text" valueField="id" onvalueChanged="doSearch()" emptyText="结算状态" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <span class="separator"></span> 
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client" 
             pageSize="100" sizeList="[50,100,200,500]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="20">序号</div>
                <div field="billServiceId" name="name" summaryType="count" width="100"  headeralign="center" >业务单号</div>
                <div field="billTypeId" name="name" width="100"  headeralign="center" >收支类型</div>
                <div field="shortName" name="shortName" width="100"  headeralign="center" >供应商简称</div>
                <div field="rpAmt" name="rpAmt" width="50" summaryType="sum" headeralign="center" >应付金额</div>
                <div field="trueCharOffAmt" name="trueCharOffAmt" summaryType="sum" width="60"  headeralign="center" >已付金额</div>
                <div field="noCharOffAmt" name="noCharOffAmt" summaryType="sum" width="60"  headeralign="center" >未付金额</div>
                <div field="settleStatus" name="settleStatus" width="100" headeralign="center" >结算状态</div>
                <div field="auditDate" name="auditDate" width="100" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" >单据日期</div>
                <div field="fullName" name="name" width="120"  headeralign="center" >供应商全称</div>
           
            </div>
        </div>

    </div>

</body>
</html>