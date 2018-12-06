<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
<title>微信手动派卷</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
     <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
 <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label>卡券名字：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="newEvent()" id="addBtn"><span class="fa fa-credit-card fa-lg"></span>&nbsp;手动派券</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="list()" id="addBtn"><span class="fa fa-list fa-lg"></span>&nbsp;派券记录</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
        <div id="investGrid" class="nui-datagrid" style="width:100%;height:100%;"
        pageSize="50"
        multiSelect="false"
        totalField="page.count"
        sizeList=[20,50,100,200]
        dataField="list"
        onrowdblclick=""
        allowCellSelect="true"
        allowCellWrap = true
        ondrawcell=""
        >
        <div property="columns">

            <div field="carNo" name="carNo" width="80" headerAlign="center" header="ID"></div>
            <div field="serviceCode" name="serviceCode" width="135" headerAlign="center" header="卡券名字"></div>
            <div field="visitMan" name="visitMan" width="80" headerAlign="center" header="派发人"></div>
            <div field="carType" name="carType" width="80" headerAlign="center" header="商户"></div>
            <div field="carType" name="carType" width="80" headerAlign="center" header="是否成功"></div>
            <div field="auditSign" name="auditSign" width="80" headerAlign="center" header="派发时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="auditOpinion" name="auditOpinion" width="80" headerAlign="center" header="类型"></div>
            <div field="remark" name="remark" width="80" headerAlign="center" header="派发成功人数"></div>
            <div field="remark" name="remark" width="80" headerAlign="center" header="派发失败人数"></div>
            <div field="recorder" name="recorder" width="130" headerAlign="center" header="总人数"></div>
            <div field="recorder" name="recorder" width="130" headerAlign="center" header="每人次数"></div>
        </div>
    </div>


</div>



	<script type="text/javascript">
    	nui.parse();




            function newEvent(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/wechatManual_edit.jsp",
             title: "派发卡券",
             width: "60%", 
             height: "100%",
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }


               function list(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/couponPushList.jsp",
             title: "派券记录",
             width: "100%", 
             height: "100%",
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }
    </script>
</body>
</html>