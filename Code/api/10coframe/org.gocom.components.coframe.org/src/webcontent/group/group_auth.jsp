<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): gouyl
  - Date: 2013-10-09 14:43:27
  - Description:工作组授权
-->
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<head>
	<title>工作组授权</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="/coframe/tools/skins/common.jsp" %>
	<style type="text/css">
		#orgToolBar{
			width: 100%;
			margin: 0px;
			border: 0px none transparent;
			border-collapse: collapse;
		}
		#orgToolBar td{
			padding: 0px;
			border: 1px solid transparent;
		}
	</style>
</head>
<body>
	<div class="nui-fit" style="padding:10px;">
		<div id="orgForm">
			<div class="nui-toolbar" style="text-align:left;line-height:30px;padding:5px 0px 5px 10px;" borderStyle="border-bottom:0;">
				<table id="orgToolBar">
					<tr>
						<td style="width:1px;"></td>
						<td style="width:60px;"><a id="btn_save" class="nui-button" iconCls="icon-save" onclick="saving();">保存</a></td>
						<td></td>
						<td style="width:80px; text-align:right;">工作组名称：</td>
						<td style="width:100px;">
							<input class="nui-textbox" name="criteria._expr[0].groupname" style="width:100px;" />
							<input class="nui-hidden" name="criteria._expr[0]._op" value="like" />
							<input class="nui-hidden" name="criteria._expr[0]._likeRule" value="all" />
							<input class="nui-hidden" name="roleId" value="<%= StringUtil.htmlFilter(request.getParameter("roleId")) %>" />
						</td>
						<td style="width:70px; text-align:right;"><input class="nui-button" iconCls="icon-search" text="查询" onclick="searchOrg" /></td>
						<td style="width:10px;"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="nui-fit">
			<div id="orgGrid" class="nui-datagrid" style="width:100%;height:100%;" onload="onGridLoad"
				url="org.gocom.components.coframe.org.groupAuth.getGroupAuth.biz.ext"
				dataField="data" idField="groupid" allowResize="false" sizeList="[10,20,30]" pageSize="20" multiSelect="true" allowCellEdit="true">
			    <div property="columns">
			        <div field="groupid" width="120" headerAlign="center" >工作组编号</div>
			        <div field="groupname" width="120" headerAlign="center" >工作组名称</div>
			        <div type="checkboxcolumn" field="auth" width="120" headerAlign="center" trueValue="1" falseValue="">是否授权</div>
			    </div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var orgGrid = nui.get("orgGrid");
	var pageSize = orgGrid.getPageSize();
	<% if(null != request.getParameter("roleId") && !"".equals(request.getParameter("roleId"))){ %>
		var roleIdData = "<%=  StringUtil.htmlFilter(request.getParameter("roleId")) %>";
		var sendData = {"page":{"begin":0,"length":pageSize},"roleId":roleIdData};
		orgGrid.load(sendData);
	<% } %>

	function saving(){
		var orgWithAuth = [];
		var orgNoAuth = [];
		var orgData = orgGrid.getData();
		for(var i = 0; i < orgData.length; i++){
			var fieldNode = {partyTypeID:"group", id:orgData[i].groupid, code:orgData[i].groupname, name:orgData[i].groupname};
			if(orgData[i].auth == "1"){
				orgWithAuth.push(fieldNode);
			}else{
				orgNoAuth.push(fieldNode);
			}
		}
		var sendData = {roleId:"<%=  StringUtil.htmlFilter(request.getParameter("roleId")) %>", partyWithAuth:orgWithAuth, partyNoAuth:orgNoAuth};
		$.ajax({
			url:"org.gocom.components.coframe.org.authForParty.storePartyAuth.biz.ext",
			type: "POST",
			data: nui.encode(sendData),
			cache: false,
			contentType: "text/json",
			success: function(text){
				var returnJson = nui.decode(text);
				if(returnJson.saveResult){
					nui.alert("权限设置成功");
				}else{
					nui.alert("权限设置失败");
				}
			},
			error: function(jqXHR, textStatus, errorThrown){}
		});
	}

	function searchOrg(){
		var orgForm = new nui.Form("#orgForm");
		var orgFormData = orgForm.getData(false, true);
        orgGrid.load(orgFormData);
	}
	function onGridLoad(){
		var data = orgGrid.getData();
		nui.get("btn_save").set({"enabled":(data.length>0)});
	}
</script>
