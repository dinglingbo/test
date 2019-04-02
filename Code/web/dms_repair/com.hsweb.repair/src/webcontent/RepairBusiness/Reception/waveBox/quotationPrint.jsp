<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-23 14:38:41
  - Description:
-->
<head>
<title>报价单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>  
</head>
<style>
	        table, td {
	            font-family: Tahoma,Geneva,sans-serif;
	            font-size: 16px;
	            color: #000;
	        }

            table.ybk {
                width: 100%;
                max-width: 100%;
                border-spacing: 0;
                border-collapse: collapse;
                background-color: transparent;
            }
			table.ybk1 {
                width: 100%;
                max-width: 100%;
                border: 1px solid #151515;
                background-color: transparent;
            }
            
            table.ybk2 {
                border-top:#FF0000 solid 1px;
            }
            
            table.ybk td {
                border: 1px solid #000;
                height : 33px;
            }

	        .print_btn {
	            text-align: center;
	            width: 100%;
	            padding: 30px 0 20px 0;
	            border:0px solid red; 
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
            width: 720px;
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
                font-weight: 700;
                height: 26px;
                border-bottom: 1px #000 solid;
            }

            .jsxx ul {
                padding-top: 6px;
            }

                .jsxx ul li {
                    color: #000;
                }

        .renyuan {
            height: 40px;
            line-height: 40px;
            width: 97%;
            margin: 0 auto;
        }

            .renyuan li {
                width: 33%;
                float: left;
            }

        .myddc dd, .myddc dt {
            float: left;
            margin-right: 30px;
        }

            .myddc dd font {
                display: block;
                float: left;
                width: 12px;
                height: 12px;
                border: 1px #000 solid;
                margin: 4px 5px 0 0;
            }
    </style>
