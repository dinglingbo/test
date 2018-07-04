<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 21:18:54
  - Description:
-->
<head>
<title>付款</title>
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
    <table align="center">
        <tr>
            <td>
                应付金额：<span></span>
            </td>
            <td>
                已付金额：<span></span>
            </td>
            <td>
                未付金额：<span></span>
            </td>
        </tr>
        <tr>
            <td>
                供应商：<span></span>
            </td>
        </tr>
        <tr>
            <td>
                付款方式：<input class="nui-combobox">
            </td>
        </tr>
        <tr>
            <td>
                开票方式
            </td>
            <td>
                <input class="nui-checkbox">不开票
                <input class="nui-checkbox"> 增值税普通发票
                <input class="nui-checkbox"> 增值税专用发票
            </td>
        </tr>
        <tr>
            <td>票据单号：<input class="nui-textarea" style="height: 150px;"></td>
        </tr>
        <tr>
            <td>本次付款：<input class="nui-textarea" style="height: 150px;"></td>
        </tr>
        <tr>
            <td>结清优惠：<input class="nui-checkbox"></td>
        </tr>
    </table>
    <div align="right">
        <a class="nui-button" iconCls="icon-search" onclick="">确定</a>
        <a class="nui-button" iconCls="icon-search" onclick="">退出</a>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>