<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%-- <%@include file="/common/sysCommon.jsp"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->
<head>
<title>欠款凭证</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>    
    <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" /> 
    
</head>
<style>
	        table, td {
	            font-family: Tahoma,Geneva,sans-serif;
	            font-size: 16px;
	            color: #000;
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
      .parent{

		margin: 0 auto;
		width: 100%;
		height: 80px;
		text-align: center;
		line-height: 80px;
		
		}
		.content{
			border:1px solid #000;
			margin-left: 100px;
			margin-right: 100px;
			min-height:200px;　
			height:auto;
			
			
		}
    </style>
<body ><!-- oncontextmenu = "return false" -->
<div class="boxbg" style="display:none"></div>
 <div class="popbox" style="height:420px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2>
        <div style="padding-top:15px; margin:0 15px;">
            <table  width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" width="76" height="46">单据编号：</td>
                        <td><input type="text" id="serviceCode1" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">打印日期：</td>
                        <td><input id="payDate1" type="datetime-local" value=""/></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">欠款人：</td>
                        <td><input type="text" id="guestName1" class="peijianss" value="" /></td>
                    </tr>
                     <tr>
                        <td class="color999" height="46">业务单号：</td>
                        <td><input type="text" id="businessNumber1" class="peijianss" value="" /></td>
                    </tr> 
                     <tr>
                        <td class="color999" height="46">金额：</td>
                        <td><input type="text" id="netInAmt1" class="peijianss" value="" /></td>
                    </tr> 
                </tbody>
            </table>

        </div>
        <div class="boxbtn"><ul><a href="javascript:box_setup_close()" class="qc">取消</a><a href="javascript:save()" id="btn_save">保存</a></ul></div>
</div>
    <div class="print_btn" >
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a href="javascript:box_setup_open()">修改</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
 <!--        <a plain="true" iconCls="" plain="false" onclick="sendInfo()">发送短信</a>
        <a style="background:#999999" plain="true" iconCls="" plain="false" onclick="sendInfo1()">发送微信</a> -->
     </div>
     
       <!-- <div showCollapseButton="false" style="border:0; text-align: center;" class="print_hide">
        	 <div class="nui-toolbar" style="padding:0px;border-bottom:0;white-space: nowrap;">
	            <table  style="width:100%;">
	                <tr>
	                    <td style="width:80%;text-align: center;">
	                        <a class="nui-button" plain="true" iconCls="" plain="false" onclick="SetData()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信图文</a>
                            <a class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
	                    </td>
	                </tr>
	            </table>
	        </div>
	     </div> -->
	     
        <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
        	<div class="parent">
        		<p><font size="6" ><b>欠&nbsp;&nbsp;款&nbsp;&nbsp;证&nbsp;&nbsp;明&nbsp;&nbsp;单</b></font></p>
        	</div>
            <table  width="100%" >
	            <tbody>
<!-- 	                <tr>
	                    <td  style="padding-left: 70%">
	                        <div style=" font-size: 13px;font-family: Arial;">
	                          №:<span id="serviceCode"></span>  
	                        </div>
	                    </td>
	                </tr> -->
	                <tr>
	                    <td  style="padding-left: 70%">
	                        <div style="font-size: 13px;font-family: Arial;">
	                         	 欠款日期:<span id="payDate"></span>  
	                        </div>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	        
        </div>
        



        <div style="height: 12px;"></div>

             <div style="height: 12px;display:none" id="space3"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPart" style="display:none">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;"></td>
                    <td height="28" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">配件名称</td>
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
                <tbody id="tbodyId3">
				</tbody>
            </table>

            <div class="content">
            	<p><b>
            	<div style="margin-left: 50px;margin-top: 25px;">兹有:<div style="border-bottom: 1px solid black;margin-left: 35px;margin-top: -22px;"><span  id="guestName"></span></div></div>          	
            	<div style="margin-left: 30px;margin-right: 50px;border-bottom: 1px solid black;"><div style="margin-left: 200px;margin-top: 10px;">业务单号:<span id="businessNumber"></span></div></div>
            	<div style="margin-left: 50px;margin-top: 15px;float:left;">在我处欠款人民币（大写）:</div>
            	<div style="margin-top: 15px;border-bottom: 1px solid black;float:left;width: 40%"><span id="money"></span></div>
            	<div style="margin-top: 15px;float:left">￥:</div>
            	<div style="margin-top: 15px;border-bottom: 1px solid black;float:left;width: 20%"><span id="netInAmt"></span></div>
            	</b></p>
				</br>
				<div>
<!-- 	            	<div style="margin-left: 50px;margin-top: 20px;float:left;width: 50%">
	            	支付方式:    <input type="checkbox"   />现金  
	            			<input type="checkbox"   />刷卡
	   						<input type="checkbox"   />汇款    
	   					    <input type="checkbox"   />支票  
	    					<input type="checkbox"   />转账    
	    			</div> -->		
	    			<div style="margin-right: 100px;margin-top: 20px;float:left">收款单位（盖章）：<span id="companyName"></span></div>
    			</div>
            </div>
 			<table  width="100%" style="margin-top: 20px;padding-left: 100px;padding-right: 100px"   cellpadding="10">
	            <tbody>
	                <tr>
	                	<td colspan="2" >
	                     	欠款人:
	                    </td>
	                    <td colspan="2" >
	                      	  附单:
	                    </td>
	                </tr>
	                
	                <tr>
	                	<td >
							审批人:
	                	</td>
	                	<td >
							审核人:
	                	</td>
	                	<td >
							证明人:
	                	</td>
<!-- 	                	<td >
							支款人:
	                	</td> -->
	                	<td >
							经手人:<span id="makeMan"></span>
	                	</td>
	                </tr>
	            </tbody>
	        </table>
   


    </div>
	<script type="text/javascript">
	
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
/* 		function SetData(params){
			var frmBill = {};
			$.post(params.p.frmApiUrl+"com.hsapi.frm.frmService.finance.queryRPAccountDetail.biz.ext?params/billServiceId="+params.billServiceId||""+"&token="+params.p.token,{},function(text){
    		    if(text.list){
    		      frmBill = text.list;
    		      document.getElementById("serviceCode").innerHTML = frmBill[0].billServiceId||"";
    		      	var payDate = frmBill[0].auditDate;
    		      	payDate = payDate.replace(/-/g,"/");
	        		payDate = new Date(payDate);
	        		payDate = format(payDate, "yyyy-MM-dd HH:mm");
	        		document.getElementById("payDate").innerHTML = payDate;
	        		//所有车牌号
	        		var carNoList = "";
	        		for(var i =0;i<params.guestData.length;i++){
	        			carNoList = (carNoList +params.guestData[i].carNo||"")+"&nbsp;&nbsp;";
	        		}
	        		document.getElementById("guestName").innerHTML = (params.guestData[0].guestName||"")+"&nbsp;&nbsp;&nbsp;"+carNoList;
	        		document.getElementById("businessNumber").innerHTML = params.businessNumber||"";
	        		
	        		var money = transform(params.netInAmt+"");
					document.getElementById("money").innerHTML = money;
					document.getElementById("netInAmt").innerHTML = params.netInAmt||"";
					document.getElementById("makeMan").innerHTML=params.p.currUserName||"";
					document.getElementById("companyName").innerHTML=params.p.comp||"";
    		    }
	         });
			
		} */
		
		function SetData(params){
				    var carNoList = "";
	        		for(var i =0;i<params.guestData.length;i++){
	        			carNoList = (carNoList +params.guestData[i].carNo||"")+"&nbsp;&nbsp;";
	        		}
	        		document.getElementById("guestName").innerHTML = (params.guestData[0].guestName||"")+"&nbsp;&nbsp;&nbsp;"+carNoList;
	        		document.getElementById("businessNumber").innerHTML = params.businessNumber||"";
	        		
	        		var money = transform(params.netInAmt+"");
					document.getElementById("money").innerHTML = money;
					document.getElementById("netInAmt").innerHTML = params.netInAmt||"";
					document.getElementById("makeMan").innerHTML=params.p.currUserName||"";
					document.getElementById("companyName").innerHTML=params.p.comp||"";
		}
		
		function box_setup_open() {
	        $(".boxbg").show();
	        $(".popbox").show();
	        document.getElementById("serviceCode1").value = document.getElementById("serviceCode").innerHTML;
    		document.getElementById("payDate1").value = document.getElementById("payDate").innerHTML;
    		document.getElementById("guestName1").value = document.getElementById("guestName").innerHTML;
    		document.getElementById("businessNumber1").value = document.getElementById("businessNumber").innerHTML;
    		document.getElementById("netInAmt1").value = document.getElementById("netInAmt").innerHTML;
    		if(document.getElementById("payDate").innerHTML.length > 16){
    			var value = document.getElementById("payDate").innerHTML.substring(0, document.getElementById("payDate").innerHTML.length-3);
    			document.getElementById("payDate1").value = value.replace(" ","T");
    		}else{
    			document.getElementById("payDate1").value = document.getElementById("payDate").innerHTML.replace(" ","T");
    		}
    	}
    	function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }

    	 function save(){
			box_setup_close();
    		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode1").value;
    		document.getElementById("netInAmt").innerHTML = document.getElementById("netInAmt1").value;
    		document.getElementById("guestName").innerHTML = document.getElementById("guestName1").value;
    		document.getElementById("businessNumber").innerHTML = document.getElementById("businessNumber1").value;
			document.getElementById("payDate").innerHTML =  document.getElementById("payDate1").value.replace("T"," ");
			var money = transform(document.getElementById("netInAmt1").value+"");
			document.getElementById("money").innerHTML = money;
    	}
    	function box_setup_close(){
    		$(".boxbg").hide();
        	$(".popbox").hide();
    	}
    	
    </script>
</body>
</html>