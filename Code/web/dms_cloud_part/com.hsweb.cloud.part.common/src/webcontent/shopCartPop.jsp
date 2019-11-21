<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:35:46
  - Description:
-->
<head>
<title>添加采购车/销售车</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/common/js/shopCartPop.js?v=1.0.1"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="" plain="true" onclick="onOk" id="chooseBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel" id="cancelBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
<div id="batchInfoForm" class="form">
    <table style="width: 100%" id="list_table">
        <tr>
            <td class="title required">
                <label>往来单位：</label>
            </td>
            <td colspan="3">
                <input id="guestId"
                     name="guestId"
                     class="nui-buttonedit"
                     emptyText="请选择往来单位..."
                     onbuttonclick="selectSupplier('guestId')"
                     onvaluechanged="onGuestValueChanged"
                     width="100%"
                     placeholder="请选择往来单位"
                     selectOnFocus="true" />
            </td>
        </tr>
        <tr style="display:none;">
            <td class="title">
              <label>简称：</label>
            </td>
            <td colspan="3">
                <input id="shortName"
                     name="shortName"
                     class="nui-textbox" />
            </td>
        </tr>
        <tr>
            <td class="title">
              <label>票据类型：</label>
            </td>
            <td>
              <input name="billTypeId"
                     id="billTypeId"
                     class="nui-combobox width1"
                     textField="name"
                     valueField="customid"
                     emptyText="请选择..."
                     url=""
                     valueFromSelect="true"
                     allowInput="true"
                     showNullItem="false"
                     width="100%"
                     nullItemText="请选择..."/>
            </td>
            <td class="title">
              <label>结算方式：</label>
            </td>
            <td>
              <input name="settleTypeId"
                     id="settleTypeId"
                     valueFromSelect="true"
                     class="nui-combobox width1"
                     textField="name"
                     valueField="customid"
                     emptyText="请选择..."
                     url=""
                     allowInput="true"
                     showNullItem="false"
                     width="100%"
                     nullItemText="请选择..."
                     onvalidation=""/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>备注：</label>
            </td>
            <td colspan="3">
                <input id="remark" width="100%" name="remark" class="nui-textbox" selectOnFocus="true" />
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
         selectOnLoad="true" showPager="false" oncellcommitedit="onCellCommitEdit"
         dataField="" idField="id" allowCellSelect="true" allowCellEdit="true" ondrawcell="onMainGridDrawCell"
         showModified="false" showColumnsMenu="true" editNextOnEnterKey="true" url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="operateBtn" width="20" align="center" headerAlign="center" header="删除"></div>
            <div field="partId" name="partId" visible="false" header="配件ID"></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="partName" name="partName" visible="false" header="配件名称"></div>
            <div field="fullName" width="180" headerAlign="center" header="配件全称"></div>
            <div field="unit" name="unit" width="20" visible="false" header="单位"></div>
            <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>
            <div field="orderPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
                <input property="editor" vtype="float" class="nui-textbox"/>
            </div>

        </div>
    </div>
</div>



</body>
</html>
