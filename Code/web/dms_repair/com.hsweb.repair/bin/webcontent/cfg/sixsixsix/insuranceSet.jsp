<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 16:30:02
  - Description:
-->
<head>
<title>保险设置</title>
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
        <table style="width: 80%" align="center">
            <tr>
                <td style="width: 7%">
                     保险公司
                </td>
                <td style="width: 25%">
                    <input class="nui-textbox" width="50%">
                </td>
                <td style="width: 7%"></td>
                <td style="width: 30%"></td>
            </tr>
            <tr>
                <td>
                    <span style="color: tomato">业务状态</span>
                </td>
                <td>
                    <input type="radio" name="isnot">启用 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">禁用
                </td>
            </tr>
            <tr>
                <td colspan="2">
                     保险公司返点给门店
                </td>
                
                <td colspan="2">
                     门店返点给车主
                </td>
            </tr>
            <tr>
                <td>
                     商业险返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
                <td>
                    商业险返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     交强险返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
                <td>
                     交强险返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     车船税返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
                <td>
                     车船税返点
                </td>
                <td>
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     商业险提成
                </td>
                <td>
                    <input type="radio" name="isnot">固定提成 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">比例提成
                </td>
                <td>
                         提成金额
                </td>
                <td>
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                     交强险提成
                </td>
                <td>
                    <input type="radio" name="isnot">固定提成 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">比例提成
                </td>
                <td>
                    提成金额
                </td>
                <td>
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                     车船税提成
                </td>
                <td>
                    <input type="radio" name="isnot">固定提成 &nbsp;&nbsp;&nbsp;
                    <input type="radio" name="isnot">比例提成
                </td>
                <td>
                    提成金额
                </td>
                <td>
                    <input class="nui-textbox">
                </td>
            </tr>
        </table>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>