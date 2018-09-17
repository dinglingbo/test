<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 23:33:56
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>
</head>
<body oncontextmenu = "return false">
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
        <a id="print" href="javascript:void(0)">打印</a>
    </div>
    <div id="print-container">
        <div class="company-info">
            <h3><span id="comp"></span></h3>
        </div>
        <h1 id="title">派工单</h1>
        <div class="content">
            <h5>单据编号：<span id="serviceCode"></span></h5>
            <hr />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader">
                <tbody>
                    <tr>
                        <td class="left" width="33.3%" id="guestId">客户名称：</td>
                        <td class="left" width="33.3%" id="carNo">车牌号：</td>
                        <td class="left" id="tel">联系电话：</td>
                    </tr>
                    <tr>
                        <td class="left">车型：</td>
                        <td class="left"id="enterKilometers">公里数：</td>
                        <td class="left"id="mtAdvisor">服务顾问：</td>
                    </tr>
                    <tr>
                        <td class="left" id ="carVin">VIN：</td>
                        <td class="left">进厂时间：<span class="left" style="width: 33.33%" id="enterDate"></span></td>
                        <td class="left" id="planFinishDate">预计完工时间：</td>
                    </tr>
                </tbody>
            </table>
            <hr />
            <h5 style="padding-top: 20px;">施工项目</h5>
            <div style="padding: 10px 0">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td width="30" height="35" align="center">序号</td>
                            <td width="200" align="center">工时名称</td>
                            <td align="center" width="150">业务类型</td>
                            <td align="center">施工员</td>
                            <td align="center">备注</td>
                            <td align="center">签字</td>
                        </tr>
                        <tbody id="tbodyId">
						</tbody>
                    </tbody>
                </table>
            </div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table theader" style="margin-top: 15px;">
                <tbody>
                    <tr>
                        <td width="50%" height="30" class="left" style="font-size: 14px;">质检员：</td>
                        <td class="left" width="50%" style="font-size: 14px;">质检员签字：</td>
                    </tr>
                </tbody>
            </table>
            <hr />
            <table class="table theader" style="margin-top: 5px">
                <tbody>
                    <tr>
                        <td height="40" id="faultPhen">故障描述：</td>
                    </tr>
                    <tr>
                        <td style="width: 25%" id="remark">备注：</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>


	<script type="text/javascript">
	$(document).ready(function (){
		$("#print").click(function () {
            $(".print_btn").hide();
            window.print();
        });
	});	
	
	function SetData(params){
		document.getElementById("comp").innerHTML = params.comp;
		$.ajaxSettings.async = false;//设置为同步执行
        $.post(params.baseUrl+"com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext?id="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        		var maintain = text.maintain;
        		var carNo = maintain.carNo;
        		var carVin = maintain.carVin;
        		var enterDate = maintain.enterDate || "";
        		if(enterDate){
        			enterDate = enterDate.replace(/-/g,"/");
        			enterDate = new Date(enterDate);
        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm:ss");
        		}
        		var guestId = maintain.guestId;
        		var enterKilometers = maintain.enterKilometers;
        		var mtAdvisor = maintain.mtAdvisor;
        		var planFinishDate = maintain.planFinishDate || "";
        		if(planFinishDate){
        			planFinishDate = planFinishDate.replace(/-/g,"/");
        			planFinishDate = new Date(planFinishDate);
        			planFinishDate = format(planFinishDate, "yyyy-MM-dd HH:mm:ss");
        		}
        		var faultPhen = maintain.faultPhen;
        		var serviceCode = maintain.serviceCode;
        		var remark = maintain.remark || "";
        		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
        		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + carNo;
        		document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
        		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML + enterDate;
        		document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML + guestId;
        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
        		document.getElementById("planFinishDate").innerHTML = document.getElementById("planFinishDate").innerHTML + planFinishDate;
        		document.getElementById("faultPhen").innerHTML = document.getElementById("faultPhen").innerHTML + faultPhen; 
        		document.getElementById("remark").innerHTML = document.getElementById("remark").innerHTML + remark; 
        	}
        });
        $.ajaxSettings.async = true;//设置为异步执行
        var guestId = document.getElementById("guestId").innerHTML;
        $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext?guestId="+ guestId.replace(/[^0-9]/ig,"")+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        		var guest = text.guest;
        		var fullName = guest.fullName;
           		var tel = guest.tel;
           		document.getElementById("guestId").innerHTML =  guestId.replace(/[0-9]/ig,"") + fullName;
           		document.getElementById("tel").innerHTML = document.getElementById("tel").innerHTML+ tel;
        	}
        });
        $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
            	var tBody = $("#tbodyId");
				tBody.empty();
				var tds = '<td align="center">[id]</td>' +
    			"<td align='center'>[prdtName]</td>"+
    			"<td align='center'>[serviceTypeId]</td>"+ 
    			"<td align='center'>[workers]</td>"+
    			"<td align='center'></td>"+
    			"<td align='center'></td>";
        		var data = text.data;
        		for(var i = 0 , l = data.length ; i < l ; i++){
        			var tr = $("<tr></tr>");
        			tr.append(
				    				tds.replace("[id]",i +1)
				    				.replace("[prdtName]",data[i].prdtName)
				    				.replace("[serviceTypeId]",data[i].serviceTypeId)
				    				.replace("[workers]",data[i].workers || ""));
				    			tBody.append(tr);
        		}
        	}
        });
	}
    </script>
</body>
</html>