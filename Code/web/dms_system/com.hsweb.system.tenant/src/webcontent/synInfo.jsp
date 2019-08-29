<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): dlb
  - Date: 2019-08-26 11:32:24
  - Description:
-->
<head>
<title>系统信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/tenant/js/synInfo.js?v=1.0.5" type="text/javascript"></script>
    <style type="text/css">
    	.titel{
    		width: 20px;
    		height: 35px;
    	}
    	 .content{
    		width: 80%;
    		height: 35px;
    	}
    	span{margin-left:20px;}
    	.have {
    		cursor:pointer;
		    width: 90px;
		    height: 30px;
		    font-size: 16px;
		    text-align: center;
		    margin-left: 10px;
		    border-radius: 5px;
		    text-decoration: none;
		    line-height: 2;
		    background: #2180d2c7;
		    color: #f2f5f7;
		    border: 1px solid #c0e1fd;
		}
		.noHave {
			cursor:pointer;
		    width: 90px;
		    height: 30px;
		    font-size: 16px;
		    text-align: center;
		    margin-left: 10px;
		    border-radius: 5px;
		    text-decoration: none;
		    line-height: 2;
		    background: #252525ab;
		    color: #f2f5f7;
		    border: 1px solid #c0e1fd;
		}
		.kaitong {
		    width: 90px;
		    height: 34px;
		    background: #21c064;
		    border-radius: 5px;
		    display: inline-table;
		    color: #fff;
		    font-size: 16px;
		    text-align: center;
		    text-decoration: none;
		    line-height: 34px;
		}		
    </style>
</head>
<body>
<div class="nui-fit" style="width: 100%;height: 100%;">
	<div style="width: 100%;">
	
	<span style="font-size: 16px;font-weight:bold;">系统信息  <a class = "kaitong" href="#" style="width:120px;background: #4f9ada; font-size:14px;margin-left: 70%;" onclick="toSysCoinRecord()">链车币充值</a><a class = "kaitong" href="#" style="width:120px; font-size:14px;margin-left: 10px;" onclick="toSysCoinRecord()">充值消费记录</a></span>

	<hr  style="color: #fff; width:100%;"/>	
	</div>
	<p style="font-size: 18px;margin-left: 20px;">基础信息</p>
	<table border="1" cellspacing="0" cellpadding="0" style="border-color:aliceblue;width: 100%"  >
		<tr>
			<td class="titel"><span>商户号</span></td>
			<td class="content"><span id="code"></span></td>
		</tr>
		<tr>
			<td class="titel"><span>商户名称</span></td>
			<td class="content"><span id="tenantName"></span></td>
		</tr>
		<tr>
			<td class="titel"><span>服务到期日期</span></td>
			<td class="content"><span id="endDate"></span >  剩余<span id="endDay" style="color: #00b400;margin-left:5px;font-size: 18px;" ></span>&nbsp;天</td>
		</tr>
		<tr>
			<td class="titel"><span>负责人</span></td>
			<td class="content"><span id="auditMan"></span></td>
		</tr>	
		<tr>
			<td class="titel"><span>联系电话</span></td>
			<td class="content"><span id="mobile"></span></td>
		</tr>
<!-- 		<tr>
			<td class="titel"><span>端口数量</span></td>
			<td class="content"><span id=""></span></td>
		</tr> -->
		<tr>
			<td class="titel"><span>分店数量</span></td>
			<td class="content"><span id="storesQty"></span></td>
		</tr>	
		<tr>
			<td class="titel"><span>版本</span></td>
			<td class="content"><span id="">1.0.0</span></td>
		</tr>										
	</table>
	<p style="font-size: 18px;margin-left: 20px;">模块信息</p>
		<table border="1" cellspacing="0" cellpadding="0" style="border-color:aliceblue;width: 100%">
		<tr>
			<td class="titel"><span>基础模块</span></td>
			<td class="content"><span id="basis"></span></td>
		</tr>
		<tr>
			<td class="titel"><span>升级模块</span></td>
			<td class="content"><span id="upgrade"></span></td>
		</tr>										
	</table>
	<p>注：灰色为未购买产品，点击即可购买！</p>
</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>