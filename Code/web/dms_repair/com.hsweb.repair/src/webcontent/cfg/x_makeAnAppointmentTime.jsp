<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-07 20:33:11
  - Description:
-->
<head>
<title>预约时间</title>
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
    <div>
        <table style="width: 100%">
        	<tr>
        		<td></td><td></td><td></td><td></td><td></td>
        	</tr>
            <tr>
                <td colspan="2">
                     可提前几天预约
                    <input class="nui-textbox">
                    <strong>
                        <span style="color:#696969">天（不可超过30天）</span>
                    </strong>
                </td>
            </tr>
            <tr>
                <td colspan="2" >
                    多长时间不能预约
                    <input class="nui-textbox">
                    <strong>
                        <span style="color:#696969">分钟</span>
                    </strong>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    可预约时间段
                    <input class="nui-timespinner" format="H:mm:ss" />&nbsp;-
                    <input class="nui-timespinner" format="H:mm:ss" />
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    预约间隔
                    <input class="nui-combobox" data="data" value="1">
                </td>
                <td colspan="4">
                    <span style="background-color: red;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    预约优惠
                    &nbsp;&nbsp;
                    <span style="background-color: blue;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    可以预约
                     &nbsp;&nbsp;
                    <span style="background-color: #696969;">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                    不可预约
                </td>
            </tr>
            <tr>
                <td style="width:20%">
                    <div style="border:1px solid rgb(0, 162, 255);width: 70px;"align="center">09:00<br>无优惠</div>
                </td>
                <td style="width:20%">
                    <div style="border:1px solid rgb(0, 162, 255);width: 70px;" align="center">09:00
                        <br>无优惠</div>
                </td>
                <td style="width:20%">
                    <div style="border:1px solid rgb(0, 162, 255);width: 70px;" align="center">09:00
                        <br>无优惠</div>
                </td>
                <td style="width:20%">
                    <div style="border:1px solid rgb(0, 162, 255);width: 70px;" align="center">09:00
                        <br>无优惠</div>
                </td>
                <td style="width:20%">
                    <div style="border:1px solid rgb(0, 162, 255);width: 70px;" align="center">09:00
                        <br>无优惠</div>
                </td>
            </tr>
            <tr>
                <td>
                    是否启动预约&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">是 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">否
                </td>
            </tr>
            <tr>
                <td >
                    <a class="nui-button" iconcls="icon-save">保存</a>
                </td>
            </tr>
        </table>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "30分钟" }, { id: "2", text: "一小时" }];
    	nui.parse();
    </script>
</body>
</html>