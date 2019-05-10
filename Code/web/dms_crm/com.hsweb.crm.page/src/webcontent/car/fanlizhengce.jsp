<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

<head>
  <title>返利政策</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <%@include file="/common/commonRepair.jsp"%>
  <style>
    html,
    body {
      margin: 0px;
      padding: 0px;
      border: 0px;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }
  </style>
</head>

<body>
    <div class="nui-toolbar">
        <input id="txtItemCode" class="nui-textbox" type="text" style="width: 200px" />
      <a class="nui-button" plain="true" onclick="" id="" enabled="true"><span
        class="fa fa-search fa-lg"></span>&nbsp;查找</a>
    <a class="nui-button" plain="true" onclick="edit(1)" id="" plain="false"><span
        class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" plain="true" onclick="addShareUrl" id="addStationBtn">
            <span class="fa fa-save fa-lg"></span>&nbsp;保存
        </a>
  </div>

  <div class="nui-fit">
    <div id="business" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="false"
      pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
      onselectionchanged="" allowSortColumn="false" totalField="page.count" fitColumns="false">
      <div property="columns">
        <div type="indexcolumn" headerAlign="center" width="100px">序号</div>
        <!-- <div type="checkcolumn" class="mini-radiobutton" width="100px">选择</div> -->
        <div field="" headerAlign="center" allowSort="true" width="350px">返利政策</div>
        <div field="" headerAlign="center" allowSort="true" width="200px">返利金额（元）</div>
        <div field="" headerAlign="center" allowSort="true" width="200px">状态</div>
      </div>
    </div>
  </div>
  </div>

  <script type="text/javascript">
    nui.parse();
 
  </script>
</body>

</html>