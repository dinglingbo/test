<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-03 16:59:41
  - Description:
-->
<head>
    <title>短信营销</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td>
                    <label>标题：</label>
                    <input class="nui-textbox" name="" id="" enabled="true"/>
                    <a class="nui-button"  plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                    <li class="separator"></li>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;活动记录</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;中奖记录</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;奖品设置</a>
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

            <div field="" name="" width="80" headerAlign="center" header="操作"></div>
            <div type="checkcolumn" ></div>    
            <div field="" name="" width="80" headerAlign="center" header="门店"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动编码"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动名称"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动类型"></div>
            <div field="" name="" width="80" headerAlign="center" header="单人参与次数"></div>
            <div field="" name="" width="80" headerAlign="center" header="每人中奖次数"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动总人数"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动开始时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="" name="" width="80" headerAlign="center" header="活动结束时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="" name="" width="80" headerAlign="center" header="创建时间" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="" name="" width="80" headerAlign="center" header="是否生成图文"></div>
        </div>
    </div>


</div>

<script type="text/javascript">
   nui.parse();
</script>
</body>
</html>