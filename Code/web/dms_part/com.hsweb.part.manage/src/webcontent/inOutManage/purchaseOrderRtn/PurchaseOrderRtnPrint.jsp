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

<title>采购退货打印</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>    
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>    
<%--     <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" />  --%>
    
    <style type="text/css">

/*dom显示高度的设置*/

html, body {
    height: 100%;
}
#query-table {
    height: 100%;
}

/*打印高度的设置*/
@media print {
    html, body {
        height: inherit;
    }
    #query-table {
        height: inherit;
    }
    #queryTable {
        height: inherit !important;
    }
    @page {
      size: auto;  /* auto is the initial value */
      margin: 0mm; /* this affects the margin in the printer settings */
    }
}

#tbody td{
	text-align:center;
}
table{
	 width: 100%;
        max-width: 100%;
        border-spacing: 0;
        border-collapse: collapse;
        background-color: transparent;
}
table, td {
        font-family: Tahoma, Geneva, sans-serif;
        font-size: 12px;
        color: #000;
    }
table#ybk td{
    
	border: 1px solid #000;
	}
#sum{
	padding-left: 80px;
	width:350px;
	text-align:left;
}
#sumOrderQty{
	width:400px;
	text-align:right;
}
#sumOrderAmt{
	padding-left:85px;
}
 #currOrgName{
/* 	padding-left:80px; */
	padding-top:20px;
} 
#type{
	padding-right:165px;
	padding-top:20px;
}
#serviceId{
	padding-right:15px;
}
#nowDate{
	padding-right:150px;
}
#guestAddr{
	padding-right:118px;
}
#border1 tr{
/* 	border-bottom: 1px black solid !important; */
	height :35px;
	

}
#border2 tr{
/* 	border-bottom: 1px black solid !important; */
/* 	border-top: 1px black solid !important; */
	height :35px;

}
#border3 tr{
 	border-bottom: 1px black solid !important; 
	height :35px;

}
#border4{
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
	width:11%;
}
#comOemCode{
	width:11%;
}
#comPartName{
	width:11%;
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
	width:5%;
}
#orderAmt{
	width:7%;
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
#index{
	width:4%;
}
hr {
        margin: 8px 0;
        border: 0;
        border-top: 1px solid #333;
        border-bottom: 1px solid #ffffff;
    }

</style>
</head>
<body>
	<div id="query-table" style="margin: 0 10px;overflow: scroll;" class="printny" >
<!--         <div class="nui-fit" height="100%"> -->
        	<div id="queryTable" >
        		<div align="center" class="print_btn">
			      <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
			      <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
			    </div>
        		<div style="height:20px;"></div>
       		<table id="" width="100%">
				   <tr>
	            	<td rowspan="2" style="width: 133px;">
	                 	<img alt="" src="<%= request.getContextPath() %>/repair/common/log.bmp">
	                </td>
	                <td>
	                    <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;">&nbsp;&nbsp;<span id="currOrgName"></span></div>
	                </td>
	                <td rowspan="2" >
	                    <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename"></span></b></div>
	                    <div style="padding-top: 2px; font-size: 16px;font-family: Arial;">
	                      №:<span id="serviceId"></span>  
	                    </div>
	                </td>
	            </tr>
	             <tr>
                	<td >
                	<div style="font-size: 8px;padding-left: 10px; "><span id="slogan1"></span></div>
                	<div style="font-size: 8px;padding-left: 10px; "><span id="slogan2"></span></div>
                	</td>
                </tr>
	            </table>
	            
	            <hr/>
	            <table width="100%">
				  <tr>
				  	<td id="phone" style="font-size:8px;">电话:</td>
				    <td  id="guestAddr" align="right" style="font-size:8px;">地址:</td>
