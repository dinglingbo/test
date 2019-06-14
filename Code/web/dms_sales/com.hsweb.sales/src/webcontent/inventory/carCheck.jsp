<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>验车</title>
    <script src="<%=webPath + contextPath%>/sales/inventory/js/carCheck.js?v=1.0.2"></script>
    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
</style>
</head>
<body>
<div class="nui-fit">
     <div class="nui-toolbar" height="50px">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="choose()" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onClose()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    	<input name="frameColorId" id="frameColorId" class="nui-combobox" textField="name" valueField="id" allowInput="true" visible="false"/>
    <input name="interialColorId" id="interialColorId" class="nui-combobox" textField="name" valueField="id" allowInput="true" visible="false"/>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:480px"
         showPager="true"
         dataField="checkOrderDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         totalField="page.count"
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         selectOnLoad="true"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = true
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn" width="40">序号</div>
            		<div field="serviceCode" allowSort="true"  width="100" summaryType="count" headerAlign="center" header="单号"></div>
            		<div field="guestFullName" allowSort="true"  width="100" summaryType="count" headerAlign="center" header="供应商"></div>
                    <div field="carModelName" name="guestFullName" width="100" headerAlign="center" header="车型"></div>
                    <div field="frameColorId" allowSort="true"  name="frameColorId" width="60" headerAlign="center" header="车身颜色"></div>
                    <div allowSort="true" field="interialColorId"  name="interialColorId" width="60" headerAlign="center" header="内饰颜色"></div>  
                    <div allowSort="true" field="orderPrice" name="orderPrice" width="60" headerAlign="center" header="单价"></div>
                    <div allowSort="true" field="orderQty" name="orderQty" width="60" headerAlign="center" header="订货数量"></div>
                    <div field="checkingQty" name="guestFullName" width="60" headerAlign="center" header="待验"></div>
                     <div field="checkedQty" name="guestFullName" width="60" headerAlign="center" header="已验"></div>
                                                      
        </div>
    </div> 
</div>



</body>
</html>
