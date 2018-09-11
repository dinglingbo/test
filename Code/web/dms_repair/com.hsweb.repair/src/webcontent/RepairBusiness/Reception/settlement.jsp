<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->
<head>
<title>结算单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>     
</head>
<style>
        table, td {
            font-family: Tahoma,Geneva,sans-serif;
            font-size: 13px;
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
<body oncontextmenu = "return false">
<div class="boxbg" style="display:none"></div>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
    </div>
    <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
            <h3><span id="comp"></span></h3>
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td>
                            <div style="font-size: 30px; font-family: 微软雅黑;"><b><span id="spstorename"></span>维修结算单</b></div>
                        
                        <div style="padding-top: 2px; font-size: 16px;">
                            单号：<span id="serviceCode"></span>
                            
                        </div>
                    </td>
                    <td width="65" height="50px">
                            <div style="float: right; text-align: center;">
                                <div id="qrcode">
                                    	<img src="https://photo.harsonserver.com/20180910115313857.jpg">
                            </div>
                                扫码支付
                            </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="border-bottom: 1px #333 solid; height: 2px; margin-bottom: 10px;">&nbsp;</div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>地址：<span id="guestAddr"></span></td>
                <td align="right" id="enterDate">进厂时间：</td>
            </tr>
            <tr>
                <td>电话：<span id="spphoneno"></span></td>
                    <td align="right" id="date">打印时间：</td>

            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td height="24" width="33%" id="guestFullName">&nbsp;客户名称：</td>
                        <td id="guestMobile">&nbsp;联系电话：</td>
                    <td width="33%" id="mtAdvisor">&nbsp;接待人员：</td>
                </tr>
                <tr>
                    <td height="24" id="carNO">&nbsp;车牌：</td>
                    <td id="carModel">&nbsp;车辆型号： </td>
                    <td id="carVin">&nbsp;车架号：</td>
                </tr>
                <tr>
                    <td height="24" id="contactName">&nbsp;送修人：</td>
                    <td id="contactMobile">&nbsp;送修人电话：</td>
                    <td id="enterKilometers">&nbsp;行驶里程：</td>
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>套餐项目(包含工时和配件)</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
                <tbody id="tbodyId">
				</tbody>
            </table>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>工时项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
                <tbody id="tbodyId2">
				</tbody>
            </table>
            <div style="height: 12px;"></div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk1">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>配件项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
                <tbody id="tbodyId3">
				</tbody>
            </table>
            <div style="height: 12px;"></div>
                <div style="color:#000;height:32px; margin-top:-8px;">
            <span style="font-size: 16px; float:right; font-weight: bold;">价格合计：&yen;<span id="cash"></span>元</span>
            套餐：<span id="prdt">0</span>&nbsp;&nbsp;+&nbsp;&nbsp;工时：<span id="item">0</span>&nbsp;&nbsp;+&nbsp;&nbsp;配件：<span id="part">0</span>
        </div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
            <tr>
                <td height="36" colspan="6" bgcolor="#f0f0f0">
                    <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <b style="font-size: 16px;">合计</b>：
                            <font style="font-size: 15px; font-weight: bold;">
                                <span id="cash1"></span>
                            </font>元
                        </span>
                        <b style="font-size: 16px;">大写</b>：
                        <font style="font-size: 15px; font-weight: bold;">
                            <span id="money"></span>
                        </font>
                    </div>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                    <td height="50" valign="top" style="padding: 8px;">
                        出车报告：




                    </td>
                </tr>
            <tr>
                <td height="30" style="padding: 8px;">
                    <div style="font-size: 15px;">
                        <span id="spremark">
                            
                        </span>


                        
                    </div>
                    <ul class="renyuan">
                        <li>服务顾问：<span id="name"></span></li>
                        <li>收银员：</li>
                        <li>客户签名：</li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
	<script type="text/javascript">
		$(document).ready(function (){
			$("#print").click(function () {
	            $(".print_btn").hide();
	            window.print();
	        }); 
        });
        
        function getSubtotal(){//更新套餐工时配件合计金额
        	var money = parseInt(document.getElementById("prdt").innerHTML) + parseInt(document.getElementById("item").innerHTML) + parseInt(document.getElementById("part").innerHTML);
        	document.getElementById("cash").innerHTML = money;
        	document.getElementById("cash1").innerHTML = money;
    		money = transform(money+"");
    		document.getElementById("money").innerHTML = money;
        }
        
        function SetData(params){
	        var date = new Date();
	        document.getElementById("comp").innerHTML = params.comp;
	        document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm:ss");; 
	        $.ajaxSettings.async = false;//设置为同步执行
	        $.post("com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid="+params.serviceId,{},function(text){
	        	if(text.list.length > 0){
	        		var list = text.list[0];
	        		var carNo = list.carNO;
	        		var carVin = list.carVin;
	        		var enterDate = list.enterDate || "";
	        		if(enterDate){
	        			enterDate = enterDate.replace(/-/g,"/");
	        			enterDate = new Date(enterDate);
	        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm:ss");
	        		}
	        		var guestFullName = list.guestFullName;
	        		var enterKilometers = list.enterKilometers;
	        		var mtAdvisor = list.mtAdvisor;
	        		var planFinishDate = list.planFinishDate || "";
	        		if(planFinishDate){
	        			planFinishDate = planFinishDate.replace(/-/g,"/");
	        			planFinishDate = new Date(planFinishDate);
	        			planFinishDate = format(planFinishDate, "yyyy-MM-dd HH:mm:ss");
	        		}
	        		var serviceCode = list.serviceCode;
	        		var guestMobile = list.guestMobile;
	        		var carModel = list.carModel;
	        		var contactMobile = list.contactMobile;
	        		var contactName = list.contactName;
	        		var guestAddr = list.guestAddr;
	        		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
	        		document.getElementById("carNO").innerHTML = document.getElementById("carNO").innerHTML + carNo;
	        		document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
	        		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML + enterDate;
	        		document.getElementById("guestFullName").innerHTML = document.getElementById("guestFullName").innerHTML + guestFullName;
	        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
	        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
	        		document.getElementById("guestMobile").innerHTML = document.getElementById("guestMobile").innerHTML + guestMobile; 
	        		document.getElementById("carModel").innerHTML = document.getElementById("carModel").innerHTML + carModel; 
	        		document.getElementById("contactMobile").innerHTML = document.getElementById("contactMobile").innerHTML + contactMobile; 
	        		document.getElementById("contactName").innerHTML = document.getElementById("contactName").innerHTML + contactName; 
	        		document.getElementById("guestAddr").innerHTML = document.getElementById("guestAddr").innerHTML + guestAddr;
	        		document.getElementById("name").innerHTML = document.getElementById("name").innerHTML + mtAdvisor; 
	        	}
        	});	
        	$.post("com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId="+params.serviceId,{},function(text){//套餐
	        	if(text.errCode == "S"){
	        		var tBody = $("#tbodyId");
    				tBody.empty();
    				var tds = '<td align="center">[orderIndex]</td>' +
					    			"<td>[prdtName]</td>"+
					    			"<td align='center'>[amt]</td>"+ 
					    			"<td align='center'>[num]</td>"+
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>";
    				var data = text.data;
    				for(var i = 0 , l = data.length ; i < l ; i++){
    					var prdtName = data[i].prdtName;
    					var orderIndex = data[i].orderIndex;
    					var rate = data[i].rate;
    					rate = (rate * 100).toFixed(1) + "%";
    					if(data[i].billPackageId != 0){
    						prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
    						orderIndex = "";
    					}else{
    						document.getElementById("prdt").innerHTML = parseInt(document.getElementById("prdt").innerHTML) + parseInt(data[i].subtotal);
    					}
    					if(data[i].billPackageId == 0){
    						if(i != 0){
    							var tr = $("<tr class='ybk2'></tr>");
	    						tr.append(
				    				tds.replace("[orderIndex]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[num]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
	    						tBody.append(tr);
    						}
    						var tr = $("<tr style = 'height : 2px'></tr>");
				    			tr.append(
				    				tds.replace("[orderIndex]",orderIndex)
				    				.replace("[prdtName]",prdtName)
				    				.replace("[amt]",data[i].amt)
				    				.replace("[num]",1)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr); 
    					}else{
    						var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[orderIndex]",orderIndex)
				    				.replace("[prdtName]",prdtName)
				    				.replace("[amt]",data[i].amt)
				    				.replace("[num]",1)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr); 
    					}
		    			getSubtotal();
    				}
	        	}
        	});
        	 $.post("com.hsapi.repair.repairService.svr.getRpsMainItem.biz.ext?serviceId="+params.serviceId,{},function(text){//工时
	        	if(text.errCode == "S"){
	        		var tBody = $("#tbodyId2");
    				tBody.empty();
    				var tds = '<td align="center">[id]</td>' +
					    			"<td>[itemName]</td>"+
					    			"<td align='center'>[unitPrice]</td>"+ 
					    			"<td align='center'>[itemTime]</td>"+
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>";
    				var data = text.data;
    				for(var i = 0 , l = data.length ; i < l ; i++){
    					document.getElementById("item").innerHTML = parseInt(document.getElementById("item").innerHTML) + parseInt(data[i].subtotal);
    					var rate = data[i].rate;
    					rate = (rate * 100).toFixed(1) + "%";
    					var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[id]",i + 1)
				    				.replace("[itemName]",data[i].itemName)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[itemTime]",data[i].itemTime)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr);
				    	getSubtotal();		
    				}
	        	}
        	});
	        $.post("com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext?serviceId="+params.serviceId,{},function(text){//配件
	        	if(text.errCode == "S"){
	        		var tBody = $("#tbodyId3");
    				tBody.empty();
    				var tds = '<td align="center">[id]</td>' +
					    			"<td>[partName]</td>"+
					    			"<td align='center'>[unitPrice]</td>"+ 
					    			"<td align='center'>[qty]</td>"+
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>";
    				var data = text.data;
    				for(var i = 0 , l = data.length ; i < l ; i++){
    					document.getElementById("part").innerHTML = parseInt(document.getElementById("part").innerHTML) + parseInt(data[i].subtotal);
    					var rate = data[i].rate;
    					rate = (rate * 100).toFixed(1) + "%";
    					var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[id]",i + 1)
				    				.replace("[partName]",data[i].partName)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[qty]",data[i].qty)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr);
		    			getSubtotal();
    				}
	        	}
	        });
        }
    </script>
</body>
</html>