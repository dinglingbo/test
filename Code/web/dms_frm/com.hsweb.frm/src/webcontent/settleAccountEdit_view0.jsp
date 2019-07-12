<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>结算账户修改</title>
<script src="<%=webPath + contextPath%>/frm/js/settle/settleAccountEdit.js?v=1.1.31"></script>
<style type="text/css">
        a.optbtn {
            width: 44px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }
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
    font-size:13px;
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
.barkcla{
	display:none;   
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
                            <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="onClose()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
        <table class="tmargin" style="white-space:nowrap;">
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
             <tr name="bark" class="htr barkcla" >
                <td class=" right fwidtha">银行名称:</td>
                <td ><input id="bankName" name="bankName" width="100%" class="nui-textbox" ></td>
            
            </tr>
             <tr name="bark" class="htr barkcla">
                <td class=" right fwidtha">银行账号:</td>
                <td ><input id="bankAccountNumber" name="bankAccountNumber" width="100%" class="nui-textbox" ></td>
            
            </tr>
             <tr name="bark" class="htr barkcla">
                <td class=" right fwidtha">手续费率:</td>
                <td ><input id="feeRate" name="feeRate" width="100%" class="nui-textbox" >‰</td>
            
            </tr>
             <tr name="bark" class="htr barkcla">
                <td class=" right fwidtha">最高手续费:</td>
                <td ><input id="feeMax" onvalidation="onValidation" name="feeMax" width="100%" class="nui-textbox" ></td>
            
            </tr>
            <tr class="htr">
                <td class=" right fwidtha">备注:</td>
                <td ><input id="remark" name="remark" width="75%" class="nui-textbox"><span style="font-size:13px;">&nbsp;默认:</span><input type="checkbox" id="isDefault" class="mini-checkbox"></td>
                
            </tr>
        </table>

    </div>
    <div class="vpanel_body vwidth">
        <div class="nui-fit">
            <div id="settleAccountGrid" class="nui-datagrid" style="width:100%;height:150px;"
                 showPager="false"
                 dataField="list"
                 idField="id"
                 ondrawcell=""
                 url=""
                 allowCellSelect="true"
                 allowCellEdit="true"
                 multiSelect="true"
                 showSummaryRow="false">
                <div property="columns">
                    <div name="action" width="60" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;">操作</div>
                    <div field="customId" type="comboboxcolumn" width="100" headerAlign="center" header="结算方式">
                        <input  property="editor" enabled="true" name="settleAccount" data="settleList" dataField="list" class="nui-combobox" valueField="customid" textField="name"  
                                  
                                  onvaluechanged="onSettleTypeChanged" emptyText=""  vtype="required"
                                  /> 
                    </div>
                    <div field="customName" visible="false" headerAlign="center" header="结算名称"></div>
                </div>
            </div>
        </div>
        
    </div>

</div>

</body>
</html>
