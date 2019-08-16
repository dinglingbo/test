<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-15 16:18:18
  - Description:
-->
<head>
<title>Title</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

<style>
div.box {
	width: 50px;
	height: 23px;
	background-color: red;
	border-radius:5px;
	text-align: center;
}

em.emarrow {
	color: #E6E6E6;
	font-size: 40px;
}

span.arrow {
	color: #E6E6E6;
	font-size: 40px;
}
.san{	
	width:0;
	height:0;
	border-right:5px solid transparent;
	border-left:2px solid transparent;
	border-top:5px solid red;
    margin-left: 3px;
}
</style>

</head>
<body>


	<div>
		<div class="box"><span>99</span> 
		</div>
		<div class="san"></div>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>