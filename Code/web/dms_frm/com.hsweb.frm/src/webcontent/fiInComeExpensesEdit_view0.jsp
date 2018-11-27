<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>新增项目</title>
<script src="<%=webPath + contextPath%>/frm/js/arap/fiInComeExpensesEdit.js?v=1.0.2"></script>
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
    width: 120px;
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



    <div id="editForm" class="form">
    	<input id="id" name="id" width="100%" class="nui-hidden" >
    	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
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
                <td ><input id="parentId" name="parentId" width="100%" class="nui-combobox" textField="name" valueField="id"     dataField="" url="" valueFromSelect="true" allowinput="true"></td>
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
        </table>

    </div>
	<div class="nui-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;text-align:center;">
        <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;保存并新增</a>
        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
    </div>


</body>
</html>
