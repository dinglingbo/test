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
<title>3</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
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
                font-size: 16px;
            }

        .company-info {
        }

            .company-info h3 {
                font-size: 18px;
                padding: 10px 0 8px 5px;
                border-bottom: 1px solid #333;
            }

        #title {
            font-size: 26px;
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
                font-size: 16px;
            }

        .tlist td {
            line-height: 18px;
            font-size: 14px;
            padding: 0 0 0 3px;
            border: 1px solid #333;
        }

        .noborder td {
            border: none !important;
        }

        .theader td {
            font-size: 14px;
        }

        .tfooter td {
            padding: 0px;
            font-size: 14px;
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
            font-size: 14px;
            color: #000;
        }
		table#ybk td{
			border: 1px solid #000;
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
                font-size: 20px;
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
            font-size: 18px;
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
	                        <div style="padding-top: 2px; font-size: 14px;font-family: Arial;">
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
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td  style="font-size:8px;">地址：<span id="guestAddr"></span></td>
<!--                 <td  id="openBank" style="width: 300px;">开户银行：</td> -->
                <td  style="width: 190px;font-size:8px;">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="phone"></span></td>
<!--                 <td  id="bankNo" >银行账号：</td> -->
<!--              	<td  id="enterDate" style="font-size:8px;">进厂时间：</td> -->
            </tr>
        </table>
    
        <div style=" height: 2px; margin-bottom: 10px;">&nbsp;</div>
            <table width="100%" style="" id="ybk"class="table theader">
                <tbody>
                    <!-- <tr>
                        <td class="left" width="33.3%" id="guestId">客户名称：</td>
                        <td class="left" width="33.3%" id="carNo">车牌号：</td>
                        <td class="left" id="tel">联系电话：</td>
                    </tr>
                    <tr>
                        <td class="left">品牌车型：</td>
                        <td class="left"id="enterKilometers">公里数：</td>
                        <td class="left"id="mtAdvisor">服务顾问：</td>
                    </tr>
                    <tr>
                        <td class="left" id ="carVin">车架号(VIN)：</td>
                        <td class="left">进厂时间：<span class="left" style="width: 33.33%" id="enterDate"></span></td>
                        <td class="left" id="planFinishDate">预计完工时间：</td>
                    </tr> -->
                    <tr>
                        <td class="left" id="carNo" style="margin-left: 0px;"width="33.3%">车牌号：</td>
                        <td class="left" id="carModel"width="33.3%" >品牌车型：</td>
                        <td class="left"id="mtAdvisor" width="33.3%">服务顾问：</td>
                    </tr>
                    <tr>   
                        <td class="left" id ="carVin" width="33.3%">车架号(VIN)：</td>
                        <td class="left" id ="engineNo">发动机号：</td>
                        <td class="left">进厂时间：<span class="left"  id="enterDate"></span></td>
                    </tr>
                  
            
                     <tr>
                        <td class="left" id="planFinishDate">预计完工时间：</td>
                        <td >&nbsp;进厂里程：<span id="enterKilometers"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;油量：<span id="enterOilMass"></span></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
    
            <h5 style="padding-top: 20px;">施工项目</h5>
            <div style="padding: 10px 0">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;">
                    <tbody>
                        <tr>
                            <td width="30" height="35" align="center">序号</td>
                            <td width="300" align="center">项目名称</td>
                            <td width="100" align="center">工时</td>
                            <td align="center">施工员</td>
                            <td align="center">备注</td>
                            <td align="center">签字</td>
                        </tr>
                        <tbody id="tbodyId">
						</tbody>
                    </tbody>
                </table>
            </div>
            
            <!--  <div style="height: 12px;display:none" id="space3"></div> -->
             <h5 style="padding-top: 20px;display:none" id="h53">配件物料</h5>
             <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table tlist mt10" style="table-layout: fixed;display:none" id="showPart" >
                <tr>
                    <td width="30" height="35" align="center">序号</td>
                    <td width="300" align="center">配件名称</td>
                    <td width="100" align="center">数量</td>
                    <td align="center">施工员</td>
                    <td align="center">备注</td>
                    <td align="center">签字</td>
                </tr>
                <tbody id="tbodyId3">
				</tbody>
            </table>
            
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
	var guestId=null;
	var data = [];
	var date=new Date();
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
	     var imgUrl = params.currCompLogoPath || ""
            if(imgUrl && imgUrl != ""){
               $('#showImg').show();
               $("#showImg").attr("src",imgUrl);
            }
		document.getElementById("comp").innerHTML = params.comp;
		document.getElementById("spstorename").innerHTML = "派工单";
		document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
