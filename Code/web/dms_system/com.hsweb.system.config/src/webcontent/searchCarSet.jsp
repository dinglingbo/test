<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:49:18
  - Description:
-->
<head>
<title>查车单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/config/js/parameterSet.js?v=1.7.8"></script>
    
</head>
<body>
 <div class="nui-tabs" style="margin-left: 5%; width: 90%; height: 100%;">
     <div title="查车单">
     <div style="height:390%;width: 100%; background-color:#F0F0F0;">
     <div style="height:100%;width: 100%; background-color: #ffffff; width: 90%; margin-left: 5%;">
     	
  		<div style="background-color:#E8E8E8; width: 100%;height: 2%; margin-top: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">车辆环视图</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  		<div>
  		<center>
  		<img alt="" src="<%=webPath + contextPath%>/frm/Newimg/dounload.png" border="1px;" >
  		</center>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">随车物品</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>
  		<div style="width: 100%;height: 1%; margin-top: 2%;">
  		<span style="margin-left: 7%;">备胎  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">警示牌  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">点烟器 <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">千斤顶  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">灭火器  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">工具  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">烟灰缸  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">警示灯标志</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>
  		<div style="width: 100%;height: 1%; margin-top: 2%;">
  		<span style="margin-left: 7%;">备胎  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">警示牌  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">点烟器 <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">千斤顶  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">灭火器  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>  		
  		<span style="margin-left: 7%;">工具  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		<span style="margin-left: 7%;">烟灰缸  <input  class="nui-checkbox" style="margin-left: 1%;"/></span>
  		</div>
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">发动机舱检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  
  	<div style="width: 30%; height: 10%;">
  	机舱检查
  	</div>
  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">车辆外观检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   		车辆外观
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">底盘制动检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   		底盘制动
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">内饰检查</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  		</div>
  	
  	<div style="width: 30%; height: 10%;">
  		   	内饰
  	</div>

  		
  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">客户描述</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>  	
  	<div style="width: 30%; height: 8%;">
  		   	描述
  	</div>
  		
	  	<div style="background-color:#E8E8E8; width: 100%;height: 2%; ">	
  		<div style="width: 100%;height: 0.1%;"></div>
  		<div style="margin-top: 2%; margin-left: 2%;">
  		<span style="font-size: 20px; line-height: 1%;">检测照片</span>
  		<input  class="nui-checkbox" style="float: right;"/>
  		</div>
  	</div>  	
  	<div style="width: 30%; height: 8%;">
  		   	照片
  	</div>
  	<div style=" width: 100%; height: 2%; background-color: #E8E8E8">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;">保存</a>
	 </div>	
     </div>
     </div>
     </div>
     <div title="接车预检单">
     </div>
     </div>


</body>
</html>