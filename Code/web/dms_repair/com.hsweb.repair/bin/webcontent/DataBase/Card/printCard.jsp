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
<title></title>
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
<body onafterprint="CloseWindow('ok')" ><!-- oncontextmenu = "return false" -->
<div class="boxbg" style="display:none"></div>
 <div class="popbox" style="height:420px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2> 
        <div style="padding-top:15px; margin:0 15px;">
            <table  width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" height="46">门店名称：</td>
                        <td><input type="text" id="txtstorename" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">地址：</td>
                        <td><input type="text" id="txtaddress" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">电话：</td>
                        <td><input type="text" id="txtphoneno" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">打印时间：</td>
                        <td><input id="meeting" type="datetime-local" value=""/></td>
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
        <a plain="true" iconCls="" plain="false" onclick="sendInfo()">发送短信</a>
        <a style="background:#999999" plain="true" iconCls="" plain="false" onclick="sendInfo1()">发送微信</a>
     </div>

        <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
        	
            
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
	                       <!-- < div style="padding-top: 2px; font-size: 13px;font-family: Arial;">
	                          №:<span id="serviceCode"></span>  
	                        </div> -->
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
        
        <!-- <div style="border-bottom: 1px #333 solid; height: 2px; margin-bottom: 10px;">&nbsp;</div> -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td style="font-size:8px;" >地址：<span id="guestAddr"></span></td>
                <td style="font-size:8px;"  id="openBank" style="">开户银行：</td>
                <td style="font-size:8px;">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="phone"></span></td>
                <td style="font-size:8px;" id="bankNo" >银行账号：</td>
             	<!-- <td style="font-size:8px;" id="enterDate" >进厂时间：</td> -->
            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td height="24" id="carNo">&nbsp;车牌号：</td>
                    <td height="24" width="33%" id="guestFullName">&nbsp;客户名称：</td>
                    <td width="33%" id="mtAdvisor">&nbsp;服务顾问：</td>
                </tr>
                <tr>
                    
                    
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPkg">
                <tr>
                    <td height="28" align="center" bgcolor="#f8f8f8"style="font-family: 华文中宋; font-size:16px;font-weight: bold;">计次卡(含明细)</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">数量/次数</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">销售价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;">总价</td>
                </tr>
                <tr>
                	<td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                    <td ><hr style="border:0.5px solid #000"></td>
                </tr>
                <tbody id="tbodyId">
				</tbody>
            </table>
        <div style="height: 12px;" id="space1"></div>
       
        <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="ybk">
            <tr>
                <td height="36" colspan="1" style="border:0px" >
                    <!-- <div style="float: center; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-left: 200px;">优惠金额：<span id="yh">0</span>元</span>
                    </div> -->
                     <span style="margin-left: 0px;">优惠金额：<span id="yh">0</span>元</span>
                </td>
               <!--  <td height="36" colspan="1" style="border:0px" >
                    <div style="float: center; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-left: 200px;">优惠金额：<span id="yh">0</span>元</span>
                    </div>
                     <span style="margin-left: 0px;">优惠券抵扣：<span id="quanAmt">0</span>元</span>
                </td> -->
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

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                   <td height="30" style="padding: 8px;" colspan="3">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style = "margin-left: 0px;" id = "show"></span><br>
                      <span style = "margin-left: 100px;" id="makeMan">制单：</span>
                      <span style = "margin-left: 200px;">服务顾问签名：</span>
                      <span style = "margin-left: 300px;">客户签名：</span>
                  </td>
                 
            </tr>
        </table>
    </div>
	<script type="text/javascript">
		var url_one = null;
		var url_two = null;
		var url_three = null;
		var data = [];
		var phones = "";
		//尊敬的客户:以上报价在实际施工过程中可能略有小幅变动，最终价格以实际结算单为准
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
        
         function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }

        function SetData(data){
             var params = data.p;
            var imgUrl = params.currCompLogoPath || "";
            if(imgUrl && imgUrl != ""){
               $('#showImg').show();
               $("#showImg").attr("src",imgUrl);
            }
            
            var cardTime = data.row;
            var guestData = data.guestData;
            token1 =  params.token;
            webUrl = params.webUrl;
	        var date = new Date();
	        document.getElementById("spstorename").innerHTML = "计次卡结账单";
	       // document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
	       
	        document.getElementById("comp").innerHTML = params.comp||"";
	        document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + (format(date, "yyyy-MM-dd HH:mm")||"");
	        document.getElementById("openBank").innerHTML = document.getElementById("openBank").innerHTML + (params.bankName||"");
	        document.getElementById("bankNo").innerHTML = document.getElementById("bankNo").innerHTML + (params.bankAccountNumber||"");
	        document.getElementById("guestAddr").innerHTML = params.currCompAddress||"";
    		document.getElementById("phone").innerHTML = params.currCompTel||"";
    		document.getElementById("slogan1").innerHTML = params.currSlogan1||"";
    		document.getElementById("slogan2").innerHTML = params.currSlogan2||"";
    		document.getElementById("makeMan").innerHTML = "制单:" + (params.currUserName||"");
    		
    		document.getElementById("guestFullName").innerHTML = document.getElementById("guestFullName").innerHTML + (guestData.guestFullName||"");
	        document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + (guestData.mtAdvisor||"");
	        document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + (guestData.carNo||"");
    		
	        $.ajaxSettings.async = false;//设置为同步执行
	        var url = null;
	        url = "com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext?id=";
	        var tBody = $("#tbodyId");
	    	tBody.empty();
	        var tds = 
	    			"<td>[prdtName]</td>"+
	    			"<td align='center'>[times]</td>"+
	    			"<td align='center'>[sellAmt]</td>"+ 
	    			"<td align='center'>[totalAmt]</td>"; 
	    	var tr1 = $("<tr></tr>");
	    			tr1.append(
	    			  tds.replace("[prdtName]",cardTime.name)
	    				.replace("[times]",1)
	    				.replace("[sellAmt]",cardTime.sellAmt || 0)
	    				.replace("[totalAmt]",cardTime.totalAmt || 0));
	            tBody.append(tr1);		
        	$.post(params.baseUrl+url+cardTime.id+"&token="+params.token,{},function(text){//套餐
	        	    var data = {};//
	        	    data = text.timesCardDetail;
	        	    var prdtName = "";
	        	    if(data.length>0){
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    					prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+data[i].prdtName;
	    					var tr = $("<tr></tr>");
					    			tr.append(
					    			  tds.replace("[prdtName]",prdtName)
					    				.replace("[times]",data[i].times)
					    				.replace("[sellAmt]", "")
					    				.replace("[totalAmt]",""));
					            tBody.append(tr); 
	    				}
		        	}
        	});
        	var amt =  parseFloat(cardTime.totalAmt)-parseFloat(cardTime.sellAmt) + parseFloat(cardTime.deductionAmt);
        	amt = amt.toFixed(2);
        	document.getElementById("yh").innerHTML = amt;
        	/* document.getElementById("quanAmt").innerHTML = cardTime.deductionAmt ; */
        	var quanSellAmt = parseFloat(cardTime.sellAmt) - parseFloat(cardTime.deductionAmt);
        	quanSellAmt = quanSellAmt.toFixed(2);
        	var quanSellAmt = 
    		document.getElementById("cash1").innerHTML = quanSellAmt;			
    		var money = transform(quanSellAmt+""); 
			document.getElementById("money").innerHTML = money;
     }   	
        function box_setup_open() {
	        $(".boxbg").show();
	        $(".popbox").show();
    		document.getElementById("txtstorename").value = document.getElementById("comp").innerHTML;
    		//document.getElementById("txtaddress").value = document.getElementById("guestAddr").innerHTML;
    		//document.getElementById("txtphoneno").value = document.getElementById("phone").innerHTML;
    		if(document.getElementById("date").innerHTML.length > 16){
    			var value = document.getElementById("date").innerHTML.substring(0, document.getElementById("date").innerHTML.length-3);
    			document.getElementById("meeting").value = value.replace(" ","T");
    		}else{
    			document.getElementById("meeting").value = document.getElementById("date").innerHTML.replace(" ","T");
    		}
    	}
    	
    	function save(){
			box_setup_close();
    		document.getElementById("comp").innerHTML = document.getElementById("txtstorename").value;
    		document.getElementById("guestAddr").innerHTML = document.getElementById("txtaddress").value;
    		document.getElementById("phone").innerHTML = document.getElementById("txtphoneno").value;
			document.getElementById("date").innerHTML =  document.getElementById("meeting").value.replace("T"," ");
    	}
    	
    	function box_setup_close(){
    		$(".boxbg").hide();
        	$(".popbox").hide();
    	}
   var token1 =null; 
   var webUrl =null;
   function sendInfo(){
	nui.open({
		url: webUrl+"com.hsweb.crm.manage.sendInfo.flow?token="+token1,
		//url:"http://127.0.0.1:8080/default/com.hsweb.crm.manage.sendInfo.flow",
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