<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>成本调整</title>
<script src="<%=webPath + contextPath%>/sales/inventory/js/costAdjust.js?v=1.0.0"></script>
<style type="text/css">
.title {
    width: 90px;
    text-align: right;
}

.title.required {
    color: red;
}

.mini-panel-border {
    /*border-right: 0;*/
    
}

.mini-panel-body {
    padding: 0;
}

.panelwidth{
    width: 300px;
}

.htr{
    height: 30px;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 80px;
}
.fwidthb{
    width: 120px;
}
.required {
    color: red;
}
</style>
</head>
<body>


	<div class="nui-fit">
	    <div id="editForm" class="form">
	    	<input id="id" name="id" width="100%" class="nui-hidden" >
	    	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
	    		
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onClose()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
	        <table class="tmargin">
	            <tr class="htr">
	                <td class=" right fwidtha required">车型:</td>
	                <td ><input id="carModelName" name="carModelName" width="100%" class="nui-textbox" ></td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">供应商:</td>
	                <td ><input id="guestFullName" name="guestFullName" width="100%" class="nui-textbox" ></td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">原成本:</td>
	                <td ><input id="unitPrice" name="unitPrice" width="100%" class="nui-textbox" ></td>
	            </tr>	            
	            <tr class="htr">
	                <td class=" right fwidtha required">现成本:</td>
	                <td ><input id="xunitPrice" name="xunitPrice" width="100%" class="nui-textbox" ></td>
	            </tr>

	        </table>
	
	    </div>
	</div>
</body>
</html>
