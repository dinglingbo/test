<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
<title>收支项目设置</title> 
	<%@include file="/common/sysCommon.jsp" %>
    <script src="<%=frmDomain%>/frm/js/setting/incomeExpenItem.js?v=1.0" type="text/javascript"></script>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;" id="queryForm">
    <table style="width:100%;">
        <tr>
            <td><!-- style="white-space:nowrap;"-->
                <label style="font-family:Verdana;" title="点击清空条件"><span onclick="clearQueryForm()">快速查询：</span></label>
                
                <label style="font-family:Verdana;">项目名称：</label>
                <input class="nui-textbox" name="name" id="name" enabled="true"/>
                
                <label style="font-family:Verdana;">助记码：</label>
                <input class="nui-textbox" name="code" id="code" enabled="true"/>
                <input name="itemTypeId"
                    id="itemTypeId"
                    visible="false"
                    class="nui-combobox width2"
                    textField="name"
                    valueField="customid"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <input name="isPrimaryBusiness"
                    id="isPrimaryBusiness"
                    visible="false"
                    class="nui-combobox width2"
                    textField="text"
                    valueField="value"
                    data="const_yesno"
                    emptyText="请选择..."
                    allowInput="false"
                    valueFromSelect="true"
                    showNullItem="false"
                    nullItemText="请选择..."/>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query" enabled="true">查询</a>
                
                <li class="separator"></li>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="add()" id="add" enabled="true">新增</a>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addSub()" id="addSub" enabled="true">新增子项</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="edit()" id="edit" enabled="true">修改</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="del()" id="del" enabled="true">删除</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
        <div class="nui-fit">
            <div id="dgGrid" class="nui-treegrid" style="width:100%;height:100%;"
                 showPager="true" pageSize="10" sizeList="[10,20,50]" allowAlternating="true"
                 multiSelect="true" totalField="page.count"
                 url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.queryIncomeExpenItem.biz.ext"
                 dataField="data" idField="id" treeColumn="treeName" parentField="parentId">
                <div property="columns" width="20">
                    <div type="checkcolumn" width="10%"></div>
                    <div field="orgid"  visible="false" headerAlign="center" width="20%">所属机构</div>
                    <div field="name" name="treeName" allowSort="true" headerAlign="center" width="20%">项目名称</div>
                    <div field="code" allowSort="true" headerAlign="center" width="20%">助记码</div>
                    <div field="itemTypeId" allowSort="true" headerAlign="center" width="25%">收支类型</div>
                    <div field="isPrimaryBusiness" allowSort="true" headerAlign="center" width="20%">主营业务</div>
                    <div field="parentName" allowSort="true" headerAlign="center" width="20%">上级项目</div>
                    <div field="parentId" allowSort="true" headerAlign="center" width="20%" visible="false">上级ID</div>
                </div>
            </div>
        </div>
    <!--
    </div>
    -->
</div>
</body>
</html>