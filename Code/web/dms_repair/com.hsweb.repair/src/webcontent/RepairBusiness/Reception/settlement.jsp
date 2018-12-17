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
<body ><!-- oncontextmenu = "return false" -->
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
        	
            
            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
	                <tr>
	                	<td rowspan="2" style="width: 133px;">
	                     	<img alt="" src="<%= request.getContextPath() %>/repair/common/log.bmp">
	                    </td>
	                    <td>
	                        <div style="font-size: 20px; font-family: 微软雅黑;">&nbsp;&nbsp;<span id="comp"></span></div>
	                    </td>
	                    <td rowspan="2" style="width: 300px;">
	                        <div style="font-size: 30px; font-family: 微软雅黑;"><b><span id="spstorename"></span></b></div>
	                        <div style="padding-top: 2px; font-size: 16px;">
	                          №:<span id="serviceCode"></span>  
	                        </div>
	                    </td>
	                </tr>
	                <tr>
	                	<td>
	                	<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国第15店/河南华胜</br>
	                	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中国第15店/河南华胜-->
	                	</td>
	                </tr>
	            </tbody>
	        </table>
	        
        </div>
        
        <div style="border-bottom: 1px #333 solid; height: 10px; margin-bottom: 10px;">&nbsp;</div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td>地址：<span id="guestAddr"></span></td>
                <td  id="openBank" style="width: 300px;">开户银行：</td>
                <td  style="width: 300px;">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td>电话：<span id="phone"></span></td>
                <td  id="bankNo" >银行账号：</td>
             	<td  id="enterDate" >进厂时间：</td>
            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td height="24" width="42%" id="guestFullName">&nbsp;客户名称：</td>
                    <td height="24" id="carNo">&nbsp;车牌号：</td>
<!--                     <td width="33%" id="mtAdvisor">&nbsp;服务顾问：</td> -->
<!--                     <td >&nbsp;进厂里程：<span id="enterKilometers"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;油量：<span id="enterOilMass"></span></td> -->
                </tr>
