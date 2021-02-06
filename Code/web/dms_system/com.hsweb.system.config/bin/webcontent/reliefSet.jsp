<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 10:23:01
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   <script src="<%= request.getContextPath() %>/config/js/reliefSet.js?v=1.7.8"></script>
    
</head>
<body>
	<div id="tabs2" class="nui-tabs" activeIndex="0" style="width:93%;height:95%; margin-left:2.5%; margin-top: 1%; " plain="false">
  	<div title="结算单打印内容">
  	<div style="border: solid 1px black; width: 50%;  height:80%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<textarea placeholder="由于上述自带材料引起的任何相关问题（除了因安装不规范造成的故障责任由施工方承担外，其它因材料质量等因素引起的故障责任，如：对车辆本身造成的伤害、车辆行驶过程中造成的损害、以及出现交通事故产生的损害等）都由承修方承担，与施工方无关，恳请悉知！"style="width: 90%;  margin-left: 5%; height: 68.5%;" name="settArea" id="settArea"></textarea>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;" onclick="orderPrintSet('repair_sett_print_content',1)">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;" onclick="orderPrintSet('repair_sett_print_content',0)">保存</a>
	 </div>
	 </div>
	 </div>
	 <div title="委托单打印内容">
	 <div style="border: solid 1px black; width: 50%; height:80%; margin-left: 2%; margin-top: 3%;">
  	<div style="height: 5%; margin-top: 5%; margin-bottom: 5%;">
  	<span style="width: 100%; height: 20%; margin-left: 45%; ">内容体</span>
  	</div>
  	<textarea style="width: 90%;  margin-left: 5%; height: 68.5%;"  name="entrustArea" id="entrustArea"></textarea>
  	<div style="background-color: #F0F0F0; width: 100%;height: 10%; margin-top: 3%;">
	 	<a class="nui-button" style="margin-top: 1.5%;   float: right; margin-right:10%;" onclick="orderPrintSet('repair_entrust_print_content',1)">保存并复制</a>
	 	<a class="nui-button"  style="margin-top: 1.5%;  float: right; margin-right:3%;" onclick="orderPrintSet('repair_entrust_print_content',0)">保存</a>
	 </div>
	 </div>
	 </div>
  	</div>
	

</body>
</html>