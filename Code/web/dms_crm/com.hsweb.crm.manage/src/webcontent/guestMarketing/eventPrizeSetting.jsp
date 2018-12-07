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
  <title>奖品设置</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <%@include file="/common/commonRepair.jsp"%>
</head>
<body>
  <div class="nui-toolbar" style="padding:2px;border-bottom: 0" id="queryForm">
    <table style="width:100%;">
      <tr>
        <td>
          <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
          <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
          <a class="nui-button" iconCls="" plain="true" onclick="" id="addBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
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
        <div type="checkcolumn" ></div>    
        <div type="indexcolumn" headerAlign="center" header="序号"></div>
        <div field="" name="" width="80" headerAlign="center" header="奖品名称"></div>
        <div field="" name="" width="80" headerAlign="center" header="奖品等级"></div>
        <div field="" name="" width="80" headerAlign="center" header="奖品数量"></div>
        <div field="" name="" width="80" headerAlign="center" header="中奖概率"></div>
        <div field="" name="" width="80" headerAlign="center" header="奖品价值"></div>
        <div field="" name="" width="80" headerAlign="center" header="备注" ></div>
      </div>
    </div>


  </div>

  <script type="text/javascript">
    nui.parse();



  </script>
</body>
</html>