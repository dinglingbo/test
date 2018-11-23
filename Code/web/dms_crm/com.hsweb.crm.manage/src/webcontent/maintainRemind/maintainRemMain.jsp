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
    <title>保养提醒</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/manage/js/maintainRemMain/maintainRemMain.js?v=1.0.61" type="text/javascript"></script>
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
    <div class="nui-toolbar">
       <!--  <label style="font-family:Verdana;">快速查询：</label> -->
        <label style="font-family:Verdana;">车牌号：</label>
        <input class="nui-textbox" name="tcarNo" id="tcarNo">
        <label style="font-family:Verdana;">手机号：</label>
        <input class="nui-textbox" name="tmobile" id="tmobile">
        <a class="nui-button" plain="true" onclick="onSearch()" iconcls="" plain="false"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
        <span class="separator"></span>
        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-send fa-lg"></span>&nbsp;发送短信</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="addBooking()"><span class="fa fa-clock-o fa-lg"></span>&nbsp;预约</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="remindDetail()"><span class="fa fa-list fa-lg"></span>&nbsp;跟踪明细</a>
		<a class="nui-button" plain="true" iconCls="" plain="false" onclick="checkMtRecord()"><span class="fa fa-search fa-lg"></span>&nbsp;查看保养提醒</a>
                <a class="nui-button" plain="true" iconcls="" plain="false" onclick="openOrderDetail()" ><span class="fa fa-search fa-lg"></span>&nbsp;查询工单详情</a>
    </div>

                <div class="nui-fit">
                    <div id="gridCar" class="nui-datagrid gridborder"
                    style="width: 100%; height: 100%;"
                    url=""
                    dataField="data" idField="id" sizeList="[20,30,50,100]"
                    pageSize="20" totalField="page.count" showPager="true">

                    <div property="columns">
                        <div type="indexcolumn" width="30">序号</div>
                        <div field="carNo" width="70" headerAlign="center"align="center">车牌号</div>
                        <div field="carModel" width="170" headerAlign="center"align="center">车型</div>
                        <div field="guestName" width="70" headerAlign="center"align="center">客户名称</div>
                        <div field="leaveDays" width="70" headerAlign="center"align="center">离厂天数</div>
                        <div field="finalRemindDay" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后提醒时间</div>
                        <div field="chainComeTimes" width="70" headerAlign="center"align="center">连锁次数</div>
                        <div field="lastComeDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后进厂时间</div>
                        <div field="firstComeDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">首次来厂时间</div>
                        <div field="lastLeaveDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center"align="center">最后离厂时间</div>
                        <div field="careDueDate" dateFormat="yyyy-MM-dd HH:mm" width="170" headerAlign="center" align="center">保养到期时间</div>
                        <div field="preAdvisorName" width="70" headerAlign="center" align="center">营销员</div>
                        <div field="mobile" visible="false" width="70" headerAlign="center" align="center">手机号</div>
                        <div field="carBrandId" visible="false" width="70" headerAlign="center" align="center">品牌</div>
                        <div field="carBrandId" visible="false" width="70" headerAlign="center" align="center">车型</div>
                    </div>
                </div> 
            </div> 
     
<script type="text/javascript">
    nui.parse();
</script>
</body>
</html>