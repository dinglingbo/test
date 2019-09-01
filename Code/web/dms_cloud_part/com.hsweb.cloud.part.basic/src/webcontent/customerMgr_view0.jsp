<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 23:38:03
  - Description:
-->
<head>
<title>客户管理</title>

<script src="<%=webPath + contextPath%>/basic/js/customerMgr.js?v=1.0.31"></script>
<style type="text/css">
.table-label {
	text-align: right;
	width: 70px;
}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
    <input class="nui-combobox" visible="false" id="managerDuty"/>
    <input class="nui-combobox" visible="false" id="settType"/>
    <input class="nui-combobox" visible="false" id="guestType"/>
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
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="" plain="true" onclick="addCustomer"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" id="editBtn" iconCls="" plain="true" onclick="editCustomer"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" plain="true" iconCls="" onclick="importGuest()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
         url=""  idField="id" multiSelect="true"
         pageSize="20"
         dataField="customers"
         pageSize="20"
         totalField="page.count"
         onrowdblclick="onRowDblClick"
         sortMode="client"
         onrowclick="onGridRowClick"
     	>
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <!--<div type="checkcolumn" ></div>-->
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="code" width="100" headerAlign="center">客户编码</div>
                    <div allowSort="true" field="shortName" width="80" headerAlign="center">客户简称</div>
                    <div allowSort="true" field="fullName" width="100" headerAlign="center">客户全称</div>
                    <!-- <div allowSort="true" field="guestType" width="100" headerAlign="center">对象类型</div> -->
                </div>
            </div>
            <div header="联系人信息" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" field="manager" width="80" headerAlign="center">联系人</div>
                    <div allowSort="true" field="contactor" width="80" headerAlign="center">业务员</div>
                    <div allowSort="true" field="contactorTel" width="100" headerAlign="center">业务员手机</div>
                </div>
            </div>
            <div header="客户联系方式" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="tel" width="100" headerAlign="center">电话</div>
                    <div allowSort="true" field="mobile" width="100" headerAlign="center">联系人手机</div>
                    <div allowSort="true" field="addr" width="100" headerAlign="center">地址</div>
                </div>
            </div>
            <div header="财务信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="tgrade" width="100" headerAlign="center">信用等级</div>
                    <div allowSort="true" field="billTypeId" width="80" headerAlign="center">票据类型</div>
                    <div allowSort="true" field="creditLimit" width="100" headerAlign="center">信誉额度</div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div field="pyName" width="100" headerAlign="center">拼音</div>
                    <div field="provinceId" width="80" headerAlign="center">省份 </div>
                    <div field="cityId" width="100" headerAlign="center">城市</div>
                    <div field="fax" width="100" headerAlign="center">传真</div>

                    <div field="remark" width="200" headerAlign="center">备注</div>
                </div>
            </div>
            <div header="操作信息" headerAlign="center">
                <div property="columns">
                    <div field="modifier" width="70" headerAlign="center">最后操作人</div>
                    <div field="modifyDate" width="135" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm">最后操作时间</div>
                    <div field="isDisabled" width="30" headerAlign="center" align="center">禁用</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:570px;height:250px;"
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
                    <input name="fullName" class="nui-textbox" style="width:89%;"/>
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
                           name="provinceId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="true"
                           onvaluechanged="onProvinceSelected('cityId')"
                           nullItemText="请选择..."/>
                </td>
                <td class="table-label">城市:</td>
                <td>
                    <input id="cityId"
                           name="cityId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
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
