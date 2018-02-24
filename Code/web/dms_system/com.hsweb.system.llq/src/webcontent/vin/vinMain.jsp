<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
<title>车架号查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>

	全部品牌 >
	<div class="mini-autocomplete" style="width:250px;"  popupWidth="400" textField="text" valueField="id" 
	    url="../data/AjaxService.aspx?method=FilterCountrys2" value="cn" text="中国"  onvaluechanged="onValueChanged">     
	    <div property="columns">
	        <div header="vin" field="vin" width="50"></div>
	        <div header="brand" field="品牌"></div>
	    </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>