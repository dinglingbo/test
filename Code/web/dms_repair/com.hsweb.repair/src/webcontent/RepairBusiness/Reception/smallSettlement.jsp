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
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    
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
<div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
</div>
<div style="height:5px"></div>
<table width="380" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <div style="font-family: '宋体'; font-size: 30px;">结账单</div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="20" style="font-size: 16px;"><b><span></span></b></td>
                        </tr>
                        <tr>
                            <td height="20" id="guestId">客户：</td>
                        </tr>
                        <tr>
                             <td height="20" id="mobile">电话：</td>
                        </tr>
                        <tr>
                            <td height="20" id="mtAdvisor">顾问：</td>
                        </tr>
                        <tr>
                            <td height="20" id="carNo">车牌：</td>
                        </tr>
                        <tr>
                            <td height="20" id="enterDate">进厂时间：</td>
                        </tr>
                    </table>
                </div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showPkg">
                        <thead>
                            <tr>
			                    <td  width="240" bgcolor="#f8f8f8"><b>套餐项目(包含工时和配件)</b></td>
			                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                            </tr>
                        </thead>
                        <tbody id="tbodyId">
						</tbody>
                    </table>
                </div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showItem">
                        <thead>
                            <tr>
			                    <td  width="240" bgcolor="#f8f8f8"><b>工时项目</b></td>
			                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                            </tr>
                        </thead>
                        <tbody id="tbodyId1">
						</tbody>
                    </table>
                </div>
                <!-- <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <thead>
                            <tr>
			                    <td  width="240" bgcolor="#f8f8f8"><b>配件项目</b></td>
			                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                            </tr>
                        </thead>
                        <tbody id="tbodyId2">
						</tbody>
                    </table>
                </div> -->
                <div class="shishou">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    	<tr>
                    		<td>
                    			套餐：<span id="prdt">0</span>&nbsp;&nbsp;&nbsp;&nbsp;工时：<span id="item">0</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0</span>
                    		</td>
                    	</tr>
                        <tr>
                            <td height="40" style="font-size: 18px; border-bottom: 2px #999 dashed;">应收：<span id="money">0</span></td>
                        </tr>
                        
                    </table>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">

                        <tr>
                            <td height="40">签名：</td>
                        </tr>
                            <tr>
                                <td height="200" align="center" style="border-top: 1px #999 dashed;" width="200">
                                    <div id="qrcode">
                                    	<img src="https://photo.harsonserver.com/20180910115313857.jpg">
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
        });; 
    	
	    function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    	function SetData(params){
    		nui.ajax({
                url: params.baseUrl+"com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext",
                type : "post",
                data : {
                	id : params.serviceId,
	                	token : params.token
                },
                async: false,
                success: function (text) {
                   var maintain = nui.decode(text.maintain);
                   if(text.errCode == "S"){
                   		var mtAdvisor = maintain.mtAdvisor || "";
                   		var guestId = maintain.guestId || "";
                   		var carNo = maintain.carNo || "";
                   		var enterDate = maintain.enterDate || "";
                   		if(enterDate){
	        			   enterDate = format(enterDate, "yyyy-MM-dd HH:mm");
	        		    }
                   		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML+ mtAdvisor;
                   		document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML+ guestId;
                   		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML+ carNo;
                   		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML+ enterDate;
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            var guestName = document.getElementById("guestId").innerHTML;
            var guestId = guestName.replace(/[^0-9]/ig, "");
            nui.ajax({
                url: params.baseUrl+"com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext",
                type : "post",
                data : {
                	guestId : guestId,
	                	token : params.token
                },
                async: false,
                success: function (text) {
                	var guest = nui.decode(text.guest);
                   if(text.errCode == "S"){
                   		var fullName = guest.fullName || "";
                   		var mobile = guest.mobile || "";
                   		document.getElementById("guestId").innerHTML =  guestName.replace(/[0-9]/ig,"") + fullName;
                   		document.getElementById("mobile").innerHTML = document.getElementById("mobile").innerHTML+ mobile;
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            	//document.getElementById("name").innerHTML = "&nbsp;套餐";
            	nui.ajax({
	                url: params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext",
	                type : "post",
	                data : {
	                	serviceId : params.serviceId,
	                	token : params.token
	                },
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId");
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                     if(data.length>0){
	                         for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var prdtName = data[i].prdtName;
	                   			if(data[i].billPackageId == 0){
	                   				document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].subtotal);
	                   				document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(data[i].subtotal);
	                   			}else{
	                   				prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	                   			}
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",prdtName)
				    				.replace("[sal]",data[i].subtotal));
				    			tBody.append(tr);
	                   		}
	                   		document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML).toFixed(2);
    				        document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML).toFixed(2);
	                     }else{
	                         $("#showPkg").hide();
	                     }
	                   		
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	});
            	//document.getElementById("name").innerHTML = "&nbsp;工时";
            	nui.ajax({
	                url: params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext",
	                type : "post",
	                data : {
	                	serviceId : params.serviceId
	                },
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId1");
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                         if(data.length>0){
	                            for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var tr = $("<tr></tr>");
	                   			var itemName = data[i].prdtName || "";
	                   			if(data[i].pid != 0 ){
		    						itemName = "&nbsp;&nbsp;&nbsp;&nbsp;" + itemName;
		    						document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
		    					}else{
		    						document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
		    					}
				    			tr.append(
				    				tds.replace("[name]",itemName)
				    				.replace("[sal]",data[i].subtotal));
				    			tBody.append(tr);
				    			document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].subtotal);
	                   		}
    				          document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML).toFixed(2);
	    				      document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML).toFixed(2);
	                         }else{
	                           $("#showItem").hide();
	                         }
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	});
            	//document.getElementById("name").innerHTML = "&nbsp;配件";
            	/* nui.ajax({
	                url: params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext",
	                type : "post",
	                data : {
	                	serviceId : params.serviceId,
	                	token : params.token
	                },
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId2");
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                   		for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",data[i].partName)
				    				.replace("[sal]",data[i].subtotal));
				    			tBody.append(tr);
				    			document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].subtotal);
	                   		}
	                   }
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    console.log(jqXHR.responseText);
	                    showMsg("网络出错", "W");
	                }
            	}); */
    	}
    </script>
</body>
</html>