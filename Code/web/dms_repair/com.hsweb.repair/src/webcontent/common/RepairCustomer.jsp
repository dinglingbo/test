<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 12:06:08
  - Description:
-->
<head>
<title>维修客户选择</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-2px 0 0 0">
					<td>
						<label style="font-family:Verdana;">查询选项：</label>
					</td>
					<td>
						<input class="nui-combobox" width="80px" emptyText="请选择..." /> 
					</td>
					<td>
						<label>查询值：</label>
					</td>
					<td>
						<input class="nui-textbox" width="120px"/> 
					</td>
					<td>
						<span style="widht:0;height:100%;border:0.6px solid #AAAAAA;margin: 0 0 0 5px" ></span>
					</td>
					<td>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
						<a class="nui-button" iconCls="icon-downgrade" onclick="search()" plain="true">下一页(P)</a>
						<a class="nui-button" iconCls="icon-ok" onclick="search()" plain="true">选择（X）</a>
						<a class="nui-button" iconCls="icon-no" onclick="search()" plain="true">关闭（C）</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"
			url=""
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="false" showPage="true" showPageSize="false"
			showReloadButton="false" showPagerButtonIcon="false"
			totalCount="total" onselectionchanged="selectionChanged"
			allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="5">

			<div property="columns">
				<div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
				<div header="基本信息" headerAlign="center">
					<div property="columns">
						<div  field="type" headerAlign="center"
							allowSort="true" visible="true" width="70px">公司名称</div>
						<div  field="name" headerAlign="center"
							allowSort="true" visible="true" width="140px">工单号</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="75px">维修顾问</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="65px">车牌号</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="75px">接车卡号</div>
					</div>
				</div>
				<div header="辅助信息" headerAlign="center">
					<div property="columns">
						<div  field="type" headerAlign="center"
							allowSort="true" visible="true" width="60px">品牌</div>
						<div  field="name" headerAlign="center"
							allowSort="true" visible="true" width="150px">车型</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="60px">质检员</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">客户名称</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">业务类型</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">维修类型</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">投保公司</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">维修日期</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">离厂日期</div>
						<div  field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="120px">备注</div>
					</div>
				</div>
				<div header="维修项目" headerAlign="center">
					<div property="columns">
						<div  field="type" headerAlign="center"
							allowSort="true" visible="true" width="80px">项目金额</div>
						<div  field="name" headerAlign="center"
							allowSort="true" visible="true" width="60px">优惠率</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">优惠金额</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">项目小计</div>
					</div>
				</div>
				<div header="材料信息" headerAlign="center">
					<div property="columns">
						<div  field="type" headerAlign="center"
							allowSort="true" visible="true" width="80px">材料金额</div>
						<div  field="name" headerAlign="center"
							allowSort="true" visible="true" width="60px">优惠率</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">优惠金额</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">材料小计</div>
					</div>
				</div>
				<div header="金额信息" headerAlign="center">
					<div property="columns">
						<div  field="type" headerAlign="center"
							allowSort="true" visible="true" width="80px">维修金额</div>
						<div  field="name" headerAlign="center"
							allowSort="true" visible="true" width="100px">材料管理费</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="60px">辅料费</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">折让金额</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">其他费用</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="100px">整单优惠率</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="100px">总优惠金额</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">结算金额</div>
						<div  field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="8，，0px">发票金额</div>
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