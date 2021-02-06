<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	    <%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-03-06 15:50:47
  - Description:
-->
<head>
<title>修改仓位</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/js/editPositions.js?v=1.0.1"></script>
    

    
</head>
<body>
    <div class="mini-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" onclick="onOk" style="width: 60px;" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
		<a class="nui-button" onclick="onCancel" style="width: 60px;" plain="true"><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>
    </div>
	<div class="nui-fit" style="width: 100%;">
		<table align="center">
		   <tr >
			  <td>
					<label for="billType1" >原仓位：</label>    
	               <input class="nui-textbox" name="oldPositions" id="oldPositions" readonly="readonly" />
			  </td>
			</tr>
			<tr >
			 	<td>
					<label for="billType2">现仓位：</label>    
	               	<input class="nui-textbox" name="positions" id="positions"  />
				</td>
			</tr>
		</table>
		
	</div>
</body>
</html>