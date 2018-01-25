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
<script src="baseData/js/storehouseMgr/storehouseMgr.js?v=1.0.0"></script>
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
                showTreeIcon="true" textField="text" idField="id">
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
                        <a class="nui-button" plain="true" iconCls="icon-no" onclick="disablePosition()">禁用</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div field="dept_name" headerAlign="center" allowSort="true">仓位</div>
                    <div field="isDisabled" width="80" headerAlign="center" allowSort="true">是否禁用</div>
                    <div field="createdBy" width="60" headerAlign="center" allowSort="true">建档人</div>
                    <div field="creationDate" width="100" headerAlign="center" allowSort="true">建档时间</div>
                    <div field="lastUpdatedBy" width="60" allowSort="true" headerAlign="center">修改人</div>
                    <div field="lastUpdateDate" width="100" headerAlign="center" allowSort="true">修改时间</div>
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
