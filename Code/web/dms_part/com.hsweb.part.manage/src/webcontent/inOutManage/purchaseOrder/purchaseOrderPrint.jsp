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
}
</style>
<title>采购订单打印</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div style="margin: 0 10px;" class="printny">
        <div class="nui-fit">
        	<div>
        		<table id="" width="100%">
				  <tr style="font-size:25px;">
				    <td id="currOrgName"></td>
				    <td id="">采购订单</td>
				  </tr>
				  <tr>
				    <td id="address">地址:</td>
				    <td id="serviceId">No:</td>
				  </tr>
				  <tr>
				    <td id="mobile">电话073186205120</td>
				    <td id="createDate">订单日期</td>
				    <td id="nowDate">打印日期</td>
				  </tr>
				  <tr>
				    <td id="guestFullName">供应商</td>
				    <td id="">联系人</td>
				    <td id="">联系方式</td>
				  </tr>
				  <tr>
				    <td id="">地址</td>
				    <td id="">票据类型：收费</td>
				    <td id="">结算方式现结</td>
				  </tr>
				</table>
        	</div> 
            <div>
				<table id="" width="100%" border="1">
					<thead>
						<tr>
							<td id="comPartCode">配件编码</td>
							<td id="comPartName">配件名称</td>
							<td id="comPartBrandId">品牌</td>
							<td id="comApplyCarModel">车型</td>
							<td id="comUnit">单位</td>
							<td id="orderQty">数量</td>
							<td id="orderPrice">单价</td>
							<td id="orderAmt">金额</td>
							<td id="remark">备注</td>
							<td id="storehouse">仓库</td>
							<td id="storeShelf">仓位</td>
							<td id="comOemCode">OEM码</td>
							<td id="comSpec">规格/方向/颜色</td>
						</tr>
					</thead>
					 <tbody id="tbodyId">
					 </tbody>
				</table>
			</div>
            <div>
            	<table id="" width="100%">
				  <tr>
				    <td id="">合计</td>
				    <td id="" >合计409.0</td>
				    <td id="">37337.0</td>
				  </tr>
				  <tr>
				    <td id="currUserName">打印人：系统管理员</td>
				    <td id="">送货人：</td>
				    <td id="">收货人：</td>
				  </tr>
				  <tr>
				    <td id="remark">备注</td>
				  </tr>
				   <tr>
				    <td id="">注(白联仓库   红联财务  黄联供应商)</td>
				  </tr>
				</table>
            </div>
        </div>
       </div>
	<script type="text/javascript">
		var date=new Date();
    	$(document).ready(function(){
    		$('#currOrgName').text(currOrgName);
    		$('#nowDate').text("打印日期:"+format(date,"yyyy/MM/dd/HH:mm:ss"));
    		$('#currUserName').text("打印人:"+currUserName);
    	});
    	
    	function SetData(mainParams,params){
       		$('#guestFullName').text("供应商:"+mainParams.guestFullName);
       		$('#createDate').text("订单日期："+format(mainParams.createDate,"yyyy/MM/dd/HH:mm:ss"));
       		$('#serviceId').text("No:"+mainParams.serviceId);
     
    		nui.ajax({
    			url: params.baseUrl+"com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext",
    			data:{
    				params: params,
    				token : token
    			},
    			async :false,
    			success : function(text){
    				var data=text.pjPchsOrderDetailList;
    				var tBody=$("tbodyId");
    				tBody.empty();
    				var tds='<td align="center">[comPartCode]</td>'+
    						'<td align="center">[comPartName]</td>'+
    						'<td align="center">[comPartBrindId]</td>'+
    						'<td align="center">[comApplyCarModel]</td>'+
    						'<td align="center">[comUnit]</td>'+
    						'<td align="center">[orderQty]</td>'+
    						'<td align="center">[orderPrice]</td>'+
    						'<td align="center">[orderAmt]</td>'+
    						'<td align="center">[remark]</td>'+
    						'<td align="center">[storehouse]</td>'+
    						'<td align="center">[storeShelf]</td>'+
    						'<td align="center">[comOemCode]</td>'+
    						'<td align="center">[comSepc]</td>';			  			
    					for(var i=0;i<data.length;i++){ 
    						var tr=$("<tr></tr>");
    						tr.append(
    							tds.replace("[comPartCode]",data[i].comPartCode)
    								.replace("[comPartName]",data[i].comPartName)
    								.replace("[comPartBrindId]",data[i].comPartBrindId)
    								.replace("[comApplyCarModel]",data[i].comApplyCarModel)
    								.replace("[comUnit]",data[i].comUnit)
    								.replace("[orderQty]",data[i].orderQty)
    								.replace("[orderPrice]",data[i].orderPrice)
    								.replace("[orderAmt]",data[i].orderAmt)
    								.replace("[remark]",data[i].remark)
    								.replace("[storehouse]",data[i].storehouse)
    								.replace("[storeShelf]",data[i].storeShelf)
    								.replace("[comOemCode]",data[i].comOemCode)
    								.replace("[comSepc]",data[i].comSepc));
    						tBody.append(tr);
    						
    					}
    					
    	
    			},
			  error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
    		});
    	}
    </script>
</body>
</html>