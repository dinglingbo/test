<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-09-17 11:03:30
  - Description:
-->
<head>
<style type="text/css">
table{
	margin-top:10px;
	font-size:16px;
	word-wrap: break-word; word-break: break-all;
}

#tbody td{
	text-align:center;
}
#sum{
	padding-left: 80px;
	width:350px;
	text-align:left;
}
#sumOrderQty{
	width:290px;
	text-align:right;
}
#sumOrderAmt{
	padding-left:45px;
}
#currOrgName{
	padding-left:80px;
}
#type{
	padding-right:165px;
}
#serviceId{
	padding-right:110px;
}
#border1 td{
	border-bottom: 1px black solid !important;
	height :35px;

}
#border2 td{
	border-bottom: 1px black solid !important;
	border-top: 1px black solid !important;
	height :35px;

}
#border3 td{
	border-bottom: 1px black solid !important;
	height :35px;

}
#border4 td{
	border-bottom: 1px black solid !important;
	height :35px;

}
.mini-button{
	text-align: center;
    padding-top: 8px;
    font-size: 18px;
    color: yellow;
}
#getMan{
	text-align:left;
}
.print_btn {
    text-align: center;
    width: 100%;
    padding: 30px 0 20px 0;
}

.print_btn a {
    width: 160px;
    height: 42px;
    display: inline-block;
    background: #578ccd;
    line-height: 42px;
    border-radius: 5px;
    color: #fff;
    font-size: 18px;
    text-decoration: none;
    margin: 0 10px;
}

.print_btn a:active, .print_btn a:hover {
    background: #df0024;
}
#comPartCode{
	width:13%;
}
#comOemCode{
	width:12%;
}
#comPartName{
	width:13%;
}
#comPartBrandId{
	width:6%;
}
#comApplyCarModel{
	width:10%;
}
#comSpec{
	width:8%;
}
#comUnit{
	width:4%;
}
#orderQty{
	width:4%;
}
#orderPrice{
	width:4%;
}
#orderAmt{
	width:4%;
}
#remark{
	width:4%;
}
#storehouse{
	width:10%;
}
#storeShelf{
	width:4%;
}
</style>
<title>采购退货打印</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>    
    
