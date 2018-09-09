<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:38
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
    <style>
        body, p, div, td, html {
            font-family: "微软雅黑","黑体","新宋体","宋体",Arial;
            font-size: 13px;
            color: #000;
        }

        .print_btn {
            width: 800px;
            margin: 0 auto;
            text-align: center;
        }

            .print_btn a {
                width: 180px;
                height: 46px;
                background: #578ccd;
                font-size: 18px;
                text-align: center;
                line-height: 46px;
                border-radius: 5px;
                display: inline-block;
                color: #fff;
                text-decoration: none;
            }

                .print_btn a:hover {
                    background: #dc0000;
                }

        .printtopbt {
            border: 1px #999 solid;
            padding: 8px 12px;
            background: #f5f5f5;
        }

        .printny {
            width: 240px;
            height: auto;
            overflow: hidden;
            margin: 0 auto;
        }

            .printny h1 {
                font-size: 30px;
                font-family: "宋体";
            }

        .shishou input {
            border: none;
            text-align: center;
            height: 22px;
        }

        .peijian {
            border-bottom: 1px #999 dashed;
            padding-bottom: 5px;
        }
    </style>
<body>
<table width="240" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <div style="font-family: '宋体'; font-size: 30px;">结账单</div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="20" style="font-size: 16px;"><b>易维天下</b></td>
                        </tr>
                        <tr>
                            <td height="20" id="guestId">客户：</td>
                        </tr>
                        <tr>
                             <td height="20" id="tel">电话：</td>
                        </tr>
                        <tr>
                            <td height="20" id="mtAdvisor">顾问：</td>
                        </tr>
                        <tr>
                            <td height="20" id="carNo">车辆：</td>
                        </tr>
                        <tr>
                            <td height="20" id="enterDate">开始时间：</td>
                        </tr>
                    </table>
                </div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <thead>
                            <tr>
                                <th height="30" align="left" id="name">&nbsp;项目</th>
                                <th width="55" id="sal">费用</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyId">
						</tbody>
                    </table>
                </div>
                <div class="shishou">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="40" style="font-size: 18px; border-bottom: 2px #999 dashed;">应收：<span id="money">0</span></td>
                        </tr>
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">

                                                                        <tr>
                            <td height="40">签名：</td>
                        </tr>
                            <tr>
                                <td height="200" align="center" style="border-top: 1px #999 dashed;" width="200px">
                                    <div id="qrcode">
                                    	<img src="https://photo.harsonserver.com/20180907191028539.jpg">
                                    </div>
                                    <p>扫码支付</p>
                                </td>
                            </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
	<script type="text/javascript">
    	nui.parse();
		
		$(document).ready(function (){
    		nui.ajax({
                url: "com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext?id=1",
                async: false,
                success: function (text) {
                   var maintain = nui.decode(text.maintain);
                   if(text.errCode == "S"){
                   		var mtAdvisor = maintain.mtAdvisor;
                   		var guestId = maintain.guestId;
                   		var carNo = maintain.carNo;
                   		var enterDate = maintain.enterDate;
                   		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML+ mtAdvisor;
                   		document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML+ guestId;
                   		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML+ carNo;
                   		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML+ formatDate(new Date(enterDate));
                   }else{
                   		
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            var guestId = document.getElementById("guestId").innerHTML;
            nui.ajax({
                url: "com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext?guestId="+ guestId.replace(/[^0-9]/ig,""),
                async: false,
                success: function (text) {
                	var guest = nui.decode(text.guest);
                   if(text.errCode == "S"){
                   		var fullName = guest.fullName;
                   		var tel = guest.tel;
                   		document.getElementById("guestId").innerHTML =  guestId.replace(/[0-9]/ig,"") + fullName;
                   		document.getElementById("tel").innerHTML = document.getElementById("tel").innerHTML+ tel;
                   }else{
                   		
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            var type = 1;//1 2 3 套餐 工时 配件
            if(type == 1){
            	document.getElementById("name").innerHTML = "&nbsp;套餐";
            	nui.ajax({
	                url: "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId=381",
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                   		for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",data[i].prdtName)
				    				.replace("[sal]",data[i].subtotal));
				    			tBody.append(tr);
				    			document.getElementById("money").innerHTML = parseInt(document.getElementById("money").innerHTML) + parseInt(data[i].subtotal);
	                   		}
	                   }else{
	                   		
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	});
            }else if(type == 2){
            	document.getElementById("name").innerHTML = "&nbsp;工时";
            	nui.ajax({
	                url: "com.hsapi.repair.repairService.svr.getRpsMainItem.biz.ext?serviceId=381",
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                   		for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",data[i].itemName)
				    				.replace("[sal]",data[i].amt));
				    			tBody.append(tr);
				    			document.getElementById("money").innerHTML = parseInt(document.getElementById("money").innerHTML) + parseInt(data[i].amt);
	                   		}
	                   }else{
	                   		
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	});
            }else{
            	document.getElementById("name").innerHTML = "&nbsp;配件";
            	nui.ajax({
	                url: "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext?serviceId=381",
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                   		for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",data[i].partName)
				    				.replace("[sal]",data[i].amt));
				    			tBody.append(tr);
				    			document.getElementById("money").innerHTML = parseInt(document.getElementById("money").innerHTML) + parseInt(data[i].amt);
	                   		}
	                   }else{
	                   		
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	});
            }
    	}); 
    </script>
</body>
</html>