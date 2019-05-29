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
        <a id="print" href="javascript:void(0)" onclick="CloseWindow('cancle')">取消</a>
        <a plain="true" iconCls="" plain="false" onclick="sendInfo()" id = "sendInfo">发送短信</a>
        <a style="" plain="true" iconCls="" plain="false" onclick="sendWechatInfo()" id = "openId">发送微信</a>
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
	                	<td rowspan="2" style="width: 133px;text-align: center">
	                     	<img alt="" src="http://qxy60.7xdr.com/Fv1sKmBhuP9apHjTtFsNG5fKTlV7" id="showImg" height="60px">
	                    </td>
	                    <td style="width:55%">
                            <div style="font-size: 18px; font-family: 黑体;padding-top: 5px;padding-left: 10px;"><span id="comp">车道东莞测试12店</span></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">您身边的车管家</span></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">一次选择 终生服务</span></div>
	                    </td>
	                    <td rowspan="2" style="">
	                        <div style="font-size: 20px; font-family: 华文中宋;padding-top: 5px;"><b><span id="spstorename">现款购车计算表</span></b></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">Loan Detail</span></div>
                            <div style="font-size: 14px;padding-left: 10px; "><span id="slogan1">打印日期：2019-5-24 11:17:38</span></div>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
        </div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk" style="line-height:32px;margin-top:5px;天天斗图">
            <tbody>
                <tr>
                    <td height="50" valign="top" style="padding:8px" id="guestDesc">
                            购车人
                    </td>
                      <td height="50" valign="top" style="padding: 8px;" id="faultPhen">
                            <span id="guestFullName"></span>
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="solveMethod">
                                                       购车方式
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="">
                                                      现款
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding: 8px;" id="">
                                                       购买车型
                    </td>
                      <td height="50" valign="top" style="padding: 8px;" id="">
                            <span id="carModelName"></span>
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="">
                                                       车价（元）
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="">
                            <span id="saleAmt"></span>
                    </td>
                </tr>
                <tr>
                    <td height="50" valign="top" style="padding: 8px;" id="" colspan="2">
                            本明细表所列费用为购车的所有费用
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="">
                                                       厂商指导价（元）
                    </td>
                     <td height="50" valign="top" style="padding: 8px;" id="">
                                                      239800
                    </td>
                </tr>
        </tbody>
        <tbody>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                项目名称
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="">
                                金额（元）
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                项目名称
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                金额（元）
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                保险预算费
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="insuranceBudgetAmt"></span>
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                上牌费
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="boardLotAmt"></span>
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                购置税预算
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="purchaseBudgetAmt"></span>
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                精品加装
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="decrAmt"></span>
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                GPS费
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="gpsAmt"></span>
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                其它费用
                        </td>
                         <td height="50" valign="top" style="padding: 8px;" id="">
                                <span id="otherAmt"></span>
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                提车合计
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="" colspan="3">
                                <span id="getCarTotal" style="width:95px;display: inline-block;"></span>&nbsp;&nbsp;<span >大写（人民币）：叁佰贰拾叁万贰仟伍佰玖拾伍元整</span>
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                购车预算合计
                        </td >
                          <td height="50" valign="top" style="padding: 8px;" id="" colspan="3">
                                <span id="buyBudgetTotal" style="width:95px;display: inline-block;"></span>&nbsp;&nbsp;<span >大写（人民币）：元</span>
                        </td>
                    </tr>
                <tr>
                        <td height="50" valign="top" style="padding: 8px;" id="">
                                备注
                        </td>
                          <td height="50" valign="top" style="padding: 8px;" id="" colspan="3">
                        </td>
                    </tr>
                    <tr style=height:100px;>
                            <td height="100" valign="top" style="padding: 8px;" id="" colspan="4">
                                <div>
                                    <div style="float:left;width:200px;">销售顾问：<span ></span></div>
                                    <div style="float:right;width:200px;">客户（签字）：<br>
                                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
                                    </div>
                                    <div style="clear:both"></div>
                                    <div style="height:50px;width:100%"></div>
                                    <div style="width:100%;height:20px;">
                                        <span>特别声明：客户签字后本购车计算表与购车合同起同等法律效力。</span>
                                    </div>

                                </div>     
                            </td>
                        </tr>
            </tbody>
        </table>
    </div>
	<script type="text/javascript">
		$("#print").click(function () {
            $(".print_btn").hide();
            $(".print_hide").hide();
            
            window.print();
        }); 
        getTableData() ;
        function getTableData() {
            var url = 'http://127.0.0.1:8080/default/sales.search.searchSaleCalc.biz.ext?billType=2&serviceId=24';
            $.post(url,function(res){
                if(res.data.length > 0){
                    var temp = res.data[0];
                    //document.getElementById("guestFullName").innerHTML = temp.guestFullName;
                    //document.getElementById("carModelName").innerHTML = temp.carModelName;
                    document.getElementById("saleAmt").innerHTML = temp.saleAmt;//车价（元）
                    document.getElementById("insuranceBudgetAmt").innerHTML = temp.insuranceBudgetAmt;//保险预算费
                    document.getElementById("boardLotAmt").innerHTML = temp.boardLotAmt;//上牌费
                    document.getElementById("purchaseBudgetAmt").innerHTML = temp.purchaseBudgetAmt;//购置税预算	
                    document.getElementById("decrAmt").innerHTML = temp.decrAmt;//精品加装	
                    document.getElementById("gpsAmt").innerHTML = temp.gpsAmt;//GPS费
                    document.getElementById("otherAmt").innerHTML = temp.otherAmt;//其它费用
                    document.getElementById("getCarTotal").innerHTML = temp.getCarTotal;//提车合计
                    document.getElementById("buyBudgetTotal").innerHTML = temp.buyBudgetTotal;//购车预算合计
                }
            });


        }
            
    </script>
</body>
</html>