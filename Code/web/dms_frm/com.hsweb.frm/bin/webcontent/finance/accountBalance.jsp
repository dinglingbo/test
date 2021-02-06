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
    <title>账户余额表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/accountBalance.js?v=1.0.1"></script>
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
    	<a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>
    	<ul id="popupMenuDate" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch(0)" id="type0">本月</li>
            <li iconCls="" onclick="quickSearch(1)" id="type1">上月</li>
            <li iconCls="" onclick="quickSearch(2)" id="type2">本季</li>
            <li iconCls="" onclick="quickSearch(3)" id="type3">本年</li>
            <li iconCls="" onclick="quickSearch(4)" id="type4">上年</li>
        </ul>
        <span class="separator"></span>
        <label style="font-family:Verdana;">开始日期 从：</label>
        <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        
        <input id="accountId" width="100px" textField="name" valueField="id" emptyText="结算账户" class="nui-combobox" allowinput="true" onvalueChanged="doSearch()" valueFromSelect="true"/>
        <span class="separator"></span> 
        <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             showPager="true"  dataField="list"   url="" sortMode="client" ondrawcell=""
              pageSize="500" sizeList="[500,1000,2000]" showSummaryRow="true" sortMode="client">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="20">序号</div>
                <div field="settAccountCode" name="code" width="60" summaryType="count"  headeralign="center" allowsort="true" >账户编码</div>
                <div field="settAccountName" name="settAccountName" width="100"  headeralign="center" allowsort="true">账户名称</div>
                <div field="fyear" name="fyear" width="50"  headeralign="center" allowsort="true">年份</div>
                <div field="fmonth" name="fmonth" width="50"  headeralign="center" allowsort="true" >月份</div>
                <div field="beginBala" name="beginBala" width="60"  headeralign="center" allowsort="true">期初</div>
                <div field="debit" name="debit" width="60" summaryType="sum"  headeralign="center" allowsort="true" dataType="float">收入</div>
                <div field="credit" name="credit" width="60" summaryType="sum"  headeralign="center" allowsort="true" dataType="float">支出</div>
                <div field="endBala" name="endBala" width="60"  headeralign="center" summaryType="sum" allowsort="true" dataType="float">余额</div>
                <!-- <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div> -->
           
            </div>
        </div>
    </div>
<div id="exportDiv" style="display:none">  
</div>
</body>
</html>