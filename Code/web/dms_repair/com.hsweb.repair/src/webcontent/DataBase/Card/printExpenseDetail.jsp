<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/commonRepair.jsp"%>
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
        <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>  
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>
</head>
<body onafterprint="CloseWindow('ok')" oncontextmenu = "return false">
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
        	height:30px;
        }

            .company-info h3 {
                font-size: 16px;
                padding: 10px 0 8px 5px;
                border-bottom: 1px solid #333;
            }

        #title {
            font-size: 24px;
            margin: 20px 0 5px;
            font-weight: 800;
            text-align: right;
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
            
        table#ybk td{
		border: 1px solid #000;
		}

        hr {
            margin: 8px 0;
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
        @media print {
		    html, body {
		        height: inherit;
		    }
		    @page {
		      size: auto;  /* auto is the initial value */
		      margin: 0mm; /* this affects the margin in the printer settings */
		    }
	    }
    </style>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
    <div id="print-container">
        <div class="company-info">
<!--             <h3><span id="comp"></span></h3> -->
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
<!-- 	                <td style="width: 190px;font-size:8px;">预计交车时间：<span id=planFinishDate></span></td> -->
	<!--                 <td  id="bankNo" >银行账号：</td> -->
<!-- 	             	<td style="font-size:8px;" id="enterDate" >进厂时间：</td> -->
	            </tr>
	        </table>
	        <hr />
<!--             <table width="100%" id="ybk" border="0" cellpadding="0" cellspacing="0" class="table theader">
                <tbody>
                    <tr>
                        
                        <td class="left" id="carNo" width="30%"style="margin-left: 0px;">车牌号：</td>
                        <td class="left" id="carModel" width="45%">品牌车型/品牌：</td>
                        <td class="left"id="mtAdvisor" width="">服务顾问：</td>
                     	
                    </tr>
                    <tr>
                        <td class="left" width="33.3%" id="guestFullName">客户名称：</td>
                        <td class="left" width="33.3%" id="carNo">车牌号：</td>
                        <td class="left" id="contactMobile">联系电话：</td>
                        
                        <td class="left" id ="carVin" width="200px">车架号(VIN)：</td>
                        <td class="left" id ="engineNo">发动机号：</td>
                        <td class="left" id="enterDate">进厂时间：</td>
    
                    </tr>

                   
                </tbody>
            </table> -->
            <hr />
           <!--  <h5 style="padding-top: 20px;">施工项目</h5> -->
            <div style="padding: 10px 0">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td width="30" height="35" align="center">序号</td>
                            <td align="center" width = "200px">项目</td>
                             <td align="center" >类型</td>                           
                            <td align="center" >金额</td>
                            <td align="center">往来单位</td>
                            <td align="center">备注</td>
                        </tr>
                        
                        <tbody id="tbodyId">
						</tbody>
                    </tbody>
                </table>
                <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                     <span style="margin-right: 15px;">
				            <font style="font-size: 13px; font-weight: bold;">				              
				                	&nbsp;&nbsp;&nbsp;总金额：<span id="cash1"></span>元
				             </font>
                       </span>
                        <font style="font-size: 13px; font-weight: bold;">
                                                                                                      大写：<span id="money" style="margin-right: 0px;"></span>
                        </font>
                    </div>
            </div>
 			<table  width="100%" style="margin-top: 5px;padding-left: 10px;"   >
	            <tbody>
	                
	                <tr>
	                	<td >
							会计:
	                	</td>
	                	<td >
							计账:
	                	</td>
	                	<td >
							出纳:
	                	</td>
	                	<td >
							经手人:<span id="makeMan"></span>
	                	</td>
	                </tr>
	            </tbody>
	        </table>
        </div>
    </div>


	<script type="text/javascript">
	var baseUrl=apiPath + repairApi + "/";
	var storeHouse = null;
	var data = [];
	$(document).ready(function (){
		$('#currOrgName').text(currOrgName);
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
		document.getElementById("serviceCode").innerHTML = params.serviceCode;
		document.getElementById("makeMan").innerHTML=params.currUserName||"";
		document.getElementById("comp").innerHTML = params.comp;
		document.getElementById("spstorename").innerHTML = "领料单费用登记";
		document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
		document.getElementById("guestAddr").innerHTML = params.currCompAddress;
		document.getElementById("phone").innerHTML = params.currCompTel;
		var nowDate=format(date,"yyyy-MM-dd HH:mm");
	    $.ajaxSettings.async = false;
	    $.post(params.partApiUrl+"com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext?"+"&token="+params.token,{},function(text){
    		    if(text.storehouse){
    		      storeHouse = text.storehouse || "";
    		    }
	         });
	    var dictids= ['DDT20130703000051'];    
            	var tBody = $("#tbodyId");
				tBody.empty();
				var tds = '<td align="center">[id]</td>' +
    			"<td align='center'>[typeName]</td>"+ 
    			"<td align='center'>[dcName]</td>"+
    			"<td align='center'>[amt]</td>"+
				"<td align='center'>[guestName]</td>"+
    			"<td align='center'>[remark]</td>";
/*         		var receiveData = params.receiveData;
        		for(var i = 0 , l = receiveData.length ; i < l ; i++){
        			var tr = $("<tr></tr>");
        			tr.append(
				    				tds.replace("[id]",i +1)
				    				.replace("[typeName]",receiveData[i].typeName)
				    				.replace("[dcName]","费用收入")
				    				.replace("[amt]",receiveData[i].amt)
				    				.replace("[guestName]",receiveData[i].guestName || "")
				    				.replace("[remark]",receiveData[i].remark)
				    				);
				    			tBody.append(tr);
				    		//	document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].sellAmt);
        		} */
        		var payData = params.payData;
        		var zongAmt = 0;
        		for(var i = 0 , l = payData.length ; i < l ; i++){
        		zongAmt = parseFloat(zongAmt) + parseFloat(payData[i].amt);
        			var tr = $("<tr></tr>");
        			tr.append(
				    				tds.replace("[id]",i +1)
				    				.replace("[typeName]",payData[i].typeName)
				    				.replace("[dcName]","费用支出")
				    				.replace("[amt]",payData[i].amt)
				    				.replace("[guestName]",payData[i].guestName || "")
				    				.replace("[remark]",payData[i].remark)
				    				);
				    			tBody.append(tr);
				    		//	document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].sellAmt);
        		}
        		zongAmt = zongAmt.toFixed(4);
        	   var money = transform(zongAmt+"");
    		   document.getElementById("money").innerHTML = money;
    		   document.getElementById("cash1").innerHTML = zongAmt;
	}
	</script>
</body>
</html>