<!--                 <tr> -->
<!--                     <td height="24" id="carNo">&nbsp;车牌号：</td> -->
<!--                     <td id="carModel">&nbsp;品牌车型： </td> -->
<!--                     <td id="carVin">&nbsp;车架号(VIN)：</td> -->
<!--                 </tr> -->
                <tr>
                    
                    
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPkg">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>套餐项目(含工时配件)</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>小计</b></td>
                    
                </tr>
                <tbody id="tbodyId">
				</tbody>
            </table>
        <div style="height: 12px;" id="space1"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showItem">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>项目名称</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>工时/数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>小计</b></td>
                </tr>
                <tbody id="tbodyId2">
				</tbody>
            </table>
         <!--  <div style="height: 12px;" id="space2"></div>  -->
                    <!-- <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk1">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b></b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>配件项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
                <tbody id="tbodyId3">
				</tbody>
            </table>
            <div style="height: 12px;"></div> -->
            
        <!-- <div style="color:#000;height:42px; margin-top:-8px;">
             <span style="font-size: 16px; float:right; font-weight: bold;">价格合计：&yen;<span id="cash"></span>元</span>
                      套餐：<span id="prdt">0</span>&nbsp;&nbsp;&nbsp;&nbsp;工时：<span id="item">0</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0</span>
            
            <span style="margin-left: 200px;">优惠金额：<span id="yh">0</span>元</span>
            
            <span style="margin-left: 400px;">
                <b style="font-size: 16px;">小计</b>：
                <font style="font-size: 15px; font-weight: bold;">
                    <span id="cash1"></span>
                </font>元&nbsp;&nbsp;&nbsp;
            </span>
            
            <span style="margin-right: 100px;">
               <b style="font-size: 16px;">大写</b>：
               <font style="font-size: 15px; font-weight: bold;">
                  <span id="money"></span>
               </font>
            </span>
        </div> -->
        <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="y">
            <tr>
                <td height="36" colspan="1" style="border:0px solid #DDD; " rowspan="1" colspan="1" >
                   <!--  <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                                                             
                    </div> -->
                      套餐：<span id="prdt">0</span>&nbsp;&nbsp;&nbsp;&nbsp;工时：<span id="item">0</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0</span>
            
                </td>
                <td height="36" colspan="1" style="border:0px" >
                    <!-- <div style="float: center; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-left: 200px;">优惠金额：<span id="yh">0</span>元</span>
                    </div> -->
                     <span style="margin-left: 0px;">优惠金额：<span id="yh">0</span>元</span>
                </td>
                <td height="36" colspan="2" style="border:0px">
                    <div style="float: left; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <b style="font-size: 16px;">小计</b>：
                            <font style="font-size: 15px; font-weight: bold;">
                                <span id="cash1"></span>
                            </font>元
                        </span>
                        <b style="font-size: 16px;">大写</b>：
                        <font style="font-size: 15px; font-weight: bold;">
                            <span id="money"></span>
                        </font>
                    </div>
                </td>
                
            </tr>
        </table> 

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
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
                      <span style = "margin-left: 0px;" id = "show"></span>
                      <span style = "margin-left: 500px;">客户签名：</span>
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
        //com.hsapi.repair.repairService.svr.billqyeryMaintainList
        function getSubtotal(){//更新套餐工时配件合计金额
        	var money = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(document.getElementById("item").innerHTML) + parseFloat(document.getElementById("part").innerHTML);
        	//document.getElementById("cash").innerHTML = money;
        	document.getElementById("cash1").innerHTML = money;
    		money = transform(money+"");
    		document.getElementById("money").innerHTML = money;
    		document.getElementById("cash1").innerHTML = parseFloat(document.getElementById("cash1").innerHTML).toFixed(2);

        }
        function SetData(params){
            token1 =  params.token;
            webUrl = params.webUrl;
	        var date = new Date();
	        if(params.name){
	        	document.getElementById("spstorename").innerHTML = params.name;
	        	//维修结算单没有这段话
	        	if(params.name == "结账单"){
	        	   document.getElementById("spstorename").innerHTML = "结账单";
	        	   document.getElementById("show").innerHTML = params.currRepairSettPrintContent||"";
	        	}else if(params.name == "报价单"){
	        	   $("#enterDate").hide();
	        	   document.getElementById("spstorename").innerHTML = "报价单";
	        	   document.getElementById("show").innerHTML = params.currRepairEntrustPrintContent||"";
	        	}
	        }
	        document.getElementById("comp").innerHTML = params.comp;
	        document.getElementById("date").innerHTML = document.getElementById("date").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	        //document.getElementById("pdate").innerHTML = document.getElementById("pdate").innerHTML + format(date, "yyyy-MM-dd HH:mm");
	        
	        document.getElementById("openBank").innerHTML = document.getElementById("openBank").innerHTML + params.bankName;
	        document.getElementById("bankNo").innerHTML = document.getElementById("bankNo").innerHTML + params.bankAccountNumber;
	        
	        document.getElementById("guestAddr").innerHTML = params.currCompAddress;
    		document.getElementById("phone").innerHTML = params.currCompTel;
    		
	        $.ajaxSettings.async = false;//设置为同步执行
	        var url = null;
	        if(params.type){
	        	url = "com.hsapi.repair.repairService.svr.billqyeryMaintainList.biz.ext?rid=";
	        }else{
	        	url = "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext?params/rid=";
	        }
	        var dictids= ['DDT20130703000051'];
	        
	         $.post(params.sysUrl+"com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictids="+dictids+"&token="+params.token,{},function(text){
    		    if(text.data){
    		      data = text.data;
    		    }
	         });
	        $.post(params.baseUrl+url+params.serviceId+"&token="+params.token,{},function(text){
	        	if(text.list.length > 0){
	        	   
	        		var list = text.list[0];
	        		phones = list.contactMobile || "";
	        		var carNo = list.carNo || "";
// 	        		var carVin = list.carVin || "";
	        		var enterDate = list.enterDate || "";
	        		
	        		var drawOutReport = list.drawOutReport || "";
	        		if(enterDate){
	        			enterDate = enterDate.replace(/-/g,"/");
	        			enterDate = new Date(enterDate);
	        			enterDate = format(enterDate, "yyyy-MM-dd HH:mm");
	        		}else{
	        		  enterDate='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
	        		}
	        		var guestFullName = list.guestFullName || "";
// 	        		var enterOilMass = list.enterOilMass || "0";
	        		var name = "0";
	        		//查找油量http://127.0.0.1:8080/default/
// 	        		for(var i = 0;i<data.length;i++){
// 	        		        if(data[i].customid == enterOilMass){
// 	        		           name = data[i].name;
// 	        		           break;
// 	        		        }
// 	        		}
// 	        		var enterKilometers = list.enterKilometers || "0";
// 	        		var mtAdvisor = list.mtAdvisor || "";
	        		var planFinishDate = list.planFinishDate || "";
	        		if(planFinishDate){
	        			planFinishDate = planFinishDate.replace(/-/g,"/");
	        			planFinishDate = new Date(planFinishDate);
	        			planFinishDate = format(planFinishDate, "yyyy-MM-dd HH:mm");
	        		}
	        		var serviceCode = list.serviceCode || "";
	        		var guestDesc = list.guestDesc || "";
// 	        		var carModel = list.carModel || "";
	        		var faultPhen = list.faultPhen || "";
	        		var solveMethod = list.solveMethod || "";
	        		var guestAddr = list.guestAddr || "";
	        		if(params.type){
	        			guestFullName = list.guestName || "";
	        			//guestMobile = list.guestTel || "";
	        			//contactMobile = list.contactorTel || "";
	        			carNo = list.carNo || "";
	        			//contactName = list.contactorName || "";
// 	        			mtAdvisor = list.mtAdvisor || "";
	        		}
	        		document.getElementById("serviceCode").innerHTML = document.getElementById("serviceCode").innerHTML + serviceCode;
	        		document.getElementById("carNo").innerHTML = document.getElementById("carNo").innerHTML + carNo;
// 	        		document.getElementById("carVin").innerHTML = document.getElementById("carVin").innerHTML + carVin;
	        		document.getElementById("enterDate").innerHTML = document.getElementById("enterDate").innerHTML + enterDate;
	        		document.getElementById("guestFullName").innerHTML = document.getElementById("guestFullName").innerHTML + guestFullName;
// 	        		document.getElementById("enterKilometers").innerHTML = document.getElementById("enterKilometers").innerHTML + enterKilometers;
// 	        		document.getElementById("enterOilMass").innerHTML = document.getElementById("enterOilMass").innerHTML + name;
// 	        		document.getElementById("mtAdvisor").innerHTML = document.getElementById("mtAdvisor").innerHTML + mtAdvisor;
	        		document.getElementById("guestDesc").innerHTML = document.getElementById("guestDesc").innerHTML + guestDesc; 
// 	        		document.getElementById("carModel").innerHTML = document.getElementById("carModel").innerHTML + carModel; 
	        		document.getElementById("faultPhen").innerHTML = document.getElementById("faultPhen").innerHTML + faultPhen; 
	        		document.getElementById("solveMethod").innerHTML = document.getElementById("solveMethod").innerHTML + solveMethod; 
	        		document.getElementById("guestAddr").innerHTML = document.getElementById("guestAddr").innerHTML + guestAddr;
	        		//document.getElementById("name").innerHTML = document.getElementById("name").innerHTML + mtAdvisor; 
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
	    				var tds = '<td align="center">[orderIndex]</td>' +
						    			"<td>[prdtName]</td>"+
						    			"<td align='center'>[qty]</td>"+
						    			"<td align='center'>[uintPrice]</td>"+ 
						    			"<td align='center'>[amt]</td>"+ 
						    			"<td align='center'>[rate]</td>"+
						    			"<td align='center'>[subtotal]</td>";
	    				
	    				var j = 0;
	    				var discountAmt = 0;
	    				for(var i = 0 , l = data.length ; i < l ; i++){
	    					document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
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
	    					}
	    					if(data[i].billPackageId == 0){
	    						if(i != 0){
	    							var tr = $("<tr class='ybk2'></tr>");
		    						tr.append(
					    				tds.replace("[orderIndex]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[prdtName]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[qty]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[uintPrice]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[amt]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[rate]","<hr style= 'border:1px dashed #000' />")
					    				.replace("[subtotal]","<hr style= 'border:1px dashed #000' />"));
		    						tBody.append(tr);
	    						}
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
			    			getSubtotal();
	    				}
	    				document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML).toFixed(2);
	    				document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML).toFixed(2);
	    				
		        	}else{
	                  $("#showPkg").hide();
	                  $("#space1").hide();
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
    				tBody.empty();
    				var tds = '<td align="center">[id]</td>' +
					    			"<td>[prdtName]</td>"+
					    			"<td align='center'>[qty]</td>"+
					    			"<td align='center'>[unitPrice]</td>"+ 
					    			"<td align='center'>[amt]</td>"+ 
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>";
    				
    				for(var i = 0 , l = data.length ; i < l ; i++){
    					document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
    					var rate = data[i].rate;
    					rate = rate + "%";
    					var tr = $("<tr></tr>");
    					var itemTime = null;
    					var itemName = null;
    					if(params.type){
    						 itemTime = data[i].itemTime || "";
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
    						   itemName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + itemName;
    						   document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					    }else{
    						   document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML) + parseFloat(data[i].subtotal);
    					   }
    					}
    					 
				    			tr.append(
				    				tds.replace("[id]",data[i].orderIndex)
				    				.replace("[prdtName]",itemName)
				    				.replace("[qty]",itemTime)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[amt]",data[i].amt)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr);
				    	getSubtotal();		
    				}
    				    document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML).toFixed(2);
    				    document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML).toFixed(2);
	    				document.getElementById("item").innerHTML = parseFloat(document.getElementById("item").innerHTML).toFixed(2);
	        	    }else{
                        $("#showItem").hide();	        	      
	        	    }
	        	}
        	});
        	/* if(params.type){
        		url_three = "com.hsapi.repair.repairService.svr.billgetRpsMainPart.biz.ext?serviceId=";
        	}else{
        		url_three = "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext?serviceId=";
        	} */
	        /* $.post(params.baseUrl+url_three+params.serviceId+"&token="+params.token,{},function(text){//配件
	        	if(text.errCode == "S"){
	        		var tBody = $("#tbodyId3");
    				tBody.empty();
    				var tds = '<td align="center">[id]</td>' +
					    			"<td>[partName]</td>"+
					    			"<td align='center'>[unitPrice]</td>"+ 
					    			"<td align='center'>[qty]</td>"+
					    			"<td align='center'>[rate]</td>"+
					    			"<td align='center'>[subtotal]</td>";
    				var data = text.data;
    				for(var i = 0 , l = data.length ; i < l ; i++){
    					document.getElementById("yh").innerHTML = parseFloat(document.getElementById("yh").innerHTML) + parseFloat(data[i].discountAmt);
    					document.getElementById("part").innerHTML = parseFloat(document.getElementById("part").innerHTML) + parseFloat(data[i].subtotal);
    					var rate = data[i].rate;
    					rate = (rate/100).toFixed(1) + "%";
    					var tr = $("<tr></tr>");
				    			tr.append(
				    				tds.replace("[id]",i + 1)
				    				.replace("[partName]",data[i].partName)
				    				.replace("[unitPrice]",data[i].unitPrice)
				    				.replace("[qty]",data[i].qty)
				    				.replace("[rate]",rate)
				    				.replace("[subtotal]",data[i].subtotal));
				    			tBody.append(tr);
		    			getSubtotal();
    				}
	        	}
	        }); */
        }
        
        function box_setup_open() {
	        $(".boxbg").show();
	        $(".popbox").show();
	        document.getElementById("txtno").value = document.getElementById("serviceCode").innerHTML;
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
    		document.getElementById("serviceCode").innerHTML = document.getElementById("txtno").value;
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