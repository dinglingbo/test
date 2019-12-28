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
    <title>总部付款明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/report/js/finance/hqAccountPDetail.js?v=1.0.16"></script>
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
        <input id="advanceGuestId" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." onbuttonclick="selectSupplier('advanceGuestId')" width="150px" selectOnFocus="true" />


        <input id="isMain" width="100px" data="pList" textField="text" valueField="id"  emptyText="是否主营业务" class="nui-combobox" allowinput="true" valueFromSelect="true"/>
        
        <span class="separator"></span> 
        <a class="nui-button" iconCls="" plain="true" onclick="doSearch()"><span class="fa fa-select fa-lg"></span>&nbsp;查询</a>
    </div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"  onshowrowdetail="onShowRowDetail"
             ondrawcell="onDrawCell" showPager="true"  dataField="list"   url="" sortMode="client" 
             pageSize="100" sizeList="[50,100,200,500]" showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn"  headeralign="center" width="30">序号</div>
                <div type="expandcolumn"  width="20" >#</div>
                <div field="settAccountId" name="code" width="60" summaryType="count"  headeralign="center" >账户编码</div>
                <div field="settAccountId" name="name" width="100"  headeralign="center" >账户名称</div>
                <div field="isPrimaryBusiness" name="name" width="100"  headeralign="center" >是否主营业务</div>
                <div field="shortName" name="name" width="130"  headeralign="center" >供应商简称</div>
                <div field="rAmt" name="rAmt" width="50" summaryType="sum" headeralign="center" >应收金额</div>
                <div field="pAmt" name="charOffAmt" width="50" summaryType="sum" headeralign="center" >应付金额</div>
                <div field="sumAmt" name="charOffAmt" width="70" summaryType="sum" headeralign="center" >应收应付金额</div>
                <div field="rBillQty" name="charOffAmt" width="70" summaryType="sum" headeralign="center" >应收单据数量</div>
                <div field="pBillQty" name="charOffAmt" width="80" summaryType="sum" headeralign="center" >应付单据数量</div>
                <div field="sumQty" name="sumQty" width="70" summaryType="sum" headeralign="center" >总单据数量</div>
                <div field="auditor" name="auditor" width="60"  headeralign="center" >付款人</div>
                <div field="remark" name="remark" width="100"  headeralign="center" >备注</div>
                <div field="auditDate" name="auditDate" width="120" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" >付款日期</div>
                <div field="fullName" name="name" width="180"  headeralign="center" >供应商全称</div>
           
            </div>
        </div>

    </div>

<div id="editFormtDetail" style="display:none;">
    <div id="innerGrid" class="nui-datagrid" style="width:100%;height:150px"
       showPager="false"
       dataField="list"
       idField="id"
       showSummaryRow="true"     
       ondrawcell="onDrawCell" 
       oncellbeginedit=""
       showModified="false"
       multiSelect="true"
       editNextOnEnterKey="true"
       onshowrowdetail=""
       url="">
      <div property="columns">
        <div type="indexcolumn"  headeralign="center" width="30">序号</div>
        <div field="settAccountId" name="code" width="60" summaryType="count"  headeralign="center" >账户编码</div>
        <div field="settAccountId" name="name" width="100"  headeralign="center" >账户名称</div>
        <div field="orgName" name="name" width="100"  headeralign="center" >公司名称</div>
        <div field="billServiceId" name="name" width="180"  headeralign="center" >业务单号</div>
        <div field="billTypeId" name="name" width="100"  headeralign="center" >收支类型</div>
        <div field="isPrimaryBusiness" name="name" width="100"  headeralign="center" >是否主营业务</div>
        <div field="shortName" name="name" width="120"  headeralign="center" >客户简称</div>
        <div field="charOffAmt" name="charOffAmt" width="60" summaryType="sum" headeralign="center" >付款金额</div>
        <div field="auditor" name="auditor" width="60"  headeralign="center" >付款人</div>
        <div field="remark" name="remark" width="100"  headeralign="center" >备注</div>
        <div field="auditDate" name="auditDate" width="120" dateFormat="yyyy-MM-dd HH:mm" headeralign="center" >付款日期</div>
        <div field="fullName" name="name" width="180"  headeralign="center" >客户全称</div>
   
    </div>
  </div>
</div>

</body>
</html>