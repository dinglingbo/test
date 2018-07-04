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
<title>快速报价</title>
<script src="<%=webPath + cloudPartDomain%>/purchase/js/quickSearch.js?v=1.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
.title {
	text-align: right;
	display: inline-block;
}

.title-width1 {
	width: 75px;
}

.title-width2 {
	width: 90px;
}
.left{
    text-align: left;
}
.right{
    text-align: right;
}  
.fwidtha{
    width: 60px;
}
.fwidthb{
    width: 60px;
}
.htr{
    height: 20px;
}
.mainwidth{
    width: 700px;
}
.tmargin{
    margin-top: 10px;
    margin-bottom: 10px;
}
</style>
</head>
<body>

<div class="nui-fit">
    <div  class="nui-splitter" style="width:100%;height:100%;" allowResize="true">
        <div size="450px" showCollapseButton="false">
            <div id="queryForm" class="form" style="text-align:center;padding:10px;">
                <table style="width:100%;" border="0">
                    <tr>
                        <td>
							<input name="queryConditions" id="queryConditions" class="nui-combobox" textField="name" valueField="id"
                       emptyText="请选择..." allowInput="false" value="0" showNullItem="false" width="100%" valueFromSelect="true"/>
						</td>
						<td>
                            <input class="nui-textbox" width="100%" id="conditoinsValue" name="conditoinsValue" emptyText="请输入查询条件"/>
                        </td>
                    </tr>
                    <tr>
                        <td >
                            <textarea class="nui-textarea" emptyText="编码列表(多个编码请换行输入)" width="100%" style="height:80px;" id="partCodeList" name="partCodeList"></textarea>
						</td>
						<td >
                            <textarea class="nui-textarea" emptyText="剪贴板" width="100%" style="height:80px;" id="resList" name="resList"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a class="nui-button" width="" iconCls="" plain="false" onclick="onSearch()">&nbsp;查&nbsp;&nbsp;&nbsp;&nbsp;询&nbsp;</a>
							<a class="nui-button" width="" iconCls="" plain="false" onclick="onClear()">清空条件</a>
							<a class="nui-button" width="" iconCls="" plain="false" onclick="addPart()">新增配件</a>
						</td>
                    </tr>
                </table>
			</div>
			<div class="nui-fit">
				<div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
							 dataField="parts"
							 url=""
							 idField="id"
							 showPager="false"
							 allowCellSelect="true"
							 showLoading="true"
							 selectOnLoad="true"
							 multiSelect="true"
							 showSummaryRow="true"
							 showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
						<div property="columns">
								<div type="expandcolumn" width="40">替换件</div>
								<div field="partCode" width="150" headerAlign="center" allowSort="true" summaryType="count">编码</div>
								<div field="fullName" width="150" headerAlign="center" allowSort="true">全称</div>
								<div field="stockQty" width="40" headerAlign="center">库存</div>
								<div field="partBrandId" width="70" headerAlign="center">品牌</div>
								<div field="partName" width="80" headerAlign="center" allowSort="true">名称</div>
								<div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
								<div field="applyCarModel" width="120" headerAlign="center" allowSort="true">车型</div>
								<div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
								<div field="qualityTypeId" width="60" headerAlign="center">品质</div>
  
						</div>
				</div>
			</div>
        </div>
        <div showCollapseButton="false">
			<div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
				<div size="50%" showCollapseButton="false">
					<div class="nui-fit">
						<div id="mainTabs" class="nui-tabs" name="mainTabs"
							activeIndex="0" 
							style="width:100%; height:100%;" 
							plain="false" 
							onactivechanged="">
							<div title="本店库存" id="partInfoTab" name="partInfoTab" url="" >
							</div> 
							<div title="库存分布" id="billmain" name="billmain" url="">
							</div>
							<div title="价格信息" name="purchaseAdvanceTab" url="" >
							</div>   
							<div title="入库记录" name="purchaseAdvanceTab" url="" >
							</div>  
							<div title="出库记录" name="purchaseAdvanceTab" url="" >
							</div>  
							<div title="出入库流水" name="purchaseAdvanceTab" url="" >
							</div>  
							<div title="替换件" name="purchaseAdvanceTab" url="" >
							</div> 
						</div>	
					</div>
				</div>
				<div showCollapseButton="false">
					<iframe id="formIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
				</div>
			</div>		    
        </div>
    </div>
        
</div>

<div id="partCommonForm" style="display:none;">
	<div id="innerPartCommonGrid" class="nui-datagrid" style="width:100%;height:150px;"
					dataField="parts"
					url=""
					idField="id"
					showPager="false"
					allowCellSelect="true"
					showLoading="true"
					selectOnLoad="true"
					multiSelect="true"
					showSummaryRow="true"
					showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
			<div property="columns">
					<div field="partCode" width="150" headerAlign="center" allowSort="true" summaryType="count">编码</div>
					<div field="fullName" width="150" headerAlign="center" allowSort="true">全称</div>
					<div field="stockQty" width="40" headerAlign="center">库存</div>
					<div field="partBrandId" width="70" headerAlign="center">品牌</div>
					<div field="partName" width="80" headerAlign="center" allowSort="true">名称</div>
					<div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
					<div field="applyCarModel" width="120" headerAlign="center" allowSort="true">车型</div>
					<div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
					<div field="qualityTypeId" width="60" headerAlign="center">品质</div>

			</div>
	</div>
</div>


</body>
</html>
