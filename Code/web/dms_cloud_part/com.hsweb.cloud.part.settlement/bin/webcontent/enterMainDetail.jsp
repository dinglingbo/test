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
<title>采购入库、销售退货明细</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<!--<script src="<%=webPath + contextPath%>/common/js/shopCartPop.js?v=1.0.48"></script>-->
<style type="text/css">
.title {
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



<div id="batchInfoForm" class="form">
	<input class="nui-hidden" name="directGuestId"/>
	<input class="nui-hidden" name="directOrgid"/>
	<input class="nui-hidden" name="sourceType"/>
	<input class="nui-hidden" name="code"/>
	<input class="nui-hidden" name="codeId"/>
    <table style="width: 100%" id="list_table">
        <tr>
            <td class="title">
                <label >往来单位：</label>
            </td>
            <td colspan="1">
                <input id="guestFullName"
                     name="guestFullName"
                      class="nui-textbox"
                      width="100%"
                     />
            </td>
            <td class="title">
                <label >单号：</label>
            </td>
            <td colspan="1">
                <input id="serviceId"
                     name="serviceId"
                      width="100%"
                      class="nui-textbox"/>
            </td>
        </tr>
        <tr style="display:none;">
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
                     class="nui-combobox width1"
                     textField="name"
                     valueField="customid"
                     emptyText="请选择..."
                     url=""
                     allowInput="true"
                     showNullItem="false"
                     width="100%"
                     nullItemText="请选择..."
                     onvalidation="onComboValidation"/>
            </td>
        </tr>
        <tr>
        	<td class="title">
                <label>日期：</label>
            </td>
            <td colspan="1">
                <input id="auditDate" width="100%" name="auditDate"  class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
            </td>
        
            <td class="title">
                <label>备注：</label>
            </td>
            <td colspan="1">
                <input id="remark" width="100%" name="remark" class="nui-textbox" selectOnFocus="true" />
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
         selectOnLoad="true" showPager="false" oncellcommitedit=""  oncellbeginedit=""
         dataField="" idField="id" allowCellSelect="true" allowCellEdit="true" ondrawcell=""
         showModified="false" showColumnsMenu="true" editNextOnEnterKey="true" url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="partId" name="partId" visible="false" header="配件ID"></div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="partName" name="partName" visible="false" header="配件名称"></div>
            <div field="fullName" width="180" headerAlign="center" header="配件名称"></div>
            <div field="unit" name="unit" width="20" visible="false" header="单位"></div>
            <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
              
            </div>
            <div field="orderPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价(成本)">
               
            </div>
              <div field="orderAmt" numberFormat="0.0000" width="50" headerAlign="center" header="金额">
               
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">

var batchInfoForm = null;
var mainGrid = null;

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	batchInfoForm = new nui.Form("#batchInfoForm");

	billTypeIdEl = nui.get("billTypeId");
	settleTypeIdEl = nui.get("settleTypeId");
	guestIdEl = nui.get("guestId");

	var dictDefs = {
		"billTypeId" : "DDT20130703000008",
		"settleTypeId" : "DDT20130703000035"
	};
	initDicts(dictDefs, null);


});
function setInitData(data){
	batchInfoForm.setData(data.main);
	partList = data.partList;
	initGridData(partList);
}

function initGridData(data) {
	var rows = [];
	if (data && data.length > 0) {
		for (var i = 0; i < data.length; i++) {
			var part = data[i];
			var partId = part.partId;
			var partCode = part.partCode;
			var partName = part.partName;
			var fullName = part.fullName;
			var unit = part.unit;
			var orderQty = part.orderQty || 1;
			var orderPrice = part.orderPrice || 0;
			var orderAmt = part.orderAmt || 0;
			var prevDetailId = part.prevDetailId || 0;
			var row = {
				partId : partId,
				partCode : partCode,
				partName : partName,
				fullName : fullName,
				unit : unit,
				orderQty : orderQty,
				orderPrice : orderPrice,
				orderAmt : orderAmt,
				showPartId : partId,
        		showPartCode : partCode,
                showFullName : fullName,
                showBrandName :part.partBrandName || "",
                showCarModel : part.applyCarModel  || "",
                showOemCode : part.oemCode  || "",
                showSpec : part.spec  || "",
                showPrice :orderPrice
			};
			rows.push(row);
		}
	}

	mainGrid.setData(rows);
}

function CloseWindow(action) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}

function onCancel(e) {
	CloseWindow("cancel");
}
</script>

</body>
</html>
