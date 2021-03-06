<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
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
    <script src="<%=webPath + contextPath%>/report/js/finance/accountPBillDetail.js?v=1.0.5"></script>
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
        <label style="font-family:Verdana;">开始日期 从：</label>
        <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
        
        <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />
        <input class="nui-combobox" id="elBillTypeId" name="elBillTypeId" 
               textField="name" valueField="id" allowInput="true"
         nullitemtext="请选择..." emptyText="收支项目"  />
        <input id="settleStatus" width="100px" data="settleStatusList" textField="text" valueField="id"  emptyText="结算状态" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <span class="separator"></span> 
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" 
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client"  allowSort="true"
             pageSize="500" sizeList="[500,2000,3000]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
                <div field="billServiceId" name="name" summaryType="count" width="100"  headeralign="center"  allowSort="true" dataType="string">业务单号 </div>
                <div field="billTypeId" name="name" width="100"  headeralign="center" allowSort="true" dataType="string">收支类型</div>
                <div field="shortName" name="shortName" width="120"  headeralign="center" allowSort="true" dataType="string">供应商简称</div>
                <div field="rpAmt" name="rpAmt" width="60" summaryType="sum" headeralign="center" >应付金额</div>
                <div field="trueCharOffAmt" name="trueCharOffAmt" summaryType="sum" width="60"  headeralign="center" >已付金额</div>
                <div field="noCharOffAmt" name="noCharOffAmt" summaryType="sum" width="60"  headeralign="center" >未付金额</div>
                <div field="settleStatus" name="settleStatus" width="100" headeralign="center" allowSort="true" dataType="string">结算状态</div>
                <div field="auditDate" name="auditDate" width="120" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" allowSort="true" dataType="date" >单据日期</div>
                <div field="fullName" name="name" width="180"  headeralign="center" allowSort="true" dataType="string">供应商全称</div>
                <div field="fYear" name="fYear" width="80"  headeralign="center" >年份</div>
                <div field="fMonth" name="fMonth" width="80"  headeralign="center" >月份</div>           
            </div>
        </div>

    </div>

<div id="exportDiv" style="display:none"> 
</div>
</body>
</html>