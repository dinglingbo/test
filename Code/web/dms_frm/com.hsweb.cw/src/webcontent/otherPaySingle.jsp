<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 20:32:57
  - Description:
-->
<head>
<title>其他收支单</title>
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
    <div>
        <form>
            <table align = "center">
                <tr>
                    <td>
                        收支类型
                    </td>                   
                    <td>
                        <input class="nui-checkbox">
                    </td>
                    <td>其他收入</td>
                    <td>
                        <input class="nui-checkbox">
                    </td>
                    <td>其他支出</td>
                </tr>
                <tr>
                    <td>业务类别：</td>
                    <td>
                        <input class="nui-combobox">
                    </td>
                </tr>
                <tr>
                    <td>业务对象：</td>
                    <td>
                        <input class="nui-textbox" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td>金额：</td>
                    <td>
                        <input class="nui-textbox" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td>支付方式：</td>
                    <td>
                        <input class="nui-combobox">
                    </td>
                </tr>
                <tr>
                    <td>
                       开票方式
                    </td>
                    <td>
                        <input class="nui-checkbox">
                    </td>
                    <td>不开票</td>
                    <td>
                        <input class="nui-checkbox">
                    </td>
                    <td>增值税普通发票</td>
                    <td>
                        <input class="nui-checkbox">
                    </td>
                    <td>增值税专用发票</td>
                </tr>
            </table>
        </form>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>