// 		document.getElementById("openBank").innerHTML = document.getElementById("openBank").innerHTML + params.bankName;
//         document.getElementById("bankNo").innerHTML = document.getElementById("bankNo").innerHTML + params.bankAccountNumber;
        
        document.getElementById("guestAddr").innerHTML = params.currCompAddress;
		document.getElementById("phone").innerHTML = params.currCompTel;
		var dictids= ['DDT20130703000051'];
		$.ajaxSettings.async = false;
		$.post(params.sysUrl+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+params.token,{},function(text){
    		   if(text.data){
    		     data = text.data;
    		   }
	        });//com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext?id=
		$.ajaxSettings.async = false;//设置为同步执行
        $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.list.length > 0){
        	   var maintain = text.list[0];
        	   var enterOilMass = maintain.enterOilMass || "0";
	        	var name = "0";
        	   for(var i = 0;i<data.length;i++){
			        if(data[i].customid == enterOilMass){
			           name = data[i].name;
			           break;
			        }
	        	}
	        	var engineNo = maintain.engineNo || "";
        		var carNo = maintain.carNo || "";
        		var carVin = maintain.carVin || "";
        		var enterDate = maintain.enterDate || "";
        		var carModel = maintain.carModel || "";
        		if(enterDate){
        			enterDate = enterDate.replace(/-/g,"/");
        			enterDate = new Date(enterDate);
        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm");
        		}
        		guestId = maintain.guestId;
        		var enterKilometers = maintain.enterKilometers;
        		var mtAdvisor = maintain.mtAdvisor;
        		var planFinishDate = maintain.planFinishDate || "";
        		if(planFinishDate){
        			planFinishDate = planFinishDate.replace(/-/g,"/");
        			planFinishDate = new Date(planFinishDate);
        			planFinishDate = format(planFinishDate, "yyyy-MM-dd HH:MM");
        		}
        		var faultPhen = maintain.faultPhen || "";
        		var serviceCode = maintain.serviceCode;
        		var remark = maintain.remark || "";
        		document.getElementById("engineNo").innerHTML = document.getElementById("engineNo").innerHTML + engineNo; 
        		document.getElementById("carModel").innerHTML = document.getElementById("carModel").innerHTML + carModel; 
        		document.getElementById("enterOilMass").innerHTML = document.getElementById("enterOilMass").innerHTML + enterOilMass;
        		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
        		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + carNo;
        		document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
        		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML + enterDate;
//         		document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML + guestId;
        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
        		document.getElementById("planFinishDate").innerHTML = document.getElementById("planFinishDate").innerHTML + planFinishDate;
        		document.getElementById("faultPhen").innerHTML = document.getElementById("faultPhen").innerHTML + faultPhen; 
        		document.getElementById("remark").innerHTML = document.getElementById("remark").innerHTML + remark; 
        	}
        });
        

