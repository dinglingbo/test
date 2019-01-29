<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>收款明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp"%>
    <script src="<%=webPath + contextPath%>/frm/js/finance/accountRDetail.js?v=1.1.2"></script>
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
        
        <input id="accountId" width="100px" textField="name" valueField="id" emptyText="结算账户" onvalueChanged="onSearch()" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择客户..." onvalueChanged="onSearch()" onbuttonclick="selectSupplier('advanceGuestId')" allowInput="false" width="150px" selectOnFocus="true" />

        <input id="isMain" width="100px" data="pList" textField="text" valueField="id"  emptyText="是否主营业务" onvalueChanged="onSearch()" class="nui-combobox" allowinput="true" valueFromSelect="true"/>

        <span class="separator"></span> 
        <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client" 
             pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="40">序号</div>
                <div field="settAccountId" name="code" width="60" summaryType="count"  headeralign="center" visible="false" allowsort="true">账户编码</div>
                <div field="settAccountId" name="name" width="100"  headeralign="center" visible="false" allowsort="true">账户名称</div>
                <div field="billServiceId" name="billServiceId" width="150"  headeralign="center" summaryType="count" allowsort="true">业务单号</div>
                <div field="billTypeId" name="name" width="100"  headeralign="center" allowsort="true">收支类型</div>
                <div field="isPrimaryBusiness" name="name" width="100"  headeralign="center" allowsort="true">是否主营业务</div>
                <div field="shortName" name="shortName" width="100"  headeralign="center" allowsort="true">客户简称</div>
                <div field="carNo" name="carNo" width="70"  headeralign="center" allowsort="true">车牌号</div>
                <div field="charOffAmt" name="charOffAmt" width="50" summaryType="sum" headeralign="center" allowsort="true">收款金额</div>
                <div field="feeService" name="feeService" width="50" summaryType="sum" headeralign="center" allowsort="true" >手续费</div>
                <div field="trueInoutAmt" name="trueInoutAmt" width="50" summaryType="sum" headeralign="center" allowsort="true">实收金额 </div>
                <div field="auditor" name="auditor" width="60"  headeralign="center" allowsort="true">收款人</div>
                <div field="auditDate" name="auditDate" width="100" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowsort="true">收款日期</div>
                <div field="fullName" name="name" width="120"  headeralign="center" allowsort="true">客户全称</div>
           
            </div>
        </div>

    </div>

</body>
</html>