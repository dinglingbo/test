<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 16:12:11
  - Description:
-->
<head>
<title>计次卡/储值卡</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>
<body>
<div class="nui-fit">
    <div style="height: 50px;"align="right">
        <a class="nui-button" iconCls="icon-add" onclick="">批量修改提成</a>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" type="indexcolumn" headeralign="center" align="center">编号</div>
                <div field="name" name="name" headeralign="center" align="center">套餐名称</div>
                <div field="sellAmt" id="sellAmt" name="" headeralign="center" align="center">售价</div>
                <div field="salesDeductType" id="salesDeductType" name="salesDeductType" headeralign="center" align="center">提成类型</div>
                <div field="salesDeductValue" id="salesDeductValue" name="" headeralign="center" align="center">提成点</div>
                <div field="" id="" name="" headeralign="center" align="center">操作</div>
            </div>
        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>