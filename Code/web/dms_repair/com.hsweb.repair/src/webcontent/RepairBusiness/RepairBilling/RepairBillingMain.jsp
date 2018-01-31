<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:50:17
  - Description:
-->
<head>
<title>维修开单</title>
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
						style="margin-top: 7px;" plain="true">本日</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">昨日</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本周</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上周</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本月</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上月</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本年</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上年</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>


					<td class="form_label" id="lookup_type_name">车牌号（客户）：</td>
					<td colspan="3"><input class="nui-buttonedit"
						name="isDisabled" emptyText="请输入..." showClose="true"
						oncloseclick="onCloseClick" /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td class="form_label" id="lookup_type_name">维修顾问：</td>
					<td colspan="3"><input class="nui-combobox" name="isDisabled"
						emptyText="请选择..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td><a class="nui-button" iconCls="icon-search"
						onclick="search()">查询（Q）</a></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">更多</td>
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
				<td style="width: 100%"><a class="nui-button" id="new"
					iconCls="icon-new" onclick="new()">开单</a> <a class="nui-button"
					id="edit" iconCls="icon-edit" onclick="edit()">修改</a> <a
					class="nui-button" id="next" iconCls="icon-downgrade"
					onclick="next()">下一页</a> <a class="nui-button" id="user"
					iconCls="icon-user" onclick="user()">客户资料</a> <a class="nui-button"
					id="dataon" iconCls="icon-date" onclick="dateon()">维修历史</a> <a
					class="nui-menubutton" id="datacut" iconCls="icon-print"
					onclick="print()">打印</a></td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		vertical="true">
		<div size="40%" showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 100%;"
					url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="4">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="30px">序号</div>
						<div header="基本信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">公司名称</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="150px">工单号</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修顾问</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="120px">车牌号</div>
							</div>
						</div>
						<div header="辅助信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="60px">品牌</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="150px">车型</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="60px">质检员</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">客户名称</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">业务类型</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修类型</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">投保公司</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">维修日期</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="100px">离厂日期</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="120px">备注</div>
							</div>
						</div>
						<div header="维修项目" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">项目金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="60px">优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">项目小计</div>
							</div>
						</div>
						<div header="材料信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">材料金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="60px">优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">材料小计</div>
							</div>
						</div>
						<div header="金额信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">维修金额</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="100px">材料管理费</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="60px">辅料费</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">折让金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">其他费用</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="100px">整单优惠率</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="100px">总优惠金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">结算金额</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="80px">发票金额</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div id="mainTabs" class="nui-tabs" activeIndex="0"
				style="width: 100%; height: 100%;" plain="false" onactivechanged="">
				<div title="维修项目/材料" url="./subpage/RepairItem.jsp"></div>
				<div title="辅料清单 " url="./subpage/PartList.jsp"></div>
				<div title="出车报告 " url="./subpage/OutCar.jsp"></div>
				<div title="描述信息 " url="./subpage/Description.jsp"></div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>