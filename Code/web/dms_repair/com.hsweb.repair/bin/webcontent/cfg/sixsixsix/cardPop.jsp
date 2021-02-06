<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 16:12:11
  - Description:
-->
<head>
<title>批量修改提成</title>
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
            <table align="center">
                <tr>
                    <td style="width: 100px">
                        <span>提成类型</span>
                    </td>
                    <td>
                        <input type="radio" name="isnot">固定提成 &nbsp;&nbsp;&nbsp;
                        <input type="radio" name="isnot">比例提成
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <span>提成点</span>
                    </td>
                    <td>
                        <input class="nui-textbox">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                    </td>
                    <td>
                        <a class="nui-button" iconcls="icon-no">取消</a>
                        <a class="nui-button" iconcls="icon-save">保存</a>
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