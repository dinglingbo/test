<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-08-15 11:25:16
  - Description:
-->
<head>
<title>设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/config/js/tenantIdShareUrl.js?v=1.0.0"></script>
<style type="text/css">
.table-label {
	text-align: right;
}

.title {
   width: 60px;
   text-align: right;
}

.form_label {
   width: 72px;
   text-align: right;
}

.required {
   color: red;
}

.rmenu {
  font-size: 14px;
  /* font-weight: bold; */
  text-align: left;
  margin: 0;
  padding-left: 25px;
  height: 18px;
  color: #fff;
  width: auto;
  margin-left: 20px;
  margin-top: 20px;
  background-size: 50%;
}

.tbtext{
  text-align: right;
  line-height: 40px;
  width: 10%;
}
.tbitext{
  text-align: right;
  line-height: 40px;
}
.spTag{
    float: right;
    margin-right: 20%;
}


</style>

</head>
<body>
<div  class="nui-tabs" activeIndex="0" style="width:100%;height:650px;">
    <div title="共享设置">
    <div class="nui-fit">
		<div class="nui-toolbar" style="padding:0px;border-bottom:1;">
			<table style="width:100%;">
				<tr>
					<td style="width:100%;text-align:left;">
						<a class="nui-button" plain="true" onclick="search" id="addStationBtn">
							<span class="fa fa-refresh fa-lg"></span>&nbsp;刷新
						</a>
						<a class="nui-button" plain="true" onclick="addShareUrl" id="addStationBtn">
							<span class="fa fa-plus fa-lg"></span>&nbsp;新增
						</a>
						<a class="nui-button" plain="true" onclick="delShareUrl" id="addStationBtn">
							<span class="fa fa-close fa-lg"></span>&nbsp;删除
						</a>
						<a class="nui-button" plain="true" onclick="saveShare" id="saveStationBtn">
							<span class="fa fa-save fa-lg"></span>&nbsp;保存
						</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="shareUrlGrid" class="nui-datagrid" style="width:100%;height:100%;"
					showPager="true"
					dataField="list"
					totalField="page.count"
					sortMode="client"
					allowCellSelect="true"
					allowCellEdit="true"
					showModified="false"
					pageSize="50"
					sizeList="[50,100,200]"
					showSummaryRow="true">
				<div property="columns">
					<div type="indexcolumn">序号</div>
					<div allowSort="true" field="name"  summaryType="count" headerAlign="center" header="名称">
							<input property="editor" class="nui-textbox"/>
					</div>
					<div allowSort="true" field="shareUrl" headerAlign="center" header="链接">
							<input property="editor" class="nui-textbox"/>
					</div>
					<div allowSort="true" allowSort="true" field="isDisabled"  headerAlign="center" header="状态">
						<input property="editor" class="nui-combobox" textField="name" data="statusList"
							valueField="id" />
					</div>
				</div>
			</div>
		</div>
</div>
    </div>
    <div title="其他设置"   >
      <!-- 数据实体名称 -->
        <input class="nui-hidden" name="criteria/_entity" value="com.hsapi.system.config.com_bmwUserCfg.ComBmwusercfg">
     <div class="nui-toolbar" style="padding:0px;border-bottom:1;" >
			<table style="width:100%;">
				<tr>
					<td style="width:100%;text-align:left;">
						<a class="nui-button" plain="true" onclick="baseAt()" id="">
							<span class="fa fa-plus fa-lg"></span>&nbsp;增加
						</a>
						<a class="nui-button" plain="true" onclick="edit()" id="baseMove()">
							<span class="fa fa-close fa-lg"></span>&nbsp;修改
						</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">
			<div id="grid1" class="nui-datagrid" style="width:100%;height:100%;"
					showPager="true"	
					totalField="page.count"
					sortMode="client"
					allowCellSelect="true"
					allowCellEdit="true"
					showSummaryRow="true"
					url="<%=sysApi %>/com.hsapi.system.config.textbase.searchBase.biz.ext" 
					dataField="bmw"
					idField="ID"
					>
				<div property="columns" >
					<div type="indexcolumn" >序号</div>
					<div field="loginname"  summaryType="count" headerAlign="center">
					宝马用户账号
					</div>
					<div allowSort="true" field="password" headerAlign="center" >
					宝马用户密码
					</div>
					<div allowSort="true" allowSort="true" field="encryptedstr"  headerAlign="center" >
					加密字符串
					</div>
					<div allowSort="true" field="remarks" headerAlign="center" >
					备注
					</div>
					<div allowSort="true" field="apptype" headerAlign="center" >
					类型
					</div>
				</div>
			</div>
		</div>
    </div>
</div>
<script type="text/javascript">
			nui.parse();
			var grid = nui.get("grid1");
			grid.load();
	function baseAt() {
		nui.open({
			targetWindow : window,
			url : "<%=contextPath %>/config/base64LoginIn.jsp",
			title : "新增用户",
			width : 350,
			height : 180,
			onload : function() {
			},
		});
	}
	
	function edit() {
		var row = grid.getSelected();
		if (row) {
			nui.open({
				url : "<%=contextPath %>/config/updataBase.jsp",
				title : "修改",
				width : 350,
				height : 200,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						pageType : "edit",
						record : {
							bmw : row
						}
					};
					//直接从页面获取，不用去后台获取
					iframe.contentWindow.setFormData(data);
				}
			});
		} else {
			nui.alert("请选中一条记录", "提示");
		}
	}
</script>
</body>
</html>