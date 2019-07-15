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
     <%-- <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script> --%>
	 <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
     <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>  
     <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>
      
     <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/mian.css" rel="stylesheet" type="text/css" />
     <link href="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/bill.css" rel="stylesheet" type="text/css" /> 
    
</head>
<body>
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

    <div class="print_btn">
        <a href="javascript:;" id="print" style="background:#ff6600;">打印</a><a href="javascript:box_setup_open()">修改</a>
    </div>
    <div class="printny">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="160">
                    <div class="fl">
                        <p style="font-size:30px; font-family:'黑体';"><span id="comp">测试店12</span></p>
                        <p style="font-size:18px; padding:2px 0 5px 0;"></p>
                        <p style="font-size:13px;">
                            地&nbsp;&nbsp;&nbsp;&nbsp;址：<span id="guestAddr">广东省东莞市市辖区长安镇新安街口麦 园工业区1号</span><!-- <span style="margin-left:30px;">邮编：650000</span> -->
                   <br> 
                    <br>        
                            电&nbsp;&nbsp;&nbsp;&nbsp;话：<span id="phone">131XXXXXX05</span><!-- <span style="margin-left:50px;">传真 Fax：</span> -->
                        </p>
                    </div>
                </td>
                <td width="60" valign="top">
                    <div class="fr" style="height:100px; display:flex; align-items:center;">
                           <!-- <img alt="" src="" id="showImg" height="60px" style="display:none"> -->
                           <img alt="" src="<%= request.getContextPath() %>/repair/imag/comp.png" id="showImg"  width="70" height="70" style="margin-bottom:10px;">
                    </div>
                </td>

            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
            <tr>
                <td width="50%" valign="bottom">
                    <p style="font-size:18px; line-height:140%;">
                        <span style="font-size:24px;" id="guestFullName">李XX</span><br /><br />
                        <span class="font16" id="mobile">13838XXXX138</span>
                     <br />
                    </p>
                </td>
                <td align="center" valign="top">
                    <div style="font-size:26px; font-family:'黑体';"><span id="spstorename">结算单</span></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                        <tr>
                            <td width="50%" height="24" align="center" bgcolor="#b4b4b4" colspan="2"><span class="hei">工单号</span></td>
                            <!-- <td width="50%" align="center" bgcolor="#b4b4b4"><span class="hei">服务编号</span> File No.</td> -->
                        </tr>
                        <tr>
                            <td height="24" align="center" colspan="2"><span id="serviceCode">ZHD10060119070400001</span></td>
                            <!-- <td align="center">235404</td> -->
                        </tr>
                        <tr>
                            <td height="24" align="center" bgcolor="#b4b4b4"><span class="hei">进厂时间</span> </td>
                            <td align="center" bgcolor="#b4b4b4"><strong><span class="hei">打印时间</span></strong></td>
                        </tr>
                        <tr>
                            <td height="24" align="center"><span id="enterDate">2019-07-04 16:35</span></td>
                            <td align="center"><span id="date">2019-07-13 11:46</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk" style="margin-top:15px;">
            <tr>
                <td width="33%" height="24" align="center" bgcolor="#b4b4b4"><span class="hei">车牌号</span></td>
                <td width="33%" align="center" bgcolor="#b4b4b4"><span class="hei">品牌车型</span></td>
                <td width="33%" align="center" bgcolor="#b4b4b4"><span class="hei">车架号(VIN)</span></td>
                
               <!--  <td width="25%" height="24" align="center" bgcolor="#b4b4b4"><span class="hei">发动机号</span> Engine No.</td>
                <td width="25%" align="center" bgcolor="#b4b4b4"><span class="hei">接待人员</span> Receptionist</td> -->
            </tr>
            <tr>
                <td  height="24" align="center"><span id="carNo">湘AXXXXX</span></td>
                <td align="center"><span id="carModel">上海大众 波罗</span></td>
                <td align="center"><span id="carVin">LSVFAXXXXXXXXXXXX</span></td>
                <!-- <td height="24" align="center">&nbsp;</td>
                <td align="center">&nbsp;</td> -->
            </tr>
            <tr>
                <td align="center" bgcolor="#b4b4b4"><span class="hei">里程数</span></td>
                <!-- <td align="center" bgcolor="#b4b4b4"><span class="hei">油量</span></td> -->
                <td height="24" align="center" bgcolor="#b4b4b4"><span class="hei">油量</span></td>
                <td align="center" bgcolor="#b4b4b4"><span class="hei">服务顾问</span></td>
            </tr>
            <tr>
                <td align="center"><span id="enterKilometers">10000</span></td>
                <!-- <td align="center">&nbsp;</td> -->
                <td height="24" align="center"><span id="enterOilMass">3/4</span></td>
                <td align="center"><span id="mtAdvisor">宜XX</span></td>
            </tr>
        </table>

        <div class="byzmx">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                    <tr>
                        <th width="40" height="40"><span class="hei">序号</span></th>
                        <!-- <th width="110" align="left">&nbsp;<span class="hei">编码</span></th> -->
                        <th align="left">
                            &nbsp;<span class="hei">项目名称(包含套餐)</span><br />
                        </th>
                        <th width="70" align="right"><span class="hei">工时/数量</span>&nbsp;</th>
                        <th width="60" align="right"><span class="hei">单价</span>&nbsp;</th>
                        <th width="66" align="right"><span class="hei">金额</span>&nbsp;</th>
                        <th width="70" align="right"><span class="hei">优惠率</span>&nbsp;</th>
                        <th width="70" align="right"><span class="hei">小计</span>&nbsp;</th>
                    </tr>
                </thead>
                <tbody id="tbodyId">
                 <tr>
                    <td align="center"  height="24">1</td> 
					<td>工时名称1</td>
					<td align='center'>1</td>
					<td align='center'>100</td>
					<td align='center'>100</td>
					<td align='center'>10%</td>
					<td align='center'>90</td>
                </tr>
                <tr>
                    <td align="center">1.1</td> 
					<td>配件名称1</td>
					<td align='center'>1</td>
					<td align='center'>300</td>
					<td align='center'>300</td>
					<td align='center'>5%</td>
					<td align='center'>285</td>
                </tr>
                <tr>
                    <td align="center">1.2</td> 
					<td>配件名称2</td>
					<td align='center'>2</td>
					<td align='center'>100</td>
					<td align='center'>200</td>
					<td align='center'>0</td>
					<td align='center'>200</td>
                </tr>
                <tr>
                    <td align="center"><hr style= 'border:1px dashed #000' /></td> 
					<td><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
                </tr>
               <tr>
                    <td align="center">2</td> 
					<td>工时名称2</td>
					<td align='center'>2</td>
					<td align='center'>60</td>
					<td align='center'>120</td>
					<td align='center'>0</td>
					<td align='center'>120</td>
                </tr>
                <tr>
                    <td align="center">2.1</td> 
					<td>配件名称2</td>
					<td align='center'>1</td>
					<td align='center'>200</td>
					<td align='center'>200</td>
					<td align='center'>10%</td>
					<td align='center'>180</td>
                </tr>
                <tr>
                    <td align="center"><hr style= 'border:1px dashed #000' /></td> 
					<td><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
					<td align='center'><hr style= 'border:1px dashed #000' /></td>
                </tr>
                <tr>
                    <td align="center">3</td> 
					<td>套餐名称1</td>
					<td align='center'>1</td>
					<td align='center'>360</td>
					<td align='center'>360</td>
					<td align='center'>45.00%</td>
					<td align='center'>198</td>
                </tr>
                <tr>
                    <td align="center">3.1</td> 
					<td>工时名称1</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
                <tr>
                    <td align="center">3.2</td> 
					<td>配件名称1</td>
					<td align='center'>1</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
					<td align='center'>&nbsp;</td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="hctable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                     <td align="left" >
                       <!--  <p style="text-align:left; min-height:40px; padding:5px; border-bottom:1px #000 solid; margin-bottom:5px;">
                                                    出车报告：出车报告内容，出车报告内容出车报告内容</p> -->
                         出车报告：<span id="drawOutReport">这是出车报告详情</span>
                    </td>
                    <!-- <td valign="top" width="150">
                        <div class="byh1">
                            <p class="hei" style="font-size:14px; margin-bottom:6px;">支付方式 Payment</p>
                            <p><font></font>现金 Cash</p>
                            <p><font></font>支票 Cheque</p>
                            <p><font></font>信用卡 CreditCard</p>
                        </div>
                    </td> -->
                   <td width="80">
                        &nbsp;套餐 :<br />
                        &nbsp;工时:<br />
                        &nbsp;配件:<br />
                        &nbsp;其他费用 :<br />
                        &nbsp;其他优惠:<br />
                    </td>
                    <td width="80" align="right">
                        <span id="prdt">198.00</span>&nbsp;<br />
                        <span id="item">210.00</span>&nbsp;<br />
                        <span id="part">665.00</span>&nbsp;<br />
                        <span id="expense">0.00</span>&nbsp;<br />
                        <span id="expRateAmt">0.00</span>&nbsp;<br />
                    </td>
                    <td width="100">
                        &nbsp;项目优惠率 :<br />
                        &nbsp;项目优惠金额:<br />
                        &nbsp;配件优惠率 :<br />
                        &nbsp;配件优惠金额:<br />
                    </td>
                    <td width="80" align="right">
                        <span id="itemRate">4.55</span>%&nbsp;<br />
                        <span id="itemAmt">10.00</span>&nbsp;<br />
                        <span id="partRate">5.00</span>%&nbsp;<br />
                        <span id="partAmt">35.00</span>&nbsp;<br />
                    </td>
                </tr>
                <tr>
                  <td colspan="5" style="height:40px;width:500px "  >
                  <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <font style="font-size: 13px; font-weight: bold;">
                                 优惠金额：<span id="yh">207.00</span>元
              
                &nbsp;&nbsp;&nbsp;结算金额：<span id="cash1">1073</span>元
                            </font>
                        </span>
                        <font style="font-size: 13px; font-weight: bold;">
                                                            大写：<span id="money" style="margin-right: 0px;">壹仟零柒拾叁元</span>
                        </font>
                    </div>
                  </td>
                </tr>
            </table>
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
            <tr>
                <td width="60" height="40" style="padding-left:5px; line-height:150%;">
                    <span class="hei">客户签字：</span>
                </td>
                <td><div style="width:70%; height:30px; border-bottom:1px #000 solid;"></div></td>
                <td width="90"><span class="hei">维修顾问签字：</span></td>
                <td><div style="width:70%; height:30px; border-bottom:1px #000 solid;"></div></td>
                <td width="90"><span class="hei">收银员签字：</span></td>
                <td width="15%"><div style="width:100%; height:30px; border-bottom:1px #000 solid; float:right"></div></td>
            </tr>
        </table>
    </div>
</body>
</html>
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
        //com.hsapi.repair.repairService.svr.billqyeryMaintainList
         function getSubtotal(p){//更新套餐工时配件合计金额
            var params = p;
        	if(params.name != "结账单"){
        	    
        	   var money = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(document.getElementById("item").innerHTML) + parseFloat(document.getElementById("part").innerHTML);
        	   var expenseAmt = parseFloat(document.getElementById("expense").innerHTML);
        	   /* if(params.type && params.type==1){
    		       money = parseFloat(money) + parseFloat(expenseAmt);      
    		    } */
    		     money = parseFloat(money) + parseFloat(expenseAmt); 
        	  // document.getElementById("cash").innerHTML = money;
        	   document.getElementById("cash1").innerHTML = money;
        	   money = transform(money+"");
    		   document.getElementById("money").innerHTML = money;
    		   document.getElementById("cash1").innerHTML = parseFloat(document.getElementById("cash1").innerHTML).toFixed(2);
        	}
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
        
</script>