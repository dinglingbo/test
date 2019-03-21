<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:05:48
  - Description:
-->
<head>
<title>仓库定义</title>
<script src="<%=webPath + contextPath%>/baseDataPart/js/storehouseMgr/storehouseMgr.js?v=1.1.24"></script>
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
    <div size="250" showCollapseButton="false">
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <label style="font-family:Verdana;">仓库定义:</label>
                        <a class="nui-button" plain="true" iconCls="" onclick="onAddNode()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                        <a class="nui-button" plain="true" iconCls="" onclick="onEditNode()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <ul id="tree1" class="nui-tree" url="" style="width:100%;height: 100%;"
                contextMenu="#treeMenu"
                dataField="storehouse"
                resultAsTree="false"
                onnodeselect="onNodeselect"
                showTreeIcon="true" textField="name" idField="id" parentField="parentId">
            </ul>
        </div>
    </div>
    <div showCollapseButton="false">
        
        
        <div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
	        <!-- 上 -->
	        <div size="50%" showCollapseButton="false">
	         	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="white-space:nowrap;">
		                    	 <label style="font-family:Verdana;">仓位定义:</label>
		                        <a class="nui-button" plain="true" iconCls="" onclick="addPosition()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增仓位</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="savePosition()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="disableLocation()" id="disableBtn"><span class="fa fa-ban fa-lg"></span>&nbsp;禁用</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="enableLocation()" id="enableBtn" visible="false"><span class="fa fa-check fa-lg"></span>&nbsp;启用</a>
		                    </td>
		                </tr>
		            </table>
		        </div>
		        <div class="nui-fit">
		            <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                 showPager="false"
		                 dataField="locations"
		                 idField="id"
		                 allowCellEdit="true"
		                 allowCellSelect="true"
		                 ondrawcell="onDrawCell"
		                 selectOnLoad="true"
		                 sortMode="client"
		                 url="">
		                <div property="columns">
		                    <div type="indexcolumn">序号</div>
		                    <div field="name" name="name" headerAlign="center" allowSort="true">仓位
		                        <input property="editor" class="nui-textbox" style="width:100%;"/>
		                    </div>
		                    <div field="isDisabled" width="80" headerAlign="center" allowSort="true">是否禁用</div>
		                    <div field="recorder" width="60" headerAlign="center" allowSort="true">建档人</div>
		                    <div field="recordDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">建档时间</div>
		                    <div field="modifier" width="60" allowSort="true" headerAlign="center">修改人</div>
		                    <div field="modifyDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">修改时间</div>
		                </div>
		            </div>
		        </div>
        	</div>
        
	        <div  showCollapseButton="false">
	        	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		            <table style="width:100%;">
		                <tr>
		                    <td style="white-space:nowrap;">
		                    	 <label style="font-family:Verdana;">员工配置:</label>
		                        <a class="nui-button" plain="true" iconCls="" onclick="addStoreMem()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加员工</a>
		                        <a class="nui-button" plain="true" iconCls="" onclick="delStoreMem()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
		                    </td>
		                </tr>
		            </table>
		        </div>
		        <div class="nui-fit">
		            <div id="memGrid" class="nui-datagrid" style="width:100%;height:100%;"
		                 showPager="false"
		                 dataField="data"
		                 idField="id"
		                 allowCellEdit="true"
		                 allowCellSelect="true"
		                 ondrawcell="onDrawCell"
		                 selectOnLoad="true"
		                 sortMode="client"
		                 multiSelect="true"
		                 url="">
		                <div property="columns">
		                    <div type="indexcolumn">序号</div>
		                    <div type="checkcolumn" field="check" width="20"></div>
		                    <div field="empName" name="empName" headerAlign="center" allowSort="true">员工名称
		                    </div>
		                    <div field="recorder" width="60" headerAlign="center" allowSort="true">建档人</div>
		                    <div field="recordDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">建档时间</div>
		                </div>
		            </div>
		        </div>
	        </div>
        </div>
        
        
    </div>
</div>

</body>
</html>
