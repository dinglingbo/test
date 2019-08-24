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
<title>链车币充值</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/tenant/js/chainCarCoinRecharge.js?v=1.0.1" type="text/javascript"></script>
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
		    background: url(../img/cztcbtn.gif) right bottom no-repeat;
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
    </style>
</head>
<body>
    <div id="fw" class="fw" style="margin-left: 0;">
             <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top: 15px;">
            <tbody>
                <tr>
                    <td>
                        <div style="padding: 15px; background: #fbf7f2; border: 1px #e9e2d9 solid; height: auto; overflow: hidden;">
                            <p class="kaitong"><a href="/Main/Tool/ConsumeRecord" style="width:120px; font-size:14px;">充值消费记录</a></p>
                            <font class="sfbz" style="line-height: 34px; margin-left: 10px;"><b>注：</b><b style="color:#ff9600; margin:0 5px;">1元人民币</b>= <em>100个链车币</em></font>
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
                                    <td height="420" valign="top" style="border: 1px #dce1e5 solid; border-radius: 8px; background: url(images/ystopbg.png) 0 -30px repeat-x; box-shadow: 0px 2px 4px rgba(230, 235, 242, 0.5);">
                                        <table width="92%" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                                            <tbody>
                                                <tr>
                                                    <td width="80" height="60" class="color999">剩余余额：</td>
                                                    <td><b style="color: #00b400;">0</b>&nbsp;个</td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" class="color999">选择套餐：</td>
                                                    <td valign="top">
                                                        <div class="cztc" id="demo">
<!--                                                             <a href="#" itemid="1" itemmoney="20">
                                                                ¥<font>20</font>
                                                                <p>充值2000个</p>
                                                            </a>
                                                            <a href="#" itemid="2" itemmoney="100">
                                                                ¥<font>100</font>
                                                                <p>充10000个送1000个</p>
                                                            </a>
                                                            <a href="#" itemid="3" itemmoney="500">
                                                                ¥<font>500</font>
                                                                <p>充50000个送10000个</p>
                                                            </a>
                                                            <a href="#" itemid="4" itemmoney="1000">
                                                                ¥<font>1000</font>
                                                                <p>充100000个送30000个</p>
                                                            </a>
                                                            <a href="#" itemid="5" itemmoney="2000">
                                                                ¥<font>2000</font>
                                                                <p>充200000个送80000个</p>
                                                            </a> -->
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td height="60" class="color999">支付金额：</td>
                                                    <td id="paymoney">0元</td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" class="color999">&nbsp;</td>
                                                    <td valign="top"><a href="#" class="btn" itemid="0">确认充值</a></td>
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

</body>
<script type="text/javascript">
	var type = null;
	type = "<%= request.getParameter("type")%>";
	
</script>


</html>