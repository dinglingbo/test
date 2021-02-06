<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>帐户设置</title>
<%@include file="/common/sysCommon.jsp"%>


</head>
<body>


    <div title="修改密码" >
    <table style="border-spacing:0px 20px;">
    <tr>
    <td  style="width:400px; text-align: right; color: red;">
    	<div style="margin-right: 10px;">原密码</div>
   	</td>
   	<td style="width:400px; ">
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    </tr>
    <tr>
    <td  style="text-align: right; color: red;"">
    	<div style="margin-right: 10px;">新密码</div>
   	</td>
   	<td >
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    </tr>
      <tr>
    <td  style="text-align: right; color: red;"">
    	<div style="margin-right: 10px;">确认新密码</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    </tr>
	 </table>
	 <div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">退出</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>
    </div>
 


	
</body>
 <script type="text/javascript">
      
		nui.parse();

      
       
  </script>
</html>