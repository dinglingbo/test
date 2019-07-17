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
    <title>账户余额表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/report/js/finance/accountBalance.js?v=1.0.1"></script>
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
        
        <input id="accountId" width="100px" textField="name" valueField="id" emptyText="结算账户" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        <span class="separator"></span> 
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-select fa-lg"></span>&nbsp;查询</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:1000px;height:100%;" 
             showPager="true"  dataField="list"   url="" sortMode="client" ondrawcell=""
              pageSize="100" sizeList="[50,100,200,500]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
                <div field="settAccountCode" name="code" width="70" summaryType="count"  headeralign="center" >账户编码</div>
                <div field="settAccountName" name="name" width="140"  headeralign="center" >账户名称</div>
                <div field="fyear" name="fyear" width="60"  headeralign="center" >年份</div>
                <div field="fmonth" name="fmonth" width="60"  headeralign="center" >月份</div>
                <div field="beginBala" name="beginBala" width="70"  headeralign="center" >期初</div>
                <div field="debit" name="debit" width="70" summaryType="sum"  headeralign="center" >收入</div>
                <div field="credit" name="credit" width="70" summaryType="sum"  headeralign="center" >支出</div>
                <div field="endBala" name="endBala" width="70"  headeralign="center" >余额</div>
           
            </div>
        </div>
    </div>

</body>
</html>