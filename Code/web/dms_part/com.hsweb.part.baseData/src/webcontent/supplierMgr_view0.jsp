<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:10:32
  - Description:
-->
<head>
<title>供应商管理</title>
<script src="<%= request.getContextPath() %>/baseData/js/supplierMgr/supplierMgr.js?v1.0.2"></script>
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
                <label style="font-family:Verdana;">供应商全称：</label>
                <input class="nui-textbox" width="100" id="fullName"/>
                <label style="font-family:Verdana;">供应商类型：</label>
                <input id="supplierType"
                       name="supplierType"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       width="100"
                       allowInput="true"
                       showNullItem="true"
                       nullItemText="请选择..."/>
                <label style="font-family:Verdana;">优势品牌/产品：</label>
                <input class="nui-textbox" width="100" id="advantageCarbrandId"/>
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
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addSuplier">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editSuplier">修改</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
         url=""  idField="id" multiSelect="true"
         dataField="suppliers"
         pageSize="20"
         totalField="page.count"
         onrowdblclick="onRowDblClick"
         ondrawcell="onDrawCell"
         frozenStartColumn="0"
         frozenEndColumn="7">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <!--<div type="checkcolumn" ></div>-->
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <div field="compCode" width="100" headerAlign="center" header="店名"></div>
                    <div field="shortName" width="80" headerAlign="center" header="供应商简称"></div>
                    <div field="fullName" width="100" headerAlign="center" header="供应商全称"></div>
                    <div field="tel" width="100" headerAlign="center" header="电话"></div>
                    <div field="mobile" width="90" headerAlign="center" header="手机号码"></div>
                    <div field="supplierType" width="100" headerAlign="center" header="供应商类型"></div>
                    <div field="advantageCarbrandId" width="100" headerAlign="center" header="优势品牌/产品"></div>
                </div>
            </div>
            <div header="联系人信息" headerAlign="center">
                <div property="columns">
                    <div field="manager" width="80" headerAlign="center">联系人</div>
                    <div field="managerDuty" width="80" headerAlign="center">职务</div>
                    <div field="mobile" width="90" headerAlign="center">联系人手机</div>
                    <div field="contactor" width="80" headerAlign="center">业务员</div>
                    <div field="contactorTel" width="100" headerAlign="center">业务员电话</div>
                </div>
            </div>
            <div header="财务信息" headerAlign="center">
                <div property="columns">
                    <div field="tgrade" width="100" headerAlign="center">信誉等级</div>
                    <div field="creditLimit" width="100" headerAlign="center">信誉额度</div>
                    <div field="billTypeId" width="100" headerAlign="center">票据类型</div>
                    <div field="settTypeId" width="100" headerAlign="center">结算方式</div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div field="provinceId" width="80" headerAlign="center">省份 </div>
                    <div field="cityId" width="100" headerAlign="center">城市</div>
                    <div field="fax" width="100" headerAlign="center">传真</div>
                    <div field="remark" width="200" headerAlign="center">备注</div>
                </div>
            </div>
            <div header="操作信息" headerAlign="center">
                <div property="columns">
                    <div field="modifier" width="70" headerAlign="center">最后操作人</div>
                    <div field="modifyDate" width="135" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm:ss">最后操作时间</div>
                    <div field="isDisabled" width="30" headerAlign="center" align="center">禁用</div>
                    <div field="code" width="120" headerAlign="center">供应商编码</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <input class="nui-hidden" name="id"/>
        <table style="width:100%;">
            <tr>
                <td class="table-label">供应商编码:</td>
                <td><input name="code" class="nui-textbox" /></td>
                <td class="table-label">供应商简称:</td>
                <td><input name="shortName" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">供应商全称:</td>
                <td colspan="3">
                    <input name="fullName" class="nui-textbox" style="width:100%;"/>
                </td>
            </tr>
            <tr>
                <td class="table-label">联系人:</td>
                <td><input name="manager" class="nui-textbox" /></td>
                <td class="table-label">联系人电话：</td>
                <td><input name="mobile" class="nui-textbox" /></td>
            </tr>
            <tr>
                <td class="table-label">省份:</td>
                <td>
                    <input name="provinceId"
                           id="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                </td>
                <td class="table-label">城市:</td>
                <td>
                    <input name="cityId"
                           id="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
                <td class="table-label">是否禁用:</td>
                <td>
                    <input class="nui-checkbox" name="isDisabled"/>
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