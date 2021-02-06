<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 17:32:01
  - Description:
-->
<head>
<title>客户索赔</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerClaim/CustomerClaimMain.js?v=1.0.1"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<input class="nui-combobox" id="carBrand" visible="false"/>
<input class="nui-combobox" id="claimsType" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
                    <label style="font-family:Verdana;">开始日期：</label>
                </td>
                <td>
                    <input class="nui-datepicker" format="yyyy-MM-dd" name="startDate"/>
                </td>
                <td>
                    <label style="font-family:Verdana;">结束日期：</label>
                </td>
                <td>
                    <input class="nui-datepicker" format="yyyy-MM-dd" name="endDate"/>
                </td>
                <td>
                    <label style="font-family:Verdana;">车牌号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="carNo"/>
                </td>
                <td>
                    <label style="font-family:Verdana;">结算状态：</label>
                </td>
                <td>
                    <input class="nui-combobox" value="0"
                           data="[{id:0,text:'未结算'},{id:1,text:'已结算'},{id:2,text:'已作废'},{id:-1,text:'所有'}]"
                           name="state"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="border-bottom: 0;">
    <table>
        <tr>
            <td>
                <a class="nui-button" plain="true" iconCls="icon-add" onclick="add()">登记</a>
                <a class="nui-button" plain="true" iconCls="icon-ok" onclick="edit()">处理</a>
                <a class="nui-button" plain="true" iconCls="icon-search" onclick="showDetail()">查看</a>
                <a class="nui-button" plain="true" iconCls="icon-undo" onclick="relist()">返单</a>
                <a class="nui-MenuButton" plain="true" iconCls="icon-print" menu="#printMenu">打印</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="leftGrid" dataField="list" class="nui-datagrid"
         style="width: 100%; height: 100%;"
         pageSize="20"
         totalField="page.count"
         sortMode="client"
         selectOnLoad="true"
         allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="4">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" allowSort="true"
                 visible="true" width="30px">序号
            </div>
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <div field="serviceCode" headerAlign="center" allowSort="true"
                         visible="true" width="100px">索赔单号
                    </div>
                    <div field="claimsType" headerAlign="center" allowSort="true"
                         visible="true" width="60px">索赔类型
                    </div>
                    <div field="recordDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                         allowSort="true" visible="true" width="80px">索赔日期
                    </div>
                    <div field="isSettle" headerAlign="center"
                         allowSort="true" visible="true" width="60px">结算状态
                    </div>
                </div>
            </div>
            <div header="费用信息" headerAlign="center">
                <div property="columns">
                    <div field="itemAmt" headerAlign="center" allowSort="true" align="right" datatype="float"
                         visible="true" width="80px">项目金额
                    </div>
                    <div field="partAmt" headerAlign="center" allowSort="true" align="right" datatype="float"
                         visible="true" width="80px">配件金额
                    </div>
                    <div field="otherAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">其他费用
                    </div>
                    <div field="agioAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">折让金额
                    </div>
                    <div field="balanceAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">结算金额
                    </div>
                    <div field="jdDeductAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">机电提成
                    </div>
                    <div field="bjDeductAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">钣金提成
                    </div>
                    <div field="pqDeductAmt" headerAlign="center" align="right" datatype="float"
                         allowSort="true" visible="true" width="80px">喷漆提成
                    </div>
                </div>
            </div>
            <div header="维修业务" headerAlign="center">
                <div property="columns">
                    <div field="maintainServiceCode" headerAlign="center" allowSort="true"
                         visible="true" width="80px">业务单号
                    </div>
                    <div field="mtAdvisor" headerAlign="center" allowSort="true"
                         visible="true" width="80px">业务顾问
                    </div>
                    <div field="sureMtDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                         allowSort="true" visible="true" width="80px">维修日期
                    </div>
                    <div field="outDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                         allowSort="true" visible="true" width="80px">离厂日期
                    </div>
                </div>
            </div>
            <div header="客户信息" headerAlign="center">
                <div property="columns">
                    <div field="contactorName" headerAlign="center" allowSort="true"
                         visible="true" width="80px">客户名称
                    </div>
                    <div field="carNo" headerAlign="center" allowSort="true"
                         visible="true" width="80px">车牌号
                    </div>
                    <div field="carBrandId" headerAlign="center"
                         allowSort="true" visible="true" width="80px">厂牌
                    </div>
                    <div field="carModel" headerAlign="center"
                         allowSort="true" visible="true" width="80px">品牌车型
                    </div>
                </div>
            </div>
            <div header="仓库审核信息" headerAlign="center">
                <div property="columns">
                    <div field="partAudit" headerAlign="center" allowSort="true" align="right"
                         visible="true" width="80px">审核状态
                    </div>
                    <div field="partAuditdate" headerAlign="center" allowSort="true"dateFormat="yyyy-MM-dd"
                         visible="true" width="80px">审核日期
                    </div>
                    <div field="partAuditor" headerAlign="center"
                         allowSort="true" visible="true" width="80px">审核人
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<ul id="printMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li onclick="print()">打印维修委托单（A）</li>
    <li>打印派工单（C）</li>
    <li>打印结算单（E）</li>
    <li>打印出单结算单（F）</li>
</ul>

</body>
</html>