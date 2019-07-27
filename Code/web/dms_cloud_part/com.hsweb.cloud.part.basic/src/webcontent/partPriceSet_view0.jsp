<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
- Author(s): Administrator
- Date: 2018-05-04 09:13:58
- Description:
-->
<head>
    <title>统一售价设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/basic/js/settleAccountSet.js?v=2.0.0"></script>
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
    <div class="nui-toolbar" style="padding:10px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
        <a class="nui-button" iconCls="" plain="true" onclick="edit()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
        <a class="nui-button" iconCls="" plain="true" onclick="deleteType()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
        <a class="nui-button" id="disable" iconCls="" plain="true" onclick="disable()"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
        <a class="nui-button" id="undisable" iconCls="" plain="true" onclick="undisable()"><span class="fa fa-check-circle fa-lg"></span>&nbsp;启用</a>
        <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
    </div>
    <div id="mainGrid" class="nui-treegrid" style="width:100%;height:100%;" dataField="settleAccount"  url="" 
                    showTreeIcon="true"  treeColumn="name" expandOnLoad="true" showModified="false"
                    onselectionchanged="onGridSelectedChange" selectOnLoad="true"
                    idField="id" parentField="parentId" resultAsTree="false">
        <div property="columns">
            <div type="indexcolumn"  headeralign="center" width="20">序号</div>
            <div field="id" name="id" width="80"  visible="false" >id</div>
            <div field="code" name="code" width="80"  headeralign="center" >配件编码</div>
            <div field="name" name="name" width="140"  headeralign="center" >OE码</div>
            <div field="accountTypeId" name="accountTypeId" width="40" renderer="onAccount"  headeralign="center" >配件全称</div>
            <div field="isDisabled" name="isDisabled" width="40" renderer="onRenderer"  headeralign="center" >统一售价</div>
            <div field="remark" name="remark" width="80"  headeralign="center" >备注</div>
            <div field="operator" name="modifier" width="60"  headeralign="center" >最近修改人</div>
            <div field="operateDate" name="operateDate" width="80" dateFormat="yyyy-MM-dd HH:mm"  headeralign="center" >最近修改日期</div>
       
        </div>
    </div>

</body>
</html>