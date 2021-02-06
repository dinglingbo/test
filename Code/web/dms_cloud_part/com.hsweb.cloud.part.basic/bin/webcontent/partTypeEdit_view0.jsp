<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>新增分类</title>
<script src="<%=webPath + contextPath%>/basic/js/partTypeEdit.js?v=2.0.0"></script>
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


<div class="nui-fit">
<!--     <div class="nui-fit"> -->
        <div id="editForm" class="form">
        	<input id="id" name="id" width="100%" class="nui-hidden" >
        	<input id="orgid" name="orgid" width="100%" class="nui-hidden" >
            <table class="tmargin">
                <tr class="htr">
                    <td class=" right fwidtha required">分类编码:</td>
                    <td ><input id="code" name="code" width="100%" class="nui-textbox" ></td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidtha required">分类名称:</td>
                    <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
                </tr>
                <tr class="htr">
                    <td class=" right fwidtha required">上级分类:</td>
                    <td ><input id="parentId" name="parentId" width="100%" class="nui-combobox" textField="name" valueField="id"  popupHeight="50%"   dataField="" url="" valueFromSelect="true" allowinput="true"></td>
                </tr>
            </table>

        </div>
<!--     </div> -->
	<div class="nui-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;text-align:center;">
        <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;保存并新增</a>
        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
    </div>
</div>


</body>
</html>
