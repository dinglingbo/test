<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>客户办卡、充值记录</title>
<script src="<%=request.getContextPath()%>/repair/js/RechargeQuery/RechargeQueryMain.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>

<input id="startDate"
       visible="false"
       allowInput="false"
       showClearButton="false"
       class="nui-datepicker"/>
<input id="endDate"
       visible="false"
       allowInput="false"
       showClearButton="false"
       class="nui-datepicker"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="50"
         totalField="page.count" allowSortColumn="true"
         frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" width="30">序号</div>
            <div header="客户信息" headerAlign="center">
                <div property="columns">
                    <div field="fullName" headerAlign="center" allowSort="true" visible="true" width="">客户名称</div>
                    <div field="cardNo" headerAlign="center" allowSort="true" visible="true" width="">会员卡号</div>
                    <div field="mobile" headerAlign="center" allowSort="true" visible="true" width="">客户电话</div>
                    <div field="rechargeDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">充值日期</div>
                </div>
            </div>
            <div header="充值信息" headerAlign="center">
                <div property="columns">
                    <div field="rechargeAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">充值金额</div>
                    <div field="largessAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">赠送金额</div>
                    <div field="integral" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">赠送积分</div>
                </div>
            </div>
            <div header="余额信息" headerAlign="center">
                <div property="columns">
                    <div field="cardBalaAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">储蓄余额</div>
                    <div field="largessBalaAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">赠送余额</div>
                    <div field="integral" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">赠送积分</div>
                </div>
            </div>
            <div header="备注" headerAlign="center">
                <div property="columns">
                    <div field="recorder" headerAlign="center" allowSort="true" visible="true" width="">记录人</div>
                    <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">记录日期</div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" width="">备注</div>
                </div>
            </div>
        </div>
    </div>
</div>

 

</body>
</html>