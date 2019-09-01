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
<style>
 /* table, td {
    font-family:Arial,simsun,Verdana,Lucida,Helvetica,sans-serif,"宋体";
    font-size: 12px;
    color: #000;
}  */
</style>
<body>
<div class="boxbg" style="display:none"></div>
 <div class="popbox" style="height:420px; width:480px; margin:-210px 0 0 -240px; display:none">
        <h2><a class="close2" href="javascript:box_setup_close()" title="关闭">&nbsp;</a>修改</h2>
        <div style="padding-top:15px; margin:0 15px;">
            <table  width="92%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td class="color999" width="76" height="46">单据编号：</td>
                        <td><input type="text" id="txtno" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">门店名称：</td>
                        <td><input type="text" id="txtstorename" class="peijianss" value="" /></td>
                    </tr>
                    <!-- <tr>
                        <td class="color999" height="46">地址：</td>
                        <td><input type="text" id="txtaddress" class="peijianss" value="" /></td>
                    </tr>
                    <tr>
                        <td class="color999" height="46">电话：</td>
                        <td><input type="text" id="txtphoneno" class="peijianss" value="" /></td>
                    </tr> -->
                    <tr>
                        <td class="color999" height="46">进厂时间：</td>
                        <td><input id="updateEnterDate" type="datetime-local" value=""/></td>
                    </tr>
                     <tr>
                        <td class="color999" height="46">结算时间：</td>
                        <td><input id="updateOutDate" type="datetime-local" value=""/></td>
                    </tr>
                    <!-- <tr>
                        <td class="color999" height="46">打印时间：</td>
                        <td><input id="meeting" type="datetime-local" value=""/></td>
                    </tr> -->
                </tbody>
            </table>

        </div>
        <div class="boxbtn"><ul><a href="javascript:box_setup_close()" class="qc">取消</a><a href="javascript:save()" id="btn_save">保存</a></ul></div>
