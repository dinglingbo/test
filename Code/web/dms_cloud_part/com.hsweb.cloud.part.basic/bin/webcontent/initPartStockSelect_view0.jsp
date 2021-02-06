<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>期初入库选择</title>
<script src="<%=webPath + contextPath%>/basic/js/initPartStockSelect.js?v=2.0.2"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
        <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
    </div>
</div>
    
<div class="nui-fit" >
    <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
         borderStyle="border:0;"
         dataField="pjEnterMainList"
         url=""
         ondrawcell="onDrawCell"
         onrowdblclick="onRowDblClick"
         idField="id"
         totalField="page.count"
         pageSize="50"
         showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
        <div property="columns">
            <div header="基础信息" headerAlign="center">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center">序号</div>
                    <!-- <div field="isDisabled" width="50" headerAlign="center">状态</div> -->
                    <!-- <div field="qualityTypeId" width="60" headerAlign="center">品质</div> -->
                    <div field="serviceId" width="100" headerAlign="center">入库单号</div>
                    <div field="storeId" width="60" headerAlign="center" allowSort="true">默认仓库</div>
                    <div field="auditSign" width="50" headerAlign="center" renderer="onRenderer">是否审核</div>
                    <div field="orderMan" width="50" headerAlign="center">业务员</div>
                    <div field="remark" width="120" headerAlign="center" allowSort="true">备注</div>
                    <div field="enterAmt" width="80" headerAlign="center" allowSort="true">总金额</div>
                    <div field="creator" width="80" headerAlign="center" allowSort="true">制单人</div>
                    <div field="createDate" dateFormat="yyyy-MM-dd HH:mm" width="120px" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true">
                    制单日期
                    </div>
                    
                </div>
            
            </div>
        </div>
</div>
        
    
</div>


</body>
</html>
