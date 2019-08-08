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
<title>付款凭证</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>    
    
</head>
<style>
	        table, td {
	            font-family: 宋体;
	            font-size: 17px;
	            color: #000;
	        }




	        .print_btn {
	            text-align: center;
	            width: 100%;
	            border:0px solid red; 
	        }

            .print_btn a {
                width: 80px;
                height: 22px;
                display: inline-block;
                background: #578ccd;
                line-height: 22px;
                border-radius: 5px;
                color: #fff;
                font-size: 18px;
                text-decoration: none;
            }

            .print_btn a:active, .print_btn a:hover {
                background: #df0024;
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
		height: 30px;
		text-align: center;
		line-height: 30px;
		
		}
		*{font:黑体}
		.content{
			font-size: 15px;
			font-family:黑体;
			
			border:1px solid #000;
			margin-left: 0px;
			margin-right: 0px;
			min-height:150px;　
			height:auto;
			
			
		}
    </style>
<body onafterprint="CloseWindow('ok')" ><!-- oncontextmenu = "return false" -->
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
                        <td class="color999" height="46">结算日期：</td>
                        <td><input id="payDate1" type="datetime-local" value=""/></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">即付：</td>
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
        		<p><font size="6" style="border-bottom:3px double black;" ><b>支&nbsp;&nbsp;款&nbsp;&nbsp;证&nbsp;&nbsp;明&nbsp;&nbsp;单</b></font></p>
        	</div>
            <table  width="100%" >
	            <tbody>
	                <tr>
	                    <td align="right">
	                        <div style=" font-size: 14px;font-family: 宋体;">
	                          №:<span id="serviceCode"></span> &nbsp;&nbsp;

	                         	 结算日期:<span id="payDate"></span>  
	                        </div>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
	        
        </div>
        


            <div class="content">
            	<p><b>
            	<div style="margin-left: 40px;margin-top: 5px;">即付:<div style="border-bottom: 1px solid black;margin-left: 35px;margin-top: -22px;"><span  id="guestName"></span></div></div>
            	
            	<div style="margin-left: 5px;margin-top: 3px;border-bottom: 1px solid black;"><div style="margin-top: 10px;">业务单号:<span id="businessNumber"></span></div></div>
            	<div style="margin-left: 10px;margin-top: 3px;float:left;">人民币（大写）:</div>
            	<div style="margin-top: 5px;margin-top: 3px;border-bottom: 1px solid black;float:left;width: 40%"><span id="money"></span></div>
            	<div style="margin-top: 5px;margin-top: 3px;float:left">￥:</div>
            	<div style="margin-top: 5px;margin-top: 3px;border-bottom: 1px solid black;float:left;width: 30%"><span id="netInAmt"></span></div>
            	</b></p>
				</br>
				<div>
	            	<div style="margin-left: 5px;margin-top: 3px;float:left;width: 55%">
	            	支付方式:    <input type="checkbox"   />现金  
	            			<input type="checkbox"   />刷卡
	   						<input type="checkbox"   />汇款    
	   					    <input type="checkbox"   />支票  
	    					<input type="checkbox"   />转账    
	    			</div>		
	    			<div style="margin-top: 3px;float:left;width: 43%">支款单位(盖章):<span id="companyName"></span></div>
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
		function SetData(params){
			var frmBill = {};
			$.post(params.p.frmApiUrl+"com.hsapi.frm.frmService.finance.queryRPAccountDetail.biz.ext?params/billServiceId="+params.billServiceId||""+"&token="+params.p.token,{},function(text){
    		    if(text.list){
    		      frmBill = text.list;
    		      document.getElementById("serviceCode").innerHTML = frmBill[0].rpAccountId||"";
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