//         $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext?guestId="+ guestId+"&token="+params.token,{},function(text){
//         	if(text.errCode == "S"){
//         		var guest = text.guest;
//         		var fullName = guest.fullName;
//            		var tel = guest.mobile;
//           		document.getElementById("guestId").innerHTML =  guestId.replace(/[0-9]/ig,"") + fullName;
//            		document.getElementById("tel").innerHTML = document.getElementById("tel").innerHTML+ tel;
//         	}
//         });
        //url_one = "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId=";
        //com.hsapi.repair.repairService.query.getRpsItemByServiceId.biz.ext?serviceId=
        var partShow = 0;
        var itemNum = 1;
        var partNum = 1;
        $.ajaxSettings.async = false;//设置为异步执行
        var tBody = $("#tbodyId");
		tBody.empty();
		var tBody3 = $("#tbodyId3");
		tBody3.empty();
		var tds = '<td align="center">[orderIndex]</td>' +
		"<td align='center'>[prdtName]</td>"+
		"<td align='center'>[qty]</td>"+
		"<td align='center'>[workers]</td>"+
		"<td align='center'>[remark]</td>"+
		"<td align='center'></td>";
        $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        		var data = text.data;
        		for(var i = 0 , l = data.length ; i < l ; i++){
        		     var tr = $("<tr></tr>");
        		    /*  tr.append(
		    				tds.replace("[id]",index)
		    				.replace("[prdtName]",itemName)
		    				.replace("[qty]",itemTime)
		    				.replace("[unitPrice]",data[i].unitPrice)
		    				.replace("[amt]",data[i].amt)
		    				.replace("[rate]",rate)
		    				.replace("[subtotal]",data[i].subtotal));
		    			if(data[i].billItemId != 0){
		    			   tBody3.append(tr);
		    			   partShow = 1;
		    			}else{
		    			   tBody.append(tr);
		    		} */
		    		
		    		if(data[i].billItemId==0){
        		       var tr = $("<tr></tr>");
        			    tr.append(
				    		  tds.replace("[orderIndex]",data[i].orderIndex)
				    			 .replace("[prdtName]",data[i].prdtName)
				    			 .replace("[qty]",data[i].qty)
				    			 .replace("[workers]",data[i].workers || "")
				    			 .replace("[remark]",data[i].remark || ""));
				    	tBody.append(tr);
				    	itemNum = itemNum + 1;
        		    }else{
        		       if(params.currIsCanfreeCarnovin==1){
		    		       var tr = $("<tr></tr>");
		    			    tr.append(
					    		  tds.replace("[orderIndex]",partNum)
					    			 .replace("[prdtName]",data[i].prdtName)
					    			 .replace("[qty]",data[i].qty)
					    			 .replace("[workers]","----")
					    			 .replace("[remark]",data[i].remark || ""));
					    	 tBody3.append(tr);
			    			 partShow = 1;
			    			 partNum = partNum + 1;
        		       }
        		        
        		    } 
        		}
        		if(partShow==1){
				   document.getElementById("showPart").style.display = "";
				   //document.getElementById("space3").style.display = "";
				   document.getElementById("h53").style.display = "";
				}
        	}
        });
         $.ajaxSettings.async = false;//设置为同步执行
         $.post(params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
        	if(text.errCode == "S"){
        		var data = text.data;
        		for(var i = 0 , l = data.length ; i < l ; i++){
        		     var tr = $("<tr></tr>");
        		     //套餐下的项目
		    		if(data[i].billPackageId!=0 && data[i].type==2){
        		       var tr = $("<tr></tr>");
        			    tr.append(
				    		  tds.replace("[orderIndex]",itemNum)
				    			 .replace("[prdtName]",data[i].prdtName)
				    			 .replace("[qty]",data[i].qty)
				    			 .replace("[workers]",data[i].workers || "")
				    			 .replace("[remark]",data[i].remark || ""));
				    	tBody.append(tr);
				    	itemNum = itemNum + 1;
        		    }else{
        		       if(params.currIsCanfreeCarnovin==1){
        		           if(data[i].billPackageId!=0 && data[i].type==3){
        		                var tr = $("<tr></tr>");
			    			    tr.append(
						    		  tds.replace("[orderIndex]",partNum)
						    			 .replace("[prdtName]",data[i].prdtName)
						    			 .replace("[qty]",data[i].qty)
						    			 .replace("[workers]","----")
						    			 .replace("[remark]",data[i].remark || ""));
						    	 tBody3.append(tr);
				    			 partShow = 1;
				    			 partNum = partNum + 1;
        		           }
		    		       
        		       }
        		        
        		    } 
        		}
        		if(partShow==1){
				   document.getElementById("showPart").style.display = "";
				  // document.getElementById("space3").style.display = "";
				   document.getElementById("h53").style.display = "";
				}
        	}
        });
        
        
        
        
	}
    </script>
</body>
</html>