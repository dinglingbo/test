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
    <title>微信自动派卷</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
     <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label>名称：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="newEvent()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消审核</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
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

            <div field="carNo" name="carNo" width="80" headerAlign="center" header="操作"></div>
            <div field="serviceCode" name="serviceCode" width="135" headerAlign="center" header="名称"></div>
            <div field="visitMan" name="visitMan" width="80" headerAlign="center" header="条件"></div>
            <div field="carType" name="carType" width="80" headerAlign="center" header="条件金额"></div>
            <div field="auditSign" name="auditSign" width="80" headerAlign="center" header="开始时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="auditDate" name="auditDate" width="130" headerAlign="center" header="结束时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="auditOpinion" name="auditOpinion" width="80" headerAlign="center" header="微信显示名称"></div>
            <div field="remark" name="remark" width="80" headerAlign="center" header="优惠券有效期"></div>
            <div field="recorder" name="recorder" width="130" headerAlign="center" header="审核人"></div>
        </div>
    </div>


</div>

<script type="text/javascript">
 nui.parse();


 

            function newEvent(){
             nui.open({
             url: webPath + contextPath  + "/manage/guestMarketing/wechatAuto_Edit.jsp",
             title: "自动派券",
             width: 600, 
             height: 280,
             onload: function () {
             },
             ondestroy: function (action) {
             }
         });
   }
</script>
</body>
</html>