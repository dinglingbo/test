<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>	
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 18:46:38
  - Description:
-->

<head>
	<title>开票单</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/cw/js/invoiceManagement/invoice.js?v=1" type="text/javascript"></script>
</head>
<style type="text/css">
	body {
		margin: 0;
		padding: 0;
		border: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}

	#left {
		display: inline-block;
		float: left;
	}

	#right {
		display: inline-block;
		float: right;
	}
</style>

<body>
	<div class="nui-fit">
		<div style="width: 100%; height: 40%;" id="form">
			<input class="nui-hidden"id="state" value='<b:write property="state"/>'  name="state"/>  
			<input class="nui-hidden"id="mainId" name="mainId"/>  
			<div>
				<h2>
					<span id="left">开票单</span>
				</h2>
				<span id="right"></span>
			</div>
			<br>
			<div>
				<span>
					<h2>发票信息</h2>
				</span>
			</div>
			<form id="form">
				<table>
					<tr>
						<td>
							发票类型
							<input name="invoiceType"
	                        id="invoiceType"
	                        class="nui-combobox width1"
	                        textField="name"
	                        valueField="id"
	                        emptyText="请选择..."
	                        url=""
	                        allowInput="true"
	                        showNullItem="false"
	                        valueFromSelect="true"
	                        nullItemText="请选择..."/>
						</td>
						<td>
							税率
							<input type="text" style="width:80%" name="rate" id="rate" oninput="checkValue()">
						</td>
					</tr>
					<tr>
						<td>
							发票号
							<input class="nui-textbox" style="width:80%"name="invoiceNo">
						</td>
						<td>
							发票抬头
							<input class="nui-textbox" style="width:70%"name="invoiceName">
						</td>
					</tr>
					<tr>
						<td>
							开票备注：
							<input class="nui-textarea" style="width:70%" name="remark">
						</td>
					</tr>
				</table>
			</form>

		</div>
		<div class="nui-fit">
			<div class="mini-autocomplete" style="width:200px;"  popupWidth="650" 
                     url="" value="" placeholder="来源单号" dataField="list" loadingText="数据加载中...">     
                    <div property="columns">
                        <div field="serviceCode" name="serviceCode" headeralign="center" align="center">单号</div>
						<div field="guestId" name="guestId" headeralign="center">客户名称</div>
						<div field="carNo" name="carNo" headeralign="center" align="center">车牌号</div>
						<div field="invoiceType" name="invoiceType" headeralign="center" align="center">发票类型</div>
						<div field="rate" name="rate" headeralign="center" align="center">税率</div>
						<div field="invoiceAmt" name="invoiceAmt" headeralign="center" align="center">发票金额</div>
						<div field="rateAmt" name="rateAmt" headeralign="center" align="center">税额</div>
                    </div>
                </div>
                
			<span>
				<h2>单据信息</h2>
			</span>
			<div id="grid" class="nui-datagrid " datafield="ticketDetail"  allowHeaderWrap="true"allowCellSelect="true" allowcelledit="true" url="com.hsapi.frm.invoiceManagement.searchTicketDetail.biz.ext" allowcellwrap="true" style="width:100%;height:50%;" allowcellselect="true">
				<div property="columns">
					<div field="serviceCode" name="serviceCode" headeralign="center" align="center">单号
						<input class="nui-textbox" property="editor">
					</div>
					<div field="guestId" name="guestId" headeralign="center">客户名称
						<input class="nui-textbox" property="editor">
					</div>
					<div field="carNo" name="carNo" headeralign="center" align="center">车牌号
						<input class="nui-textbox" property="editor">
					</div>
					<div field="invoiceType" name="invoiceType" headeralign="center" align="center">发票类型
						<input class="nui-textbox" property="editor">
					</div>
					<div field="rate" name="rate" headeralign="center" align="center">税率
						<input class="nui-textbox" property="editor">
					</div>
					<div field="invoiceAmt" name="invoiceAmt" headeralign="center" align="center">发票金额
						<input class="nui-textbox" property="editor">
					</div>
					<div field="rateAmt" name="rateAmt" headeralign="center" align="center">税额
						<input class="nui-textbox" property="editor">
					</div>
					<div field="action" name="action" headeralign="center" align="center">操作</div>
				</div>
			</div>
			<div style="height: 20px;"></div>
			<span>
				<h2>金额合计</h2>
			</span>
			<div>
				<span>开票金额</span>
			</div>
			<div>
				<span>税额</span>
			</div>
			<div align="right">
				<a class="nui-button" iconcls="" id="" name="" onclick="saveData()">开票</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();

	</script>
</body>

</html>