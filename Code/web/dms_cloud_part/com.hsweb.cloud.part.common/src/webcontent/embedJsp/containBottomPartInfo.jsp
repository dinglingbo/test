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
<title>配件详情</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containBottomPartInfo.js?v=2.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>
<div class="nui-fit">
        <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
             frozenStartColumn="0"
                     frozenEndColumn="7"
                     dataField="parts"
                     url=""
                     ondrawcell="onPartGridDraw"
                     onrowdblclick=""
                     idField="id"
                     totalField="page.count"
                     pageSize="50"
                     showPager="false"
                     showLoading="true"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                <div property="columns">
                           
                        <div type="indexcolumn">序号</div>
                        <div field="isDisabled" width="50" headerAlign="center">状态</div>
                        <div field="qualityTypeId" width="60" headerAlign="center">品质</div>
                        <div field="partBrandId" width="120" headerAlign="center">品牌</div>
                        <div field="id" width="50" headerAlign="center">配件ID</div>
                        <div field="code" width="120" headerAlign="center" allowSort="true">编码</div>
                        <div field="name" width="120" headerAlign="center" allowSort="true">名称</div>
                        <div field="fullName" width="250" headerAlign="center" allowSort="true">全称</div>
                        <div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
                        <div field="spec" width="80" headerAlign="center" allowSort="true">规格</div>

                        <div field="position_name" width="60" headerAlign="center" allowSort="true">型号</div>

                        <div field="applyCarModel" width="280" headerAlign="center" allowSort="true">品牌车型</div>
                        <div field="carTypeIdF" width="80" headerAlign="center" allowSort="true">一级分类</div>
                        <div field="carTypeIdS" width="80" headerAlign="center" allowSort="true">二级分类</div>
                        <div field="carTypeIdT" width="80" headerAlign="center" allowSort="true">三级分类</div>
                        <div field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">零售价</div>
                        <div field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">批发价</div>
                        <div field="uniformSellPrice" width="70" headerAlign="center" align="right" allowSort="true">统一价格</div>
                        <div field="dept_name" width="60" headerAlign="center" allowSort="true">助记码</div>

                        <div field="namePy" width="60" headerAlign="center" allowSort="true">拼音</div>

                        <div field="position_name" width="70" headerAlign="center" header="售价方式" allowSort="true"></div>

                        <div field="abcType" width="80" headerAlign="center" allowSort="true">ABC类型</div>
                        <div field="produceFactory" width="80" headerAlign="center" allowSort="true">生产厂家</div>
                        <div field="nameEn" width="120" headerAlign="center" allowSort="true">英文名称</div>

                </div>
        </div>
</div>


</body>
</html>
