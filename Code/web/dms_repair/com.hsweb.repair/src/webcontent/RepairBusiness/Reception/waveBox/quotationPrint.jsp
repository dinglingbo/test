<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-23 14:38:41
  - Description:
-->
<head>
<title>报价单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/numberFormat.js"  type="text/javascript"></script>  
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
<body ><!-- oncontextmenu = "return false" -->
<div class="boxbg" style="display:none"></div>
<input  class="nui-combobox" name="carBrandId" id="carBrandId"  valueField="id" textField="name"width="100%" visible="false"/>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
    </div>
     
        <div style="margin: 0 10px;" class="printny">
        <div class="company-info">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0">
	            <tbody>
	                <tr>
	                	<td rowspan="2" style="width: 133px;">
	                     	<img alt="" src="/default/repair/common/log.bmp">
	                    </td>
	                    <td style="width:55%">
	                        <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp"></span></div>
	                    </td>
	                    <td rowspan="2" style="">
	                        <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename">报价单</span></b></div>
	                        <div style="padding-top: 2px; font-size: 13px;font-family: Arial;">
	                          №:<span id="serviceCode"></span>  
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
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
                <td style="font-size:8px;" >地址：<span id="currCompAddress"></span></td>
                <td style="font-size:8px;"  style="">开户银行：<span id="currBankName"></span></td>
                <td style="font-size:8px;">打印时间：<span id="date"></span></td>
            </tr> 
            <tr>
                <td style="font-size:8px;">电话：<span id="currCompTel"></span></td>
                <td style="font-size:8px;">银行账号：<span id="currBankAccountNumber"></span></td>
             	<td style="font-size:8px;" id="enterDate" >进厂时间：</td>
            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td width="14%" >&nbsp;客户名称</td>
                    <td id="guestFullName"></td>
                    <td width="14%">&nbsp;变速箱型号</td>
                    <td id="boxModel"></td>
                    <td width="14%">&nbsp;驱动形式</td>
                    <td id="driveType"></td>
                </tr>
                <tr>
                    <td>&nbsp;联系人</td>
                    <td id="name"></td>
                    <td id="">&nbsp;变速箱号 </td>
                    <td id="boxNo"></td>
                    <td >&nbsp;波箱厂牌</td>
                    <td id="carBrand"></td>
                </tr>
                <tr>
                    <td>&nbsp;客户地址</td>
                    <td id="guestAddr"></td>
                    <td >&nbsp;底盘号 </td>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td>&nbsp;联系手机</td>
                    <td id="guestMobile"></td>
                    <td >&nbsp;发动机型号 </td>
                    <td colspan="3" id="engineNo"></td>
                </tr>
                <tr>
                    <td>&nbsp;传真/电话</td>
                    <td></td>
                    <td >&nbsp;公里数</td>
                    <td colspan="3" id="enterKilometers"></td>
                </tr>
                <tr>
                    
                    
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk1" id="showPkg">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8" style="font-family: 华文中宋; font-size:16px;font-weight: bold;"></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"style="font-family: 华文中宋; font-size:16px;font-weight: bold;">套餐项目(含工时配件)</td>
                    
                    
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
                <tbody id="tbodyId">
				</tbody>
            </table> 
       
        <table width="100%" border="0"  cellpadding="0" cellspacing="0" class="ybk">
            <tr>
                <td height="36" colspan="1" style="border:0px solid #DDD; " rowspan="1" colspan="1" >
                      套餐：<span id="prdt">0</span>&nbsp;&nbsp;&nbsp;&nbsp;配件：<span id="part">0</span>
            
                </td>
                <td height="36" colspan="1" style="border:0px" >
                     <span style="margin-left: 0px;">优惠金额：<span id="yh">0</span>元</span>
                </td>
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
		<div style="display:none" id="hidden1" >
			<span>出厂报告</span>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                   <td height="30" style="padding: 8px;" colspan="4" id="drawOutReport">
                   		
                  </td>
            </tr>
        </table>
		</div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                   <td height="30" style="padding: 8px;" colspan="4">
                   		<span style="padding: 8px;font-size: 16px;" id="msg">尊敬的客户：以上报价在实际施工过程中可能有小幅变动，最终价格以实际结算单为准！</span>
                   		<div style="display:none" id="hidden2" >
                   			<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk"  >
				                <tr >
				                    <td width="5%"  align="center">序号</td>
				                    <td align="center">波箱配件</td>
				                    <td width="5%" align="center">数量</td>
				                    <td width="5%" align="center">序号</td>
				                    <td align="center">波箱配件</td>
				                    <td width="5%" align="center">数量</td>
				                </tr>
				                <tr>
				                	<td align="center">1</td>
				                	<td align="center">总成</td>
				                	<td align="center"></td>
				                	<td align="center">5</td>
				                	<td align="center">冬菇</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">2</td>
				                	<td align="center">波箱壳</td>
				                	<td align="center"></td>
				                	<td align="center">6</td>
				                	<td align="center">内件</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">3</td>
				                	<td align="center">差速器</td>
				                	<td align="center"></td>
				                	<td align="center">7</td>
				                	<td align="center">油泵</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center">4</td>
				                	<td align="center">传感器</td>
				                	<td align="center"></td>
				                	<td align="center">8</td>
				                	<td align="center">油路板</td>
				                	<td align="center"></td>
				                </tr>
				                <tr>
				                	<td align="center" colspan="3"></td>
				                	<td align="center">9</td>
				                	<td align="center">F盅</td>
				                	<td align="center"></td>
				                </tr>
				            </table>
                   		</div>
                   		<br/>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style = "margin-left: 0px;" id = "show"></span><br>
                      <span style = "margin-left: 10px;" id="makeMan">制单员：</span><span style = "margin-left: 100px;">维修顾问签名：</span><span style = "margin-left: 110px;">客户签名：</span>
                  </td>
                 
            </tr>
        </table>
    </div>
    <script type="text/javascript">
			 nui.parse();
			 var mainUrl = "com.hsapi.repair.repairService.svr.qyeryMaintainListBX.biz.ext?";
			 var baseUrl = apiPath + repairApi + "/"; 
			 var QD = [{id:1,text:"FWD"},{id:2,text:"RWD"},{id:3,text:"4WD"}];
			 $(document).ready(function (){
			 	var date = new Date();
			 	document.getElementById("date").innerHTML = format(date, "yyyy-MM-dd HH:mm");
			 	initCarBrand("carBrandId",function(){
				 
	 			});
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
        	
        	function checkBoxChange(e){
        		console.log(e);
        	}
        	
			 function SetData(serviceId,type){
			    var imgUrl = currCompLogoPath || "";
                if(imgUrl && imgUrl != ""){
                    $('#showImg').show();
                    $("#showImg").attr("src",imgUrl);
                 }
				 if(type){//默认报价单
					if(type == 4){
						document.getElementById("spstorename").innerHTML = "波箱厂内翻新单";
						document.getElementById("msg").innerHTML = "";
						document.getElementById("hidden2").style.display =""
					}else{
						document.getElementById("spstorename").innerHTML = "结算单";
				 	document.getElementById("msg").innerHTML = '服务满意度调查：<input id="satisfaction" name="satisfaction" type="checkbox" value="非常满意" onclick="return false;"/>非常满意     '+
				 						'<input id="satisfaction" name="satisfaction" type="checkbox" value="基本满意" onclick="return false;"/>基本满意     '+
				 						'<input id="satisfaction" name="satisfaction" type="checkbox" value="一般" onclick="return false;"/>一般     '+
				 						'<input id="satisfaction" name="satisfaction" type="checkbox" value="不满意" onclick="return false;"/>不满意     '+
				 						'<div>            尊敬的客户：为了维护您的利益改进本公司的工作，如您对本公司服务有不满意之处，请您拨打华胜波箱中心投诉电话：123321234567</div>'
					}
				 }
				 document.getElementById("currCompTel").innerHTML = "&nbsp;&nbsp;&nbsp;"+currCompTel;
				 document.getElementById("currCompAddress").innerHTML = "&nbsp;&nbsp;&nbsp;"+currCompAddress;
				 document.getElementById("currBankName").innerHTML = "&nbsp;&nbsp;&nbsp;"+currBankName;
				 document.getElementById("currBankAccountNumber").innerHTML = "&nbsp;&nbsp;&nbsp;"+currBankAccountNumber;
			 	 $.post(baseUrl+mainUrl+"params/rid="+serviceId+"&token="+token,{},function(text){
			 	 	   if(text.list.length > 0){
			 	 	   		 var list = text.list[0];
			 	 	   		 var guestFullName = list.guestFullName || "";
			 	 	   		 var boxModel = list.boxModel || "";
			 	 	   		 var driveType = QD[list.driveType-1].text;
			 	 	   		 var name = list.name || "";
			 	 	   		 var boxNo = list.boxNo || "";
			 	 	   		 var carBrandId = list.carBrandId || "";
			 	 	   		 nui.get("carBrandId").setValue(carBrandId);
			 	 	   		 var  carBrand = nui.get("carBrandId").text || "";
			 	 	   		 var guestAddr = list.guestAddr || "";
			 	 	   		 var guestMobile = list.guestMobile || "";
			 	 	   		 var engineNo =list.engineNo || "";
			 	 	   		 var enterKilometers = list.enterKilometers || "";
			 	 	   		 var enterDate = list.enterDate || "";
			 	 	   		 var serviceCode = list.serviceCode || "";
			 	 	   		 var drawOutReport = list.drawOutReport || "";
			 	 	   		 document.getElementById("guestFullName").innerHTML = "&nbsp;&nbsp;&nbsp;"+guestFullName;
			 	 	   		 document.getElementById("boxModel").innerHTML = "&nbsp;&nbsp;&nbsp;"+boxModel;
			 	 	   		 document.getElementById("driveType").innerHTML = "&nbsp;&nbsp;&nbsp;"+driveType;
			 	 	   		 document.getElementById("name").innerHTML = "&nbsp;&nbsp;&nbsp;"+name;
			 	 	   		 document.getElementById("boxNo").innerHTML = "&nbsp;&nbsp;&nbsp;"+boxNo;
			 	 	   		 document.getElementById("carBrand").innerHTML = "&nbsp;&nbsp;&nbsp;"+carBrand;
			 	 	   		 document.getElementById("guestAddr").innerHTML = "&nbsp;&nbsp;&nbsp;"+guestAddr;
			 	 	   		 document.getElementById("guestMobile").innerHTML = "&nbsp;&nbsp;&nbsp;"+guestMobile;
			 	 	   		 document.getElementById("engineNo").innerHTML = "&nbsp;&nbsp;&nbsp;"+engineNo;
			 	 	   		 document.getElementById("enterKilometers").innerHTML = "&nbsp;&nbsp;&nbsp;"+enterKilometers || 0 + "KM";
			 	 	   		 document.getElementById("enterDate").innerHTML = "&nbsp;&nbsp;&nbsp;"+document.getElementById("enterDate").innerHTML + format(enterDate, "yyyy-MM-dd HH:mm");
			 	 	   		 document.getElementById("serviceCode").innerHTML = "&nbsp;&nbsp;&nbsp;"+serviceCode;
			 	 	   		 document.getElementById("drawOutReport").innerHTML = "&nbsp;&nbsp;&nbsp;"+drawOutReport;
			 	 	   }
			 	 });
			 	 var url_one = "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext?serviceId=";
			 	 $.post(baseUrl+url_one+serviceId+"&token="+token,{},function(text){//套餐
	        	if(text.errCode == "S"){
	    			 var data = text.data;
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
	    					var prdtName = data[i].prdtName;
	    					var orderIndex = data[i].orderIndex;
	    					var rate = data[i].rate;
	    					rate = rate + "%";
	    					if(data[i].billPackageId != 0){
	    						prdtName = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+prdtName;
	    						orderIndex = "";
	    						
	    					}else{
	    						document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML) + parseFloat(data[i].subtotal);
	    					}
	    					if(data[i].billItemId == 0){
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
					    				.replace("[uintPrice]",data[i].amt)
					    				.replace("[amt]",data[i].amt)
					    				.replace("[rate]",rate)
					    				.replace("[subtotal]",data[i].subtotal));
					    			tBody.append(tr); 
	    					}
	    				}
	    				 document.getElementById("prdt").innerHTML = parseFloat(document.getElementById("prdt").innerHTML).toFixed(2);
	    				 var money = parseFloat(document.getElementById("prdt").innerHTML);
	    				 document.getElementById("cash1").innerHTML = parseFloat(money).toFixed(2);
	    				 money = transform(money+"");
    		   			 document.getElementById("money").innerHTML = money;
		        	}else{
	                  $("#showPkg").hide();
	                  $("#space1").hide();
	                }
	          }
        	});
			 }
    </script>
</body>
</html>