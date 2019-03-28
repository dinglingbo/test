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
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" /> 
    
</head>
    <style>
        body, p, div, td, html {
            font-family: "微软雅黑","黑体","新宋体","宋体",Arial;
            font-size: 13px;
            color: #000;
        }

        .print_btn {
            width: 1000px;
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

<div class="boxbg" id ="show" style="display:none"></div>
 <div class="popbox" id ="show1" style="height:220px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2>
        <div style="padding-top:15px; margin:0 15px;">
            <table  width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" height="46">结算时间：</td>
                        <td><input id="updOutDate" type="datetime-local" value=""/></td>
                    </tr>
                </tbody>
            </table>

        </div>
        <div class="boxbtn"><ul><a href="javascript:box_setup_close()" class="qc">取消</a><a href="javascript:save()" id="btn_save">保存</a></ul></div>
</div>

<div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a href="javascript:box_setup_open()">修改</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
        <a  style="background:#999999" iconCls="" onclick="sendInfo()">发送短信</a>
        <a  style="background:#999999" iconCls="" onclick="sendInfo()">发送微信</a>
</div>
<div style="height:5px"></div>
<table width="430" border="0" align="center" cellpadding="0" cellspacing="0">
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
                            <td height="20" id="mtAdvisor">服务顾问：</td>
                        </tr>
                        <tr>
                            <td height="20" id="carNo">车牌号：</td>
                        </tr>
                        <tr>
                            <td height="20" >结算时间：<span id="outDate"></span></td>
                        </tr>
                    </table>
                </div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showPkg">
                        <thead>
                            <tr>
			                    <td  width="240" bgcolor="#f8f8f8"><b>套餐(包含工时配件)</b></td>
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
			                    <td  width="240" bgcolor="#f8f8f8"><b>项目</b></td>
			                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                            </tr>
                        </thead>
                        <tbody id="tbodyId1">
						</tbody>
                    </table>
                </div>
                <div class="peijian">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showPart" style="display:none">
                        <thead>
                            <tr>
			                    <td  width="240" bgcolor="#f8f8f8"><b>配件</b></td>
			                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                            </tr>
                        </thead>
                        <tbody id="tbodyId2">
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
                    			套餐：<span id="prdt">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;工时：<span id="item">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0.00</span>
                    		</td>
                    	</tr>
                    	<tr>
                    		<td>
                    			其他费用：<span id="expense">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;其他优惠：<span id="expRateAmt">0.00</span>
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
                           <!--  <tr>
                                <td height="200" align="center" style="border-top: 1px #999 dashed;" width="200">
                                    <div id="qrcode">
                                    	<img src="https://photo.harsonserver.com/20180910115313857.jpg">
                                    </div>
                                    <p>扫码支付</p>
                                </td>
                            </tr> -->
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
    	    var currRepairBillMobileFlag = params.currRepairBillMobileFlag;
    	    token1 =  params.token;
            webUrl = params.webUrl;
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
                   		var outDate = maintain.outDate || "";
                   		if(outDate){
	        			   outDate = format(outDate, "yyyy-MM-dd HH:mm");
	        		    }
                   		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML+ mtAdvisor;
                   		document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML+ guestId;
                   		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML+ carNo;
                   		document.getElementById("outDate").innerHTML = outDate; 
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            var guestName = document.getElementById("guestId").innerHTML;
            var guestId = guestName.replace(/[^0-9]/ig, "");
            $.ajaxSettings.async = false;
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
                   		phones = mobile;
                   		document.getElementById("guestId").innerHTML =  guestName.replace(/[0-9]/ig,"") + fullName;
                   		if(currRepairBillMobileFlag==1){
	        	            document.getElementById("guestId").innerHTML = document.getElementById("guestId").innerHTML + 
	        	            "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ phones;
	        	        }
                   		//document.getElementById("mobile").innerHTML = document.getElementById("mobile").innerHTML+ mobile;
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
            	//document.getElementById("name").innerHTML = "&nbsp;套餐";
            	$.ajaxSettings.async = false;
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
	                            var subtotal = "";
	                   			var prdtName = data[i].prdtName;
	                   			if(data[i].billPackageId == 0){
	                   				document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML) + parseFloat(data[i].subtotal);
	                   				document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(data[i].subtotal);
	                   			    subtotal = data[i].subtotal;
	                   			}else{
	                   				prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	                   			}
	                   			var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[name]",prdtName)
				    				.replace("[sal]",subtotal));
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
            	var partShow = null;
            	//document.getElementById("name").innerHTML = "&nbsp;工时";
            	$.ajaxSettings.async = false;
            	nui.ajax({
	                url: params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext",
	                type : "post",
	                data : {
	                	serviceId : params.serviceId
	                },
	                success: function (text) {
	                	var data = nui.decode(text.data);
	                	var tBody = $("#tbodyId1");
	                	var tBody2 = $("#tbodyId2");
	    				var tds = '<td align="left">[name]</td>' +
		    			"<td align='center'>[sal]</td>";
	                   if(text.errCode == "S"){
	                         if(data.length>0){
	                            for(var i = 0 , l = data.length ; i < l ; i ++){
	                   			var tr = $("<tr></tr>");
	                   			var itemName = data[i].prdtName || "";
	                   			if(data[i].pid != 0 ){
		    						document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
		    					}else{
		    						document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
		    					}
		    					
				    			tr.append(
				    				tds.replace("[name]",itemName)
				    				.replace("[sal]",data[i].subtotal));
				    			if(data[i].billItemId != 0){
				    			   tBody2.append(tr);
				    			   partShow = 1;
				    			}else{
				    			   tBody.append(tr);
				    			}
				    			if(partShow==1){
    				               document.getElementById("showPart").style.display = "";
    				             }
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
            	 $.ajaxSettings.async = false;
        	 $.post(params.baseUrl+"com.hsapi.repair.repairService.query.querySettleAmt.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
				   if(text.errCode=="S"){ 
 		    		    var money = text.data.balaAmt;
					    document.getElementById("money").innerHTML = money;
	
    				}else{
    					nui.alert(text.errMsg,"提示");
    				}
	            });
            	//其他费用com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext
    		 $.ajaxSettings.async = false;
    		 var httpstr = params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext?serviceId="+params.serviceId+"&dc=1"+"&token="+params.token;
    		 $.post(httpstr,{},function(text){
    			   if(text.errCode=="S"){
    		            data = text.data;
    		            if(data.length>0){
    		             var expAmt = 0;
    		             for(var i = 0;i<data.length;i++){
    		                 expAmt = expAmt + data[i].amt;
    		             }
    		             if(expAmt>0){
    		                expAmt = expAmt.toFixed(2);
    		                document.getElementById("expense").innerHTML = expAmt;
    		             }
    		            }
    		       }
	         });
	         $.ajaxSettings.async = false;
	         $.post(params.baseUrl+"com.hsapi.repair.repairService.query.querySettleAmt.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
				    if(text.errCode=="S"){ 
				    		if(text.data.allowanceAmt<0){
	    				 		document.getElementById("expRateAmt").innerHTML = "0.00";
	    				 	}else{
	    				 		document.getElementById("expRateAmt").innerHTML = text.data.allowanceAmt.toFixed(2);
	    				 	} 			
    				}else{
    					nui.alert(text.errMsg,"提示");
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
        function box_setup_open() {
	        /* $(".boxbg").show();
	        $(".popbox").show(); */
	        document.getElementById("show").style.display = "";
	        document.getElementById("show1").style.display="";
			var updOutDate = document.getElementById("outDate").value;
			if(updOutDate!=null && updOutDate!=""){
			   if(updOutDate > 16){
    			var value = enterDate.substring(0, updOutDate-3);
    			  document.getElementById("updOutDate").value = value.replace(" ","T");
    		   }else{
    			  document.getElementById("updOutDate").value = updOutDate.replace(" ","T");
    		   }
			}
			
    	}
    	
    	function save(){
			box_setup_close();
		    document.getElementById("outDate").innerHTML = document.getElementById("updOutDate").value.replace("T"," ");
       	}
    	
    	function box_setup_close(){
    		/* $(".boxbg").hide();
        	$(".popbox").hide(); */
        	document.getElementById("show").style.display = 'none';
	        document.getElementById("show1").style.display='none';
    	} 	
   var token1 =null; 
   var webUrl =null;
   var phones = null;
   function sendInfo(){
	nui.open({
		//url: webUrl+"com.hsweb.crm.manage.sendInfo.flow?token="+token1,
		url:"http://127.0.0.1:8080/default/com.hsweb.crm.manage.sendInfo.flow",
		title: "发送短信", width: 655, height: 386,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setPhones(phones);
		},
		ondestroy: function (action) {
            //重新加载
            //query(tab);
        }
    });
  }
    	
    	
    </script>
</body>
</html>