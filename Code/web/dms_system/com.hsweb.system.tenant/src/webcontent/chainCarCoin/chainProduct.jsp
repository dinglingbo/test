<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-21 12:20:40
  - Description:
-->
<head>
<title>产品充值</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/tenant/js/chainProduct.js?v=1.1.5" type="text/javascript"></script>
    <style type="text/css">
    	.sfbz em {
		    color: #5fc8d7;
		    font-weight: 700;
		}
		.kaitong a {
		    width: 90px;
		    height: 34px;
		    background: #21c064;
		    border-radius: 5px;
		    display: block;
		    color: #fff;
		    font-size: 16px;
		    text-align: center;
		    text-decoration: none;
		    line-height: 34px;
		    float: left;
		}
		body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, input, p {
		    margin: 0;
		    padding: 0;
		    font-family: "微软雅黑", "宋体","黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
		    font-size: 14px;
		    font-style: normal;
		    font-weight: normal;
		    font-variant: normal;
		}
		.cztc a {
		    display: block;
		    float: left;
		    width: 200px;
		    height: 76px;
		    border: 1px #a6e0f5 solid;
		    margin: 0 25px 25px 0;
		    text-align: center;
		    text-decoration: none;
		    color: #666;
		    padding-top: 14px;
		}
		.cztc a.xz {
		    border: 1px #ff6600 solid;
		    color: #ff6600;
		    background: url(<%= request.getContextPath() %>/tenant/img/cztcbtn.gif) right bottom no-repeat;
		}
		.cztc a font {
		    font-size: 18px;
		    margin-left: 2px;
		}
		.cztc a p {
		    color: #999;
		}
		.color999 {
		    color: #999;
		}
		a.btn {
		    background: #28bef0;
		    text-decoration: none;
		    display: inline-block;
		    height: 38px;
		    line-height: 38px;
		    padding: 0 22px;
		    border-radius: 5px;
		    color: #fff;
		    font-size: 15px;
		}
		a.btn:hover {
		    background: #3ca0dc;
		    box-shadow: 0px 1px 2px #c8c8c8;
		}
		.kaitong {
		    float: right;
		}
	.popbox {
	    background: #fff;
	    position: fixed;
	    left: 50%;
	    top: 50%;
	    box-shadow: 0px 0px 15px #888;
	    z-index: 2244;
	    margin: -220px 0 0 -360px;
	    width: 720px;
	    height: 440px;
	    border-radius: 5px;
    }	
	 a.close2 {
	    width: 14px;
	    height: 14px;
	    background: url(<%= request.getContextPath() %>/tenant/img/close.png) no-repeat;
	    display: block;
	    position: absolute;
	    right: 15px;
	    text-decoration: none;
	    top: 17px;
	}
	.popbox h2 {
	    background: #f8f8f8;
	    height: 50px;
	    line-height: 50px;
	    font-size: 18px;
	    padding-left: 14px;
	    border-radius: 5px 5px 0 0;
	}	   	
    </style>
</head>
<body>
    <div id="fw" class="fw" style="margin-left: 0;">
             <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top: 15px;">
            <tbody>
                <tr>
                    <td>
                        <div style="padding: 15px; background: #fbf7f2; border: 1px #e9e2d9 solid; height: auto; overflow: hidden;">
                            <p class="kaitong"><a href="/Main/Tool/ConsumeRecord" style="width:120px; font-size:14px;" onclick="toSysCoinRecord()">充值消费记录</a></p>
<!--                             <font class="sfbz" style="line-height: 34px; margin-left: 10px;"><b>注：</b><b style="color:#ff9600; margin:0 5px;">产品总天数=剩余天数+充值天数</b> <em></em></font> -->
                            <p style="margin-left: 50px;font-size: 15px;">到期日期：<b style="color:#00b400; margin:0 5px;" id="endDate"></b>(剩余：<b style="color:#ff9600; margin:0 5px;" id="endDay"></b> 天)</p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="840" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 60px;">
                            <tbody>
                                <tr>
                                    <td height="420" valign="top" style="border: 1px #dce1e5 solid; border-radius: 8px; box-shadow: 0px 2px 4px rgba(230, 235, 242, 0.5);">
                                        <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                                            <tbody>
                                                <tr>
                                                     <td width="80" height="60" class="color999">产品名称：</td>
                                                    <td><b style="color: #00b400;" id="name"></b></td>
                                                </tr>
                                                <tr>
                                                     <td width="80" height="60" class="color999">充值天数：</td>
                                                    <td><b style="color: #00b400;" id="periodValidity"></b>&nbsp;天</td>
                                                </tr>
                                                <tr>
                                                     <td width="80" height="60" class="color999">产品描述：</td>
                                                    <td><p id="remark"></p></td>
                                                </tr>                                                
                                                <tr>
                                                    <td height="60" class="color999">支付金额：</td>
                                                    <td ><b style="color: #00b400;" id="sellPrice"></b>&nbsp;元</td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" class="color999">&nbsp;</td>
                                                    <td valign="top"><a href="#" class="btn" itemid="0" onclick="sellCoin()">确认充值</a></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="110">&nbsp;</td>
                </tr>
            </tbody>
        </table>

    </div>
</div>
<div class="popbox" id="popbox_1" style="width: 500px; height: 440px; margin: -220px 0 0 -250px; display: none">
    <h2><a class="close2" href="#" title="关闭" onclick="onclosePopbox_1()" >&nbsp;</a>微信支付</h2>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 15px;">
        <tr>
            <td height="66" align="center" class="color999" style="font-size: 18px;">待支付: <span style="font-weight: bold; font-size: 24px; color: #00b400;" id="payqrcodemoney"></span>元</td>
        </tr>
        <tr>
            <td align="center">
                <img  width="300" height="220" id="sellImg" />
            </td>
        </tr>
        <tr>
            <td height="50" align="center" class="color999" style="font-size: 13px;">用微信扫此二维码结算 (10分钟有效)</td>
        </tr>
    </table>
</div>
<div class="popbox" id="popbox_2" style="width: 500px; height: 200px; margin: -120px 0 0 -250px; display: none">
    <h2><a class="close2" href="#" title="关闭" onclick="onclosePopbox_2()" >&nbsp;</a>支付成功</h2>
		<p  style="font-size: 18px;margin-left: 20px;margin-top: 40px;color: #21c064;">支付成功，剩余  <span style="font-weight: bold; font-size: 20px;" id="dtime">5</span> 关闭本页面...</p>
</div>
<script type="text/javascript">
	var productId = null;
	productId = "<%= request.getParameter("productId")%>";
	loadCarCoin(productId);
</script>
</body>
</html>