<%@include file="/common/sysCommon.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
        //获取openid
	    String code =request.getParameter("code");
		System.out.println("code:"+code);
		String appid="wxd10b49dcb45e5591";
		String secret="8f21ab04f3b9bc252d8dce64a6d055e4";
		String getOpenid="";
	    System.out.println(code);
	    if (code != null){
	        //获取openid和access_token的连接
	        StringBuffer result = new StringBuffer(); //用来接受返回值
			URLConnection connection = null; //创建的http连接
			URL httpUrl = null; //HTTP URL类 用这个类来创建连接
			BufferedReader bufferedReader = null; //接受连接受的参数
	        String getOpenIdUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code";
	       	String requestUrl = getOpenIdUrl.replace("CODE", code);
	       	requestUrl = requestUrl.replace("APPID", appid);
	        requestUrl = requestUrl.replace("APPSECRET", secret);
	        httpUrl=new URL(requestUrl);
			connection = httpUrl.openConnection();
			connection.connect();
			 bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
		        String line;
		        while ((line = bufferedReader.readLine()) != null) {
		            result.append(line);
		        }
	        System.out.println(result);
	        JSONObject jsStr = JSONObject.parseObject(result.toString());
	        String openid = jsStr.getString("openid");
	          getOpenid=openid;
		}
    	System.out.println("openid:"+getOpenid);
    	//菜单点击的页面
    	String weChatMenuStirng=request.getParameter("weChatMenuStirng");
    	System.out.println("weChatMenuStirng:"+weChatMenuStirng);
 %>
<html>
<!-- 
  - Author(s): 11017555
  - Date: 2018-10-08 10:25:05
  - Description:
-->
<head>
<title>车道车服</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>


	<script type="text/javascript">
    	nui.parse();
    	$(function(){
    		var openid="<%=getOpenid %>";
    		var pathapi=apiPath+wechatApi;
    		var pathweb=webPath+wechatDomain;
    		//window.location.href="http://ppwq72ty36.51http.tech/default/com.hsweb.wechat.autoServiceSys.userLogin.flow?openId="+openid;
    		initLoaction(openid,pathweb,pathapi);
    	});
    	
    	function initLoaction(openid,pathweb,pathapi){
    		var acconJson={password:"000000",userId:"YX001"};
    		var weChatMenuStirng = "<%=weChatMenuStirng %>";
    		/* var acconJson={password:"qxy.123",userId:"syswechat"}; */
    		nui.ajax({
				url: pathweb+"/com.hsapi.system.auth.LoginManager.userLogin.biz.ext",
				type: 'POST',
				data: acconJson,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					var  token = text.data.attributes.token;
					var json=nui.encode({openId:openid});
		    		console.log(token,json);
		    		nui.ajax({//http://qxy60.hszb.harsons.cn/wechatApi  http://ppwq72ty36.51http.tech/default
						url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryUserStoreCarGetOpenid.biz.ext?token="+token,
						type: 'POST',
						data: json,
						cache: false,
						async: false,
						contentType: 'text/json',
						success: function(text) {
							if(weChatMenuStirng && weChatMenuStirng != "null" ){//菜单点击进入
								if(text.userData.length > 0 ){//已经绑定的用户
									var userData=text.userData[0];
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/menuLogin?carId="+userData.userCarId+"&carModelId="+userData.carModelId+"&carid="+userData.carId+"&userCarNo="+userData.carNo+"&guestId="+userData.guestId+"&openid="+openid+"&orgid="+userData.orgid+"&storeId="+userData.storeId+"&storeName="+userData.storeName+"&tenantId="+userData.tenantId+"&userId="+userData.userId+"&userPhone="+userData.userPhone+"&weChatMenuStirng="+weChatMenuStirng;
								}else if( text.userNo.length > 0  && text.storeData.length <=0 ){//已经关注公众号，，但没有关联门店和绑定
									var userNo=text.userNo[0];
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/menuLogin?openid="+openid+"&userId="+userNo.userId+"&weChatMenuStirng="+weChatMenuStirng;
								}else if( text.storeData.length > 0 && text.userNo.length > 0){//已关注公众号和门店，但没有绑定
									var userNo=text.userNo[0];
									var storeData = text.storeData[0];
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/menuLogin?openid="+openid+"&userId="+userNo.userId+"&orgid="+storeData.orgid+"&storeId="+storeData.storeId+"&storeName="+storeData.storeName+"&tenantId="+storeData.tenantId+"&weChatMenuStirng="+weChatMenuStirng;
								}
							}else{
								if(text.userData.length > 0 ){//已经绑定的用户
									var userData=text.userData[0];
									// http://tomato.harsonserver.com/app/test-chedaoWeixin/
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/loginHome?userId="+userData.userId+"&userPhone="+userData.userPhone+"&guestId="+userData.guestId+"&openid="+openid;
								}else if( text.userNo.length > 0  && text.storeData.length <=0 ){//已经关注公众号，，但没有关联门店和绑定
									var userNo=text.userNo[0];
									// http://tomato.harsonserver.com
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/mapLocation?openid="+openid+"&userId="+userNo.userId;
								}else if( text.storeData.length > 0 && text.userNo.length > 0){//已关注公众号和门店，但没有绑定
									var userNo=text.userNo[0];
									var storeData = text.storeData[0];
									window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/registered?openid="+openid+"&userId="+userNo.userId+"&orgid="+storeData.orgid+"&storeId="+storeData.storeId+"&storeName="+storeData.storeName+"&tenantId="+storeData.tenantId+"&storeMarke=useStore";
								}
							}
							
							
						}
					});
					
					
				}
			});
    	}
    </script>
</body>
</html>