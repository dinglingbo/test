<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 21:41:45
  - Description:
-->
<head>
<title>预收处理历史</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
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
    <span>交易日期</span><input class="nui-datepicker"  style="width:120px"/>至<input class="nui-datepicker" style="width:120px" />
    <a class="nui-button" iconCls="icon-search" onclick="">查询</a>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="num" name="num" type="indexcolumn" headeralign="center" align="center">序号</div>
                <div field="" name="" headeralign="center" align="center">交易日期</div>
                <div field="" name="" headeralign="center" align="center">交易门店</div>
                <div field="" id="" name="" headeralign="center" align="center">处理单号</div>
                <div field="" id="" name="" headeralign="center" align="center">来源单号</div>
                <div field="" id="" name="" headeralign="center" align="center">车牌号</div>
                <div field="" id="" name="" headeralign="center" align="center">交易金额</div>
                <div field="" id="" name="" headeralign="center" align="center">交易备注</div>
            </div>
        </div>
        <div align="right">
            <a class="nui-button" iconCls="icon-search" onclick="">退出</a>
        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>