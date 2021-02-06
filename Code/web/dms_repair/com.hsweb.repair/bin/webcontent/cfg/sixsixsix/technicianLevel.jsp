<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 14:36:48
  - Description:
-->
<head>
<title>预约工位</title>
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
    <div style="height: 50px;">
        <input class="nui-textbox" style="width:20%" emptytext="请输入预约工位名称">
        <a class="nui-button" iconCls="icon-add" onclick="">添加工位</a>
        <a class="nui-button" iconCls="icon-search" onclick="">刷新列表</a>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" type="indexcolumn" headeralign="center" align="center" >编号</div>
                <div field="" name="" headeralign="center" align="center">名称</div>
                <div field="" id="" name="" headeralign="center" align="center">工位数量</div>
                <div field="" id="" name="" headeralign="center" align="center">排序值</div>
                <div field="" id="" name="" headeralign="center" align="center">状态</div>
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