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
  <title>PDI检测</title>
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
        项目编号：      <input id="code" name="code" class="nui-textbox" type="text" style="width: 110px" />
      项目名称：      <input id="name" name="name" class="nui-textbox" type="text" style="width: 110px" />
      <!-- 拼音码：<input id="txtItemCode" class="nui-textbox" type="text" style="width: 110px" /> -->
      <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
        class="fa fa-search fa-lg"></span>&nbsp;查找</a>
      <a class="nui-button" plain="true" onclick="onOk()" id="" enabled="true"><span
        class="fa fa-check fa-lg"></span>&nbsp;确定</a>
  </div>

  <div class="nui-fit">
    <div id="grid1" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" multiSelect="true"
      pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"  onDrawCell=""
      onselectionchanged="" allowSortColumn="false" totalField="page.count" >
      <div property="columns">
          <div type="checkcolumn" class="mini-radiobutton" width="60px">选择</div>
        <div field="orderNo" headerAlign="center" width="60px">序号</div>
        <div field="name" headerAlign="center" allowSort="true" width="150px">项目名称</div>
        <div field="pdiTypeId" headerAlign="center" allowSort="true" width="150px">项目类型</div>
        <div field="code" headerAlign="center" allowSort="true" width="150px">项目编号</div>
      </div>
    </div>
  </div>
  </div>
  <script type="text/javascript">
    nui.parse();
    var gridUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.searchCsbPDI.biz.ext"
    var grid =nui.get("grid1");
    grid.setUrl(gridUrl);
    grid.load({
        params:{
            isDisabled:0
        }
    });

    function search() {
        var params = {
            name: nui.get('name').value,
            code: nui.get('code').value,
            isDisabled:0
        };
        grid.load({ params: params });
    }

    function getRows() {
        return grid.getSelecteds();
    }

    function onOk() {
        CloseWindow("ok");
    }
    

    function onCancel() {
        CloseWindow("cancel");
    }

    function CloseWindow(action){
        if (window.CloseOwnerWindow) 
            return window.CloseOwnerWindow(action);
        else 
            window.close();
    }

  </script>
</body>

</html>