</div>
    <div class="print_btn">
        <a href="javascript:;" id="btnprint" style="background:#ff6600;">打印</a><a href="javascript:box_setup_open()">修改</a>
    </div>
    <div class="printny">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="160" valign="top">
                    <div class="fl">
                        <p style="font-size:30px; font-family:'黑体';" id="spstorename"></p>
                       <!--  <p style="font-size:16px; padding-top:3px;">Detailed Account</p> -->
                    </div>
                </td>
                <td>
                    <div class="fr" style="text-align:center;">
                        <p style="font-size:24px;" id="comp"></p>
                        <p style="font-size:14px; padding:2px 0 5px 0;"></p>
                        <p style="font-size:20px;"></p>
                    </div>
                </td>
            </tr>
        </table>
        <div class="hctop">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk" style="margin-top:15px;">
                <tr>
                    <td colspan="2" rowspan="2" valign="top">
                        <div class="hctop_left" style="float:none; padding:8px; width:auto"><em>顾客资料：</em><span class="font16" style="margin:0 30px 0 10px;" id="guestFullName"> </span><span class="font16" id="mobile"></span></div>
                        <!-- <div style="padding-left:8px;">(Customer)</div> -->
                    </td>
                    <td width="36%"><div class="hctop_right"><em>工单号：</em></div><div class="hctop_right" id="serviceCode"></div></td>
                </tr>
                <tr>
                    <td><div class="hctop_right"><em>进厂时间：</em></div><div class="hctop_right" id="enterDate"></div></td>
                </tr>
                <!-- <tr>
                    <td><div class="hctop_left"><em>出车日期：</em><br />Date Of Prdctn.</div><div class="hctop_right" id="outDate"></div></td>
                </tr> -->
                <tr>
                    <td width="23%"><div class="hctop_right" ><em>车牌号：</em></div><div class="hctop_right" id="carNo"></div></td>
                    <td colspan="1"><div class="hctop_right" style="width:85px;"><em>品牌车型：</em></div><div class="hctop_right" id="carModel"></div></td>
                    <td colspan="1" ><div class="hctop_right" ><em>结算日期：</em></div><div class="hctop_right" id="outDate"></div></td>
                </tr>
                <tr>
                    <td><div class="hctop_right"><em>服务顾问：</em></div><div class="hctop_right" id="mtAdvisor"></div></td>
                    <td colspan="1" ><div class="hctop_right" style="width:110px"><em>车架号(VIN)：</em></div><div class="hctop_right" id="carVin"></div></td>
                    <td><div class="hctop_right"><em>进厂油量：</em></div><div class="hctop_right" id="enterOilMass"></div>
                    <div class="hctop_right"><em>&nbsp;&nbsp;&nbsp;进厂里程：</em></div><div class="hctop_right" id="enterKilometers"></div>
                    </td>
                    <!-- <td colspan="2"><div class="hctop_right" style="width:150px"><em>车架号(VIN)：</em></div><div class="hctop_right" id="carVin"></div></td> --> 
                   <!--  <td><div class="hctop_left"><em>发动机号：</em><br />Engine No.</div><div class="hctop_right">175*****045</div></td>
                    <td rowspan="2"><div class="hctop_left"><em>服务顾问：</em><br />Adviser.</div><div class="hctop_right" id="mtAdvisor"></div></td> -->
                </tr>
               <!--  <tr>
                    <td><div class="hctop_left" style="width:85px;"><em>车&nbsp;&nbsp;&nbsp;&nbsp;型：</em><br />Type.</div><div class="hctop_right">途观</div></td>
                    <td><div class="hctop_left"><em>车辆颜色：</em><br />Color.</div><div class="hctop_right">白色</div></td>
                </tr> -->
            </table>
        </div>
        <div class="hctable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showPkg">
                <tr class="title">
                    <td width="40" rowspan="2" align="center">序号</td>
                    <td height="24" colspan="6" align="center">套餐项目</td>
                    <td width="80" rowspan="2" align="center">小计</td>
                </tr>
                <tr class="title">
                    <td height="24" colspan="2" align="center">套餐名称</td>
                    <td width="70" align="center">数量</td>
                    <td width="70" align="center">单价</td>
                    <td width="70" align="center">金额</td>
                    <td width="80" align="center">优惠率</td>
                </tr>
                <tbody id="tbodyId">
				</tbody>
                <tr>
                    <td height="24" colspan="7" align="right"><span style="font-family:'黑体'; font-size:15px;">套餐小计：</span></td>
                    <td align="right"><span id="prdtSub">0.00</span>&nbsp;</td>
                </tr>
                </table>
                <!-- <div style="height: 1px;" id="space1"></div> -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showItem">
                <tr class="title">
                    <td width="40" rowspan="2" align="center" style="border-top-style:none">序号</td>
                    <td height="24" colspan="6" align="center" style="border-top-style:none">项目</td>
                    <td width="80" rowspan="2" align="center"  style="border-top-style:none">小计</td>
                </tr>
                <tr class="title">
                    <td height="24" colspan="2" align="center">项目名称</td>
                    <td width="70" align="center">数量</td>
                    <td width="70" align="center">单价</td>
                     <td width="70" align="center">金额</td>
                    <td width="80" align="center">优惠率</td>
                </tr>
                <tbody id="tbodyId2">
				</tbody>
                <tr>
                    <td height="24" colspan="7" align="right"><span style="font-family:'黑体'; font-size:15px;">项目小计：</span></td>
                    <td align="right"><span id="itemSub">0.00</span>&nbsp;</td>
                </tr>
                </table>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="showPart" style="display:none">
                <tr class="title">
                    <td width="40" rowspan="2" align="center" style="border-top-style:none">序号</td>
                    <td height="24" colspan="6" align="center" style="border-top-style:none">配件项目</td>
                    <td width="80" rowspan="2" align="center" style="border-top-style:none">小计</td>
                </tr>
                <tr class="title">
                    <td height="24" align="center" colspan="2">配件名称</td>
                    <td width="70" align="center" >数量</td>
                    <td align="center" width="70">单价</td>
                    <td align="center" width="70">金额</td>
                    <td align="center" width="80">优惠率</td>
                </tr>
                <tbody id="tbodyId3">
				</tbody>
                <tr>
                    <td height="24" colspan="7" align="right"><span style="font-family:'黑体'; font-size:15px;">配件小计：</span></td>
                    <td align="right"><span id="partSub">0.00</span>&nbsp;</td>
                </tr>
            </table>
        </div>
        
        <div class="hctable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr class="title">
                    <td width="14%" height="45" align="center">套餐费</td>
                    <td width="14%" height="45" align="center">工时费</td>
                    <td width="14%" align="center">配件费</td>
                    <td width="14%" align="center">其他费用</td>
                    <td width="14%" align="center">其他优惠</td>
                    <!-- <td width="14%" align="center">管理费<br />Management</td>
                    <td width="14%" align="center">税费<br />Taxation</td> -->
                    <td align="center" colspan="2">总费用</td>
                </tr>
                <tr>
                    <td height="28" align="right" class="font15">&yen;<span id="prdt">0.00</span></td>
                    <td align="right" class="font15">&yen;<span id="item">0.00</span></td>
                    <td align="right" class="font15">&yen;<span id="part">0.00</span></td>
                    <td align="right" class="font15">&yen;<span id="expense">0.00</span></td>
                    <td align="right" class="font15">&yen;<span id="expRateAmt">0.00</span></td>
                   <!--  <td align="right" class="font15">&yen;0.00&nbsp;</td> --> 
                    <td align="right" class="font15" colspan="2">&yen;<span id="totalAmt">0.00</span></td>
                </tr>
                <tr>
                    <td height="28" colspan="2" align="left" class="font15"><span class="hei16">项目优惠率：</span><span id="itemRate">0.00</span>%</td>
                    <td colspan="2" align="left" class="font15"><span class="hei16">项目优惠金额：&yen;</span><span id="itemAmt">0.00</span></td>
                    <td colspan="2" align="left" class="font15" width="22%"><span class="hei16">配件优惠率：</span><span id="partRate">0.00</span>%</td>
                    <td  align="left" class="font15"><span class="hei16">配件优惠金额：&yen;</span><span id="partAmt">0.00</span></td>
                </tr>
                 <tr>
                    <td height="28" align="center"><span class="hei16">优惠金额</span></td>
                    <td colspan="8" align="right"><div id="yh" class="hei16">0.00</div></td>
                </tr>
                <tr>
                    <td height="28" align="center"><span class="hei16">结算金额</span></td>
                    <td colspan="8" align="right"><div id="cash1" class="hei16">0.00</div></td>
                </tr>
                <tr>
                    <td height="28" align="center"><span class="hei16">金额大写</span></td>
                    <td colspan="8" align="right"><div id="money" class="hei16"></div></td>
                </tr>
                <tr>
                    <td height="45" colspan="8" valign="top" style="padding:5px;">
                        <div style="text-align:left; min-height:20px; padding:5px; border-bottom:1px #000 solid; margin-bottom:5px;">
                            <span class="hei" style="font-size:14px">出车报告：</span><span id="drawOutReport"></span>
                        </div>
                        <div style="padding:10px;" class="hei16"></div>
                    </td>
                </tr>
                <tr>
                    <td height="60" colspan="2" class="hei16" style="padding-left:8px;"><span id="makeMan">制单：</span></td>
                    <td colspan="2" class="hei16" style="padding-left:10px;">服务顾问签名：</td>
                    <td colspan="4" class="hei16" style="padding-left:10px;">客户签名：</td>
                </tr>
            </table>
        </div>
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
    $("#btnprint").click(function () {
        $(".print_btn").hide();
        window.print();
    });

    $("#btnmodify").click(function () {
        layer.open({
            title: "修改",
            type: 2, //iframe窗
            area: ["560px", "500px"],
            fixed: true, //不固定
            maxmin: false, //开启最大化最小化按钮
            content: "/Main/system/SettingPrintTemplate?templateId=3"
        });
    });

    function reload() {
        window.location.reload();
    }
    
       function SetData(params){
            weChatData = params;
            var currRepairBillMobileFlag = params.currRepairBillMobileFlag || ""; 
            var imgUrl = params.currCompLogoPath || "";
           /*  if(imgUrl && imgUrl != ""){
               $('#showImg').show();
               $("#showImg").attr("src",imgUrl);
            } */
            token1 =  params.token;
            webUrl = params.webUrl;
	        var date = new Date();
	        if(params.name){
	        	document.getElementById("spstorename").innerHTML = params.name;
	        	//维修结算单没有这段话
	        	if(params.name == "结账单"){
	        	   document.getElementById("spstorename").innerHTML = "结&nbsp;账&nbsp;单";
	        	  // document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
	        	}else if(params.name == "报价单"){
	        	   //$("#enterDate").hide();
	        	   document.getElementById("spstorename").innerHTML = "报&nbsp;价&nbsp;单";
	        	   //document.getElementById("show").innerHTML = params.currRepairEntrustPrintContent||"";
	        	}
	        }else{//这是报销单调用的
		        if(params.printName){
			        if(params.printName == "结账单"){
		        	   document.getElementById("spstorename").innerHTML = "结&nbsp;账&nbsp;单";
		        	  // document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
		        	}else if(params.printName == "报价单"){
		        	   document.getElementById("spstorename").innerHTML = "报&nbsp;价&nbsp;单";
		        	 //  document.getElementById("show").innerHTML = params.currRepairEntrustPrintContent||"";
		        	}
		        }
	           
	        } 
	      
	        document.getElementById("comp").innerHTML = params.comp;
	        //document.getElementById("date").innerHTML = format(date, "yyyy-MM-dd HH:mm");打印日期
	        //document.getElementById("pdate").innerHTML = document.getElementById("pdate").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	        
	        //document.getElementById("openBank").innerHTML =  params.bankName;
	        //document.getElementById("bankNo").innerHTML = params.bankAccountNumber;
	        
	        //document.getElementById("guestAddr").innerHTML = params.currCompAddress;
    		//document.getElementById("phone").innerHTML = params.currCompTel;
    		//document.getElementById("slogan1").innerHTML = params.currSlogan1;
    		//document.getElementById("slogan2").innerHTML = params.currSlogan2;
    		document.getElementById("makeMan").innerHTML="制单:" + params.currUserName;
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
	        /* var dictids= ['DDT20130703000051'];
	        
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
	        		/* infoData.mobile = mobile;
	        		infoData.carNo = carNo;
	        		infoData.carId = carId;
	        		infoData.guestId = list.contactorId;
	        		infoData.serviceType = 11;
	        		infoData.mainId = params.serviceId; */
	        		enterDate = list.enterDate || "";
	        		outDate = list.outDate || "";
	        		wechatOpenId = list.openId || "";
	        		if(wechatOpenId == "" || wechatOpenId == null){
	        		   // document.getElementById("openId").style.background="#999999"; 
	        		}
	        		
	        		
	        		var drawOutReport = list.drawOutReport || "";
	        		document.getElementById("drawOutReport").innerHTML = document.getElementById("drawOutReport").innerHTML + drawOutReport;
	        		if(enterDate){
	        			enterDate = enterDate.replace(/-/g,"/");
	        			enterDate = new Date(enterDate);
	        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm");
	        		}else{
	        		  enterDate='&nbsp;'
	        		}
	        		if(outDate){
	        			outDate = outDate.replace(/-/g,"/");
	        			outDate = new Date(outDate);
	        			outDate = format(outDate, "yyyy-MM-dd HH:mm");
	        		}else{
	        		  outDate='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
	        		}
	        		var guestFullName = list.guestFullName || "";
	        		var guestMobile = list.guestMobile || "";
	        		var contactMobile = list.contactMobile;
	        		var enterOilMass = list.enterOilMass || "0";
	        		/* var name = "0";
	        		//查找油量http://127.0.0.1:8080/default/
	        		for(var i = 0;i<data.length;i++){
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
	        		document.getElementById("guestFullName").innerHTML = document.getElementById("guestFullName").innerHTML + contactName;
	        		//document.getElementById("contactName").innerHTML = document.getElementById("contactName").innerHTML + contactName;
	        		
	        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
	        		document.getElementById("enterOilMass").innerHTML = document.getElementById("enterOilMass").innerHTML + enterOilMass;
	        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
	        		//document.getElementById("guestDesc").innerHTML = document.getElementById("guestDesc").innerHTML + guestDesc; 
	        		document.getElementById("carModel").innerHTML = document.getElementById("carModel").innerHTML + carModel; 
	        		//document.getElementById("faultPhen").innerHTML = document.getElementById("faultPhen").innerHTML + faultPhen; 
	        		//document.getElementById("solveMethod").innerHTML = document.getElementById("solveMethod").innerHTML + solveMethod; 
	        		//document.getElementById("guestAddr").innerHTML = document.getElementById("guestAddr").innerHTML + guestAddr;
	        		//document.getElementById("name").innerHTML = document.getElementById("name").innerHTML + mtAdvisor; 
	        	     if(currRepairBillMobileFlag==1){
	        	       document.getElementById("mobile").innerHTML = document.getElementById("mobile").innerHTML + mobile;
	        	    } 
	        	    if(params.type){
	        	      document.getElementById("outDate").innerHTML = format(date, "yyyy-MM-dd HH:mm");
	        	      outDate = format(date, "yyyy-MM-dd HH:mm");
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
	        	    var data = {};//
	        	    if(params.type){
	    			   data = text.pkgBill;
	    			}else{
	    			    data = text.data;
	    			}
	        	    if(data.length>0){
		        		var tBody = $("#tbodyId");
	    				tBody.empty();
	    				var tds = '<td align="center" >[orderIndex]</td>' +
						    			"<td colspan='2'>[prdtName]</td>"+
						    			"<td align='center'>[qty]</td>"+
						    			"<td align='center'>[uintPrice]</td>"+ 
						    			"<td align='center'>[amt]</td>"+ 
						    			"<td align='center'>[rate]</td>"+
						    			"<td align='center'>[subtotal]</td>";
	    				
	    				var j = 0;
	    				var discountAmt = 0;
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    				    if(params.name != "结账单"){
	    				      if(data[i].billPackageId == 0){//只计算套餐的优惠
	    				           document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
	    				      }
	    				    }
	    					var prdtName = data[i].prdtName;
	    					if(params.type){
	    						prdtName = data[i].packageName || "";
	    					}
	    					var orderIndex = data[i].orderIndex;
	    					var rate = data[i].rate;
	    					rate = rate + "%";
	    					if(data[i].billPackageId != 0){
	    						prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	    						orderIndex = "";
	    						
	    					}else{
	    						if(params.type){
	    							j++;
	    							orderIndex = j;
	    						}
	    						document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(data[i].subtotal);
	    						document.getElementById("prdtSub").innerHTML = parseFloat(document.getElementById("prdtSub").innerHTML) + parseFloat(data[i].subtotal);
	    					}
	    					if(data[i].billPackageId == 0){
	    						/* if(i != 0){
	    							var tr = $("<tr></tr>");
		    						tr.append(
					    				tds.replace("[orderIndex]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[qty]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[uintPrice]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
		    						tBody.append(tr);
	    						} */
	    						var tr = $("<tr style = 'height : 2px'></tr>");
					    			tr.append(
					    				tds.replace("[orderIndex]",orderIndex)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[uintPrice]",data[i].amt)
					    				.replace("[amt]",data[i].amt)
					    				.replace("[rate]",rate)
					    				.replace("[subtotal]",data[i].subtotal));
					    			tBody.append(tr); 
	    					}else{
	    						var tr = $("<tr></tr>");
					    			tr.append(
					    				tds.replace("[orderIndex]",orderIndex)
					    				.replace("[prdtName]",prdtName)
					    				.replace("[qty]",data[i].qty || 1)
					    				.replace("[uintPrice]", "")
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
	    				 document.getElementById("prdtSub").innerHTML = parseFloat(document.getElementById("prdtSub").innerHTML).toFixed(2);
	    				
		        	}else{
	                  $("#showPkg").hide();
	                }
	          }
        	}); 
        	if(params.type){
        		url_two = "com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext?serviceId=";
        	}else{
        		url_two = "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId=";
        	} 
        	  $.post(params.baseUrl+url_two+params.serviceId+"&token="+params.token,{},function(text){//工时
        	   
	        	if(text.errCode == "S"){
	        	    var data = {};
	        	    if(params.type){
	        	       data = text.itemBill;
	        	    }else{
	        	       data = text.data;
	        	    }
	        	    if(data.length>0){
	        	        var tBody = $("#tbodyId2");
	        	        var tBody3 = $("#tbodyId3");
    				tBody.empty();
    				tBody3.empty();
    				 var tds = '<td height="26" align="center">[id]</td>' +
					    			'<td colspan="2">[prdtName]</td>'+
					    			"<td align='center'>[qty]</td>"+
					    			"<td align='center'>[unitPrice]</td>"+ 
					    			"<td align='center'>[amt]</td>"+ 
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>"; 
					/* var tds =  '<td height="26" align="center">[id]</td>'+
                               '<td colspan="3">[prdtName]</td>'+
                                '<td align="center">洗车</td>'+
                                '<td align="right">[amt]</td>'+
                                '<td align="right">[rateAmt]</td>'; */
    				var partShow = null;
    				var num = 1;
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
    						   itemName =  itemName;
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					       document.getElementById("partSub").innerHTML = parseFloat(document.getElementById("partSub").innerHTML) + parseFloat(data[i].subtotal);
    					      }else{
    						     document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    						     document.getElementById("itemSub").innerHTML = parseFloat(document.getElementById("itemSub").innerHTML) + parseFloat(data[i].subtotal);
    					      }
    					}else{
    						itemTime = data[i].qty || "";
    						itemName = data[i].prdtName || "";
    						if(data[i].pid != 0 ){
    						   itemName = itemName;
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    						   document.getElementById("partSub").innerHTML = parseFloat(document.getElementById("partSub").innerHTML) + parseFloat(data[i].subtotal);
    					    }else{
    						   document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    						   document.getElementById("itemSub").innerHTML = parseFloat(document.getElementById("itemSub").innerHTML) + parseFloat(data[i].subtotal);
    					   }
    					}
    					
    					       var index = data[i].orderIndex;
    					       
    					       if(data[i].billItemId == 0){
					              itemAmt = itemAmt + data[i].amt;
					              itemSubtotal = itemSubtotal + data[i].subtotal;
    					       }else{
    					          index = num;
    					          num = num + 1;
    					          partAmt = partAmt + data[i].amt;
    					          partSubtotal = partSubtotal + data[i].subtotal;
    					       }
				    			tr.append(
				    				tds.replace("[id]",index)
				    				.replace("[prdtName]",itemName)
				    				.replace("[qty]",itemTime)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[amt]",data[i].amt)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			if(data[i].billItemId != 0){
				    			   tBody3.append(tr);
				    			   partShow = 1;
				    			}else{
				    			   tBody.append(tr);
				    			}
				    			
				    	getSubtotal(params);		
    				}
    				  if(partShow==1){
    				    document.getElementById("showPart").style.display = "";
    				  }
    				  if(params.name != "结账单"){
    				      document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML).toFixed(2);
    				   }
    				   
    				  document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML).toFixed(2);
    				  document.getElementById("partSub").innerHTML = parseFloat(document.getElementById("partSub").innerHTML).toFixed(2);
	    			  document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML).toFixed(2);
	    			  document.getElementById("itemSub").innerHTML = parseFloat(document.getElementById("itemSub").innerHTML).toFixed(2);
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
	        	    }else{
                        $("#showItem").hide();	
                       // $("#space2").hide();        	      
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
        	//总费用
            var totalMoney = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(document.getElementById("item").innerHTML) + parseFloat(document.getElementById("part").innerHTML)+ parseFloat(document.getElementById("expense").innerHTML);
            document.getElementById("totalAmt").innerHTML = totalMoney.toFixed(2); 
        }
        
        function box_setup_open() {
	        $(".boxbg").show();
	        $(".popbox").show();
	        document.getElementById("txtno").value = document.getElementById("serviceCode").innerHTML;
    		document.getElementById("txtstorename").value = document.getElementById("comp").innerHTML;
    		/* document.getElementById("txtaddress").value = document.getElementById("guestAddr").innerHTML;
    		document.getElementById("txtphoneno").value = document.getElementById("phone").innerHTML; */
    		/* if(document.getElementById("date").innerHTML.length > 16){
    			var value = document.getElementById("date").innerHTML.substring(0, document.getElementById("date").innerHTML.length-3);
    			document.getElementById("meeting").value = value.replace(" ","T");
    		}else{
    			document.getElementById("meeting").value = document.getElementById("date").innerHTML.replace(" ","T");
    		} */
    		if(enterDate > 16){
    			var value = enterDate.substring(0, enterDate-3);
    			document.getElementById("updateEnterDate").value = value.replace(" ","T");
    		}else{
    			document.getElementById("updateEnterDate").value = enterDate.replace(" ","T");
    		}
    		if(outDate > 16){
    			var value = outDate.substring(0, outDate-3);
    			document.getElementById("updateOutDate").value = value.replace(" ","T");
    		}else{
    			document.getElementById("updateOutDate").value = outDate.replace(" ","T");
    		}
    	}
    	function save(){
			box_setup_close();
    		document.getElementById("serviceCode").innerHTML = document.getElementById("txtno").value;
    		document.getElementById("comp").innerHTML = document.getElementById("txtstorename").value;
    		/* var txtaddress = document.getElementById("txtaddress").value;
    		if(txtaddress != null && txtaddress != ""){
    		    document.getElementById("guestAddr").innerHTML = txtaddress;
    		}
    		var txtphoneno = document.getElementById("txtphoneno").value;
    		if(txtphoneno != null && txtphoneno != ""){
    		    document.getElementById("phone").innerHTML = txtphoneno;
    		}
			document.getElementById("date").innerHTML =  document.getElementById("meeting").value.replace("T"," "); */
            document.getElementById("enterDate").innerHTML = document.getElementById("updateEnterDate").value.replace("T"," ");
            document.getElementById("outDate").innerHTML = document.getElementById("updateOutDate").value.replace("T"," ");
    	}
    	function box_setup_close(){
    		$(".boxbg").hide();
        	$(".popbox").hide();
    	}
</script>