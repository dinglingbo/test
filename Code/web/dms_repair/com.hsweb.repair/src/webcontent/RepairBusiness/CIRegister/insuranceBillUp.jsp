<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-08-15 17:18:09
  - Description:
-->   
<head>
	<title>车险工单结算</title>
	
	</script>
	<style type="text/css">
	.vpanel_heading {
		border-bottom: 1px solid #d9dee9;
		width: 100%;
		height: 28px;
		line-height: 28px;
	}

	.vpanel_heading span {
		margin: 0 0 0 20px;
		font-size: 16px;
		font-weight: normal;
	}
</style>
</head>
<body>
	<div class="nui-toolbar" id="toolbar1" >
	<a class="nui-button" onclick="noPay()" id="noPay"><span class="fa fa-dollar fa-lg"></span>&nbsp;转入预结算</a> 
				<a class="nui-button" onclick="pay()" id="pay"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算收款</a>
	</div>

	<div id="detailGridshow" datafield="list" class="nui-datagrid" style="width: 100%; height:118px;"
	showpager="false" sortmode="client" allowcelledit="true" allowcellselect="true"
	showSummaryRow="true" showModified ="false" ondrawsummarycell="drawSummaryCell">
	<div property="columns">
		<div type="indexcolumn" width="50" headeralign="center" align="center">序号</div>
		<div field="insureTypeId" headeralign="center"  align="center" visible="true" width="100">险种ID</div>
		<div field="insureTypeName" headeralign="center"  align="center" visible="true" width="100">名称</div>
		<div field="amt" name="amt" headeralign="center" align="center" visible="true" width="100" header="保司保费(售价/元)"summaryType="sum"></div>
		<div field="rtnCompRate"name="rtnCompRate" headeralign="center" align="center" visible="true" width="100" header="保司返点(%)"summaryType="sum"></div>
		<div field="rtnGuestRate" name="rtnGuestRate" headeralign="center" align="center" visible="true" width="100" header="客户返点(%)" summaryType="sum"></div>

	</div>
</div>

<div style="padding: 0px;" borderStyle="border:0;">
	<table width="100%" style="line-height: 30px;">
		<tr>
			<td >
				<label >结算应收：</label>
				<label id="showmoney" style="color:green;font-size:18px;">0元</label>
				<label id="showtip"></label>
			</td> 
		</tr> 
		<tr> 
			<td >
				<label>保费收取方式：</label> 
				<input type="radio" name="settleTypeId" id="radio1" value="1" disabled style="margin-left: 0px;">保司直收
				<input type="radio" name="settleTypeId" id="radio2" value="2" disabled>门店代收全款
				<input type="radio" name="settleTypeId" id="radio3" value="3" disabled>代收减返点
			</td>
		</tr> 
		<tr> 
			<td >
				<label >选择结算方式：</label>
				<div class="mini-radiobuttonlist" repeatItems="1" style="display: inline-block;"
				repeatLayout="table" repeatDirection="vertical" id="payType" name="payType"
				textField="text" valueField="value"
				data="[{value:'020101',text:'现金',},{value:'020102',text:'刷卡'},{value:'020104',text:'微信/支付宝'}]"
				value="020101" ></div>
			</td>
  
		</tr>
	</table>
</div>
</body>
<script type="text/javascript">
	nui.parse();
	var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
	var detailGridshow = nui.get("detailGridshow");
	var mainData = null;

	function SetData(params){
		mainData = params;
		detailGridshow.setData(params.gridData);
		$("#showmoney").html(params.moneyCost+"元");
		if(params.sTypeId == 1){
			$("#radio1").attr("checked", "checked"); 
			$("#showtip").html("(保司保费)");
		}
		if(params.sTypeId == 2){
			$("#radio2").attr("checked", "checked"); 
			$("#showtip").html("(保司保费)");
		}
		if(params.sTypeId == 3){
			$("#radio3").attr("checked", "checked"); 
			$("#showtip").html("(保司保费-客户返点)");
		}
	}


	function drawSummaryCell(e){
		var data = e.data;
		var value = e.value;
		var column = e.column;
		var field = e.field;
		var editor = e.editor;
		var rtn_comp_amt_sum = 0;
		var rtn_guest_amt_sum = 0;
		var amt = 0;
		var rtnCompRate = 0;
		var rtnGuestRate = 0;
		for (var i = 0; i < data.length; i++) {
			amt = data[i].amt || 0;
			rtnCompRate = data[i].rtnCompRate || 0;
			rtnGuestRate = data[i].rtnGuestRate || 0;
			rtn_comp_amt_sum +=(amt*rtnCompRate)/100;
			rtn_guest_amt_sum +=(amt*rtnGuestRate)/100;
		}
		if(column.field == "insureTypeName" ){
			e.cellHtml = "合计";
			e.cellStyle = "text-align:center";
		}
		if(column.field == "amt" ){
			e.cellHtml = value;
			e.cellStyle = "text-align:center";
		}

		if(column.field == "rtnCompRate" ){
			e.cellHtml = rtn_comp_amt_sum.toFixed(2);
			e.cellStyle = "text-align:center";
		}

		if(column.field == "rtnGuestRate" ){
			e.cellHtml = rtn_guest_amt_sum.toFixed(2);
			e.cellStyle = "text-align:center";
		}
	}


	function noPay(){
		var url = baseUrl+"com.hsapi.repair.repairService.settlement.PreInsuranceReceiveSettle.biz.ext";
		doPost({
			url : url,
			data : {
				serviceId:mainData.data1.id,
				allowanceAmt:mainData.moneyCost
			},
			success : function(data)
			{
				showMsg(data.errMsg,data.errCode);
				CloseWindow("ok");
			}
		});
	}


	function pay(){
		var json = {
			allowanceAmt:0,
			cardPayAmt:0,
			serviceId:mainData.data1.id,
			payType:nui.get("payType").value,
			payAmt:mainData.moneyCost
		};


		nui.ajax({
			url:"com.hsapi.repair.repairService.settlement.receiveInsuranceSettle.biz.ext",
			type:"post",
			async: false,
			data : json,
			success:function(text){
				nui.unmask(document.body);
				if(text.errCode =="S"){
					showMsg("结算成功！","S");
				}else{
					showMsg(text.errMsg,"E");
				}
				CloseWindow("ok");

			}

		});

	}

	function CloseWindow(action) {
		if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
		else window.close();
	}
</script>
</html>