<body ><!-- oncontextmenu = "return false" -->
<div class="boxbg" style="display:none"></div>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
     
        <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
	                <tr>
	                	<td rowspan="2" style="width: 133px;" >
	                     	<img alt="" src="" id="showImg" height="60px" style="display:none">
	                    </td>
	                    <td style="width:55%" >
	                        <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><b><span id="comp"></span></b></div>
	                    </td>
	                    <td rowspan="2" style="">
	                        <div style="font-size: 20px; font-family: 微软雅黑;padding-top: 5px;"><b><span id="spstorename">报价单</span></b></div>
	                        <div style="padding-top: 2px; font-size: 13px;font-family: Arial;">
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
	        
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td style="font-size:8px;" width="40%">地址：<span id="currCompAddress"></span></td>
                <td style="font-size:8px;"   width="33%">开户银行：<span id="currBankName"></span></td>
                <td style="font-size:8px;padding-right:1%" width="33%" align="right">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="currCompTel"></span></td>
                <td style="font-size:8px;">银行账号：<span id="currBankAccountNumber"></span></td>
             	<td style="font-size:8px;padding-right:1%" align="right" >进厂时间：<span id="enterDate"></span></td>
            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td width="14%" >&nbsp;客户名称</td>
                    <td id="guestFullName" width="25%"></td>
                    <td width="14%">&nbsp;变速箱型号</td>
                    <td id="boxModel"></td>
                    <td width="14%">&nbsp;车型</td>
                    <td id="carModel"></td>
                </tr>
                <tr>
                    <td>&nbsp;联系人</td>
                    <td id="name"></td>
                    <td id="">&nbsp;底盘号</td>
                    <td id="carVin" colspan="3"></td>
                </tr>
                <tr>
                    <td id="guestAddr1">&nbsp;客户地址</td>
                    <td id="guestAddr"></td>
                    <td>&nbsp;联系手机</td>
                    <td id="guestMobile" ></td>
                    <td>&nbsp;车牌号</td>
                    <td id="carNo" ></td>
                </tr>
                <tr>
                    
                    
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
        	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk" id="showItem">
                <tr style="height:30px">
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">序号</td>
                    <td height="28" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">项目名称</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">工时</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">单价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">金额</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">优惠率</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">小计</td>
                </tr>
                <tbody id="tbodyId">
				</tbody>
            </table>
            <div style="height: 12px;" id="space3"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk" id="showPart" >
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">序号</td>
                    <td height="28" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">配件名称</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">数量</td>
                     <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">单位</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">单价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">金额</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">优惠率</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 微软雅黑; font-size:16px;font-weight: bold;">小计</td>
                </tr>
                <tbody id="tbodyId2">
				</tbody>
            </table>
       
        <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="ybk">
            <tr>
                <td height="36" colspan="1" style="border:0px solid #DDD; " rowspan="1" colspan="1" >
                      工时：<span id="item">0</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0</span>
            
                </td>
                <td height="36" colspan="1" style="border:0px" >
                     <span style="margin-left: 0px;">优惠金额：<span id="yh">0</span>元</span>
                </td>
                <td height="36" colspan="2" style="border:0px;font-family: Arial; font-size:16px;font-weight: bold;">
                    <div style="float: left; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <font style="font-size: 16px; font-weight: bold;">
                                结算金额：<span id="cash1"></span>元
                            </font>
                        </span>
                        <font style="font-size: 16px; font-weight: bold;">
                            大写：<span id="money"></span>
                        </font>
                    </div>
                </td>
                
            </tr>
        </table> 
		<div style="display:none" id="hidden1" >
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
				<tr>
					<td>
							<div style="width:100%;height:100%;min-height:80px;" id="drawOutReport"></div>
					</td>
				</tr>
        </table>
		</div>
		<div style="padding-top:10px"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk" >
                <tr>
                   <td height="30" style="padding: 8px;" colspan="4">
                   		<span style="padding: 8px;font-size: 16px;" id="msg">尊敬的客户：以上报价在实际施工过程中可能有小幅变动，最终价格以实际结算单为准！</span>
                   		<div style="display:none" id="hidden2" >
                   			<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk"  >
				                <tr >
				                    <td width="5%"  align="center">序号</td>
				                    <td align="center">波箱配件</td>
				                    <td width="5%" align="center">数量</td>
				                    <td width="5%" align="center">序号</td>
				                    <td align="center">波箱配件</td>
				                    <td width="5%" align="center">数量</td>
				                </tr>
				                <tr>
				                	<td align="center">1</td>
				                	<td align="center">总成</td>
				                	<td align="center"></td>
				                	<td align="center">5</td>
				                	<td align="center">冬菇</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">2</td>
				                	<td align="center">波箱壳</td>
				                	<td align="center"></td>
				                	<td align="center">6</td>
				                	<td align="center">内件</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">3</td>
				                	<td align="center">差速器</td>
				                	<td align="center"></td>
				                	<td align="center">7</td>
				                	<td align="center">油泵</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">4</td>
				                	<td align="center">传感器</td>
				                	<td align="center"></td>
				                	<td align="center">8</td>
				                	<td align="center">油路板</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center" colspan="3"></td>
				                	<td align="center">9</td>
				                	<td align="center">F盅</td>
				                	<td align="center"></td>
				                </tr>
				            </table>
                   		</div>
                   		<br/>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style = "margin-left: 0px;" id = "show"></span><br>
                      <span style = "margin-left: 10px;" id="makeMan">制单员：</span><span style = "margin-left: 100px;">维修顾问签名：</span><span style = "margin-left: 110px;">客户签名：</span>
                  </td>
                 
            </tr>
        </table>
    </div>
    <script type="text/javascript">
			 nui.parse();
			 var mainUrl = "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid=";
			 var baseUrl = apiPath + repairApi + "/"; 
			 $(document).ready(function (){
			 	var date = new Date();
			 	document.getElementById("date").innerHTML = format(date, "yyyy-MM-dd HH:mm");
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
			 
			 function CloseWindow(action) {
	            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
	            else window.close();
       		 }
        	
			 function SetData(serviceId,type){
			 	document.getElementById("comp").innerHTML = currRepairSettorderPrintShow
			    var imgUrl = currCompLogoPath || "";
                if(imgUrl && imgUrl != ""){
                    $('#showImg').show();
                    $("#showImg").attr("src",imgUrl);
                 }
				 if(type){//默认报价单
					if(type == 4){
						document.getElementById("spstorename").innerHTML = "波箱厂内翻新单";
						document.getElementById("msg").innerHTML = "";
						document.getElementById("hidden2").style.display =""
					}else if(type != 5){
						document.getElementById("spstorename").innerHTML = "结算单";
						
				 	document.getElementById("msg").innerHTML = '服务满意度调查：☐   非常满意     '+
				 						'☐   基本满意     '+
				 						'☐   一般     '+
				 						'☐   不满意     '+
				 						'<div>'+currRepairSettPrintContent+'</div>'
					}
				 }
				 if(!type || type != 5){
				 	document.getElementById("hidden1").style.display = "";
				 }
				 if(type == 5 || type == 6){//报销单   5报价单   6结算单 
				 	mainUrl = "com.hsapi.repair.repairService.svr.billqyeryMaintainList.biz.ext?rid=";
				 }
				 document.getElementById("currCompTel").innerHTML = "&nbsp;&nbsp;&nbsp;"+currCompTel;
				 document.getElementById("currCompAddress").innerHTML = "&nbsp;&nbsp;&nbsp;"+currCompAddress;
				 document.getElementById("currBankName").innerHTML = "&nbsp;&nbsp;&nbsp;"+currBankName;
				 document.getElementById("currBankAccountNumber").innerHTML = "&nbsp;&nbsp;&nbsp;"+currBankAccountNumber;
				 $.ajaxSettings.async = false;
			 	 $.post(baseUrl+mainUrl+serviceId+"&token="+token,{},function(text){
			 	 	   if(text.list.length > 0){
			 	 	   		 var list = text.list[0];
			 	 	   		 var guestFullName = list.guestFullName || list.guestName || "" ;
			 	 	   		 var boxModel = list.boxModel || list.engineModel || "";
			 	 	   		 var carNo = list.carNo || "";
			 	 	   		 var name = list.name || list.contactorName ||"";
			 	 	   		 var carVin = list.carVin|| list.carVin || "";
			 	 	   		 var guestAddr = list.guestAddr || "";
			 	 	   		 var guestMobile = list.guestMobile || list.guestTel ||"";
			 	 	   		 var enterDate = list.enterDate || "";
			 	 	   		 var serviceCode = list.serviceCode || "";
			 	 	   		 var drawOutReport = list.drawOutReport || "";
			 	 	   		 var carModel = list.carModel || "";
			 	 	   		 document.getElementById("guestFullName").innerHTML = "&nbsp;"+guestFullName;
			 	 	   		 document.getElementById("carNo").innerHTML = "&nbsp;"+carNo;
			 	 	   		 document.getElementById("boxModel").innerHTML = "&nbsp;"+boxModel;
			 	 	   		 document.getElementById("carModel").innerHTML = "&nbsp;"+carModel;
			 	 	   		 document.getElementById("name").innerHTML = "&nbsp;"+name;
			 	 	   		 document.getElementById("carVin").innerHTML = "&nbsp;"+carVin;
			 	 	   		 document.getElementById("guestAddr").innerHTML = "&nbsp;"+guestAddr;
			 	 	   		 document.getElementById("guestMobile").innerHTML = "&nbsp;"+guestMobile;
			 	 	   		 document.getElementById("enterDate").innerHTML =document.getElementById("enterDate").innerHTML + format(enterDate, "yyyy-MM-dd HH:mm");
			 	 	   		 document.getElementById("serviceCode").innerHTML = "&nbsp;"+serviceCode;
			 	 	   		 document.getElementById("drawOutReport").innerHTML ="&nbsp;&nbsp;出厂报告："+ document.getElementById("drawOutReport").innerHTML+drawOutReport;
			 	 	   		 if(type == 5 || type == 6){
			 	 	   		 		$.post(baseUrl+"com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid="+list.sourceServiceId+"&token="+token,{},function(text){
			 	 	   		 			if(text.list.length > 0){
			 	 	   		 				var list = text.list[0];
			 	 	   		 				var guestAddr = list.guestAddr || "";
			 	 	   		 				var carModel = list.carModel || "";
			 	 	   		 				document.getElementById("guestAddr").innerHTML = "&nbsp;"+guestAddr;
			 	 	   		 				document.getElementById("carModel").innerHTML = "&nbsp;"+carModel;
			 	 	   		 			}
			 	 	   		 		});
			 	 	   		 }
			 	 	   }
			 	 });
			 	 var url_one = "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId=";
			 	 if(type == 5 || type == 6){//报销单 5报价单   6结算单
				 	url_one = "com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext?serviceId=";
				 }
			 	 $.post(baseUrl+url_one+serviceId+"&token="+token,{},function(text){//套餐
	        	if(text.errCode == "S"){
	    			 var data = text.data || text.itemBill;
	        	    if(data.length>0){
		        		var tBody = $("#tbodyId");
		        		var tBody2 = $("#tbodyId2");
	    				tBody.empty();
	    				tBody2.empty();
	    				var tds = '<td align="center" style="font-family: 微软雅黑;">[orderIndex]</td>' +
						    			"<td style='font-family: 微软雅黑;'>[prdtName]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[qty]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[unit]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[uintPrice]</td>"+ 
						    			"<td align='center' style='font-family: 微软雅黑;'>[amt]</td>"+ 
						    			"<td align='center' style='font-family: 微软雅黑;'>[rate]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[subtotal]</td>";
	    				
	    				var j = 0;
	    				var num1 = 0;
	    				var num2 = 0;
	    				var discountAmt = 0;
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    					var prdtName = data[i].prdtName || data[i].itemName || "";
	    					var rate = data[i].rate;
	    					rate = rate + "%";
	    					if(data[i].billItemId == 0){
	    						var tds1 = '<td align="center" style="font-family: 微软雅黑;">[orderIndex]</td>' +
						    			"<td style='font-family: 微软雅黑;'>[prdtName]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[qty]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[uintPrice]</td>"+ 
						    			"<td align='center' style='font-family: 微软雅黑;'>[amt]</td>"+ 
						    			"<td align='center' style='font-family: 微软雅黑;'>[rate]</td>"+
						    			"<td align='center' style='font-family: 微软雅黑;'>[subtotal]</td>";
	    						num1 ++;
	    						var tr = $("<tr ></tr>");
					    			tr.append(
					    				tds1.replace("[orderIndex]",num1)
					    				.replace("[prdtName]","&nbsp;"+prdtName || "")
					    				.replace("[qty]",data[i].qty|| data[i].itemTime || 1)
					    				.replace("[uintPrice]",data[i].unitPrice || 0)
					    				.replace("[amt]",data[i].amt || 0)
					    				.replace("[rate]",rate || 0)
					    				.replace("[subtotal]",data[i].subtotal || 0));
					    			tBody.append(tr); 
	    					}else{
	    						num2 ++;
	    						var tr = $("<tr></tr>");
					    			tr.append(
					    				tds.replace("[orderIndex]",num2)
					    				.replace("[prdtName]","&nbsp;"+prdtName || "")
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[unit]",data[i].unit || "")
					    				.replace("[uintPrice]", data[i].unitPrice || 0)
					    				.replace("[amt]",data[i].amt  || 0)
					    				.replace("[rate]",rate || 0)
					    				.replace("[subtotal]",data[i].subtotal || 0));
					    			tBody2.append(tr); 
	    					}
	    					if(data[i].pid != 0 ){
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					    }else{
    						   document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    					   }
	    				}
	    				 document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML).toFixed(2);
	    				 document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML).toFixed(2);
	    				 if(type == 5 || type == 6){
	    				 	document.getElementById("yh").innerHTML = 0;
			        		var money = parseFloat(document.getElementById("part").innerHTML) + parseFloat(document.getElementById("item").innerHTML);
			        		document.getElementById("cash1").innerHTML = money || "";	  
			        		money = transform(money+"");
							document.getElementById("money").innerHTML = money;
	    				 }
		        	}
	          }
        	});
        	$.ajaxSettings.async = false;
	        	if(type != 5 && type != 6){
		        	$.post(baseUrl+"com.hsapi.repair.repairService.query.querySettleAmt.biz.ext?serviceId="+serviceId+"&token="+token,{},function(text){
			    				if(text.errCode=="S"){ 
			    				 		document.getElementById("yh").innerHTML = text.data.totalPrefAmt || 0;;
			    				 		document.getElementById("cash1").innerHTML = text.data.balaAmt || 0;	    		    				 			
			    						    		var money = transform(text.data.balaAmt+"");
													document.getElementById("money").innerHTML = money;
			    					
			    				}else{
			    					showMsg(text.errMsg,"W");
			    				}
			            }); 
	        	}
			 }
    </script>
</body>
</html>