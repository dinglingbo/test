<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-09 15:33:46
  - Description:
-->
<head>
<title>备货级别设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<script src="<%=webPath + contextPath%>/basic/js/stockLevelSet.js?v=1.0.70"></script>
   
<style type="text/css">
.table-label {
	text-align: right;
}  
</style>
</head>
<body>
	<div class="nui-splitter"
           id="splitter"
           allowResize="false"
           handlerSize="6"
           style="width:100%;height:100%;">
           
          <div size="260" showCollapseButton="false">
          	
          	 <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;">
                                  <label style="font-family:Verdana;">备货级别定义:</label>
                                  <a class="nui-button" plain="true" iconCls="" onclick="onAddNode()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="onSaveNode()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
<!--                                   <a class="nui-button" plain="true" id="deleteNode" iconCls="" onclick="onDeleteNode()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a> -->
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="straGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="data"
                           idField="id"
                           selectOnLoad="true"
                           allowCellEdit="true"
                           allowCellSelect="true"
                           showModified="false"
                           selectOnLoad="false"
                           onrowclick="onStraGridClick"
                           oncellbeginedit =""
                           sortMode="client"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn" width="20">序号</div>
                              <div field="name" width="60" headerAlign="center" header="级别名称" allowSort="true">
                                  <input property="editor" class="nui-textbox" />
                              </div>
                              <div field="isDisabled"  allowSort="true" headerAlign="center" header="状态">
                                    <input property="editor" class="nui-combobox" textField="name" data="statusList" valueField="id" />
                                </div>
                          </div>
                      </div>
                  </div>
         	</div>
          
          <div showCollapseButton="false">
          		
          		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
					<table style="width:100%;">
						<tr>
							<td style="white-space:nowrap;">
							    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statuList" allowInput="false" />
				                <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch()" />
								<a class="nui-button" plain="true" iconCls="" onclick="onUnifySearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
								<span class="separator"></span>
								<a class="nui-button" plain="true" iconCls="" onclick="addUnifyPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
								<a class="nui-button" plain="true" iconCls="" onclick="delUnifyPart()"><span class="fa fa-close fa-lg"></span>&nbsp;删除配件</a>
								<a class="nui-button" plain="true" iconCls="" onclick="saveUnifyPart()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
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
						<div field="id" name="id" visible="false" headerAlign="center" allowSort="true">主键</div>
						<div field="leveId" name="leveId" visible="false" headerAlign="center" allowSort="true">级别ID</div>
						<div field="partCode" name="partCode" headerAlign="center" allowSort="true">配件编码</div>
						<div field="partName" name="partName" headerAlign="center" allowSort="true">配件名称</div>
						<div field="fullName" name="partName" headerAlign="center" allowSort="true">配件全称</div>
						<div field="remark" name="remark" headerAlign="center" allowSort="true" header="备注">
							<input  property="editor"  class="nui-textbox"/>
						</div>
						<div field="operator" width="60" headerAlign="center" allowSort="true">操作人</div>
						<div field="operateDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">操作日期</div>
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