<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 12:06:08
  - Description:
-->
<head>
<title>维修客户选择</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairCustomer.js?v=1.0.0"></script>
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
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInform">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">查询选项：</label>
                </td>
                <td>
                    <input class="nui-combobox" emptyText="请选择..." value="serviceCode"
                           data="[{id:'serviceCode',text:'工单号'},{id:'carNo',text:'车牌号'},{id:'guestName',text:'客户名称'},{id:'carModel',text:'品牌车型'},{id:'underpanNo',text:'底盘号'},{id:'mobile',text:'手机号'}]"
                           id="queryField"/>
                </td>
                <td>
                    <label>查询值：</label>
                </td>
                <td>
                    <input class="nui-textbox" id="queryValue"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
                    <a class="nui-button" iconCls="icon-ok" onclick="onOk()" plain="true">选择</a>
                    <a class="nui-button" iconCls="icon-no" onclick="onCancel()" plain="true">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="leftGrid"
         dataField="list"
         class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="50"
         selectOnLoad="true"
         totalField="page.count"
         sortMode="client"
         allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="5">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
            <div header="基本信息" headerAlign="center">
                <div property="columns">
                    <div field="orgid" headerAlign="center" allowSort="true" visible="true" header="公司名称"></div>
                    <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" header="工单号"></div>
                    <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" header="维修顾问"></div>
                    <div field="carNo" headerAlign="center" allowSort="true" visible="true" header="车牌号"></div>
                    <div field="serviceCard" headerAlign="center" allowSort="true" visible="true" header="接车卡号"></div>
                </div>
            </div>
            <div header="辅助信息" headerAlign="center">
                <div property="columns">
                    <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" header="品牌"></div>
                    <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="品牌车型"></div>
                    <div field="checker" headerAlign="center" allowSort="true" visible="true" header="质检员"></div>
                    <div field="contactorName" headerAlign="center" allowSort="true" visible="true" header="客户名称"></div>
                    <div field="serviceTypeId" headerAlign="center" allowSort="true" visible="true" header="业务类型"></div>
                    <div field="mtType" headerAlign="center" allowSort="true" visible="true" header="维修类型"></div>
                    <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" header="投保公司"></div>
                    <div field="sureMtDate" headerAlign="center" allowSort="true" visible="true" header="维修日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="outDate" headerAlign="center" allowSort="true" visible="true" header="离厂日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" header="备注"></div>
                </div>
            </div>
            <div header="维修项目" headerAlign="center">
                <div property="columns">
                    <div field="itemAmt" headerAlign="center" allowSort="true" visible="true" header="项目金额" datatype="float" align="right"></div>
                    <div field="itemPrefRate" headerAlign="center" allowSort="true" visible="true" header="优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                    <div field="itemPrefAmt" headerAlign="center" allowSort="true" visible="true" header="优惠金额" datatype="float" align="right"></div>
                    <div field="itemSutotal" headerAlign="center" allowSort="true" visible="true" header="项目小计" datatype="float" align="right"></div>
                </div>
            </div>
            <div header="材料信息" headerAlign="center">
                <div property="columns">
                    <div field="partAmt" headerAlign="center" allowSort="true" visible="true" header="材料金额" datatype="float" align="right"></div>
                    <div field="partPrefRate" headerAlign="center" allowSort="true" visible="true" header="优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                    <div field="partPrefAmt" headerAlign="center" allowSort="true" visible="true" header="优惠金额" datatype="float" align="right"></div>
                    <div field="partSubtotal" headerAlign="center" allowSort="true" visible="true" header="材料小计" datatype="float" align="right"></div>
                </div>
            </div>
            <div header="金额信息" headerAlign="center">
                <div property="columns">
                    <div field="mtAmt" headerAlign="center" allowSort="true" visible="true" header="维修金额" datatype="float" align="right"></div>
                    <div field="partManageExp" headerAlign="center" allowSort="true" visible="true" header="材料管理费" datatype="float" align="right"></div>
                    <div field="materialExp" headerAlign="center" allowSort="true" visible="true" header="辅料费" datatype="float" align="right"></div>
                    <div field="allowanceAmt" headerAlign="center" allowSort="true" visible="true" header="折让金额" datatype="float" align="right"></div>
                    <div field="otherExp" headerAlign="center" allowSort="true" visible="true" header="其他费用" datatype="float" align="right"></div>
                    <div field="totalPrefRate" headerAlign="center" allowSort="true" visible="true" header="整单优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                    <div field="totalPrefAmt" headerAlign="center" allowSort="true" visible="true" header="总优惠金额" datatype="float" align="right"></div>
                    <div field="balaAmt" headerAlign="center" allowSort="true" visible="true" header="结算金额" datatype="float" align="right"></div>
                    <div field="billAmt" headerAlign="center" allowSort="true" visible="true" header="发票金额" datatype="float" align="right"></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>