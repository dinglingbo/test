<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 15:50:19
  - Description:
-->
<head>
	<title>通用提成</title>
	
	<script src="<%=webPath + contextPath%>/repair/cfg/js/tongyongticheng.js?v=1.0.61" ></script>
</head>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>
<body>
	<div class="nui-fit">
		<div style="width:100%;height:50%;">
			<div>
				<strong><span>项目提成：</span></strong>
				<span style="color: red">如果一个项目提成没有设置，则会使用通用提成。若需关闭通用提成，请清空设置即可。</span>
				<a class="nui-button" iconcls="" onclick="saveAll()">保存</a>
				<input style="display :none;" id="serviceTypeId" name="serviceTypeId" class="nui-combobox" valueField="id" textFiled="name" required="true"allowInput="true">
			</div>
			<div id="form">
				<table style="width:100%">
					<tr>
						<td style="width: 20%" align="center">
							类型
						</td>
						<td style="width: 25%" align="center">
							销售提成比例%
						</td>
						<td style="width: 25%" align="center">
							施工提成比例%
						</td>
						<td style="width: 25%" align="center">
							服务顾问提成比例%
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="grid" class="nui-datagrid"oncellcommitedit="onCellCommitEdit" datafield="list" showModified="false" allowcelledit="true" showVGridLines="false" allowcellselect="true" showColumns = "false"multiselect="false" showpager="false" url="" allowcellwrap="true" style="width:100%;height:90%;">
					<div property="columns">
						<div field="serviceTypeId"  headeralign="center" align="center" ></div>
						<div field="salesDeductType" id="salesDeductType" name="salesDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="salesDeductValue" id="salesDeductValue" name="salesDeductValue" headeralign="center" align="center" >
							<input class="nui-textbox" property="editor" vtype="float;range:0,100;">
						</div>
						<div field="techDeductType" id="techDeductType" name="techDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="techDeductValue" id="techDeductValue" name="techDeductValue" headeralign="center" align="center" >
							<input class="nui-textbox" property="editor"vtype="float;range:0,100;">
						</div>
						<div field="advisorDeductType" id="advisorDeductType" name="advisorDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="advisorDeductValue" id="advisorDeductValue" name="advisorDeductValue" headeralign="center" align="center">
							<input class="nui-textbox" property="editor" vtype="float;range:0,100;">
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div style="width:100%;height:50%;">
			<div>
				<strong><span>配件提成：</span></strong>
				<span style="color: red">如果一个配件提成没有设置，则会使用通用提成。若需关闭通用提成，请清空设置即可。</span>
				<a class="nui-button" iconcls="" onclick="savePart()">保存</a>
			</div>
			<div id="form2">
				<table style="width:100%">
					<tr>
						<td style="width: 20%" align="center">
							类型
						</td>
						<td style="width: 25%" align="center">
							销售提成比例%
						</td>
						<td style="width: 25%" align="center">
							施工提成比例%
						</td>
						<td style="width: 25%" align="center">
							服务顾问提成比例%
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="partGrid" class="nui-datagrid"oncellcommitedit="onCellCommitEdit" datafield="list" showModified="false" allowcelledit="true" showVGridLines="false" allowcellselect="true" showColumns = "false"multiselect="false" showpager="false" url="" allowcellwrap="true" style="width:100%;height:90%;">
					<div property="columns">
						<div field="serviceTypeId"  headeralign="center" align="center" ></div>
						<div field="salesDeductType" id="salesDeductType" name="salesDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="salesDeductValue" id="salesDeductValue" name="salesDeductValue" headeralign="center" align="center" >
							<input class="nui-textbox" property="editor" vtype="float;range:0,100;">
						</div>
						<div field="techDeductType" id="techDeductType" name="techDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="techDeductValue" id="techDeductValue" name="techDeductValue" headeralign="center" align="center" >
							<input class="nui-textbox" property="editor"vtype="float;range:0,100;">
						</div>
						<div field="advisorDeductType" id="advisorDeductType" name="advisorDeductType" headeralign="center" align="right" renderer="ontypeRenderer">
							<input class="nui-combobox" property="editor" data="type">
						</div>
						<div field="advisorDeductValue" id="advisorDeductValue" name="advisorDeductValue" headeralign="center" align="center">
							<input class="nui-textbox" property="editor" vtype="float;range:0,100;">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	nui.parse();
	var type = [{ id: "1", text: "原价" }, { id: "2", text: "折后价" }, { id: "3", text: "产值" }];
</script>
</body>
</html>