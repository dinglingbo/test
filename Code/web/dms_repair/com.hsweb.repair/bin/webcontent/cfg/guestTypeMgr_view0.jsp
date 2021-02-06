 <%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head> 
<title>客户级别</title>

<script src="<%=webPath + contextPath%>/repair/cfg/js/guestTypeMgr.js?v=1.0.5"></script>
<style type="text/css">
.title {
	width: 90px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
   <table style="width:100%;">
       <tr>
           <td style="white-space:nowrap;">
                <input id="name" width="150px" emptyText="级别名称" class="nui-textbox"/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" iconCls="" onclick="addGuestType()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" plain="true" iconCls="" onclick="editGuestType()" id="editBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
           </td>
       </tr>
       </table>
   </div>
   <div class="nui-fit">
       <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
        showPager="true"
        dataField="list"
        idField="id"
        selectOnLoad="true"
        sortMode="client"
        totalField="page.count"
        pageSize="20"
        sizeList="[50,100,200]"
        url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="name" name="name" width="120" headerAlign="center" allowSort="true">级别名称</div>
            <div allowSort="true" width="50" field="isDisabled" headerAlign="center" header="状态"></div>
            <div field="modifier" width="60" allowSort="true" headerAlign="center">修改人</div>
            <div field="modifyDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">修改时间</div>
            </div>
       </div>
   </div>




</body>
</html>
