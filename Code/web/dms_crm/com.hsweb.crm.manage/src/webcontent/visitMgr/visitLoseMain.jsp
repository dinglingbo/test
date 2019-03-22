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
    <title>流失回访</title> 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/manage/js/visitMgr/visitLoseMain.js?v=1.1.2" type="text/javascript"></script>
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
    #wechatTag1{
            color:#ccc;
    }
    #wechatTag{
        color:#62b900;
    }
</style> 
</head>
<body>
        <div class="mini-splitter" vertical="true" style="width:100%;height:100%;">
                <div size="70%" showCollapseButton="true">
        <input name="visitMode" id="visitMode" class="nui-combobox "textField="name" valueField="customid" visible="false"/>
    <div class="nui-toolbar" id="toolbar1">
        <label style="font-family:Verdana;">快速查询：</label>
        <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">今日计划跟进客户</a>
        <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
            <li iconCls="" onclick="quickSearch(1)" id="type1">今日计划跟进客户</li>
            <li iconCls="" onclick="quickSearch(2)" id="type2">新流失客户</li>
            <li iconCls="" onclick="quickSearch(3)" id="type3">流失超过半年客户</li>
            <li iconCls="" onclick="quickSearch(4)" id="type4">流失超过一年的客户</li>
            <li iconCls="" onclick="quickSearch(5)" id="type5">所有客户</li>
        </ul>
  
        <label style="font-family:Verdana;">流失天数：</label>
        <input class="nui-textbox" name="slost" id="slost" style="width: 60px;">
        <label style="font-family:Verdana;">至</label>
        <input class="nui-textbox" name="elost" id="elost" style="width: 60px;">
        <input class="nui-textbox" name="tcarNo" id="tcarNo" style="width:90px;" emptyText="车牌号">
        <input class="nui-combobox" name="level" id="level" style="width: 125px;"  required="false" multiSelect="true"
        textField="name" valueField="id" allowInput="false" emptyText="客户等级" />
        <a class="nui-button" plain="true" onclick="quickSearch(0)" iconcls="" ><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <span class="separator"></span>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="SetData()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
        <a class="nui-button" id="wcBtn1"  plain="true" iconCls="" plain="false" visible="false" onclick="sendWcText()"><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
        <a class="nui-button" id="wcBtn2"  plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
        <a class="nui-button" id="wcBtn3"  plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sellPoint()"><span class="fa fa-gift fa-lg"></span>&nbsp;销售机会</a>
        <!--<a class="nui-button" plain="true" iconCls="" plain="false" onclick="WindowrepairHistory()"><span class="fa fa-wrench fa-lg"></span>&nbsp;维修历史</a>-->
        <!-- <a class="nui-button" plain="true" iconcls="" plain="false" onclick="openOrderDetail()" ><span class="fa fa-search fa-lg"></span>&nbsp;查询工单详情</a> -->
    </div>

    <div class="nui-fit">
        <div id="gridCar" class="nui-datagrid gridborder"
        style="width: 100%; height: 100%;"
        url="" allowCellWrap = true
        dataField="data" idField="id" sizeList="[20,30,50,100]"
        pageSize="20" totalField="page.count" showPager="true">

        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="serviceCode" width="160" headerAlign="center" align="center">工单号</div>
            <div field="billTypeId" name="billTypeId" width="70" headerAlign="center"  align="center" allowsort="true"  header="工单类型"></div>
            <div field="carNo" width="75" headerAlign="center"align="center">车牌号</div>
            <div field="carModel" name="carModel" width="200px" headerAlign="center"  header="品牌车型"></div>
            <div field="carVin" name="carVin" width="130px" headerAlign="center" header="车架号(VIN)"></div>
            <div field="guestFullName" name="guestFullName" width="80px" headerAlign="center" header="客户姓名"></div>
            <div field="guestMobile" name="guestMobile" width="110px" headerAlign="center" header="客户手机"></div>
            <div field="tgrade" name="tgrade" width="90px" headerAlign="center" header="客户等级"></div>
            <div field="serviceTypeName" name="serviceTypeName" width="155px" headerAlign="center" header="业务类型"></div>
            <!--<div field="isSettle" name="isSettle" width="60px" headerAlign="center" header="结算状态"></div> -->
            <div field="enterDate" name="recordDate" width="120px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="进厂日期"></div>
            <div field="outDate" name="recordDate" width="120px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="离厂日期"></div>
            <!-- <div field="planFinishDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm" header="预计完工日期"></div> -->
            <!-- <div field="mtAdvisor" width="70" headerAlign="center" align="center">维修顾问</div> -->
            <div field="leaveDays" width="70" headerAlign="center" align="center">离厂天数</div>
            <div field="mtAdvisor" name="mtAdvisor" width="60px" headerAlign="center" header="服务顾问"></div>
        </div>
    </div> 
</div> 
</div> 
<div >
        <div class="nui-fit">
            <div id="visitHis" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                multiSelect="false" pageSize="20" showPageInfo="true" selectOnLoad="true"  onDrawCell="" onselectionchanged=""
                allowSortColumn="false" totalField='page.count'  allowCellWrap="true">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" header="序号" width="20px"></div>
                    <div field="serviceType" headerAlign="center" allowSort="true" width="100px">回访类型</div>
                    <div field="visitMode" headerAlign="center" allowSort="true" width="100px">回访方式</div>
                    <div field="visitContent" headerAlign="center" allowSort="true" width="200px">回访内容</div>
                    <div field="visitMan" headerAlign="center" allowSort="true" width="100px">回访员</div>
                    <div field="visitDate" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" width="100px">回访日期</div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    nui.parse();
</script>
</body>
</html>