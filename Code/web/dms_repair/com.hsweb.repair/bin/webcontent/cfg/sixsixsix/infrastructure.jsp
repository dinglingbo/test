<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 15:13:55
  - Description:
-->
<head>
<title>基础设置</title>
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
	<table align= "center">
		<tr>
			<td>
				是否启用技师等级分配提成：
			</td>
			<td>
				<input type="radio" name="isnot">开启 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="isnot">关闭
			</td>
		</tr>
		<tr>	 
			<td>
				绩效核算指标：	 
			</td>
			<td>
				<input type="radio" name="isnot">原价 &nbsp;&nbsp;&nbsp;
                <input type="radio" name="isnot">折后价&nbsp;&nbsp;&nbsp;
                <input type="radio" name="isnot">产值
			</td>
		</tr>
	</table>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>