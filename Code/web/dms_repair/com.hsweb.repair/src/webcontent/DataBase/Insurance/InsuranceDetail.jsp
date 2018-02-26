<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-29 15:58:11
  - Description:
-->
<head>
<title>编辑保险公司</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceDetail.js?v=1.0.1" ></script>
    
</head>
<body>
	<input name="id" class="nui-hidden" />
	<fieldset style="width:93%;height:200px;border:solid 1px #aaa;position:relative;margin:5px 5px;">
	    <div id="basicInfoForm" class="form" style="padding-top:5px;" >
	    <input class="nui-hidden" name="code"/>
	    	 <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
	                <tr>
	                    <td class="form_label" width="130px">
	                     <span style="color:#FF0000;margin-left:30px;">保险公司代码：</span> 	  
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="code" width="250px"/>
	                    </td>
	                </tr>
	                    <td class="form_label" width="130px">
	                       <span style="color:#FF0000;margin-left:30px;">保险公司名称：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="fullName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">保险公司缩写：</span> 
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="shortName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">保险公司拼音：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="pyName" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">联系人：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="contactor" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">联系人电话：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="contactorTel" width="250px"/>
	                    </td>
	                </tr>
	                </tr>
	                    <td class="form_label" width="130px">
	                        	<span style="margin-left:30px;">排序号：</span>
	                    </td>
	                    <td colspan="1">
	                        <input class="nui-textbox" name="orderIndex" width="250px"/>
	                    </td>
	                </tr>
	            </table>
	    </div>
    </fieldset>
	<div style="text-align:center;padding:10px;">               
		<a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
		<a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
	</div>

</body>
</html>