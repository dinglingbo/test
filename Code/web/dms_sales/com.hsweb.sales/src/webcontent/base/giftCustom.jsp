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
  <title>精品定义</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
  <%@include file="/common/commonRepair.jsp"%>
  <script src="<%=webPath + contextPath%>/sales/base/js/giftCustom.js?v=1.1.3"></script>
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
        精品名称:<input id="name" name="name" class="nui-textbox" type="text" style="width: 150px" />
            状态：<input id="isDisabled" name="isDisabled" class="nui-combobox" data="isDisArr" 
            textField="text" valueField="id"  allowInput="false" style="width:90px"/>
      <a class="nui-button" plain="true" onclick="search()" id="" enabled="true"><span
        class="fa fa-search fa-lg"></span>&nbsp;查找</a>
    <a class="nui-button" plain="true" onclick="addShareUrl()" id="" plain="false"><span
        class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
    <a class="nui-button" plain="true" onclick="del()" id="" plain="false"><span
        class="fa fa-close fa-lg"></span>&nbsp;删除</a>
                <a class="nui-button" plain="true" onclick="save()" id="addStationBtn">
            <span class="fa fa-save fa-lg"></span>&nbsp;保存
        </a>
  </div>

  <div class="nui-fit">
    <!-- <div id="dgGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;" 
      pageSize="20" pageList='[10,20,50,100]' showPageInfo="true" selectOnLoad="true" onDrawCell=""
      onselectionchanged="" allowSortColumn="false" totalField="page.count" fitColumns="false"
      allowCellEdit="true" showModified="false"> -->
      <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="list" sortMode="client"
      allowCellSelect="true" allowCellEdit="true" showModified="false"
      style="width: 100%; height: 100%;" pageSize="20" pageList='[10,20,50,100]' showPageInfo="true"
      totalField="page.count" >
      <div property="columns">
        <div type="indexcolumn" headerAlign="center" width="100px">序号</div>
        <!-- <div type="checkcolumn" class="mini-radiobutton" width="100px">选择</div> -->
   
        <div field="name" headerAlign="center" allowSort="true" width="350px">精品名称
                <input property="editor" class="nui-textbox" />
        </div>
        <div field="remark" headerAlign="center" allowSort="true" width="300px">备注
                <input property="editor" class="nui-textbox" />
        </div>
        <div field="isDisabled" headerAlign="center" allowSort="true" width="80px">状态
                <input property="editor" class="nui-combobox" textField="name" data="statusList" valueField="id" />
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