<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 14:09:04
  - Description:
-->
<head>
<title>客户档案</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" showToolbar="false" title="" showFooter="true"
		style="width: 100%; height: 12%">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsweb.repair.DataBase.RpbClass" />
			<!-- 排序 -->
			<input class="nui-hidden" name="criteria/_orderby[1]/_property"
				value="id" /> <input class="nui-hidden"
				name="criteria/_orderby[1]/_sort" value="arc">
			<table class="table" id="table1" style="height: 100%;">
				<tr style="width: 100%; height: 12%; line-height: 12%;">
					<td>
						<h4>快速查询：</h4>
					</td>
					<!-- lookup_type_code -->
					<td class="nui-button" id="lookup_type_code"
						style="margin-top: 5px;" plain="true">本日来厂</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">昨日来厂</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本日新客户</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本月新客户</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本月所有来厂客户</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本月流失回厂</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">上月流失回厂</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>


					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled"
						emptyText="请输入..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td class="form_label" id="lookup_type_name">手机号码：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled"
						emptyText="请输入..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td><a class="nui-button" iconCls="icon-search"
						onclick="search()">查询（Q）</a></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">更多</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>

					<!-- 超链接模式 -->
					<!-- 
        	        <td>
        	        	<a href="../../index.html">首页</a> 
        	        </td>
        	         -->
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button" id="add"
					iconCls="icon-add" onclick="add()">新增（A）</a> <a class="nui-button"
					id="edit" iconCls="icon-edit" onclick="edit()">修改（E）</a> <a
					class="nui-button" id="dataon" iconCls="icon-date"
					onclick="dateon()">资料合并</a> <a class="nui-button" id="datacut"
					iconCls="icon-date" onclick="datecut()">资料拆分</a> <a
					class="nui-button" id="save" iconCls="icon-history"
					onclick="save()">维修历史（W）</a></td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="true" showPage="true" showPageSize="true"
			showReloadButton="true" showPagerButtonIcon="true" totalCount="total"
			onselectionchanged="selectionChanged" allowSortColumn="true"
			virtualScroll="true" virtualColumns="true" frozenStartColumn="0"
			frozenEndColumn="7">

			<div property="columns">
				<div id="type" field="type" headerAlign="center" allowSort="true"
					visible="true" width="30px">序号</div>
				<div header="车辆信息" headerAlign="center">
					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="80px">车牌号</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="80px">品牌</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">车型</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="120px">VIN</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">保险到期</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">年审日期</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">投保公司</div>
					</div>
				</div>
				<div header="客户信息" headerAlign="center">
					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="60px">档案号</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="100px">客户名称</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="100px">地址</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">最后来厂日期</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">最后离厂日期</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="50px">营销员</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="50px">建档人</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="70px">建档日期</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="70px">来厂次数</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="70px">离厂天数</div>
					</div>
				</div>
				<div header="其他信息" headerAlign="center">
					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="120px">发动机号</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="80px">生产年份</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="50px">颜色</div>
					</div>
				</div>

			</div>
		</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>