<!-- 				    <td colspan="2" style="text-align: right" id="serviceId"  class="" >No:</td> -->
				  </tr>
				  <tr id="border1">
				    <td id="createDate" align="left" style="font-size:8px;">订单日期:</td>
				    <td colspan="2" id="nowDate" align="right"  class=""  style="font-size:8px;">打印日期:</td>
				  </tr>
				</table>
				<hr/>
				<table id="ybk" width="100%">
				  <tr>
				    <td width="33.3%" id="guestFullName">供应商:</td>
				    <td width="33.3%"id="">联系人:</td>
				    <td id="">联系方式:</td>
				  </tr>
				  <tr>
				    <td id="">地址</td>
				    <td id="billTypeId">票据类型:</td>
				    <td id="settleTypeId">结算方式:</td>
				  </tr>
				</table>
        	</div> 
        	<hr />
            <div id="queryTable" style="height: auto;">
				<table id="tbody" class="ybk" width="100%"  border="1" style="border: 1px solid #151515; border-collapse:collapse; ">
					<tbody>
                        <tr>
                        	<td id="index">序号</td>
							<td id="comPartCode">配件编码</td>
							<td id="comOemCode">OEM码</td>
							<td id="comPartName">配件名称</td>
							<td id="comPartBrandId">品牌</td>
							<td id="comApplyCarModel">品牌车型</td>
							<td id="comSpec">规格</td>
							<td id="comUnit">单位</td>
							<td id="orderQty">数量</td>
							<td id="orderPrice">单价</td>
							<td id="orderAmt">金额</td>
							<td id="remark">备注</td>
							<td id="storehouse">仓库</td>
							<td id="storeShelf">仓位</td>
						</tr>
                        <tbody id="tbodyId" >
						</tbody>
					
                    </tbody>
				</table>
			</div>
			 
            <div >
            	<table id="" class="" width="100%">
				  <tr>
				    <td id="sum">合计</td>
				    <td id="sumOrderQty" >合计</td>
				    <td id="sumOrderAmt"></td>
				  </tr>
				  <tr><td  colspan="3"><hr/></td></tr>
				  <tr id="border2">
				    <td id="currUserName">打印人：系统管理员</td>
				    <td id="">送货人：</td>
				    <td id="">收货人：</td>
				  </tr>
				  <tr><td  colspan="3"><hr/></td></tr>
				  <tr colspan="3" id="border3">
				    <td id="remark1">备注</td>
				    <td></td>
				    <td></td>
				  </tr>
				  <tr><td  colspan="3"><hr/></td></tr>
				   <tr colspan="3" id="border4">
				    <td id="">注(白联仓库   红联财务  黄联供应商)</td>
				    <td></td>
				    <td></td>
				  </tr>
				</table>
            </div>
<!--         </div> -->
       </div>
	<script type="text/javascript">
		var date=new Date();
		var sumOrderQty=0;
		var sumOrderAmt=0;
    	$(document).ready(function(){
    		$('#currOrgName').text(currRepairSettorderPrintShow);
    		$('#nowDate').text("打印日期:"+format(date,"yyyy-MM-dd HH:mm"));
    		$('#currUserName').text("打印人:"+currUserName);
			$("#print").click(function () {
	            $(".print_btn").hide();
	            document.getElementById("query-table").style.overflow="hidden"
	            window.print();
	        }); 
	        document.onkeyup = function(event) {
		        var e = event || window.event;
		        var keyCode = e.keyCode || e.which;// 38向上 40向下
		        
		
		        if ((keyCode == 27)) { // ESC
		            CloseWindow('cancle');
		        }
		
		    }
    	});
    	
    	 function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    	function SetData(mainParams,detailParms,formParms){
    		document.getElementById("spstorename").innerHTML = "采购退货单";
    		document.getElementById("guestAddr").innerHTML = "地址："+currCompAddress;
	   		document.getElementById("phone").innerHTML ="电话："+currCompTel;
       		$('#guestFullName').text("供应商:"+formParms.guestFullName);
       		$('#createDate').text("退货日期："+format(formParms.createDate,"yyyy-MM-dd HH:mm"));
       		$('#serviceId').text(formParms.serviceId);
     
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
					var tr=$("<tr  ></tr>");
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