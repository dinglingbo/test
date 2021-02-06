<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 11:14:08
  - Description:
-->
<head>
<title>出车报告</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/OutCar/outCarReportMain.js?v=1.0.10"></script>
<style type="text/css">

table {
	table-layout: fixed;
	font-size: 12px;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="" id="addBtn" enabled="false" onclick="addReport()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" plain="true" iconCls="" id="editBtn" enabled="false" onclick="editReport()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" plain="true" iconCls="" id="deleteBtn" enabled="false" onclick="deleteReport()"><span class="fa fa-trash-o"></span>&nbsp;删除</a>
                <a class="nui-button" plain="true" iconCls="" id="saveBtn" enabled="false" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" plain="true" iconCls="" id="cancelBtn" enabled="false" onclick="cancelEdit()"> <span class="fa fa-times-circle"></span>&nbsp;取消</a>
                <a class="nui-button" plain="true" iconCls="icon-ok" id="selectBtn" visible="false" onclick="onOk()">选择</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height:100%;"
         showHandleButton="false" allowResize="false">
        <div size="200" showCollapseButton="false">
            <div class="nui-fit">
                <div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
                    <span>出车报告类型</span>
                </div>
                <!-- 树形联动 -->
                <div class="nui-fit">
                    <ul id="tree1" class="nui-tree"
                        style="width: 100%;"
                        showTreeIcon="true" textField="name" idField="customid" parentField="parentId"
                        resultAsTree="false"
                        onrowclick="onOutCarRowClick"
                        selectOnLoad="true">
                    </ul>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-splitter" style="width: 100%; height: 100%;"
                 borderStyle="border:0"
                 showHandleButton="false" allowResize="false">
                <div size="60%" showCollapseButton="false" style="border: 0;">
                    <div class="nui-panel" showToolbar="false" title="出车报告类型" showFooter="false"
                         borderStyle="border-top:0;border-top:bottom;border-left:0"
                         style="width:100%;height:100%;">
                        <div class="nui-fit">
                            <div id="datagrid1" dataField="outs" class="nui-datagrid"
                                 style="width: 100%; height: 100%;"
                                 showPager="false"
                                 onrowclick="onOutCarDataRowClick"
                                 selectOnLoad="true"
                                 allowSortColumn="true">
                                <div property="columns">
                                    <div type="indexcolumn" headerAlign="center" width="30">序号</div>
                                    <div header="出车报告列表" headerAlign="center">
                                        <div property="columns">
                                            <div field="type" headerAlign="center" allowSort="true" visible="true">报告类型
                                            </div>
                                            <div field="content" headerAlign="center" allowSort="true" visible="true" width="60%">报告内容
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false" style="border: 0;">
                    <div class="nui-panel" showToolbar="false"
                         borderStyle="border-top:0;border-right:0"
                         title="报告内容编辑" showFooter="false" style="width:100%;height:100%;">
                        <div class="form" id="basicInfoForm" style="width:100%;height: 100%">
                            <input name="id" class="nui-hidden"/>
                            <table class="nui-form-table" style="width:100%;height: 100%">
                                <tr height="20">
                                    <td class="form_label">
                                        <label>报告类型：</label>
                                    </td>
                                </tr>
                                <tr height="20">
                                    <td>
                                        <input class="nui-combobox"
                                               id="type" name="type"
                                               valueField="customid"
                                               textField="name"
                                               allowInput="false"
                                               allowNullItem="false"
                                               width="100%"/>
                                    </td>
                                </tr>
                                <tr height="20">
                                    <td class="form_label required">
                                        <label>报告内容：</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <textarea class="nui-textarea" name="content" style="width: 100%;height: 100%"></textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>