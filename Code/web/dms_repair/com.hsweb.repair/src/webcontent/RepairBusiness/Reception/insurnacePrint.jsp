<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 23:33:56
  - Description:  
-->    
<head> 
    <title>3</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script> 
</head>
<body onafterprint="CloseWindow('ok')" oncontextmenu = "return true">
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
        position: relative;
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
</style>
<div class="print_btn">
    <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
    <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
</div>
<div id="print-container">
    <div class="company-info">
<!--         <h3><span id="comp"></span></h3> -->
    </div>
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
                          №:<span  id="serviceCode"></span>  
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
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader" style="line-height: 20px;">
            <tbody>
                <tr>
                    <td class="left" width="33.3%" id="carNo">车牌号：</td>
                    <td class="left" width="33.3%" id="guest">客户名称：</td>
                    <td class="left" id="carBrand">车辆/品牌：</td>
                </tr>
                <tr>
                    <td class="left" id="tel">手机号：</td>
                    <td class="left"id="guestComp">客户单位：</td>
                    <td class="left"id="recordDate">单据时间：</td>
                </tr>
                <tr>
                    <td class="left" id="carVin">车架号(VIN)：</td>
                    <td class="left"id="engineNo">发动机号：</td>
                    <td class="left"id="enterKilometers">里程数：</td>
                </tr>
                <tr>
                    <td class="left" id="insurance">保险公司：</td>
                    <td class="left"id="insuranceDate">保险时间：</td>
                    <td class="left"id="saleMans">销售人员：</td>
                </tr>
                <tr>
                    <td class="left" id="settleType">保费收取方式：</td>
                    <td class="left"id="remark">备注：</td>
                </tr>

            </tbody>
        </table>
        
        <h5 style="padding-top: 20px;">保单信息</h5>
        <div style="padding: 10px 0">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                <tbody>
                    <tr>
                        <td width="30" height="35" align="center">序号</td>
                        <td width="200" align="center">名称</td>
                        <td align="center">保司保费(售价)</td>
                        <td align="center">保司返点金额(元)</td>
                        <td align="center">客户返点金额(元)</td>
                    </tr>
                    <tbody id="tbodyId">
                    </tbody>
                    <tbody id="tableTotal">
                    </tbody>
                </tbody>
            </table>

<!--             <table width="100%" border="0" cellpadding="0" cellspacing="0"  style="table-layout: fixed;">

</table> -->
        </div>
<!--         <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader" style="margin-top: 15px;">
    <tbody>
        <tr>
            <td width="50%" height="30" class="left" style="font-size: 14px;">质检员：</td>
            <td class="left" width="50%" style="font-size: 14px;">质检员签字：</td>
        </tr>
    </tbody>
</table> -->

<h4 style="float:right;" id="showTotalTip">应收金额：0元     大写：</h4>
<div style="clear: both"></div>
<h5 >结算信息</h5>
<hr />
<!--         <table class="table theader" style="margin-top: 5px">
    <tbody>
        <tr>
            <td height="40" id="faultPhen">故障描述：</td>
        </tr>
        <tr>
            <td style="width: 25%" id="remark">备注：</td>
        </tr>
    </tbody>
</table> -->

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader" style="line-height: 20px;">
    <tbody>
        <tr>
            <td class="left" width="33.3%" id="">支付方式：</td>
            <td class="left" width="33.3%" id=""></td>
            <td class="fr fb" width="33.3%">实际支付合计：  &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;元</td>
        </tr>
        <tr>
            <td class="left" id="">结算时间：</td>
            <td class="left"id="">复合：</td>
        </tr>
        <tr>
            <td class="left" id="" colspan="2">备注：</td>
        </tr>
        <tr>
            <td class="left" id="">收款方：</td>
            <td class="left"id="">客户签字：</td>
        </tr>
        <tr>
            <td class="left" id="">公司地址：</td>
            <td class="left"id="">联系电话：</td>
        </tr>

    </tbody>
</table>
</div>
</div>


