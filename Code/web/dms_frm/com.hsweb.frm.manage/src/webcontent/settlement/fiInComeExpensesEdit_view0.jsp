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
<title>新增项目</title>
<script src="<%=webPath + contextPath%>/manage/settlement/js/fiInComeExpensesEdit.js?v=2.0.7"></script>
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
.tmargin{
    margin-top: 10px;
    margin-left: 50px;
    margin-bottom: 10px;
}
.htr{
    height: 30px;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 140px;
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
	                <td class=" right fwidtha required">项目编码:</td>
	                <td ><input id="code" name="code" width="100%" class="nui-textbox" ></td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">项目名称:</td>
	                <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha">上级项目:</td>
	                <td ><input id="parentId" name="parentId" width="100%" class="nui-combobox" textField="name" valueField="id"     
	                		dataField="" url="" valueFromSelect="true" allowinput="true" popupheight="100">
	                </td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">项目类型:</td>
	                <td >
	                    <div id="itemTypeId" name="itemTypeId" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" 
	                        textField="name" valueField="id" value="1"  width="100%"
	                        url="" >
	                    </div> 
	                </td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">是否主营业务项目:</td>
	                <td >
	                    <div id="isPrimaryBusiness" name="isPrimaryBusiness" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" 
	                        textField="name" valueField="id" value="1"  width="100%"
	                        url="" >
	                    </div> 
	                </td>
	            </tr>
	            <tr class="htr">
	                <td class=" right fwidtha required">是否销售费用:</td>
	                <td >
	                    <div id="isSale" name="isSale" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" 
	                        textField="name" valueField="id" value="1"  width="100%"
	                        url="" >
	                    </div> 
	                </td>
	            </tr>
	        </table>
	
	    </div>
	</div>
</body>
</html>
