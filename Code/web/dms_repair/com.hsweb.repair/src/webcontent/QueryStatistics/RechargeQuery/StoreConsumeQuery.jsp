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
<title>客户储值卡消费记录</title>
<script src="<%=request.getContextPath()%>/repair/js/RechargeQuery/StoreConsumeQuery.js?v=1.0.6"></script>
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
                    <td class="form_label">消费日期 从:</td>
                <td>
                    <input name="startDate" width="100%" allowInput="false"showClearButton="false"class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss"showTime="false"
                           allowInput="false"showOkButton="false" width="100%" showClearButton="false"/>
                </td>
                <td>
                 	<input class="nui-combobox" data="dataList" width="100px"textFeild="text" id="data"/>
                </td>
                <td>
                	<input class="nui-textbox" emptyText="输入查询条件" />
                </td>
                <td><a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a></td>
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
                    <div field="tel" headerAlign="center" allowSort="true" visible="true" width="">客户电话</div>
                    <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="">车牌号</div>
                </div>
            </div>
            <div header="消费信息" headerAlign="center">
                <div property="columns">
                	<div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">消费日期</div>
                    <div field="type" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">消费类型</div>
                    <div field="isClearGiveAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">是否消除赠送记录</div>
                    <div field="consumeAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">本次消费金额</div>
                    <div field="serviceId" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">工单号</div>
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
	<script type="text/javascript">
		var dataList=[{id:"0",text:"客户名称"},{id:"1",text:"卡号"},{id:"2",text:"车牌号"},{id:"3",text:"手机号"}];
		nui.prise;
	</script>

</body>
</html>