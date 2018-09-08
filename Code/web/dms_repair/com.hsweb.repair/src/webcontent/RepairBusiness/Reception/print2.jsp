<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-09-07 18:52:50
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/date.js"  type="text/javascript"></script>    
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

                table.ybk td {
                    border: 1px solid #000;
                }

        .print_btn {
            text-align: center;
            width: 100%;
            padding: 30px 0 20px 0;
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
<body>
<div class="boxbg" style="display:none"></div>
    <div class="print_btn">
        <a id="print" href="javascript:void(0)" style="background: #ff6600;">打印</a>
        <a href="/Main/serve/PrintStatementA5/4207501">A5打印</a>
    </div>
    <div style="margin: 0 10px;" class="printny">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
                <tr>
                    <td>
                            <div style="font-size: 30px; font-family: 微软雅黑;"><b><span id="spstorename"></span>维修结算单</b></div>
                        
                        <div style="padding-top: 2px; font-size: 16px;">
                            编号：<span id="spno"></span>
                            
                        </div>
                    </td>
                    <td width="65">
                            <div style="float: right; text-align: center;">
                                <div id="qrcode" style="display:block;"></div>
                                扫码支付
                            </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <div style="border-bottom: 1px #333 solid; height: 2px; margin-bottom: 10px;">&nbsp;</div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>地址：<span id="spaddress"></span></td>
                <td align="right">进厂时间：</td>
            </tr>
            <tr>
                <td>电话：<span id="spphoneno"></span></td>
                    <td align="right">打印时间：</td>

            </tr>
        </table>

        <div style="padding-top: 10px;">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td height="24" width="33%">&nbsp;客户名称：</td>
                        <td>&nbsp;联系电话：</td>
                    <td width="33%">&nbsp;接待人员：</td>
                </tr>
                <tr>
                    <td height="24">&nbsp;车牌：</td>
                    <td>&nbsp;车辆型号： </td>
                    <td>&nbsp;车架号：</td>
                </tr>
                <tr>
                    <td height="24">&nbsp;送修人：</td>
                    <td>&nbsp;送修人电话：</td>
                    <td>&nbsp;行驶里程：</td>
                </tr>
            </table>
        </div>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b>序号</b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>套餐项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
            </table>
        <div style="height: 12px;"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="ybk">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b>序号</b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>工时项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
            </table>
            <div style="height: 12px;"></div>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                    <td width="40" align="center" bgcolor="#f8f8f8"><b>序号</b></td>
                    <td height="28" align="center" bgcolor="#f8f8f8"><b>配件项目</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>单价</b></td>
                    <td width="60" align="center" bgcolor="#f8f8f8"><b>数量</b></td>
                    <td width="70" align="center" bgcolor="#f8f8f8"><b>优惠率</b></td>
                    <td width="80" align="center" bgcolor="#f8f8f8"><b>金额</b></td>
                </tr>
            </table>
            <div style="height: 12px;"></div>
                <div style="color:#000;height:32px; margin-top:-8px;">
            <span style="font-size: 16px; float:right; font-weight: bold;">原价合计：&yen;元</span>
            工时：&nbsp;&nbsp;+&nbsp;&nbsp;配件：&nbsp;&nbsp;+&nbsp;&nbsp;其它：
        </div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
            <tr>
                <td height="36" colspan="6" bgcolor="#f0f0f0">
                    <div style="float: right; color: #000; margin-right: 12px; line-height: 36px;">
                        <span style="margin-right: 15px;">
                            <b style="font-size: 16px;">合计</b>：
                            <font style="font-size: 15px; font-weight: bold;">
                                
                            </font>元
                        </span>
                        <b style="font-size: 16px;">大写</b>：
                        <font style="font-size: 15px; font-weight: bold;">
                            捌佰元整
                        </font>
                    </div>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="ybk">
                <tr>
                    <td height="50" valign="top" style="padding: 8px;">
                        出车报告：




                    </td>
                </tr>
                <tr>
                    <td height="24" style="padding: 8px;">
                        <dl class="myddc">
                            <dt>服务满意度调查：</dt>
                            <dd><font></font>非常满意</dd>
                            <dd><font></font>基本满意</dd>
                            <dd><font></font>一般</dd>
                            <dd><font></font>不满意</dd>
                        </dl>
                    </td>
                </tr>
            <tr>
                <td height="30" style="padding: 8px;">
                    <div style="font-size: 15px;">
                        <span id="spremark">
                            
                        </span>


                        
                    </div>
                    <ul class="renyuan">
                        <li>服务顾问：</li>
                        <li>收银员：</li>
                        <li>客户签名：</li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
	<script type="text/javascript">
		$(document).ready(function (){
			$("#print").click(function () {
	            $(".print_btn").hide();
	            window.print();
	        });  
	          	
        });
    </script>
</body>
</html>