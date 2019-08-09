<%@include file="/common/sysCommon.jsp"%>
<%@page import="com.huasheng.userSSDK.CreateSigntrue"%>
<%@page import="com.huasheng.userSSDK.JsapiTicketUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-12 16:32:37
  - Description:
-->
<head>
<%
	//String data=request.getParameter("data");
	//String[] dataN=data.split(",");
	//String appId=dataN[0];
    //String  jsapi_ticket=dataN[1];
    
    // 必填，企业号的唯一标识，此处填写企业号corpid
    String appId="wxd10b49dcb45e5591";
    
    String jsapi_ticket = JsapiTicketUtil.getJSApiTicket();
    
    System.out.println("===jsapi_ticket==="+jsapi_ticket);
    System.out.println("===scheme==="+request.getScheme());
    System.out.println("===port==="+request.getServerPort());
    
    boolean isNormalPort = ("http".equals(request.getScheme()) && 80 == request.getServerPort()) || 
    				("https".equals(request.getScheme()) && 443 == request.getServerPort());
    				
    System.out.println("===isNormalPort==="+isNormalPort);
    
    String port = isNormalPort ? "" : (":"+request.getServerPort());
    
	String URL_X = request.getScheme()+"://"+request.getServerName()+port+request.getContextPath()+request.getServletPath();
	
	String queryString=request.getQueryString();
	
	if(queryString==null){
		queryString="";
	}
	if(!queryString.equals("")){
	   URL_X = URL_X + "?"+ queryString;
	}
	
	String url1=URL_X.split("#")[0];
	
    String signature="" ;
    
	System.out.println("===URL_X==="+URL_X);
	
    CreateSigntrue  getSi= new CreateSigntrue();
    
    System.out.println("url1:"+url1);
    
    String arr1[]=getSi.signTrue(url1,appId,jsapi_ticket);
    
    // 必填，生成签名的时间戳
    String timestamp =arr1[0];
    // 必填，生成签名的随机串
    String nonceStr =arr1[1]; 
    // 必填，签名
    String qianm1 =arr1[2]; 
	
	System.out.println("签名的时间戳: "+timestamp);
	System.out.println("签名的随机串: "+nonceStr);
	System.out.println("签名: "+qianm1);
 %>
<title>地图定位</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
</head>
<body>



	<script type="text/javascript">
    	nui.parse();
    	$(function(){ 
			wx.config({
				beta: true,						// 必须这么写，否则在微信插件有些jsapi会有问题
			    debug: true,		 			// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	        	appId: '<%=appId%>',   			// 必填，企业号的唯一标识，此处填写企业号corpid
	        	timestamp:<%=timestamp %>, 		// 必填，生成签名的时间戳
	        	nonceStr: '<%=nonceStr %>', 	// 必填，生成签名的随机串
	        	signature: '<%=qianm1 %>',		// 必填，签名
			    jsApiList: ['openLocation','getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2  
			});
			wx.error(function(res){
				alert(JSON.stringify(res));
	    		// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。
			});
			
			wx.ready(function(){
				/* wx.openLocation({
					latitude:23.132006, // 纬度，浮点数，范围为90 ~ -90
					longitude:113.377785, // 经度，浮点数，范围为180 ~ -180。
					name: '叩丁狼教育', // 位置名
					address: '专业IT培训', // 地址详情说明
					scale: 25, // 地图缩放级别,整形值,范围从1~28。默认为最大
					infoUrl: '' // 在查看位置界面底部显示的超链接,可点击跳转
				}); */
				wx.getLocation({
					type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
					success: function (res) {
						var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
						var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
						var speed = res.speed; // 速度，以米/每秒计
						var accuracy = res.accuracy; // 位置精度
						alert("纬度"+latitude);
						alert("经度"+longitude);
						alert("速度"+speed);
						alert("位置精度"+accuracy);
					}
				});	
			});
			
		});
    </script>
</body>
</html>