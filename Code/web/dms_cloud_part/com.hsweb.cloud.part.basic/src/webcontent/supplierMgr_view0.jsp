<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:10:32
  - Description:
-->
<head>
<title>供应商管理</title>
<script src="<%=webPath + contextPath%>/basic/js/supplierMgr.js?v1.1.18"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="orgId"/>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
    <input class="nui-combobox" visible="false" id="managerDuty"/>
    <input class="nui-combobox" visible="false" id="settType"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                 <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
	             <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch()" />
<!--                 <label style="font-family:Verdana;">供应商全称：</label>
                <input class="nui-textbox" width="100" id="fullName"/> -->
                <label style="font-family:Verdana;">供应商类型：</label>
                <input id="supplierType"
                       name="supplierType"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       width="100"
                       allowInput="false"
                       showNullItem="true"
                       nullItemText="请选择..."/>
<!--                 <label style="font-family:Verdana;">优势品牌/产品：</label>
                <input class="nui-textbox" width="100" id="advantageCarbrandId"/>
                <label style="font-family:Verdana;">联系人电话：</label>
                <input class="nui-textbox" width="100" id="mobile"/> -->
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--                 <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="" plain="true" onclick="addSuplier"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" id="editBtn" iconCls="" plain="true" onclick="editSuplier"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" plain="true" iconCls="" onclick="importSupplier()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
         url=""  idField="id" multiSelect="false"
         dataField="suppliers"
         pageSize="20"
         totalField="page.count"
         onrowdblclick="onRowDblClick"
         onrowclick="onGridRowClick"
         sortMode="client"
         allowCellWrap = true
         frozenStartColumn="0"
         frozenEndColumn="11">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <!--<div type="checkcolumn" ></div>-->
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <!-- <div allowSort="true" field="orgid" width="100" headerAlign="center" header="店名"></div> -->
                    <div type="checkcolumn" >选择</div>
                    <div allowSort="true" field="shortName" width="140" headerAlign="center" header="供应商简称"></div>
                    <div allowSort="true" field="fullName" width="240" headerAlign="center" header="供应商全称"></div>
                    <div allowSort="true" field="isInternal" width="100" headerAlign="center" header="是否内部供应商"></div>
                    <div allowSort="true" field="tel" width="140" headerAlign="center" header="电话"></div>
                    <div allowSort="true" field="supplierType" width="100" headerAlign="center" header="供应商类型"></div>
                    <div allowSort="true" field="advantageCarbrandId" width="100" headerAlign="center" header="优势品牌/产品"></div>
                </div>
            </div>
            <div header="联系人信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="manager" width="80" headerAlign="center">联系人</div>
                    <div allowSort="true" field="managerDuty" width="80" headerAlign="center">职务</div>
                    <div allowSort="true" field="mobile" width="90" headerAlign="center">联系人手机</div>
                    <div allowSort="true" field="contactor" width="80" headerAlign="center">业务员</div>
                    <div allowSort="true" field="contactorTel" width="100" headerAlign="center">业务员手机</div>
                </div>
            </div>
            <div header="财务信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="tgrade" width="100" headerAlign="center">信誉等级</div>
                    <div allowSort="true" field="creditLimit" width="100" headerAlign="center">信誉额度</div>
                    <div allowSort="true" field="billTypeId" width="100" headerAlign="center">票据类型</div>
                    <div allowSort="true" field="settTypeId" width="100" headerAlign="center">结算方式</div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="provinceId" width="80" headerAlign="center">省份 </div>
                    <div allowSort="true" field="cityId" width="100" headerAlign="center">城市</div>
                    <div allowSort="true" field="fax" width="100" headerAlign="center">传真</div>
                    <div allowSort="true" field="remark" width="200" headerAlign="center">备注</div>
                </div>
            </div>
            <div header="操作信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="modifier" width="100" headerAlign="center">最后操作人</div>
                    <div allowSort="true" field="modifyDate" width="135" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm">最后操作时间</div>
                    <div allowSort="true" field="isDisabled" width="30" headerAlign="center" align="center">禁用</div>
                    <div allowSort="true" field="code" width="120" headerAlign="center">供应商编码</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:520px;height:240px;"
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
                    <input name="fullName" class="nui-textbox" style="width:95%;"/>
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
                           allowInput="false"
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
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                </td>
            </tr>
            <tr>
                <td class="table-label" >是否禁用:</td>
                <td>
                    <input class="nui-checkbox" name="isDisabled" trueValue="1" falseValue="0"/>
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