<script type="text/javascript">
    var amt = null;
    var rtnCompAmt = null;
    var rtnGuestAmt = null;
    var costTotal = 0;
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
      var imgUrl = params.currCompLogoPath || "";
      if(imgUrl && imgUrl != ""){
         $('#showImg').show();
         $("#showImg").attr("src",imgUrl);
      }
      var date = new Date();
      document.getElementById("comp").innerHTML = params.currRepairSettorderPrintShow||params.currOrgName || "";
	  document.getElementById("spstorename").innerHTML = "保险单";
	  document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
      document.getElementById("guestAddr").innerHTML = params.currCompAddress;
	  document.getElementById("phone").innerHTML = params.currCompTel;
		$.ajaxSettings.async = false;//设置为同步执行
        $.post(params.baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext?params/id="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        		var maintain = text.list[0];
                var serviceCode = maintain.serviceCode || "";
                var carNo = maintain.carNo || "";
                var carVin = maintain.carVin || "";
                var carModel = maintain.carModel || "";
                var guestName = maintain.guestName || "";
                var mobile = maintain.mobile || "";
                var recordDate = maintain.recordDate || "";
                var engineNo = maintain.engineNo || "";
                var enterKilometers = maintain.enterKilometers || "";
                var insureCompName = maintain.insureCompName || "";
                var beginDate = maintain.beginDate || "";
                var endDate = maintain.endDate || "";
                var saleMans = maintain.saleMans || "";
                var settleTypeId = maintain.settleTypeId;
                var remark = maintain.remark || "";
                amt = maintain.amt || "";
                rtnCompAmt = maintain.rtnCompAmt || "";
                rtnGuestAmt = maintain.rtnGuestAmt || "";
                var settleType = null;
                var insuranceDate = null;
                if(recordDate){
                    recordDate = new Date(recordDate);
                    recordDate = format(recordDate, "yyyy-MM-dd HH:mm");
                }
                if(beginDate){
                    beginDate = new Date(recordDate);
                    beginDate = format(beginDate, "yyyy-MM-dd");
                }
                if(endDate){
                    endDate = new Date(endDate);
                    endDate = format(endDate, "yyyy-MM-dd");
                }
                if(settleTypeId == 1){
                    settleType = "保司直收";
                    costTotal = amt;
                }
                if(settleTypeId == 2){
                    settleType = "门店代收全款";
                    costTotal = amt;
                }
                if(settleTypeId == 3){
                    settleType = "代收减返点";
                    costTotal = amt - rtnGuestAmt;
                }
                insuranceDate = beginDate+"至"+endDate;
                var DX_cost = transform(costTotal+"");
                var showTotalTipText ="应收金额："+ costTotal +"元"+'&nbsp;&nbsp;&nbsp;&nbsp;'+"大写："+ DX_cost;
                document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
                document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + carNo;
                document.getElementById("guest").innerHTML = document.getElementById("guest").innerHTML + guestName;
                document.getElementById("carBrand").innerHTML = document.getElementById("carBrand").innerHTML + "";

                document.getElementById("tel").innerHTML = document.getElementById("tel").innerHTML + mobile;
                document.getElementById("guestComp").innerHTML = document.getElementById("guestComp").innerHTML + "";
                document.getElementById("recordDate").innerHTML = document.getElementById("recordDate").innerHTML + recordDate;

                document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
                document.getElementById("engineNo").innerHTML = document.getElementById("engineNo").innerHTML + engineNo;
                document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;

                document.getElementById("insurance").innerHTML = document.getElementById("insurance").innerHTML + insureCompName;
                document.getElementById("insuranceDate").innerHTML = document.getElementById("insuranceDate").innerHTML + insuranceDate;
                document.getElementById("saleMans").innerHTML = document.getElementById("saleMans").innerHTML + saleMans; 

                document.getElementById("settleType").innerHTML = document.getElementById("settleType").innerHTML + settleType; 
                document.getElementById("remark").innerHTML = document.getElementById("remark").innerHTML + remark; 
                document.getElementById("showTotalTip").innerHTML = showTotalTipText; 

            }
        });
$.post(params.baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceDetailList.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
 if(text.errCode == "S"){
    var tBody = $("#tbodyId");
    var tBodyTotal = $("#tableTotal");
    tBody.empty();
    tBodyTotal.empty();
    var tds = '<td align="center">[id]</td>' +
    "<td align='center'>[insurance]</td>"+
    "<td align='center'>[amt]</td>"+
    "<td align='center'>[rtnCompAmt]</td>"+
    "<td align='center'>[rtnGuestAmt]</td>";
    var data = text.list;
    for(var i = 0 , l = data.length ; i < l ; i++){
        var tr = $("<tr></tr>");
        tr.append(
            tds.replace("[id]",i +1)
            .replace("[insurance]",data[i].insureTypeName)
            .replace("[amt]",data[i].amt)
            .replace("[rtnCompAmt]",data[i].rtnCompAmt || "")
            .replace("[rtnGuestAmt]",data[i].rtnGuestAmt || ""));
        tBody.append(tr);
    }

    var tdsTotal = '<tr><td align="center" width="30"></td>' +
    "<td align='center' style='font-weight:bold' width='200'>合计</td>"+
    "<td align='center' style='font-weight:bold'>"+ amt +"</td>"+
    "<td align='center' style='font-weight:bold'>"+ rtnCompAmt +"</td>"+
    "<td align='center' style='font-weight:bold'>"+ rtnGuestAmt +"</td></tr>";
    tBodyTotal.append(tdsTotal);
}
});
}
</script>
</body>
</html>