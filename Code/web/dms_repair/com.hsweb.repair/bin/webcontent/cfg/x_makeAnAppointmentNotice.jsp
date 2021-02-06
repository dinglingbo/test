<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-07 21:42:08
  - Description:
-->
<head>
<title>预约通知</title>
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
                <td style="width: 100%">
                    <input class="nui-combobox" data="data" value="1"style="width: 8%">&nbsp;
                    <span style="color: red">收费标准：每条短信扣费增值币8个，目前增值币余额</span>
                    <span style="color: blue">666</span>
                    <span style="color: red">个</span>
                </td>
            </tr>
            <tr>
                <td>
                    <div style="height: 100px;width: 100%;">
                        <input class="nui-textarea" property="editor" style="width: 90%">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    	接收手机 &nbsp;
                    <a class="nui-button" iconcls="icon-add">添加手机</a>
                </td>
            </tr>
            <tr>
            	<td>
            		 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <a class="nui-button" iconcls="icon-save">保存</a>
                </td>
            </tr>
        </table>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: " ⇩插入动态变量" }];
    	nui.parse();
    </script>
</body>
</html>