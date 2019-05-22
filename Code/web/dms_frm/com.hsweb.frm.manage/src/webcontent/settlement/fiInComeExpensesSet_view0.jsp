<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>收支项目</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/settlement/js/fiInComeExpensesSet.js?v=2.1.1"></script>
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
	<div class="nui-fit">
	    <div class="nui-toolbar" style="padding:10px;border-top:0;border-left:0;border-right:0;">
	        <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
	        <a class="nui-button" iconCls="" plain="true" onclick="edit()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
	        <a class="nui-button" iconCls="" plain="true" onclick="deleteType()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
	        <!-- <a class="nui-button" id="disable" iconCls="" plain="true" onclick="disable()"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
	        <a class="nui-button" id="undisable" iconCls="" plain="true" onclick="undisable()"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用</a> -->
	        <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
	    </div>
	    <div class="nui-fit">
		    <div id="mainGrid" class="nui-treegrid" style="width:100%;height:100%;" dataField="list"  url="" onrowdblclick="edit()"
		                    showTreeIcon="true"  treeColumn="name" expandOnLoad="true" showModified="false"
		                    selectOnLoad="true"
		                    idField="id" parentField="parentId" resultAsTree="false">
		        <div property="columns">
		            <div type="indexcolumn"  headeralign="center" width="20">序号</div>
		            <div field="id" name="id" width="80"  visible="false" >id</div>
		            <div field="parentId" name="parentId" width="80"  visible="false" >parentid</div>
		            <div field="code" name="code" width="80"  headeralign="center" >项目编码</div>
		            <div field="name" name="name" width="140"  headeralign="center" >项目名称</div>
		            <div field="itemTypeId" name="itemTypeId" width="40" renderer="onIEType"  headeralign="center" >项目类型</div>
		            <div field="isPrimaryBusiness" name="isPrimaryBusiness" width="40" renderer="onRenderer"  headeralign="center" >主营业务</div>
		            <div field="operator" name="operator" width="60"  headeralign="center" >最近修改人</div>
		            <div field="operateDate" name="operateDate" width="80" dateFormat="yyyy-MM-dd HH:mm"  headeralign="center" >修改日期</div>
		            <div field="remark" name="remark" width="100"  headeralign="center" >备注</div> 
		        </div>
		    </div>
		 </div>
	</div>
</body>
</html>