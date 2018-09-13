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
	                        nullItemText="请选择..."
	                        valuechanged="change"/>
						</td>
						<td>
							税率
							<input type="text" style="width:70%" name="rate" id="rate" oninput="checkValue()">
							%
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
			<span>
				<h2>单据信息</h2>
			</span>
			<div id="grid" class="nui-datagrid " datafield="ticketDetail"  editNextOnEnterKey="true" onCellEditEnter="onCellEditEnter"oncellbeginedit="oncellbeginedit" allowCellEdit="true"allowHeaderWrap="true"allowCellSelect="true" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:50%;" allowcellselect="true">
				<div property="columns">
					<div field="serviceCode" name="serviceCode" headeralign="center" align="center">单号
						<input class="nui-textbox" property="editor">
					</div>
					<div field="guestName" name="guestName" headeralign="center">客户名称</div>
					<div field="guestId" name="guestId" headeralign="center" visible="false"></div>
					<div field="carNo" name="carNo" headeralign="center" align="center">车牌号</div>
					<div field="invoiceType" name="invoiceType" headeralign="center" align="center">发票类型	</div>
					<div field="rate" name="rate" headeralign="center" align="center">税率</div>
					<div field="invoiceAmt" name="invoiceAmt" headeralign="center" align="center">发票金额
						<input class="nui-textbox" property="editor">
					</div>
					<div field="rateAmt" name="rateAmt" headeralign="center" align="center">税额</div>
					<div field="action" name="action" headeralign="center" align="center">操作</div>
				</div>
			</div>
			<div style="height: 20px;"></div>
			<span>
				<h2>金额合计</h2>
			</span>
			<div>
				<span>开票金额:</span><span id="money">0</span>
			</div>
			<div>
				<span>税额:</span><span id="rateMoney">0</span>
			</div>
			<div align="right">
				<a class="nui-button" iconcls="" id="" name="" onclick="saveData()">开票</a>
			</div>
		</div>
<div id="advancedMorePartWin" class="nui-window"
      style="width:700px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelect()" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onClose()" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="moreGrid" class="nui-datagrid" style="width:100%;height:95%;"
               dataField="data"               
               allowCellSelect="true"
               editNextOnEnterKey="true"
               totalField="page.count" sizeList=[20,50,100,200] pageSize="20"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="serviceCode" name="serviceCode" headeralign="center" align="center">源单号</div>
				<div field="guestFullName" name="guestFullName" headeralign="center">客户名称</div>
				<div field="carNo" name="carNo" headeralign="center" align="center">车牌号</div>
				<div field="contactMobile" name="contactMobile" headeralign="center" align="center">手机号</div>
				<div field="recordDate" name="recordDate" headeralign="center" align="center">源单日期</div>
				<div field="carId" name="carId" headeralign="center" align="center" visible="false"></div>
				<div field="guestId" name="guestId" headeralign="center" align="center" visible="false"></div>
              </div>
          </div>
    </div>
</div>
	</div>
	<script type="text/javascript">
		nui.parse();

	</script>
</body>

</html>