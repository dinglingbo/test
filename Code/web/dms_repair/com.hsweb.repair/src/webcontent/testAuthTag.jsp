<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/tlds/btnAuth.tld" prefix="btnAuth" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:05:48
  - Description:
-->
<head>
<title>公告设置</title>
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

<div class="nui-fit">

		<div class="nui-toolbar" style="padding:0px;border-bottom:1;">
			<table style="width:100%;">
				<tr>
					<td style="width:100%;text-align:left;">
					
						<btnAuth:MyAuth name="test1"/>
					
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
						<btnAuth:MyAuth name="test1"/>
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

</body>
</html>
