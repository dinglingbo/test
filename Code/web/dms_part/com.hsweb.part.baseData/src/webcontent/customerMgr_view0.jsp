<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:38:03
  - Description:
-->
<head>
<title>客户管理</title>

<script src="<%= request.getContextPath() %>/baseData/js/customerMgr/customerMgr.js?v=1.0.2"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <label style="font-family:Verdana;">客户编码：</label>
                <input class="nui-textbox" width="100" id="code"/>
                <label style="font-family:Verdana;">客户全称：</label>
                <input class="nui-textbox" width="100" id="fullName"/>
                <label style="font-family:Verdana;">联系人电话：</label>
                <input class="nui-textbox" width="100" id="mobile"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addCustomer">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editCustomer">修改</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="false"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="200" showCollapseButton="false">
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;height: 100%;"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false" style="border-right:0;border-left:0;">
            <div class="nui-fit">
                <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
                     url=""  idField="id" multiSelect="true"
                     pageSize="20"
                     dataField="customers"
                     totalField="page.count"
                     ondrawcell="onDrawCell"
                     selectOnLoad="true"
                     sortMode="client"
                     frozenStartColumn="0"
                     frozenEndColumn="0">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <!--<div type="checkcolumn" ></div>-->
                        <div header="往来基本信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="shortName" width="80" headerAlign="center" header="简称"></div>
                                <div allowSort="true" field="fullName" width="100" headerAlign="center" header="全称"></div>
                                <div allowSort="true" field="advantageCarbrandId" width="100" headerAlign="center" header="优势品牌/产品"></div>
                                <div allowSort="true" field="billTypeId" width="80" headerAlign="center" header="票据类型"></div>
                                <div allowSort="true" field="settTypeId" width="100" headerAlign="center" header="结算方式"></div>
                                <div allowSort="true" field="manager" width="100" headerAlign="center" header="联系人"></div>
                                <div allowSort="true" field="mobile" width="100" headerAlign="center" header="联系电话"></div>
                                <div allowSort="true" field="contactor" width="80" headerAlign="center" header="业务员"></div>
                                <div allowSort="true" field="contactorTel" width="100" headerAlign="center" header="业务员电话"></div>
                                <div allowSort="true" field="code" width="100" headerAlign="center" header="编码"></div>
                                <div allowSort="true" field="isDisabled" width="100" headerAlign="center" header="状态"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:410px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <input class="nui-hidden" name="id"/>
        <table style="width:100%;">
            <tr>
                <td class="table-label">客户编码:</td>
                <td><input name="code" class="nui-textbox" /></td>
                <td class="table-label">客户简称:</td>
                <td><input name="shortName" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">客户全称:</td>
                <td colspan="3">
                    <input name="fullName" class="nui-textbox" style="width:100%;"/>
                </td>
            </tr>
            <tr>
                <td class="table-label">联系人:</td>
                <td><input name="contactor" class="nui-textbox" /></td>
                <td class="table-label">联系人电话：</td>
                <td><input name="contactorTel" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">会员等级:</td>
                <td><input name="memLevel" class="nui-textbox" /></td>
                <td class="table-label">会员卡号:</td>
                <td><input name="memCarNo" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">省份:</td>
                <td>
                    <input id="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                </td>
                <td class="table-label">城市:</td>
                <td>
                    <input id="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="mini-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="mini-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


</body>
</html>
