<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-25 08:57:27
  - Description:
-->
<head>
<title>施工单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
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
<body>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
    <div id="print-container">
        <div class="company-info">
<!--             <h3><span id="comp"></span></h3> -->
        </div>
        <div align="center">
        	<div style="font-size: 28px; font-family: 黑体;"><b><span id="comp"></span></b></div>
        </div>
       <table  width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-top:10px">
	            <tbody>
	                <tr>
	                	<td rowspan="1" style="width: 33%">
	                     	<div style="padding-top: 2px; font-size: 16px;font-family: Arial;">
	                          №:<span id="serviceCode"></span>  
	                        </div>
	                    </td>
	                    <td style="width: 33%">
	                         <div style="padding-top: 2px; font-size: 16px;font-family: Arial;" align="center">
	                          <strong>维修施工单</strong>  
	                        </div>
	                    </td>
	                    <td rowspan="1" style="width: 33%">
	                        <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename"></span></b></div>
	                        <div style="padding-top: 2px; font-size: 16px;font-family: Arial;">
	                          打印日期：<span id="date"></span>  
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
            <table width="100%" id="ybk" border="0" cellpadding="0" cellspacing="0" class="table theader">
                <tbody>
                    <tr>
                        <td class="left" id="" width="50%"style="margin-left: 0px;">&nbsp;&nbsp;&nbsp;客户名称：<span id="guestFullName"></span></td>
                        <td class="left"id="" width="">&nbsp;&nbsp;&nbsp;交车时间：<span id="planFinishDate"></span></td>
                     	
                    </tr>
                    <tr>
                        <td class="left" id ="" width="50%">&nbsp;&nbsp;&nbsp;波箱型号：<span id="boxModel"></span></td>
                        <td class="left" id="">&nbsp;&nbsp;&nbsp;维修顾问：<span id="mtAdvisor"></span></td>
                    </tr>
                </tbody>
            </table>
            <div style="padding-top:10px">
            	<span>客户要求及故障现象：</span>
            <div style="padding: 0px 0">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td height="35"  id="faultPhen"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            </div>
            <div style="padding: 10px 0">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPkg">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;"></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"style="font-family: 华文中宋; font-size:16px;font-weight: bold;">套餐项目(含工时配件)</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">数量</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">单价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">金额</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">优惠率</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">小计</td>
                </tr>
                <tr>
                	<td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                </tr>
                <tbody id="tbodyId">
				</tbody>
            </table>
            </div>
            <hr/>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk" sytle="padding-top:30px">
                <tr>
                   <td height="30" style="padding: 8px;" colspan="4">
                      <span style = "margin-left: 10px;" id="makeMan">制单员：</span><span style = "margin-left: 100px;">实际完工时间：</span><span style = "margin-left: 110px;">质检员签名：</span>
                  </td>
            </tr>
       	  </table>
       	  <div align="center" style="font-size:20px">
       	  		专&nbsp;&nbsp;诚&nbsp;&nbsp;奉&nbsp;&nbsp;献&nbsp;&nbsp;彰&nbsp;&nbsp;显&nbsp;&nbsp;卓&nbsp;&nbsp;越
       	  </div>
       	  <hr/>
        </div>


	<script type="text/javascript">
    	nui.parse();
    	var mainUrl = "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?";
		var baseUrl = apiPath + repairApi + "/"
    	$(document).ready(function (){
			
			$("#print").click(function () {
	            $(".print_btn").hide();
	            $(".print_hide").hide();
	            
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
        
        function SetData(serviceId,type){
        	showtime("date");
        	document.getElementById("comp").innerHTML = currRepairSettorderPrintShow;
        	 $.post(baseUrl+mainUrl+"params/rid="+serviceId+"&token="+token,{},function(text){
	        	 	if(text.list.length > 0){
	        	 		var list = text.list[0];
	        	 		var serviceCode = list.serviceCode || "";
	        	 		var guestFullName = list.guestFullName || "";
	        	 		var planFinishDate = list.planFinishDate || "";
	        	 		var boxModel = list.boxModel || "";
	        	 		var mtAdvisor = list.mtAdvisor || "";
	        	 		document.getElementById("serviceCode").innerHTML = serviceCode;
	        	 		document.getElementById("guestFullName").innerHTML = guestFullName;
	        	 		var faultPhen = list.faultPhen || "";
	        	 		if(planFinishDate){
	        	 			document.getElementById("planFinishDate").innerHTML = format(planFinishDate, "yyyy-MM-dd HH:mm");;
	        	 		}	
	        	 		document.getElementById("boxModel").innerHTML = boxModel;
	        	 		document.getElementById("mtAdvisor").innerHTML = mtAdvisor;
	        	 		document.getElementById("faultPhen").innerHTML = faultPhen;
	        	 	}
        	 });
        	 
        	 var url_one = "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId=";
			 	 $.post(baseUrl+url_one+serviceId+"&token="+token,{},function(text){//套餐
	        	if(text.errCode == "S"){
	    			 var data = text.data;
	        	    if(data.length>0){
		        		var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="center">[orderIndex]</td>' +
						    			"<td>[prdtName]</td>"+
						    			"<td align='center'>[qty]</td>"+
						    			"<td align='center'>[unitPrice]</td>"+ 
						    			"<td align='center'>[amt]</td>"+ 
						    			"<td align='center'>[rate]</td>"+
						    			"<td align='center'>[subtotal]</td>";
	    				
	    				var j = 0;
	    				var discountAmt = 0;
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    					var prdtName = data[i].prdtName;
	    					var orderIndex = data[i].orderIndex;
	    					var rate = data[i].rate;
	    					rate = rate + "%";
	    					if(data[i].billPackageId != 0){
	    						prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	    						orderIndex = "";
	    						
	    					}
	    					if(data[i].billItemId == 0){
	    						if(i != 0){
	    							var tr = $("<tr class='ybk2'></tr>");
		    						tr.append(
					    				tds.replace("[orderIndex]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[qty]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[unitPrice]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
		    						tBody.append(tr);
	    						}
	    						var tr = $("<tr style = 'height : 2px'></tr>");
					    			tr.append(
					    				tds.replace("[orderIndex]",orderIndex)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[unitPrice]",data[i].unitPrice)
					    				.replace("[amt]",data[i].amt)
					    				.replace("[rate]",rate)
					    				.replace("[subtotal]",data[i].subtotal));
					    			tBody.append(tr); 
	    					}else{
	    						var tr = $("<tr></tr>");
					    			tr.append(
					    				tds.replace("[orderIndex]",orderIndex)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[unitPrice]",data[i].unitPrice)
					    				.replace("[amt]",data[i].amt)
					    				.replace("[rate]",rate)
					    				.replace("[subtotal]",data[i].subtotal));
					    			tBody.append(tr); 
	    					}
	    				}
		        	}else{
	                }
	          }
        	});
        }
        
         function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>
</body>
</html>