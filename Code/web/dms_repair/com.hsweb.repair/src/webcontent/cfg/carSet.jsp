<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-06-14 09:48:52
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/config/js/carSet.js?v=1.7.8"></script>
    
</head>
<body>
 
     <div style="background-color: #F0F0F0; width: 50%;height: 42%; margin-top: 3%; margin-left: 5%;">
     <div style="height: 0.1%;width: 100%;"></div>
     <div style="margin-top: 1%;margin-left: 1%;">
     	<span > 
     	电子健康档案门店信息
     	</span>
     </div>
     <div style="width: 100%; height: 75%; border: 1px; background-color: #ffffff; margin-top: 1%;">
     	<div class="nui-form" id="repairStoreForm">
     	 <table style="border-spacing:0px 20px;" >
		    <tr>
		    <td  style="width:100px; text-align: right; color: red;">
			对接省份:
		    </td>
		    <td style="width:500px;">
		    <input  class="nui-combobox" style="margin-left: 5%; width: 65%; "  emptytext="选择省份"  id="provinceId" name="provinceId" textField="name"  valueField="code" onvaluechanged="onProvinceChange" />
			</td>
		    <td>
		 
            </td>
		    </tr>
			 <tr>
		    <td  style="text-align: right; color: red;">
			维修厂编号:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; " name="repairStoreNo"></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			用户名:
		    </td>
		    <td><div class="nui-textbox" style="width: 65%;margin-left: 5%; "  name="repairStoreName"></div></td>
		    </tr>
		     <tr>
		    <td  style=" text-align: right; color: red;">
			密码:
		    </td>
		    <td ><div class="nui-textbox" style="width: 65%;margin-left: 5%; "  name="repairStorePwd"></div></td>
		    </tr>
		   </table>
		 <div style=" width: 100%;height: 5%;">
	 		<a class="nui-button" style= "float: right;" onclick="repairStoreFormSet">保存</a>
	 	 </div>
      </div>
     </div>
   </div>



</body>
</html>