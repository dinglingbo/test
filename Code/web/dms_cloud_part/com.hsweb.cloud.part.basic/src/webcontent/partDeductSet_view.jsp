<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-09 20:05:20
  - Description:
-->
<head>
	<title>配件提成设置</title>
	<script src="<%=webPath + contextPath%>/basic/js/partDeductSet.js?v=1.0.29"></script>

	<style type="text/css">
	.table-label {
		text-align: center;
	}
	table{
		font-size:15px;
	}
	

	td.d_label{
		padding-top:12px;
		
	}  
	a{ text-decoration:none}   
</style>
</head>
<body>

	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		<table style="width:100%;">
			<tr>
				<td style="white-space:nowrap;">
				    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
	                <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch()" />
	<!-- 				<input id="partCodeSearch" name="queryCodeSearch" width="120px" emptyText="编码" class="nui-textbox"/>
					<input id="namePySearch" name="namePySearch" width="120px" emptyText="拼音" class="nui-textbox"/>
					<input id="partNameSearch" name="fullNameSearch" width="120px" emptyText="名称" class="nui-textbox"/> -->
					<a class="nui-button" plain="true" iconCls="" onclick="onUnifySearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
					<span class="separator"></span>
					<a class="nui-button" plain="true" iconCls="" onclick="addUnifyPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
					<a class="nui-button" plain="true" iconCls="" onclick="delUnifyPart()"><span class="fa fa-close fa-lg"></span>&nbsp;删除配件</a>
					<a class="nui-button" plain="true" iconCls="" onclick="saveUnifyPart()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
<!-- 					<a class="nui-button" plain="true" iconCls="" onclick="importUnifyPart()" id="importPartBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a> -->
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="rightUnifyGrid" class="nui-datagrid" style="width:100%;height:100%;"
		showPager="true"
		dataField="list"
		idField="id"
		pageSize="50"
		sizeList=[20,50,100,200]
		allowCellEdit="true"
		allowCellSelect="true"
		ondrawcell=""
		showReloadButton="false"
		showModified="false"
		oncellcommitedit="onCellCommitEdit"
		multiSelect="true"
		selectOnLoad="true"
		sortMode="client"
		totalField="page.count"
		allowCellWrap = true
		url="">
		<div property="columns">
			<div type="indexcolumn" width="20">序号</div>
			<div type="checkcolumn" width="25"></div>
			<div field="partCode" name="partCode" headerAlign="center" allowSort="true">配件编码</div>
			<div field="partName" name="partName" headerAlign="center" allowSort="true">配件名称</div>
<!-- 			<div field="sellPrice" name="sellPrice" headerAlign="center" allowSort="true" header="参考售价"> -->
<!-- 				<input property="editor" required="true" vtype="float" class="nui-textbox"/> -->
<!-- 			</div> -->
			<div  field="type"  name="type" headerAlign="center" allowSort="true" header="销售提成类型">
<!-- 				<input  property="editor" vtype="float" class="nui-textbox"/> -->
				<input required="true" property="editor" name="salesDeductType"
                            id="salesDeductType"
                            class="nui-combobox"
                            textField="text"
                            valueField="id"
                            data="typeList"
                            emptyText="请选择..."
                            url=""
                             required="true"
                            allowInput="false"
                            valueFromSelect="true"
                            popupHeight="90%"
                          />
			</div>
			<div field="deductRate" name="deductRate" headerAlign="center" allowSort="true" header="销售提成比例(%)">
				<input  property="editor" required="true" vtype="float;range:0,100;" class="nui-textbox"/>
			</div>
			<div field="remark" name="remark" headerAlign="center" allowSort="true" header="备注">
				<input  property="editor"  class="nui-textbox"/>
			</div>
			<div field="operator" width="60" headerAlign="center" allowSort="true">操作人</div>
			<div field="operateDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">操作日期</div>
		</div>
	</div>
</div>

</body>
</html>
