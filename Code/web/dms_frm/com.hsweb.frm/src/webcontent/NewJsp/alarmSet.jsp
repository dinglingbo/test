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
<title>提醒设置</title>
<%@include file="/common/sysCommon.jsp"%>


</head>
<body>
	<div style="border: solid 1px black; width: 40%; margin-left: 30%; margin-top: 5%;">

    <div title="修改密码" >
    <table style="border-spacing:0px 20px;">
    <tr>
    <td  style="width:30%; text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆下次保养日期前后</div>
   	</td>
   	<td style="width:5%; ">
   	<div class="nui-textbox" style="width: 100%; "></div>
    </td>
    <td  style="width:30%;">
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
    <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">车辆保养周期</div>
   	</td>
   	<td >
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
      <td>
    	<div style=" margin-left: 5%;">月提醒</div>
   	</td>
    </tr>
      <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆保险到期日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
     <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离驾照年审日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆年检日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离卡到期日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">月提醒</div>
   	</td>
    </tr>
    <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离客户生日日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离员工生日日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">当客户连续</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">月未到店服务则视为流失客户</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离采购订单到货时间</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">小时提醒</div>
   	</td>
    </tr>
    <tr>
    <td colspan="3" align="center">
    <a class="nui-button"> 提交</a>
    </td></tr>
    </table>
    </div>
 </div>

	
</body>
 <script type="text/javascript">
      
		nui.parse();

      
       
  </script>
</html>