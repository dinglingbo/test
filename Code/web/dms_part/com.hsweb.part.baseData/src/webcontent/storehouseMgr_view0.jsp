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
<script src="<%= request.getContextPath() %>/baseData/js/storehouseMgr/storehouseMgr.js?v=1.0.6"></script>
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
                        <label style="font-family:Verdana;">仓库定义</label>
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
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="white-space:nowrap;">
                        <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPosition()">新增仓位</a>
                        <a class="nui-button" plain="true" iconCls="icon-save" onclick="savePosition()">保存</a>
                        <a class="nui-button" plain="true" iconCls="icon-no" onclick="disableLocation()">禁用</a>
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
                 url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="name" name="name" headerAlign="center" allowSort="true">仓位
                        <input property="editor" class="nui-textbox" style="width:100%;"/>
                    </div>
                    <div field="isDisabled" width="80" headerAlign="center" allowSort="true">是否禁用</div>
                    <div field="recorder" width="60" headerAlign="center" allowSort="true">建档人</div>
                    <div field="recordDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss">建档时间</div>
                    <div field="modifier" width="60" allowSort="true" headerAlign="center">修改人</div>
                    <div field="modifyDate" width="100" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss">修改时间</div>
                </div>
            </div>
        </div>
    </div>
</div>

<ul id="treeMenu" class="nui-contextmenu" onbeforeopen="onBeforeOpen">
    <li name="add" iconCls="icon-add" onclick="onAddNode">新增同级</li>
    <li name="addChild" iconCls="icon-add" onclick="onAddChildNode">新增子级</li>
    <li name="edit" iconCls="icon-edit" onclick="onEditNode">修改</li>
</ul>

</body>
</html>
