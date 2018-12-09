<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-03-15 10:19:47
  - Description:
-->
<head>
    <title>Title</title>
    <script src="<%=webPath + contextPath%>/purchase/export/ex.js?v=1.0.0"></script>
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
    <div id="exportDiv" style="display:none">  
        <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        	<tr>
        		<td colspan="1">单号：</td>
                <td colspan="1" ><span id="dw"></span></td>
        	</tr>
        	<tr>
        		<td colspan="1">供应商名称：</td>
                <td colspan="1" align="center"><span id="zb"></span></td>
        	</tr>
            <tr>
                <td colspan="1">备注：</td>
                <td colspan="1" align="center"><span id="zb"></span></td>
            </tr>
            <tr>  
                <td colspan="3" align="center">配件编码</td>
                <td colspan="3" align="center">配件全称</td>
                <td colspan="3" align="center">品牌车型</td>
                <td colspan="3" align="center">单位</td>
                <td colspan="3" align="center">数量</td>
                <td colspan="3" align="center">单价</td>
                <td colspan="3" align="center">金额</td>
                <td colspan="3" align="center">备注</td>
            </tr>
            <tbody id="tableExportContent">
        	</tbody>
        </table>  
        <a href="" id="tableExportA"></a>
    </div>  
</div>

</body>
</html>