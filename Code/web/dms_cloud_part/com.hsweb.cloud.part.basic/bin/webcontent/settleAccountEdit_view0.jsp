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
<title>结算账户修改</title>
<script src="<%=webPath + contextPath%>/basic/js/settleAccountEdit.js?v=2.2.1"></script>
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
    <div>
        <div id="editForm" class="form">
            <input id="id" name="id" width="100%" class="nui-hidden" >
            <input id="orgid" name="orgid" width="100%" class="nui-hidden" >
              <table class="tmargin">
                  <tr class="htr">
                      <td class=" right fwidtha required">账户编码:</td>
                      <td ><input id="code" name="code" width="100%" class="nui-textbox" ></td>
                  </tr>
                  <tr class="htr">
                      <td class=" right fwidtha required">账户名称:</td>
                      <td ><input id="name" name="name" width="100%" class="nui-textbox" ></td>
                  </tr>
                  <tr class="htr">
                      <td class=" right fwidtha required">账户类型:</td>
                      <td >
                          <div id="accountTypeId" name="accountTypeId" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical" 
                              textField="name" valueField="id" value="1"  width="100%"
                              url="" >
                          </div> 
                      </td>
                  </tr>
                  <tr class="htr">
                      <td class=" right fwidtha required">金蝶部门编码:</td>
                      <td ><input id="kingDeptCode" name="kingDeptCode" width="100%" class="nui-textbox" ></td>
                  </tr>
                  <tr class="htr">
                      <td class=" right fwidtha required">金蝶部门名称:</td>
                      <td ><input id="kingDeptName" name="kingDeptName" width="100%" class="nui-textbox" ></td>
                  </tr>
                  <tr class="htr">
                      <td class=" right fwidtha">备注:</td>
                      <td ><input id="remark" name="remark" width="100%" class="nui-textbox" ></td>
                  </tr>
              </table>

          </div>
    </div>

    <div class="vpanel_body vwidth">
        <div class="nui-fit">
            <div id="settleAccountGrid" class="nui-datagrid" style="width:100%;height:120px;"
                 showPager="false"
                 dataField="list"
                 idField="id"
                 url=""
                 allowCellSelect="true"
                 allowCellEdit="true"
                 multiSelect="true"
                 ondrawcell="onDrawCell"
                 oncellbeginedit="OnModelCellBeginEdit"
                 showSummaryRow="false">
                <div property="columns">
                    <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">#</div>
                    <div field="customId" type="comboboxcolumn" width="100" headerAlign="center" header="结算方式">
                        <input  property="editor" enabled="true" name="settleAccount" data="settleList" dataField="list" class="nui-combobox" valueField="customid" textField="name"  url="" onvaluechanged="onSettleTypeChanged" emptyText=""  vtype="required"
                                  /> 
                    </div>
                    <div field="customName" visible="false" headerAlign="center" header="结算名称"></div>
                </div>
            </div>
        </div>
        

    </div>

	<div class="nui-toolbar" style="padding:0px;border-top:0;border-left:0;border-right:0;text-align:center;">
        <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;保存并新增</a>
        <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
    </div>
</div>




</body>
</html>