</head>
<body>
	<div style="margin: 0 10px;" class="printny">
        <div class="nui-fit" height="100%">
        	<div>
        		<div align="center" class="print_btn">
			      <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
			    </div>
        		<table id="" width="100%">
				  <tr style="font-size:25px;">
				    <td id="currOrgName"></td>
				    <td id="type" colspan="2" style="text-align: right;" id="">采购退货</td>
				  </tr>
				  <tr>
				    <td id="address">地址:</td>
				    <td colspan="2" style="text-align: right" id="serviceId">No:</td>
				  </tr>
				  <tr id="border1">
				    <td id="mobile">电话:</td>
				    <td id="createDate">订单日期:</td>
				    <td id="nowDate">打印日期:</td>
				  </tr>
				  <tr>
				    <td id="guestFullName">供应商:</td>
				    <td id="">联系人:</td>
				    <td id="">联系方式:</td>
				  </tr>
				  <tr>
				    <td id="">地址</td>
				    <td id="rtnReasonId">退货原因:</td>
				    <td id="settleTypeId">结算方式:</td>
				  </tr>
				</table>
        	</div> 
            <div>
				<table id="tbody" width="100%"  border="1" style="border: 1px solid #151515; border-collapse:collapse;">
					<tbody>
                        <tr>
                        	<td id="index">序号</td>
							<td id="comPartCode">配件编码</td>
							<td id="comOemCode">OEM码</td>
							<td id="comPartName">配件名称</td>
							<td id="comPartBrandId">品牌</td>
							<td id="comApplyCarModel">车型</td>
							<td id="comSpec">规格</td>
							<td id="comUnit">单位</td>
							<td id="orderQty">数量</td>
							<td id="orderPrice">单价</td>
							<td id="orderAmt">金额</td>
							<td id="remark">备注</td>
							<td id="storehouse">仓库</td>
							<td id="storeShelf">仓位</td>
						</tr>
                        <tbody id="tbodyId">
						</tbody>
                    </tbody>
				</table>
			</div>
            <div>
            	<table id="" width="100%">
				  <tr>
				    <td id="sum">合计</td>
				    <td id="sumOrderQty" >合计</td>
				    <td id="sumOrderAmt"></td>
				  </tr>
				  <tr id="border2">
				    <td id="currUserName">打印人：系统管理员</td>
				    <td id="">送货人：</td>
				    <td id="">收货人：</td>
				  </tr>
				  <tr colspan="3" id="border3">
				    <td id="remark1">备注</td>
				    <td></td>
				    <td></td>
				  </tr>
				   <tr colspan="3" id="border4">
				    <td id="">注(白联仓库   红联财务  黄联供应商)</td>
				    <td></td>
				    <td></td>
				  </tr>
				</table>
            </div>
        </div>
       </div>
	<script type="text/javascript">
		var date=new Date();
		var sumOrderQty=0;
		var sumOrderAmt=0;
    	$(document).ready(function(){
    		$('#currOrgName').text(currOrgName);
    		$('#nowDate').text("打印日期:"+format(date,"yyyy/MM/dd/HH:mm:ss"));
    		$('#currUserName').text("打印人:"+currUserName);
			$("#print").click(function () {
	            $(".print_btn").hide();
	            window.print();
	        }); 
    	});
    	
    	function SetData(mainParams,detailParms,formParms){
       		$('#guestFullName').text("供应商:"+mainParams.guestFullName);
       		$('#createDate').text("退货日期："+format(formParms.createDate,"yyyy/MM/dd/HH:mm:ss"));
       		$('#serviceId').text("No:"+formParms.serviceId);
     
    		$('#rtnReasonId').text("退货原因:"+formParms.rtnReasonId);
    		$('#settleTypeId').text("结算方式:"+formParms.settleTypeId);
			var data= detailParms;
			var tBody = $("#tbodyId");
			tBody.empty();
			var tds='<td align="center">[index]</td>'+
					'<td align="center">[comPartCode]</td>'+
					'<td align="center">[comOemCode]</td>'+
					'<td align="center">[comPartName]</td>'+
					'<td align="center">[comPartBrindId]</td>'+
					'<td align="center">[comApplyCarModel]</td>'+
					'<td align="center">[comSpec]</td>'+		  			
					'<td align="center">[comUnit]</td>'+
					'<td align="center">[orderQty]</td>'+
					'<td align="center">[orderPrice]</td>'+
					'<td align="center">[orderAmt]</td>'+
					'<td align="center">[remark]</td>'+
					'<td align="center">[storehouse]</td>'+
					'<td align="center">[storeShelf]</td>';
				for(var i = 0; i < data.length; i++ ){ 
					var tr=$("<tr></tr>");
					tr.append(
						tds.replace("[index]",i+1 ||"")
							.replace("[comPartCode]",data[i].comPartCode ||"")
							.replace("[comOemCode]",data[i].comOemCode ||"")
							.replace("[comPartName]",data[i].comPartName ||"")
							.replace("[comPartBrindId]",data[i].comPartBrindId ||"")
							.replace("[comApplyCarModel]",data[i].comApplyCarModel ||"")
							.replace("[comSpec]",data[i].comSpec ||"")
							.replace("[comUnit]",data[i].comUnit ||"")
							.replace("[orderQty]",data[i].orderQty ||"")
							.replace("[orderPrice]",data[i].orderPrice ||"")
							.replace("[orderAmt]",data[i].orderAmt ||"")
							.replace("[remark]",data[i].remark ||"")
							.replace("[storehouse]",data[i].storehouse ||"")
							.replace("[storeShelf]",data[i].storeShelf ||""));
					tBody.append(tr);
					sumOrderQty +=parseFloat(data[i].orderQty);
					sumOrderAmt +=parseFloat(data[i].orderAmt);
				}
				var sum=transform(parseFloat(sumOrderAmt).toFixed(1)+"");
				$('#sumOrderQty').text("合计:"+parseFloat(sumOrderQty).toFixed(1));
				$('#sumOrderAmt').text(""+parseFloat(sumOrderAmt).toFixed(1));
				$('#sum').text("合计:"+sum);
    	}
    </script>
</body>
</html>