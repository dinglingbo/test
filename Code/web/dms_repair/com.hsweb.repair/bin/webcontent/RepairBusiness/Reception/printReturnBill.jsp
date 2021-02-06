<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-12 14:21:40
  - Description:
-->
<head>
<title>打印配件退货单</title>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>    
    <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" /> 
    
</head>
<body onafterprint="CloseWindow('ok')">
<style>
    * {
        margin: 0;
        padding: 0;
    }

    ul, li, dl, dt, dd, ol {
        list-style: none;
    }

    sup {
        vertical-align: text-top;
    }

    sub {
        vertical-align: text-bottom;
    }

    legend {
        color: #000;
    }

    fieldset, img {
        border: 0;
    }

    button, input, select, textarea {
        font-size: 100%;
    }
    /*table { border-collapse: collapse; border-spacing: 0; }*/
    body {
        font-size: 12px;
    }

    div, p, td {
        font-size: 12px;
    }

    .cf:after {
        clear: both;
        content: ".";
        display: block;
        height: 0;
        overflow: hidden;
        visibility: hidden;
    }

    .cf {
        *zoom: 1;
    }

    .dn {
        display: none;
    }

    .fl {
        float: left;
    }

    .fr {
        float: right;
    }

    .mr0 {
        margin-right: 0 !important;
    }

    .mrb {
        margin-right: 10px;
    }

    .mr10 {
        margin-right: 10px;
    }

    .mb10 {
        margin-bottom: 10px;
    }

    .mb20 {
        margin-bottom: 20px;
    }

    .tc {
        text-align: center;
    }

    .tr {
        text-align: right;
    }

    .es {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .fb {
        font-weight: bold !important;
    }

    .pr {
        position: relative;
    }

    .pa {
        position: absolute;
    }

    .red {
        color: #F00;
    }

    .vm {
        vertical-align: middle;
    }

    .f14 {
        font-size: 14px;
    }

    .fwn {
        font-weight: normal !important;
    }

    /* display */
    .dn {
        display: none;
    }

    .di {
        display: inline;
    }

    .db {
        display: block;
    }

    .dib {
        display: inline-block;
    }

    .h14 {
        height: 14px;
    }

    .h16 {
        height: 16px;
    }

    .h18 {
        height: 18px;
    }

    .h20 {
        height: 20px;
    }

    .h22 {
        height: 22px;
    }

    .h24 {
        height: 24px;
    }

    .h40 {
        height: 40px;
    }

    .h60 {
        height: 60px;
    }

    .h80 {
        height: 80px;
    }

    .h100 {
        height: 100px;
    }

    /* zoom */
    .z {
        *zoom: 1;
    }

    #print-container {
        padding: 0 5px;
    }

    #print-container h5 {
        font-size: 14px;
    }

    .company-info {
    }

    .company-info h3 {
        font-size: 16px;
        padding: 10px 0 8px 5px;
        border-bottom: 1px solid #333;
    }

    #title {
        font-size: 24px;
        margin: 15px 0 10px;
        font-weight: 800;
        text-align: center;
    }

    .table {
        width: 100%;
        max-width: 100%;
        border-spacing: 0;
        border-collapse: collapse;
        background-color: transparent;
    }

    .table thead td {
        line-height: 20px;
        font-weight: bold;
    }

    hr {
        margin: 4px 0;
        border: 0;
        border-top: 1px solid #333;
        border-bottom: 1px solid #ffffff;
    }

    td.left, th.left {
        text-align: left;
    }

    td.center, th.center {
        text-align: center;
    }

    td.right, td.right {
        text-align: right;
    }

    .table-header {
        padding-bottom: 3px;
        margin: 10px 0 2px;
    }

    .table-header h3, .table-header h4 {
        text-align: left;
        padding-left: 5px;
        font-size: 14px;
    }

    .tlist td {
        line-height: 18px;
        font-size: 12px;
        padding: 0 0 0 3px;
        border: 1px solid #333;
    }

    .noborder td {
        border: none !important;
    }

    .theader td {
        font-size: 12px;
    }

    .tfooter td {
        padding: 0px;
        font-size: 12px;
    }

    [contenteditable="true"].single-line {
        white-space: nowrap;
        min-width: 200px;
        overflow: hidden;
    }

    [contenteditable="true"].single-line br {
        display: none;
    }

    [contenteditable="true"].single-line * {
        display: inline;
        white-space: nowrap;
    }

    .print-btn {
        display: block;
        position: fixed;
        width: 100px;
        height: 30px;
        line-height: 30px;
        background-color: #d9d9d9;
        color: #333;
        text-align: center;
        top: 15px;
        right: 25px;
    }

    .print-btn:hover {
        background-color: #ccc;
    }

    table, td {
        font-family: Tahoma, Geneva, sans-serif;
        font-size: 12px;
        color: #000;
    }

    .print_btn {
        text-align: center;
        width: 100%;
        padding: 30px 0 0 0;
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

    .print_btn a:hover, .print_btn a:active {
        background: #df0024;
    }

    .sminput {
        width: 640px;
        height: 40px;
        border: 1px #b4b4b4 solid;
        float: left;
        font-size: 16px;
        font-family: "微软雅黑";
    }

    .smbottom {
        width: 50px;
        height: 44px;
        background: #c8c8c8;
        border: 0;
        border-radius: 5px;
        margin-left: 5px;
    }

    .xgsm {
        width: 700px;
        margin: 0 auto;
        display: none;
    }

    .jsxx {
        color: #000;
        padding-bottom: 15px;
    }

    .jsxx h3 {
        color: #000;
        font-size: 15px;
        font-weight: bold;
        height: 22px;
        border-bottom: 1px #333 solid;
    }

    .jsxx ul {
        padding-top: 6px;
    }

    .jsxx ul li {
        color: #000;
    }
</style>
<div class="print_btn">
    <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
    <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
</div>
<div id="print-container">
<!--     <h1 id="title"> -->
<!--     配件退货单 -->
<!-- </h1> -->
<div class="content">
<!--     <hr /> -->
   <table  width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                	<td rowspan="2" style="width: 133px;">
                     	<img alt="" src="" id="showImg" height="60px" style="display:none">
                    </td>
                    <td style="width:55%">
                        <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp"></span></div>
                    </td>
                    <td rowspan="2" style="">
                        <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename"></span></b></div>
                        <div style="padding-top: 2px; font-size: 16px;font-family: Arial;">
                          №:<span id="serviceCode"></span>  
                        </div>
                    </td>
                </tr>
                <tr>
                	<td >
                	<div style="font-size: 8px;padding-left: 10px; "><span id="slogan1"></span></div>
                	<div style="font-size: 8px;padding-left: 10px; "><span id="slogan2"></span></div>
                	</td>
                </tr>
            </tbody>
        </table>
         <hr />
          <table width="100%" border="0"  cellspacing="0" cellpadding="0">
             <tr>
                <td style="font-size:8px;">地址：<span id="guestAddr"></span></td>
<!--                 <td  id="openBank" style="width: 300px;">开户银行：</td> -->
                <td  style="width: 190px;font-size:8px;">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="phone"></span></td>
<!--                 <td  id="bankNo" >银行账号：</td> -->
<!-- 	             	<td style="font-size:8px;" id="enterDate" >进厂时间：</td> -->
            </tr>
        </table>
        <hr />
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader">
        <tbody>
            <tr>
                <td width="25%" height="20" class="left">客户：<span id="guestName"></span></td>
                <td height="20" class="left">联系电话：<span id="guestMobile"></span></td>
                <td width="25%" class="left">退货日期：<span id="recordDate"></span></td>
            </tr>
            <tr>   
                <td colspan="3" class="left">收货地址：<span id="shippingAdd"></td>
            
<!--                 <td class="left">单号：<span id="serviceCode"></td> -->
            </tr>
        </tbody>
    </table>
    <div style="padding: 8px 0 5px 0">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
            <tr>
                <td width="30" height="30" align="center" bgcolor="#f5f5f5">序号</td>
                <td width="50%" align="center" bgcolor="#f5f5f5">配件名称</td>
                <td align="center" bgcolor="#f5f5f5">配件编号</td>
                <td width="40" align="center" bgcolor="#f5f5f5">单位</td>
                <td width="40" align="center" bgcolor="#f5f5f5">数量</td>
                <td width="60" align="center" bgcolor="#f5f5f5">单价</td>
                <td width="60" align="center" bgcolor="#f5f5f5">金额</td>   
            </tr>
            <tbody id="tbodyId">
		   </tbody>
        </table>
    </div>
    <div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader">
            <tbody>
                <tr>
                    <td width="20%" height="20">制单人:<span id="currUserName"></span></td>
<!--                     <td width="20%">打印时间：<span id="date"></span></td> -->
					<td width="20%"class="left" height="25">备注：</td>
                    <td width="33%" align="right"><b style="font-size:16px;">合计</b>： <font style="font-size:16px; font-weight:bold;"><span id = "amt"></span></font> 元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b style="font-size:16px;">大写</b>：<font style="font-size:16px; font-weight:bold;"><span id = "Damt"></span></font></td>
                </tr>
                <tr>

                    
                </tr>
                <tr>
                    <td height="40" colspan="3" class="left">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="55">销售员：</td>
                                <td><div style="width:80%; height:25px; border-bottom:1px #000 solid;"></div></td>
                                <td width="55">仓库员：</td>
                                <td><div style="width:80%; height:25px; border-bottom:1px #000 solid;"></div></td>
                                <td width="70">发(送)货人：</td>
                                <td><div style="width:80%; height:25px; border-bottom:1px #000 solid;"></div></td>
                                <td width="65">客户签收：</td>
                                <td width="15%"><div style="width:100%; height:25px; border-bottom:1px #000 solid;"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
<!--     <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader"> -->
<!--         <tbody> -->
<!--             <tr> -->
<!--                 <td height="20" class="left">公司地址:<span id = "currCompAddress"></span></td> -->
<!--                 <td  class="right">联系电话：<span id = "currCompTel"></td> -->
<!--             </tr> -->
<!--         </tbody> -->
<!--     </table> -->
</div>
</div>
<script type="text/javascript">
     $(document).ready(function (){
		$("#print").click(function () {
            $(".print_btn").hide();
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
function SetData(params){
       var imgUrl = currCompLogoPath || "";
       if(imgUrl && imgUrl != ""){
           $('#showImg').show();
           $("#showImg").attr("src",imgUrl);
        }
       var sumAmt = 0;
       var date = new Date();
       var data = [];
       var recordDate = format(params.recordDate, "yyyy-MM-dd HH:mm");
       document.getElementById("comp").innerHTML = currRepairSettorderPrintShow||currOrgName || "";
       document.getElementById("spstorename").innerHTML = "配件退货单";
       document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	   document.getElementById("guestAddr").innerHTML = currCompAddress;
	   document.getElementById("phone").innerHTML = currCompTel;
       $("#guestName").html(params.guestFullName);
       $("#guestAdd").html(params.addr);
       $("#recordDate").html(recordDate);
       $("#guestMobile").html(params.guestMobile); 
       $("#shippingAdd").html(params.addr); 
       $("#serviceCode").html(params.serviceCode);
       $.post(params.baseUrl+"com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext?serviceId="+params.id+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        	    data =  text.data;
        	    var tBody = $("#tbodyId");
        	     tBody.empty();
            	for(var i = 0 , l = data.length ; i < l ; i++){
            	  sumAmt = parseFloat(sumAmt) + parseFloat(data[i].amt);
		           var tr = $("<tr></tr>");
	               var tds =  '<td align="center">[id]</td>' +
				    		   "<td align='center'>[partName]</td>"+
				    			"<td>[partCode]</td>"+ 
				    			"<td align='center'>[unit]</td>"+
				    			"<td align='center'>[qty]</td>"+
				    			"<td align='center'>[nuitPrice]</td>"+
				    			"<td align='center'>[amt]</td>";
				  tr.append(
		    				tds.replace("[id]",i +1)
		    				    .replace("[partName]",data[i].partName || "")
				    			.replace("[partCode]",data[i].partCode || "")
				    			.replace("[unit]",data[i].unit || "")
				    			.replace("[qty]",data[i].qty || "")
				    			.replace("[nuitPrice]",data[i].unitPrice || "")
				    			.replace("[amt]",data[i].amt || ""));
		         tBody.append(tr);
           }
      }
      $("#amt").html(sumAmt);
      $("#Damt").html(transform(sumAmt+""));  
   });
   $("#date").html(format(date, "yyyy-MM-dd HH:mm"));
   $("#currUserName").html(currUserName);
//    $("#currCompAddress").html(currCompAddress || "");
//    $("#currComptel").html(currComptel);
   
 }
</script>