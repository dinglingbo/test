<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>快速报价</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/quickSearch.js?v=1.0.6"></script>
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
							<textarea id="tipText" style="height:80px;width:100%;" placeholder="剪贴板"></textarea>
                            <textarea class="nui-textarea" visible="false" emptyText="剪贴板" width="100%" style="height:80px;" id="resList" name="resList"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <a class="nui-button" width="" iconCls="" plain="false" onclick="onSearch()">&nbsp;查&nbsp;&nbsp;&nbsp;&nbsp;询&nbsp;</a>
							<a class="nui-button" width="" iconCls="" plain="false" onclick="onClear()">清空条件</a>
							<a class="nui-button" width="" iconCls="" plain="false" onclick="addPart()">新增配件</a>
							<a class="nui-button" width="" iconCls="" plain="false" onclick="showPanel()">购物车</a>	
							<button id="tipBtn" style="visibility: hidden;" class="tipBtn" data-clipboard-action="copy" data-clipboard-target="#tipText"></button>
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
							 sortMode="client"
							 allowCellEdit="true"
							 multiSelect="true"
							 showModified="false"
							 showSummaryRow="true"
							 showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
						<div property="columns">
								<div type="expandcolumn" width="40">替换件</div>
								<div type="checkboxcolumn" field="check" width="20" headerAlign="center" 
									 align="center" trueValue="1" falseValue="0"><span class="fa fa-check"></span>
								</div>
								<div field="partCode" width="150" headerAlign="center" allowSort="true" summaryType="count">编码</div>
								<div field="fullName" width="150" headerAlign="center" allowSort="true">全称</div>
								<div field="outableQty" width="40" headerAlign="center">库存</div>
								<div field="partBrandId" width="70" headerAlign="center">品牌</div>
								<div field="partName" width="80" headerAlign="center" allowSort="true">名称</div>
								<div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
								<div field="applyCarModel" width="120" headerAlign="center" allowSort="true">品牌车型</div>
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
							plain="false" >
							<div title="本店库存" id="storeStockTab" name="storeStockTab" url="" >
							</div> 
							<div title="库存分布" id="chainStockTab" name="chainStockTab" url="">
							</div>
							<div title="宝马中国" id="BMWStockTab" name="BMWStockTab" url="">
							</div>
							<div title="价格信息" name="priceTab" url="" >
							</div>   
							<div title="采购记录" name="enterRecordTab" url="" >
							</div>  
							<div title="销售记录" name="outRecordTab" url="" >
							</div> 
							<!-- <div title="占用记录" name="preOutTab" url="" >
							</div>  
							<div title="出入库流水" name="invocingTab" url="" >
							</div>   -->
							<div title="替换件" name="partCommonTab" url="" >
							</div> 
						</div>	
					</div>
				</div>
				<div showCollapseButton="false">
					<div class="nui-fit">
						<iframe id="epcFormIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
					</div>
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
					allowCellEdit="true"
					multiSelect="true"
					showModified="false"
					showLoading="true"
					selectOnLoad="true"
					sortMode="client"
					multiSelect="true"
					showSummaryRow="true"
					showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
			<div property="columns">
					<div type="checkboxcolumn" field="check" width="20" headerAlign="center" 
						 align="center" trueValue="1" falseValue="0"><span class="fa fa-check"></span>
					</div>
					<div field="partCode" width="150" headerAlign="center" allowSort="true" summaryType="count">编码</div>
					<div field="fullName" width="150" headerAlign="center" allowSort="true">全称</div>
					<div field="outableQty" width="40" headerAlign="center">库存</div>
					<div field="partBrandId" width="70" headerAlign="center">品牌</div>
					<div field="partName" width="80" headerAlign="center" allowSort="true">名称</div>
					<div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
					<div field="applyCarModel" width="120" headerAlign="center" allowSort="true">品牌车型</div>
					<div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
					<div field="qualityTypeId" width="60" headerAlign="center">品质</div>

			</div>
	</div>
</div>

<div id="win" class="nui-window" title="购物车(临时存放信息)" style="width:500px;height:300px;" 
        showMaxButton="true" showCollapseButton="true" showShadow="true"
        showToolbar="true" showFooter="true" showModal="false" allowResize="true" allowDrag="true"
        >
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <div class="form" id="queryForm">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" iconCls="" plain="true" onclick="deleteCartShop()">删除</a>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" visible="true" id="pchsCartBtn" plain="true" onclick="addToPchsCart()">添加采购车</a>
                            <a class="nui-button" iconCls="" visible="true" id="sellCartBtn" plain="true" onclick="addToSellCart()">添加销售车</a>
                            <span class="separator"></span>
                            <a class="nui-button" iconCls="" visible="true" id="pchsOrderBtn" plain="true" onclick="generatePchsOrder()">生成采购订单</a>
                            <a class="nui-button" iconCls="" visible="true" id="sellOrderBtn" plain="true" onclick="generateSellOrder()">生成销售订单</a>
                            
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="nui-fit">
                <div id="cartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                             borderStyle="border:0;"
                             showPager="false"
                             dataField="list"
                             url=""
                             showSummaryRow="true"
                             idField="id"
                             totalField="page.count"
                             pageSize="100"
                             oncellcommitedit="onCellCommitEdit"
							 showPager="true"
							 sortMode="client"
                             showLoading="false"
                             multiSelect="true"
                             showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
                        <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div type="checkcolumn" width="25"></div>
                                <div field="partId" width="50" visible="false" headerAlign="center">配件ID</div>
                                <div field="partCode" width="80" headerAlign="center" allowSort="true" summaryType="count">配件编码</div>
                                <div field="partName" width="120" headerAlign="center" allowSort="true">名称</div>
                                <div field="unit" width="30" visible="true" headerAlign="center" allowSort="false">单位</div>
                                <div field="orderQty" width="50" headerAlign="center" allowSort="true">
                                    数量<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="orderPrice" width="50" headerAlign="center" allowSort="true">
                                    单价<input property="editor" vtype="float" class="nui-textbox"/>
                                </div>
                                <div field="remark" width="80" headerAlign="center" allowSort="true">备注<input property="editor" class="nui-textbox"/></div>
                        </div>
                </div>
        </div>
    </div>


</body>
</html>
