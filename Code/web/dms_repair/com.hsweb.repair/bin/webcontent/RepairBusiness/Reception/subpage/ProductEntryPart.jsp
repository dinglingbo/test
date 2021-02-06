<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 14:20:21
  - Description:
-->
<head>
<title>标准化产品查询</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/ProductEntry.js?v=1.2.7"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.asLabel .mini-textbox-border,.asLabel .mini-textbox-input,.asLabel .mini-buttonedit-border,.asLabel .mini-buttonedit-input,.asLabel .mini-textboxlist-border
	{
	border: 0;
	background: none;
	cursor: default;
}

.asLabel .mini-buttonedit-button,.asLabel .mini-textboxlist-close {
	display: none;
}

.asLabel .mini-textboxlist-item {
	padding-right: 8px;
}

.point input {
	color: red;
	font-size: 12px;
	font-weight: 600;
}

a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
        .addyytime a{width:51px;height:22px;line-height:36px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;text-align:center;color:#00b4f6;border-radius:4px;margin:0 15px 15px 15px;padding-bottom:10px;}
        .addyytime a.hui{border:1px #e6e6e6 solid;color:#c8c8c8;background:#e6e6e6;}
        .addyytime a.xz{ border:1px #ff7800 solid; color:#fff; background:#ff7800;}
        a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #555555; text-decoration: none; }
        a:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 14px; color: #df0024; text-decoration: none; }
        a {transition:all .4s ease;}
        a.hot-word{color:blue !important;text-decoration: underline !important;}
</style>

</head>
<body>
<div  class="nui-panel" showToolbar="false" title="车型信息" showHeader="false" showFooter="false" style="width:100%;">
	<div class="nui-fit">
	<div id="carInfoForm" style="height:15%">
		<input class="nui-hidden" id="ExpenseAccount" name="ExpenseAccount"/>
		<input class="nui-hidden" name="carLevelId"/>
		<input class="nui-hidden" name="carLineId"/>
		<input class="nui-hidden" name="carBrandId"/>
		<table class="nui-form-table" height="8%">
			<tr>
				<td>热词分类：
					<a name="" class="hot-word" href='javascript:;' onclick="showHotWord()">保养</a>
					<a class="hot-word" href='javascript:;' onclick="showHotWord()">发动机</a>
					<a class="hot-word" href='javascript:;' onclick="showHotWord()">底盘</a>
					<a class="hot-word" href='javascript:;' onclick="showHotWord()">车身</a>
					<a class="hot-word" href='javascript:;' onclick="showHotWord()">电器</a>
					<a class="hot-word"  href='javascript:;' onclick="showHotWord()">所有</a>
				</td>				
			</tr>
			<tr>
            	 <td colspan="5">
                    <div class="addyytime">
                    </div>
                </td>
            </tr>
		</table>
	</div>
</div>
</div>
<div class="nui-fit">
	<div class="nui-splitter" style="width:100%;height:100%;"
		  borderStyle="border:0"
		  allowResize="false">
		<div size="180" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<label>配件类型</label>
				</div>
				<div class="nui-fit">
					<ul id="tree" class="nui-tree" url="" style="width: 100%;height:100%;"
						dataField="rs" showTreeIcon="true" textField="name"
						idField="id" parentField="parentId" resultAsTree="false">
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 2px; border: 0;;">
				<table class="nui-form-table">
					<tr>
						<td>
							<label>配件名称：</label>
						</td>
						<td>
							<input class="nui-textbox" id="queryValue"/>
						</td>
						<td>
							<a class="nui-button" plain="false"  onclick="onSearch(2)">查询</a>
							<a class="nui-button" plain="false"  onclick="onOk(2)">选择</a>
						</td>
					</tr>
				</table>
			</div>
			<div  class="nui-fit">
				<div class="nui-splitter" style="width:100%;height:100%;" borderStyle="0" allowResize="false">
					<div size="60%" showCollapseButton="false" style="border:0;">
						<div>
							<label>原厂配件编码：</label>
						</div>
						<div class="nui-fit">
							<div class="nui-datagrid" style="width:100%;height:100%"
								 id="partGrid" dataField="rs"
								 pageSize="20"
								 totalField="page.count"
								 allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
									<div field="name" width="180" headerAlign="center" allowSort="true" header="原厂名称"></div>
									<div field="stdName" width="100" headerAlign="center" allowSort="true" header="标准名称"></div>
									<div field="sellPrice4s" width="180" headerAlign="center" allowSort="true" header="市场金额"></div>
									<div field="sellPriceStd" width="80" headerAlign="center" allowSort="true" header="建议销价"></div>
									<div field="remark" width="80" headerAlign="center" allowSort="true" header="备注"></div>
									<div field="parentGroupCode" width="180" headerAlign="center" allowSort="true" header="主组别编码"></div>
									<!--<div field="parentGroupId" headerAlign="center" allowSort="true" header="主组别"></div>-->
									<div field="groupCode" width="100" headerAlign="center" allowSort="true" header="子组别编码"></div>
									<!--<div field="groupId" width="100" headerAlign="center" allowSort="true" header="子组别"></div>-->
									<div field="id" headerAlign="center" allowSort="true" header="内码"></div>
								</div>
							</div>
						</div>
					</div>
					<div showCollapseButton="false" style="border:0;">
						<div>
							<label>互换配件编码：</label>
						</div>
						<div class="nui-fit">
							<div class="nui-datagrid" style="width:100%;height:100%"
								 id="brandPartGrid" dataField="rs"
								 pageSize="20"
								 totalField="page.count"
								 allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div field="name" width="80" headerAlign="center" allowSort="true" header="品牌"></div>
									<div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
									<div field="hotIndex" width="100" headerAlign="center" allowSort="true" header="热度"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
    <div class="nui-datagrid" style="width:100%;height:100%"  id="packageGrid" visible="false"></div>
    <div class="nui-datagrid" style="width:100%;height:100%"  id="packageDetail" visible="false"></div>
	<div class="nui-datagrid" style="width:100%;height:100%"  id="itemGrid" visible="false"></div>
</body>
</html>