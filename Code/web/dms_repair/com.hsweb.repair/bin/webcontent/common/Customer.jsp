<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-01 16:06:07
  - Description:
-->

<head>
<title>客户选择</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/CustomerSelect.js?v=1.0.7"></script>
<style type="text/css">
table {
	font-size: 12px;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryForm">
        <table class="nui-form-table">
            <tr>
                <td class="">
                    <label>查询选项：</label>
                    <input class="nui-combobox"  id="key" name="key" value="lcarNo"/>
                    <label>查询值：</label>
                    <input class="nui-textbox" name="value" id = "setValue"  onenter="onenterSearch(this.value)"/>
                    <div class="nui-radiobuttonlist"
                         name="searchArea"
                         style="display: inline-block;position: relative;top:5px;"
                         valueField="id"
                         repeatItems="2"
                         textField="text"
                         repeatLayout="table"
                         data="[{ id: 0, text: '本店资料 '},{ id: 1, text: '所有资料' }]" value="0"
                         >
                    </div>
                    <a class="nui-button" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a class="nui-button" plain="true" id="addBtn" onclick="onAdd()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增客户</a>
                    <a class="nui-button" plain="true" id="editBtn" onclick="onEdit()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改客户</a>
                    <a class="nui-button" plain="true" id="closeBtn" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="nui-fit">
    <div class="nui-datagrid" id="datagrid1"
         style="width:100%;height:100%"
         pageSize="20"
         dataField="list"
         allowSortColumn="true" totalField="page.count" allowcellwrap="true">
        <div property="columns">
            <div type="indexcolumn" width="30">序号</div>
            <div header="客户信息" headerAlign="center">
                <div property="columns">
                    <div field="guestFullName" width="60" headerAlign="center" allowSort="true">
                        客户名称
                    </div>
                    <div field="guestMobile" width="80" headerAlign="center" allowSort="true">
                        客户手机
                    </div>
                </div>
            </div>
            <div header="联系人" headerAlign="center">
                <div property="columns">
                    <div field="contactName" width="50" headerAlign="center" allowSort="true">
                        姓名
                    </div>
                    <div field="identity" width="40" headerAlign="center" allowSort="true">
                        身份
                    </div>
                     <div field="sex" width="0" style="display:none;" headerAlign="center" allowSort="true">
                       性别
                    </div>
                </div>
            </div>
            <div header="车辆信息" headerAlign="center">
                <div property="columns">
                    <div field="carNo" width="65" headerAlign="center" allowSort="true">
                        车牌号
                    </div>
                    <div field="carModel" width="115" headerAlign="center" allowSort="true">
                        品牌车型
                    </div>
                    <div field="chainComeTimes" width="65" headerAlign="center" allowSort="true">
                        来厂次数
                    </div>
                </div>
            </div>
            <div header="辅助信息" headerAlign="center">
                <div property="columns">
                    <div field="vin" width="120" headerAlign="center" allowSort="true">
                        车架号(VIN)
                    </div>
                    <div field="engineNo" width="80" headerAlign="center" allowSort="true">
                        发动机号
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>