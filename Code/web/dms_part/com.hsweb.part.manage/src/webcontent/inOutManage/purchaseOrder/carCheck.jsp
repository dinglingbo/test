<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>整车采购退货</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/purchaseOrder/carSalesReturn.js?v=1.0.0"></script>
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
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;验车入库</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="pjPchsOrderMainList"
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
            <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                    <div field="" allowSort="true"  width="100" summaryType="count" headerAlign="center" header="品牌"></div>
                    <div field="" name="guestFullName" width="100" headerAlign="center" header="车型"></div>
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="年款"></div>
                    <div field="" name="guestFullName" width="100" headerAlign="center" header="规格"></div>
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="排量"></div>
                    <div field="" name="guestFullName" width="100" headerAlign="center" header="缸数"></div>
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="发动机号"></div>  
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="配置"></div>
                    <div field="" name="guestFullName" width="220" headerAlign="center" header="数量"></div>
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="金额"></div>   
                    <div field="" name="guestFullName" width="220" headerAlign="center" header="供方合同号"></div>
                    <div field="" width="90" name = "orderMan" headerAlign="center" header="许可证编码"></div>                                     
                    <div field="" allowSort="true"  width="130" headerAlign="center" header="预计到货" dateFormat="yyyy-MM-dd HH:mm" ></div>                    
        </div>
    </div> 
</div>



</body>
</html>
