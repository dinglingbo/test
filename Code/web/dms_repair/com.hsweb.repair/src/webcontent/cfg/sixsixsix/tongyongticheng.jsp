<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 15:50:19
  - Description:
-->
<head>
<title>通用提成</title>
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
        <strong><span>工时提成：</span></strong>
        <span style="color: red">如果一个工时提成没有设置，则会使用通用提成。若需关闭通用提成，请清空设置即可。</span>
    </div>
        <table style="width:100%">
            <tr>
                <td style="width: 20%">
                     类型
                </td>
                <td style="width: 25%">
                     销售提成比例%
                </td>
                <td style="width: 25%">
                     施工提成比例%
                </td>
                <td style="width: 25%">
                     服务顾问提成比例%
                </td>
            </tr>
            <tr>
                <td>
                     保养
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     钣金
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     喷漆
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     美容
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     洗车
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     机修
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     精品
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     改装
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     轮胎
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
            <tr>
                <td>
                     其他
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
                <td>
                    <input class="nui-combobox" data="data" value="2">
                    <input class="nui-textbox">%
                </td>
            </tr>
        </table>
        <div align="center">
            <a class="nui-button" iconcls="icon-save">保存</a>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "原价" }, { id: "2", text: "折后价" }, { id: "3", text: "产值" }];
    	nui.parse();
    </script>
</body>
</html>