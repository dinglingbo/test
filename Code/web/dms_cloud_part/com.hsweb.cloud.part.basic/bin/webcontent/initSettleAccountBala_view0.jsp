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
    <title>期初现金银行</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/basic/js/initSettleAccountBala.js?v=2.0.0"></script>
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
        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
        <a class="nui-button" iconCls="" plain="true" onclick="audit()"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
        <a class="nui-button" iconCls="" plain="true" onclick="refresh()"><span class="fa fa-refresh fa-lg"></span>&nbsp;刷新</a>
    </div>
    <div class="nui-fit">
	    <div id="mainGrid" class="nui-treegrid" style="width:100%;height:100%;" dataField="settleAccount"  url="" 
	                    showTreeIcon="true"  treeColumn="name" expandOnLoad="true" showModified="false"
	                    selectOnLoad="true" showSummaryRow="true"
	                    allowCellEdit="true" allowCellSelect="true" oncellcommitedit="onCellCommitEdit"
	                    oncellbeginedit="OnrpMainGridCellBeginEdit"
	                    idField="id" parentField="parentId" resultAsTree="false">
	        <div property="columns">
	            <div type="indexcolumn"  headeralign="center" width="20">序号</div>
	            <div field="id" name="id" width="80"  visible="false" >id</div>
	            <div field="parentId" name="parentId" width="80"  visible="false" >parentid</div>
	            <div field="code" name="code" width="80"  headeralign="center" >账户编码</div>
	            <div field="name" name="name" width="140"  headeralign="center" summaryType="count" >账户名称</div>
	            <div field="accountTypeId" name="accountTypeId" width="40" renderer="onAccount"  headeralign="center" >账户类型</div>
	            <div field="initBalance" numberFormat="0.0000" summaryType="sum" width="80" headerAlign="center" header="期初金额">
	                <input property="editor" vtype="float" class="nui-textbox"/>
	            </div>
	            <div field="isInit" name="isInit" width="40" renderer="onRenderer"  headeralign="center" >是否审核</div>
	            <div field="remark" name="remark" width="80"  headeralign="center" >备注</div>
	            <div field="modifier" name="modifier" width="60"  headeralign="center" >最近修改人</div>
	            <div field="modifyDate" name="modifyDate" width="80" dateFormat="yyyy-MM-dd HH:mm"  headeralign="center" >修改日期</div>
	       
	        </div>
	    </div>
    </div>
</div>
</body>
</html>