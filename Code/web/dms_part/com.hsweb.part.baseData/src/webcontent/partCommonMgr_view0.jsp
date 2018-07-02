<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>配件替换</title>
<script src="<%=webPath + cloudPartDomain%>/baseDataPart/js/partMgr/partCommonMgr.js?v=1.0.0"></script>
<style type="text/css">
.title {
  width: 60px;
  text-align: right;
}

.title.required {
  color: red;
}
.title.tip {
  color: blue;
}

.title.wide {
  width: 100px;
}

.mini-panel-border {
  border: 0;
}

.mini-panel-body {
  padding: 0;
}
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
</style>
</head>
<body>


<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
				<label style="font-family:Verdana;">查询项：</label>
				<input name="queryConditions" id="queryConditions" class="nui-combobox" textField="name" valueField="id"
                       emptyText="请选择..." allowInput="false" value="0" showNullItem="false" width="100px" valueFromSelect="true"/>
                <input class="nui-textbox" width="150px" id="conditoinsValue" name="conditoinsValue" emptyText="请输入查询条件"/>

                <a class="nui-button" plain="true" id="onSearch" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="addMorePart()" id="fastEnterBtn"><span class="fa fa-hand-o-right fa-lg"></span>&nbsp;多编码查询</a>
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="set()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;设置替换</a>
                <a class="nui-button" plain="true" onclick="unset()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;取消替换</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
  <div class="nui-splitter"
       id="splitter"
       allowResize="true"
	   handlerSize="6"
	   vertical="true"
       style="width:100%;height:100%;">
      <div size="220" showCollapseButton="true">
        <div title="配件列表" class="nui-panel"
               showFooter="true"
               style="width:100%;height:100%;border: 0;">
              <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                   showPager="true"
                   pageSize="50"
                   sizeList=[20,50,100,200]
                   selectOnLoad="true"
				   totalField="page.count"
				   multiSelect="true"
                   dataField="parts"
                   url="">
                  <div property="columns">
                    <div type="indexcolumn">序号</div>
					<div type="checkcolumn" width="25"></div>
					<div allowSort="true" field="qualityTypeId" width="60" headerAlign="center">品质</div>
					<div allowSort="true" field="partBrandId" width="70" headerAlign="center">品牌</div>
					<div allowSort="true" field="code" name="code" width="80" headerAlign="center" allowSort="true">编码</div>
					<div allowSort="true" field="name" name="name" width="80" headerAlign="center" allowSort="true">名称</div>
					<div allowSort="true" field="fullName" name="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
					<div allowSort="true" field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
					<div allowSort="true" field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
					<div allowSort="true" field="model" width="60" headerAlign="center" allowSort="true">型号</div>
                  </div>
              </div>
          </div>
      </div>
      <div showCollapseButton="false">
			<div class="nui-fit"> 
				<div title="替换件列表" class="nui-panel"
					showFooter="true"
					style="width:100%;height:100%;border: 0;">
					<div id="partCommonGrid" class="nui-datagrid" style="width:100%;height:100%;"
                        showPager="false"
                        pageSize="1000"
						selectOnLoad="true"
						showModified="false"
						onrowdblclick=""
						dataField="parts"
						url="">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div allowSort="true" field="qualityTypeId" width="60" headerAlign="center">品质</div>
							<div allowSort="true" field="partBrandId" width="70" headerAlign="center">品牌</div>
							<div allowSort="true" field="code" name="code" width="80" headerAlign="center" allowSort="true">编码</div>
							<div allowSort="true" field="name" name="name" width="80" headerAlign="center" allowSort="true">名称</div>
							<div allowSort="true" field="fullName" name="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
							<div allowSort="true" field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
							<div allowSort="true" field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
							<div allowSort="true" field="model" width="60" headerAlign="center" allowSort="true">型号</div>
						</div>
					</div>
				</div>
			</div>              
      </div>
  </div>


</div>

<div id="advancedSearchWin" class="nui-window"
     title="多编码录入" style="width:400px;height:200px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td colspan="3">
                    <textarea class="nui-textarea" width="100%" style="height: 110px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


</body>
</html>
