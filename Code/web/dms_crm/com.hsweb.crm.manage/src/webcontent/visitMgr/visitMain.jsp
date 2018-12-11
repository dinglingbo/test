<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description:  
--> 
<head>  
    <title>工单回访</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/manage/js/visitMgr/visitMain.js?v=1.0.4" type="text/javascript"></script>
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
    <input name="serviceTypeId"id="serviceTypeId" visible="false"class="nui-combobox"textField="name"valueField="id"/>
    <input name="carBrandId"id="carBrandId" visible="false"class="nui-combobox"textField="name"valueField="id"/>
    <div class="nui-toolbar">
        <label style="font-family:Verdana;">快速查询：</label>
        <a href="##" iconCls="" plain="true" onclick="quickSearch(1)">我接待的车辆</a>
        <a href="##" iconCls="" plain="true" onclick="quickSearch(2)">所有维修车辆</a>
        <label style="font-family:Verdana;">车牌号：</label>
        <input class="nui-textbox" name="tcarNo" id="tcarNo">
        <a class="nui-button" plain="true" onclick="quickSearch(3)" iconcls="" plain="false"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <span class="separator"></span>
        <!-- <a class="nui-button" plain="true" iconCls="" plain="false" onclick="visit()"><span class="fa fa-clock-o fa-lg"></span>&nbsp;回访</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-send fa-lg"></span>&nbsp;发送短信</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="WindowrepairHistory()"><span class="fa fa-wrench fa-lg"></span>&nbsp;维修历史</a> -->
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="SetData()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="WindowrepairHistory()"><span class="fa fa-wrench fa-lg"></span>&nbsp;维修历史</a>
        <!-- <a class="nui-button" plain="true" iconcls="" plain="false" onclick="openOrderDetail()" ><span class="fa fa-search fa-lg"></span>&nbsp;查询工单详情</a> -->
    </div>

    <div class="nui-fit">
        <div id="gridCar" class="nui-datagrid gridborder"
        style="width: 100%; height: 100%;"
        url=""
        dataField="data" idField="id" sizeList="[20,30,50,100]"
        pageSize="20" totalField="page.count" showPager="true">

        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="serviceCode" width="120" headerAlign="center" align="center">工单号</div>
            <div field="carNo" width="70" headerAlign="center"align="center">车牌号</div>
            <div field="carModel" name="carModel" width="200px" headerAlign="center"  header="品牌车型"></div>
            <div field="carVin" name="carVin" width="130px" headerAlign="center" header="车架号(VIN)"></div>
            <div field="guestFullName" name="guestFullName" width="80px" headerAlign="center" header="客户姓名"></div>
            <div field="guestMobile" name="guestMobile" width="100px" headerAlign="center" header="客户手机"></div>
            <div field="contactName" name="contactName" width="80px" headerAlign="center" header="联系人姓名"></div>
            <div field="contactMobile" name="contactMobile" width="100px" headerAlign="center" header="联系人手机"></div> 
            <div field="mtAdvisor" name="mtAdvisor" width="60px" headerAlign="center" header="服务顾问"></div>
            <div field="serviceTypeName" name="serviceTypeName" width="100px" headerAlign="center" header="业务类型"></div>
            <!--<div field="isSettle" name="isSettle" width="60px" headerAlign="center" header="结算状态"></div> -->
            <div field="recordDate" name="recordDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="开单日期"></div>
            <!-- <div field="planFinishDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="预计完工日期"></div> -->
            <!-- <div field="mtAdvisor" width="70" headerAlign="center" align="center">维修顾问</div> -->
            <div field="leaveDays" width="70" headerAlign="center" align="center">离厂天数</div>
            </div>
        </div> 
    </div> 
    <script type="text/javascript">
        nui.parse();
    </script>
</body>
</html>