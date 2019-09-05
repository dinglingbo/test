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
 <div class="popbox" style="height:450px; width:480px; margin:-210px 0 0 -240px; display:none">
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
                    <tr>
                        <td class="color999" height="46">结算时间：</td>
                        <td><input id="updateOutDate" type="datetime-local" value=""/></td>
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
                        <p style="font-size:30px; font-family:'黑体';"><span id="comp"></span></p>
                        <p style="font-size:18px; padding:2px 0 5px 0;"></p>
                        <p style="font-size:13px;">
                            地&nbsp;&nbsp;&nbsp;&nbsp;址：<span id="guestAddr"></span><!-- <span style="margin-left:30px;">邮编：650000</span> -->
                   <br> 
                    <br>        
                            电&nbsp;&nbsp;&nbsp;&nbsp;话：<span id="phone"></span><!-- <span style="margin-left:50px;">传真 Fax：</span> -->
                        </p>
                    </div>
                </td>
                <td width="60" valign="top">
                    <div class="fr" style="height:100px; display:flex; align-items:center;">
                           <!-- <img alt="" src="" id="showImg" height="60px" style="display:none"> -->
                           <img alt="" src="" id="showImg"  width="70" height="70" style="margin-bottom:10px;display:none">
                    </div>
                </td>

            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:15px;">
            <tr>
                <td width="50%" valign="bottom">
                    <p style="font-size:18px; line-height:140%;">
                        <span style="font-size:24px;" id="guestFullName"></span><br /><br />
                        <span class="font16" id="mobile"></span>
                     <br />
                    </p>
                </td>
                <td align="center" valign="top">
                    <div style="font-size:26px; font-family:'黑体';"><span id="spstorename"></span></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                        <tr>
                            <td width="50%" height="24" align="center" bgcolor="#b4b4b4" colspan="1"><span class="hei">工单号</span></td>
                            <td width="50%" align="center" bgcolor="#b4b4b4"><span class="hei">结算时间</span></td>
                        </tr>
                        <tr>
                            <td height="24" align="center" colspan="1"><span id="serviceCode"></span></td>
                            <td align="center"><span id="outDate"></span></td>
                            <!-- <td align="center">235404</td> -->
                        </tr>
                        <tr>
                            <td height="24" align="center" bgcolor="#b4b4b4"><span class="hei">进厂时间</span> </td>
                            <td align="center" bgcolor="#b4b4b4"><strong><span class="hei">打印时间</span></strong></td>
                        </tr>
                        <tr>
                            <td height="24" align="center"><span id="enterDate"></span></td>
                            <td align="center"><span id="date"></span></td>
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
                <td  height="24" align="center"><span id="carNo"></span></td>
                <td align="center"><span id="carModel"></span></td>
                <td align="center"><span id="carVin"></span></td>
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
                <td align="center"><span id="enterKilometers"></span></td>
                <!-- <td align="center">&nbsp;</td> -->
                <td height="24" align="center"><span id="enterOilMass"></span></td>
                <td align="center"><span id="mtAdvisor"></span></td>
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
                 <!--    <tr>
                        <td height="24" align="center">1</td>
                        <td>&nbsp;</td>
                        <td>工时1</td>
                        <td align="right">50.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">50.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">1.1</td>
                        <td>PJ025544100</td>
                        <td>(品牌名) 配件1</td>
                        <td align="right">20.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">20.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">1.2</td>
                        <td>PJ025544142</td>
                        <td>(品牌名) 配件2</td>
                        <td align="right">30.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">30.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">1.3</td>
                        <td>PJ025544104</td>
                        <td>(品牌名) 配件3</td>
                        <td align="right">200.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">200.00&nbsp;</td>
                    </tr>
                    <tr class="xj">
                        <td height="24" align="center">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="right">小计&nbsp;</td>
                        <td align="right">300.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="24" align="center">2</td>
                        <td>&nbsp;</td>
                        <td>工时2</td>
                        <td align="right">50.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">50.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">2.1</td>
                        <td>PJ025544100</td>
                        <td>(品牌名) 配件1</td>
                        <td align="right">100.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">100.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">2.2</td>
                        <td>PJ025544142</td>
                        <td>(品牌名) 配件2</td>
                        <td align="right">200.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">200.00&nbsp;</td>
                    </tr>
                    <tr>
                        <td height="18" align="center">2.3</td>
                        <td>PJ025544104</td>
                        <td>(品牌名) 配件3</td>
                        <td align="right">50.00&nbsp;</td>
                        <td align="right">1&nbsp;</td>
                        <td align="right">100%&nbsp;</td>
                        <td align="right">50.00&nbsp;</td>
                    </tr>
                    <tr class="xj">
                        <td height="24" align="center">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="right">小计&nbsp;</td>
                        <td align="right">400.00&nbsp;</td>
                    </tr> --> 
                </tbody>
            </table>
        </div>
        <div class="hctable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                     <td align="left" >
                       <!--  <p style="text-align:left; min-height:40px; padding:5px; border-bottom:1px #000 solid; margin-bottom:5px;">
                                                    出车报告：出车报告内容，出车报告内容出车报告内容</p> -->
                         出车报告：<span id="drawOutReport"></span>
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
                        <span id="prdt">0.00</span>&nbsp;<br />
                        <span id="item">0.00</span>&nbsp;<br />
                        <span id="part">0.00</span>&nbsp;<br />
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
                        <span id="itemRate">0.00</span>%&nbsp;<br />
                        <span id="itemAmt">0.00</span>&nbsp;<br />
                        <span id="partRate">0.00</span>%&nbsp;<br />
                        <span id="partAmt">0.00</span>&nbsp;<br />
                    </td>
                </tr>
                <tr>
                  <td colspan="5" style="height:40px;width:500px "  >
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
		var outDate = null;
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
        
          function SetData(params){
            weChatData = params;
            var currRepairBillMobileFlag = params.currRepairBillMobileFlag || ""; 
            var imgUrl = params.currCompLogoPath || "";
            if(imgUrl && imgUrl != ""){
               $('#showImg').show();
               $("#showImg").attr("src",imgUrl);
            }
            token1 =  params.token;
            webUrl = params.webUrl;
	        var date = new Date();
	        if(params.name){
	        	document.getElementById("spstorename").innerHTML = params.name;
	        	//维修结算单没有这段话
	        	if(params.name == "结账单"){
	        	   document.getElementById("spstorename").innerHTML = "结账单";
	        	   //document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
	        	}else if(params.name == "报价单"){
	        	   //$("#enterDate").hide();
	        	   document.getElementById("spstorename").innerHTML = "报价单";
	        	  // document.getElementById("show").innerHTML = params.currRepairEntrustPrintContent||"";
	        	}
	        }else{
		        if(params.printName){
			        if(params.printName == "结账单"){
		        	   document.getElementById("spstorename").innerHTML = "结账单";
		        	  // document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
		        	}else if(params.printName == "报价单"){
		        	   document.getElementById("spstorename").innerHTML = "报价单";
		        	  // document.getElementById("show").innerHTML = params.currRepairEntrustPrintContent||"";
		        	}
		        }
	           
	        }
	      
	        document.getElementById("comp").innerHTML = params.comp;
	        document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	        //document.getElementById("pdate").innerHTML = document.getElementById("pdate").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	        
	      //  document.getElementById("openBank").innerHTML = params.bankName;
	      //  document.getElementById("bankNo").innerHTML = params.bankAccountNumber;
	        
	        document.getElementById("guestAddr").innerHTML = params.currCompAddress;
    		document.getElementById("phone").innerHTML = params.currCompTel;
    		//document.getElementById("slogan1").innerHTML = params.currSlogan1;
    		//document.getElementById("slogan2").innerHTML = params.currSlogan2;
    		//document.getElementById("makeMan").innerHTML="制单:" + params.currUserName;
	        $.ajaxSettings.async = false;//设置为同步执行
	        var url = null;
	        if(params.type){
	        	url = "com.hsapi.repair.repairService.svr.billqyeryMaintainList.biz.ext?rid=";
	        	//document.getElementById("sendInfo").style.background="#999999";
	        	sendY = 0;
	        }else{
	        	url = "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid=";
	        	sendY = 1;
	        }
	       /*  var dictids= ['DDT20130703000051'];
	        
	         $.post(params.sysUrl+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+params.token,{},function(text){
    		    if(text.data){
    		      data = text.data;
    		    }
	         }); */
	        $.post(params.baseUrl+url+params.serviceId+"&token="+params.token,{},function(text){
	        	if(text.list.length > 0){
	        	   
	        		var list = text.list[0];
	        		var mobile = null;
	        		if(params.type){
	        		    mobile = list.contactorTel || "";
	        		}else{
	        		    mobile = list.contactMobile || "";
	        		}
	        		
	        		var carNo = list.carNo || "";
	        		var carVin = list.carVin || "";
	        		var carId = list.carId;
	        		var contactName = list.contactName;
	        		infoData.mobile = mobile;
	        		infoData.carNo = carNo;
	        		infoData.carId = carId;
	        		infoData.guestId = list.contactorId;
	        		infoData.serviceType = 11;
	        		infoData.mainId = params.serviceId;
	        		enterDate = list.enterDate || "";
	        		outDate = list.outDate || "";
	        		wechatOpenId = list.openId || "";
	        		/* if(wechatOpenId == "" || wechatOpenId == null){
	        		    document.getElementById("openId").style.background="#999999"; 
	        		}
	        		var drawOutReport = list.drawOutReport || "";
	        		if(drawOutReport != ""){
	        		     document.getElementById("drawOutReport").innerHTML = document.getElementById("drawOutReport").innerHTML + drawOutReport;
	        		     
	        		}else{
	        		  	  $("#drawOutReport").hide();
	        		} */
	        		var drawOutReport = list.drawOutReport || "";
	        		 document.getElementById("drawOutReport").innerHTML = document.getElementById("drawOutReport").innerHTML + drawOutReport;
	        		if(enterDate){
	        			enterDate = enterDate.replace(/-/g,"/");
	        			enterDate = new Date(enterDate);
	        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm");
	        		}else{
	        		  enterDate='';
	        		}
	        		if(outDate){
	        			outDate = outDate.replace(/-/g,"/");
	        			outDate = new Date(outDate);
	        			outDate = format(outDate, "yyyy-MM-dd HH:mm");
	        		}else{
	        		  outDate=''
	        		}
	        		var guestFullName = list.guestFullName || "";
	        		var guestMobile = list.guestMobile || "";
	        		var contactMobile = list.contactMobile;
	        		var enterOilMass = list.enterOilMass || "0";
	        		var name = "0";
	        		//查找油量http://127.0.0.1:8080/default/
	        		/* for(var i = 0;i<data.length;i++){
	        		        if(data[i].customid == enterOilMass){
	        		           name = data[i].name;
	        		           break;
	        		        }
	        		} */
	        		var enterKilometers = list.enterKilometers || "0";
	        		var mtAdvisor = list.mtAdvisor || "";
	        		var planFinishDate = list.planFinishDate || "";
	        		if(planFinishDate){
	        			planFinishDate = planFinishDate.replace(/-/g,"/");
	        			planFinishDate = new Date(planFinishDate);
	        			planFinishDate = format(planFinishDate, "yyyy-MM-dd HH:mm");
	        		}
	        		var serviceCode = list.serviceCode || "";
	        		var guestDesc = list.guestDesc || "";
	        		if(text.car){
	        		    var carM = text.car.carModel || "";
	        		    var carModel = list.carModel || carM || "";
	        		}else{
	        		    var carModel = list.carModel || "";
	        		}
	        		var faultPhen = list.faultPhen || "";
	        		var solveMethod = list.solveMethod || "";
	        		var guestAddr = list.guestAddr || "";
	        		if(params.type){
	        			guestFullName = list.guestName || "";
	        			guestMobile = list.guestTel || "";
	        			contactMobile = list.contactorTel || "";
	        			carNo = list.carNo || "";
	        			contactName = list.contactorName || "";
	        			mtAdvisor = list.mtAdvisor || "";
	        		}
	        		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
	        		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + carNo;
	        		document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
	        		document.getElementById("enterDate").innerHTML = enterDate;
	        		document.getElementById("outDate").innerHTML = outDate;
	        		document.getElementById("guestFullName").innerHTML = document.getElementById("guestFullName").innerHTML + guestFullName;
	        	//	document.getElementById("contactName").innerHTML = document.getElementById("contactName").innerHTML + contactName;
	        		
	        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
	        		document.getElementById("enterOilMass").innerHTML = document.getElementById("enterOilMass").innerHTML + enterOilMass;
	        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
	        		//document.getElementById("guestDesc").innerHTML = document.getElementById("guestDesc").innerHTML + guestDesc; 
	        		document.getElementById("carModel").innerHTML = document.getElementById("carModel").innerHTML + carModel; 
	        		//document.getElementById("faultPhen").innerHTML = document.getElementById("faultPhen").innerHTML + faultPhen; 
	        		//document.getElementById("solveMethod").innerHTML = document.getElementById("solveMethod").innerHTML + solveMethod; 
	        		//document.getElementById("guestAddr").innerHTML = document.getElementById("guestAddr").innerHTML + guestAddr;
	        		//document.getElementById("name").innerHTML = document.getElementById("name").innerHTML + mtAdvisor; 
	        	    /* if(currRepairBillMobileFlag==1){
	        	        document.getElementById("contactName").innerHTML = document.getElementById("contactName").innerHTML + 
	        	        "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ contactMobile;
	        	    } */
	        	    if(currRepairBillMobileFlag==1){
	        	       document.getElementById("mobile").innerHTML = document.getElementById("mobile").innerHTML + mobile;
	        	    } 
	        	    if(params.type){
	        	      document.getElementById("outDate").innerHTML = format(date, "yyyy-MM-dd HH:mm");
	        	      outDate = format(date, "yyyy-MM-dd HH:mm");
	                }
	        	}
        	});
        	
        	var tBody = $("#tbodyId");
	        tBody.empty();
        	var tds = '<td align="center">[id]</td>' +
		    			"<td>[prdtName]</td>"+
		    			"<td align='center'>[qty]</td>"+
		    			"<td align='center'>[unitPrice]</td>"+ 
		    			"<td align='center'>[amt]</td>"+ 
		    			"<td align='center'>[rate]</td>"+
		    			"<td align='center'>[subtotal]</td>";
        	if(params.type){
        		url_two = "com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext?serviceId=";
        	}else{
        		url_two = "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId=";
        	}
        	 var index = 0;//记录有多少个项目
        	 $.post(params.baseUrl+url_two+params.serviceId+"&token="+params.token,{},function(text){//工时
        	   
	        	if(text.errCode == "S"){
	        	    var data = {};
	        	    if(params.type){
	        	       data = text.itemBill;
	        	    }else{
	        	       data = text.data;
	        	    }
	        	    if(data.length>0){
	        	      /*   var tBody = $("#tbodyId2");
    				tBody.empty(); */
    				
    				for(var i = 0 , l = data.length ; i < l ; i++){
    				    if(params.name != "结账单"){
    				        document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
    				    }
    					var rate = data[i].rate;
    					rate = rate + "%";
    					var tr = $("<tr></tr>");
    					var itemTime = null;
    					var itemName = null;
    					if(params.type){
    						 itemTime = data[i].itemTime || 0;
    						 itemName = data[i].itemName || "";
    						 if(data[i].billItemId != 0 ){
    						   itemName = "&nbsp;&nbsp;&nbsp;&nbsp;" + itemName;
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					      }else{
    						     document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    					      }
    					}else{
    						itemTime = data[i].qty || "";
    						itemName = data[i].prdtName || "";
    						if(data[i].pid != 0 ){
    						   //itemName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + itemName;
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					    }else{
    						   document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    					   }
    					}
    					if(data[i].billItemId == 0){
    					   index = data[i].orderIndex;
    					   itemAmt = itemAmt + data[i].amt;
    					   itemSubtotal = itemSubtotal + data[i].subtotal;
    					   if(i != 0){
    							var tr = $("<tr></tr>");
	    						tr.append(
				    				tds.replace("[id]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[qty]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[unitPrice]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
				    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
	    						tBody.append(tr);
    					  }
    					  index = index + 1;
    					}else{
    					   partAmt = partAmt + data[i].amt;
    					   partSubtotal = partSubtotal + data[i].subtotal;
    					}
    					       var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[id]",data[i].orderIndex)
				    				.replace("[prdtName]",itemName)
				    				.replace("[qty]",itemTime)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[amt]",data[i].amt)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr);
				    	getSubtotal(params);		
    				}
    				  if(params.name != "结账单"){
    				      document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML).toFixed(2);
    				   }
    				   
    				    document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML).toFixed(2);
	    				document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML).toFixed(2);
	        	        if(itemAmt>0){
	        	           var ramt = itemAmt - itemSubtotal;
	        	           var rate = 0;
	        	           if(ramt>0){
	        	             rate  = ramt/itemAmt;
	        	             rate = rate * 100;
	        	             rate = rate.toFixed(2);
	        	             document.getElementById("itemRate").innerHTML =  rate;
	        	           }
	        	           ramt = ramt.toFixed(2);
	        	           document.getElementById("itemAmt").innerHTML = ramt;
	        	           
	        	        }
	        	        if(partAmt>0){
	        	           var ramt = partAmt - partSubtotal;
	        	           var rate = 0;
	        	           if(ramt>0){
	        	             rate  = ramt/partAmt;
	        	             rate = rate * 100;
	        	             rate = rate.toFixed(2);
	        	             document.getElementById("partRate").innerHTML =  rate;
	        	           }
	        	           ramt = ramt.toFixed(2);
	        	           document.getElementById("partAmt").innerHTML = ramt;
	        	        }
	        	    }
	        	}
        	});
        	
        	if(params.type){
        		url_one = "com.hsapi.repair.baseData.query.searchExpensePkgBill.biz.ext?serviceId=";
        	}else{
        		url_one = "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext?serviceId=";
        	}
        	$.post(params.baseUrl+url_one+params.serviceId+"&token="+params.token,{},function(text){//套餐
	        	if(text.errCode == "S"){
	        	    var data = {};
	        	    if(params.type){
	    			   data = text.pkgBill;
	    			}else{
	    			    data = text.data;
	    			}
	        	    if(data.length>0){
	    				/* var tds = '<td align="center">[orderIndex]</td>' +
						    			"<td>[prdtName]</td>"+
						    			"<td align='center'>[qty]</td>"+
						    			"<td align='center'>[uintPrice]</td>"+ 
						    			"<td align='center'>[amt]</td>"+ 
						    			"<td align='center'>[rate]</td>"+
						    			"<td align='center'>[subtotal]</td>"; */
	    				
	    				var j = 0;//记录套餐下的配件项目个数
	    				var currIndex = 0;//记录当前套餐是第几个
	    				var orderIndex = '';
	    				var discountAmt = 0;
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    				    if(params.name != "结账单"){
	    				       //document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
	    				       if(data[i].billPackageId == 0){//只计算套餐的优惠
	    				           document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
	    				      }
	    				    }
	    					var prdtName = data[i].prdtName;
	    					if(params.type){
	    						prdtName = data[i].packageName || "";
	    					}
	    					//var orderIndex = data[i].orderIndex;
	    					var rate = data[i].rate;
	    					rate = rate + "%";
	    					if(data[i].billPackageId != 0){
	    						//prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	    						//orderIndex = "";
	    						j = j + 1;
	    						orderIndex = currIndex + "." + j;
	    					}else{
	    						/* if(params.type){
	    							j++;
	    							orderIndex = j;
	    						} */
	    						document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(data[i].subtotal);
	    					}
	    					if(data[i].billPackageId == 0){
	    						if(index != 0){
	    							var tr = $("<tr></tr>");
					    				tr.append(
						    				tds.replace("[id]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[qty]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[unitPrice]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
						    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
		    						tBody.append(tr);
	    						}else{
	    						   index = 1;
	    						}
	    						var tr = $("<tr style = 'height : 2px'></tr>");
					    			tr.append(
					    				tds.replace("[id]",index)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[unitPrice]",data[i].amt)
					    				.replace("[amt]",data[i].amt)
					    				.replace("[rate]",rate)
					    				.replace("[subtotal]",data[i].subtotal));
					    			tBody.append(tr); 
					    			currIndex = index;
					    			index = index + 1;
					    			j = 0;
	    					}else{
	    						var tr = $("<tr></tr>");
					    			tr.append(
					    				tds.replace("[id]",orderIndex)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[unitPrice]", "")
					    				.replace("[amt]","")
					    				.replace("[rate]","")
					    				.replace("[subtotal]",""));
					    			tBody.append(tr); 
	    					}
			    			getSubtotal(params);
	    				}
	    				if(params.name != "结账单"){
	    				   document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML).toFixed(2);
	    				}
	    				 document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML).toFixed(2);
		        	}
	          }
        	}); 
        	
        	
        	$.ajaxSettings.async = false;
        	if(params.name == "结账单"){
				 $.post(params.baseUrl+"com.hsapi.repair.repairService.query.querySettleAmt.biz.ext?serviceId="+params.serviceId+"&token="+params.token,{},function(text){
    				    if(text.errCode=="S"){ 
	    				 	document.getElementById("cash1").innerHTML = text.data.balaAmt.toFixed(2);
	    				 	if(text.data.allowanceAmt<0){
	    				 		document.getElementById("expRateAmt").innerHTML = "0.00";
	    				 		document.getElementById("yh").innerHTML = (text.data.totalPrefAmt-text.data.allowanceAmt).toFixed(2);
	    				 	}else{
	    				 		document.getElementById("expRateAmt").innerHTML = text.data.allowanceAmt.toFixed(2);
	    				 		document.getElementById("yh").innerHTML = text.data.totalPrefAmt.toFixed(2);
	    				 	}    				 				
	    					var money = transform(text.data.balaAmt+"");
							document.getElementById("money").innerHTML = money;
	    				}else{
	    					nui.alert(text.errMsg,"提示");
	    				}
    	            });  
    		}
    		//其他费用com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext
    		 $.ajaxSettings.async = false;
    		 var httpstr = params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext?serviceId="+params.serviceId+"&dc=1"+"&token="+params.token;
    		 if(params.type && params.type==1){
    		   	 httpstr = params.baseUrl+"com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext?serviceId="+params.sourceServiceId+"&dc=1"+"&token="+params.token;
    		 }
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
    		                /* if(params.type && params.type==1){
    		                   getSubtotal(params);
    		                } */
    		                getSubtotal(params);
    		             }
    		            }
    		       }
	         });
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
    			var date = new Date();
	            var moDate = format(date, "yyyy-MM-dd HH:mm");
    			document.getElementById("updateEnterDate").value = moDate.replace(" ","T");
    		}
    		if(outDate > 16){
    			var value = outDate.substring(0, outDate-3);
    			document.getElementById("updateOutDate").value = value.replace(" ","T");
    		}else{
    			var date = new Date();
	            var moDate = format(date, "yyyy-MM-dd HH:mm");
    		    document.getElementById("updateOutDate").value = moDate.replace(" ","T");
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
            document.getElementById("outDate").innerHTML = document.getElementById("updateOutDate").value.replace("T"," ");
    	}
    	
    	function box_setup_close(){
    		$(".boxbg").hide();
        	$(".popbox").hide();
    	}
        
</script>