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
            font-size: 13px;
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
 <div class="popbox" style="height:420px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2>
        <div style="padding-top:15px; margin:0 15px;">
            <table  width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" width="90" height="46">单据编号：</td>
                        <td><input type="text" id="txtno" class="peijianss" value="" /></td>
                    </tr>
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
                        <td class="color999" height="46">进厂时间：</td>
                        <td><input id="updateEnterDate" type="datetime-local" value=""/></td>
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
       <!--  <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
        <a plain="true" iconCls="" plain="false" onclick="sendInfo()" id = "sendInfo">发送短信</a>
        <a style="" plain="true" iconCls="" plain="false" onclick="sendWechatInfo()" id = "openId">发送微信</a> -->
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
	                        <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp">测试12店</span></div>
	                    </td>
	                    <td rowspan="2" style="">
	                        <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename">结算单</span></b></div>
	                        <div style="padding-top: 2px; font-size: 13px;font-family: Arial;">
	                          №:<span id="serviceCode">ZHD10060119070400001</span>  
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
        
        <!-- <div style="border-bottom: 1px #333 solid; height: 2px; margin-bottom: 10px;">&nbsp;</div> -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td style="font-size:8px;" >地址：<span id="guestAddr">广东省东莞市市辖区长安镇新安街口麦 园工业区1号</span></td>
                <td style="font-size:8px;">开户银行：<span id="openBank">招商银行</span></td>
                <td style="font-size:8px;">打印时间：<span id="date">2019-07-13 11:46</span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="phone">131XXXX2505</span></td>
                <td style="font-size:8px;" >银行账号：<span id="bankNo">8888888888888888</span></td>
             	<td style="font-size:8px;">进厂时间：<span id="enterDate">2019-07-04 16:35</span></td>
            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td height="24" width="20%" id="guestFullName">&nbsp;客户名称：李XX</td>
                    <td height="24" width="28%" id="contactName">&nbsp;联系人名称：李XX<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13838XXXX138</td>
                    <td width="18%" id="mtAdvisor">&nbsp;服务顾问：宜XX</td>
                    <td width="32%">&nbsp;进厂里程：<span id="enterKilometers">10000</span>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;油量：<span id="enterOilMass">3/4</span></td>
                </tr>
                <tr>
                    <td height="24" id="carNo">&nbsp;车牌号：湘AXXXXX</td>
                    <td id="carModel">&nbsp;品牌车型：上海大众 波罗 </td>
                    <td id="carVin" colspan="2">&nbsp;车架号(VIN)：LSVFAXXXXXXXXXXXX</td>
                </tr>
                <tr>
                    
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPkg">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;"></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"style="font-family: 华文中宋; font-size:13px;font-weight: bold;">
套餐项目(含工时配件)</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">数量</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">单价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">金额</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">优惠率</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">小计</td>
                    
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
                <tr>
                    <td align="center">1</td> 
					<td>套餐名称1</td>
					<td align='center'>1</td>
					<td align='center'>360</td>
					<td align='center'>360</td>
					<td align='center'>45.00%</td>
					<td align='center'>198</td>
                </tr>
                <tr>
                    <td align="center">&nbsp;</td> 
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工时名称1</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
                <tr>
                    <td align="center">&nbsp;</td> 
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;配件名称1</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
				</tbody>
            </table>
        <div style="height: 12px;" id="space1"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showItem">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;"></td>
                    <td height="28" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">项目名称</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">工时/数量</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">单价</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">金额</td>
                    <td width="70" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">优惠率</td>
                    <td width="80" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:13px;font-weight: bold;">小计</td>
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
                <tbody id="tbodyId2">
                   <tr>
                    <td align="center">1</td> 
					<td>工时名称1</td>
					<td align='center'>1</td>
					<td align='center'>100</td>
					<td align='center'>100</td>
					<td align='center'>10%</td>
					<td align='center'>90</td>
                </tr>
                <tr>
                    <td align="center">&nbsp;</td> 
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;配件名称1</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
                <tr>
                    <td align="center">&nbsp;</td> 
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;配件名称2</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
				</tbody>
            </table>
        <div style="height: 12px;" id="space2"></div>
        <table width="100%" border="0"  cellpadding="0" cellspacing="0"  class="ybk1">
            <tr>
                <td height="36" colspan="1" style="border:0px solid #DDD;padding: 8px;" rowspan="1" colspan="1" >
                   <!--  <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                                                             
                    </div> -->
                       套餐：<span id="prdt">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;工时：<span id="item">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0.00</span>
               &nbsp;&nbsp;&nbsp;&nbsp;其他费用：<span id="expense">0.00</span>&nbsp;&nbsp;&nbsp;&nbsp;其他优惠：<span id="expRateAmt">0.00</span>
                </td>
             </tr>
             <tr>
                <td height="36" colspan="1" style="border:0px solid #DDD;padding: 8px;" rowspan="1" colspan="1" >
                  
                      <span> 项目优惠率：<span id="itemRate">0.00</span>%</span>
                      <span>&nbsp;&nbsp;&nbsp;&nbsp;项目优惠金额：<span id="itemAmt">0.00</span>元</span>
                      <span>&nbsp;&nbsp;&nbsp;&nbsp; 配件优惠率：<span id="partRate">0.00</span>%</span>
                     <span>&nbsp;&nbsp;&nbsp;&nbsp;配件优惠金额：<span id="partAmt">0.00</span>元</span>
                       
                </td>
             </tr>
             <tr>    
                <td height="36" colspan="2" style="border:0px;font-family: Arial; font-size:16px;font-weight: bold;">
                    <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <font style="font-size: 13px; font-weight: bold;">
                                 优惠金额：<span id="yh">0.00</span>元
              
                &nbsp;&nbsp;&nbsp;结算金额：<span id="cash1"></span>元
                            </font>
                        </span>
                        <font style="font-size: 13px; font-weight: bold;">
                                                            大写：<span id="money" style="margin-right: 0px;"></span>
                        </font>
                    </div>
                </td>
            </tr>
        </table> 
        <div style="height: 12px;" id="space3"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                    <td height="100" valign="top" style="padding: 8px;" id="drawOutReport" colspan="3">
                                                       出车报告：
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding: 8px;" id="guestDesc">
                                                       客户描述：
                    </td>
                      <td height="50" valign="top" style="padding: 8px;" id="faultPhen">
                                                       故障现象：
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="solveMethod">
                                                       解决措施：
                    </td>
                </tr>
                <tr>
                   <td height="30" style="padding: 8px;" colspan="3">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style = "margin-left: 0px;" id = "show"></span><br>
                      <span style = "margin-left: 0px;" id="makeMan">制单：</span><span style = "margin-left: 100px;">服务顾问签名：</span><span style = "margin-left: 110px;">客户签名：</span>
                  </td>
                 
            </tr>
        </table>
    </div>
	<script type="text/javascript">
		var url_one = null;
		var url_two = null;
		var url_three = null;
		//var data = [];
		var itemAmt = 0;
		var itemSubtotal = 0;
		var partAmt = 0;
		var partSubtotal = 0;
		var enterDate = null;
		var weChatData = {};
		var wechatOpenId = null;
		var infoData = {};
		var sendY = 1;
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
        
        function box_setup_open() {
	        $(".boxbg").show();
	        $(".popbox").show();
	        document.getElementById("txtno").value = document.getElementById("serviceCode").innerHTML;
    		document.getElementById("txtstorename").value = document.getElementById("comp").innerHTML;
    		document.getElementById("txtaddress").value = document.getElementById("guestAddr").innerHTML;
    		document.getElementById("txtphoneno").value = document.getElementById("phone").innerHTML;
    		if(document.getElementById("date").innerHTML.length > 16){
    			var value = document.getElementById("date").innerHTML.substring(0, document.getElementById("date").innerHTML.length-3);
    			document.getElementById("meeting").value = value.replace(" ","T");
    		}else{
    			document.getElementById("meeting").value = document.getElementById("date").innerHTML.replace(" ","T");
    		}
    		if(enterDate > 16){
    			var value = enterDate.substring(0, enterDate-3);
    			document.getElementById("updateEnterDate").value = value.replace(" ","T");
    		}else{
    			document.getElementById("updateEnterDate").value = enterDate.replace(" ","T");
    		}
    	}
    	
    	function save(){
			box_setup_close();
    		document.getElementById("serviceCode").innerHTML = document.getElementById("txtno").value;
    		document.getElementById("comp").innerHTML = document.getElementById("txtstorename").value;
    		var txtaddress = document.getElementById("txtaddress").value;
    		if(txtaddress != null && txtaddress != ""){
    		    document.getElementById("guestAddr").innerHTML = txtaddress;
    		}
    		var txtphoneno = document.getElementById("txtphoneno").value;
    		if(txtphoneno != null && txtphoneno != ""){
    		    document.getElementById("phone").innerHTML = txtphoneno;
    		}
			document.getElementById("date").innerHTML =  document.getElementById("meeting").value.replace("T"," ");
            document.getElementById("enterDate").innerHTML = document.getElementById("updateEnterDate").value.replace("T"," ");
    	}
    	
    	function box_setup_close(){
    		$(".boxbg").hide();
        	$(".popbox").hide();
    	}
   var token1 =null; 
   var webUrl =null;
   function sendInfo(){
     if(sendY){
         nui.open({
		 url: webUrl+"com.hsweb.crm.manage.sendInfo.flow?token="+token1,
		 //url:"http://127.0.0.1:8080/default/com.hsweb.crm.manage.sendInfo.flow",
		 title: "发送短信", width: 655, height: 386,
		 onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(infoData);
		 },
		 ondestroy: function (action) {
            //重新加载
            //query(tab);
         }
        });
    }else{
        return;
    }
	
  }
  
  function sendWechatInfo(){
       if(wechatOpenId == "" || wechatOpenId == null){
	       return; 
	    }else{
	      var url = "com.hsapi.repair.repairService.sendWeChat.sendBillCostInfo.biz.ext?serviceId=";
           $.post(weChatData.baseUrl+url+weChatData.serviceId+"&token="+weChatData.token,{},function(text){//套餐
        	if(text.errCode == "S"){
        	  alert("发送微信成功!"); 
    	    }else{
    	      alert("发送微信失败!");
    	    }
          }); 
	  } 
  }
    	
    	
    </script>
</body>
</html>