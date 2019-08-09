<%@page import="weixin.popular.bean.xmlmessage.XMLImgMessage"%>
<%@page import="weixin.popular.bean.xmlmessage.XMLArticleMessage"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="java.io.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="org.dom4j.Document"%>
<%@page import="org.dom4j.Element"%>
<%@page import="org.dom4j.io.SAXReader"%>
<%@page import="com.qq.weixin.mp.aes.AesException"%>
<%@page import="com.eos.data.datacontext.IMapContextFactory"%>
<%@page import="com.eos.data.datacontext.IRequestMap"%>
<%@page import="com.eos.data.datacontext.ISessionMap"%>
<%@page import="com.eos.system.annotation.Bizlet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.wechat.Tool.WechatIncidentTool"%>
<%@page import="weixin.popular.support.ExpireKey"%>
<%@page import="weixin.popular.support.expirekey.DefaultExpireKey"%>
<%@page import="weixin.popular.bean.xmlmessage.XMLMessage"%>
<%@page import="weixin.popular.bean.xmlmessage.XMLTextMessage"%>
<%@page import="weixin.popular.util.SignatureUtil"%>
<%@page import="com.wechat.Tool.WechatLogicTool"%>
<%@page import="com.eos.engine.component.ILogicComponent"%>
<%@page import="com.primeton.ext.engine.component.LogicComponentFactory"%>
<%@page import="com.qq.weixin.mp.aes.SHA1" %>

<%
		//获取appId,微信支付分配的商户号,通知地址
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceBackstage.weChatInquire";
		// 逻辑流名称
		String operationNameAdd = "queryBusinessDict";
		
		ILogicComponent logicComponentAdd = LogicComponentFactory.create(addDate);
		
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = "URL_TOKEN";
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		
		Map<String,String> map = (HashMap<String,String>) resultAdd[0];
	
 		String TOKEN = map.get("URL_TOKEN");
 		ExpireKey expireKey = new DefaultExpireKey();
 		
 		
    	String signature = request.getParameter("signature");
    	System.out.println("signature:"+signature);
        String timestamp = request.getParameter("timestamp");
        System.out.println("timestamp:"+timestamp);
        String nonce = request.getParameter("nonce");
        System.out.println("nonce:"+nonce);
        String echostr = request.getParameter("echostr");
        System.out.println("echostr:"+echostr);
        ServletOutputStream outputStream = response.getOutputStream();
        
        //首次请求申请验证,返回echostr
        if(echostr!=null){
        	String jiami="";
	        try {
				jiami=SHA1.getSHA1(TOKEN, timestamp, nonce,"");//自己根据token加密得到的字符串
			} catch (AesException e1) {
				e1.printStackTrace();
			}
			if(jiami.equals(signature)){//自己加密的和微信加密的对比是否一样，一样则返回 echostr
	        	outputStream.write( echostr.getBytes("utf-8") );
	        	outputStream.flush();
	        	outputStream.close();
	        }
            return;
        }
        
        //验证请求签名
        if(!signature.equals(SignatureUtil.generateEventMessageSignature(TOKEN,timestamp,nonce))){
            System.out.println("The request signature is invalid");
            return;
        }
        
        String judgeType="";
        Map<String, String> wxdata=WechatIncidentTool.parseXml(request);
       	System.out.println(wxdata);
        if(wxdata.get("MsgType")!=null){
            if("event".equals(wxdata.get("MsgType"))){//判断消息内容为：事件推送
            	if( "subscribe".equals(wxdata.get("Event")) && wxdata.get("Ticket") != null ){ //未关注的用户扫描二维码关注公众号
            		judgeType="storeCodeNotAttentionUser";
            	}else  if( "subscribe".equals(wxdata.get("Event")) ){//判断该用户为第一次关注公众号
                	judgeType="userFirstAttention";
                }else if( "unsubscribe".equals(wxdata.get("Event")) ){//判断该用户为取消关注公众号
                	judgeType="userNotAttention";
                }else if ( "SCAN".equals(wxdata.get("Event")) ){//已关注的用户扫描二维码关注公众号
                	judgeType="storeCodeAttentionUser";
                }
                
            }else if( "text".equals( wxdata.get("MsgType") ) ){//文本消息回复
            	System.out.println("文本消息回复");
            	String userSendText=wxdata.get("Content");//用户发的纯文本消息
            	System.out.println(wxdata.toString());
            	HashMap tempMap = WechatLogicTool.queryKeywordReply(userSendText,wxdata.get("FromUserName"));//查询出服务号
            	System.out.println(tempMap.toString());
	            	String replyType = tempMap.get("replyType").toString();  //1.文本/2.图片/3.单图文/4.多图文
	            	//纯文本回复
	            	if("1".equals(replyType)){
		            	//创建回复
		            	XMLMessage xmlTextMessage = new XMLTextMessage(
		                    wxdata.get("FromUserName"),
		                    wxdata.get("ToUserName"),
		                    tempMap.get("imageTextDescribe").toString());
		                //回复
		            	xmlTextMessage.outputStreamWrite(outputStream);
	            	}else if("2".equals(replyType)){//纯图片回复
	            		//创建回复
		            	XMLMessage xmlTextMessage = new XMLImgMessage(
		                    wxdata.get("FromUserName"),
		                    wxdata.get("ToUserName"),
		                    tempMap);
		                //回复
		            	xmlTextMessage.outputStreamWrite(outputStream);
	            	}else if("3".equals(replyType)){//单图文回复
	            		//创建回复
		            	XMLMessage xmlTextMessage = new XMLArticleMessage(
		                    wxdata.get("FromUserName"),
		                    wxdata.get("ToUserName"),
		                    tempMap);
		                //回复
		            	xmlTextMessage.outputStreamWrite(outputStream);
	            	}else if("0".equals(replyType)){//默认回复
	            		//创建回复
		            	XMLMessage xmlTextMessage = new XMLTextMessage(
		                    wxdata.get("FromUserName"),
		                    wxdata.get("ToUserName"),
		                    tempMap.get("imageTextDescribe").toString());
		                //回复
		            	xmlTextMessage.outputStreamWrite(outputStream,tempMap.get("imageTextDescribe").toString());
	            	}
            	
            }
        }
        
		
        if(!judgeType.equals("")){
        	System.out.println("FromUserName :"+wxdata.get("FromUserName"));
        	System.out.println("ToUserName :"+wxdata.get("ToUserName"));
        	System.out.println("MsgId :"+wxdata.get("MsgId"));
        	System.out.println("CreateTime :"+wxdata.get("CreateTime"));
        	System.out.println("Event :"+wxdata.get("Event"));
        	 //转换XML
            String key = wxdata.get("FromUserName")+ "__"
                    + wxdata.get("ToUserName")+ "__"
                    + wxdata.get("MsgId") + "__"
                    + wxdata.get("CreateTime");

            if(expireKey.exists(key)){//重复通知不作处理
            	System.out.println("重复通知不作处理");
                return;
            }else{//第一次通知记录一下
            	System.out.println("第一次通知记录一下");
                expireKey.add(key);
                
                if(judgeType.equals("userFirstAttention")){//用户第一次关注的事件处理
	            	System.out.println("key:"+key);
	            	System.out.println("Ticket:"+wxdata.get("Ticket"));
	            	//HashMap tempMap = WechatLogicTool.queryWechatUserMarke(wxdata.get("FromUserName"));//查询出服务号
	            	
	            	Object resultAdds[]=null;
					// 逻辑构件名称
					String addDates = "com.hsapi.wechat.autoServiceSys.weChatUsers";
					// 逻辑流名称
					String operationNameAdds = "queryWechatUserMarke";
					ILogicComponent logicComponentAdds = LogicComponentFactory
							.create(addDates);
					int sizeAdds= 1;
					// 逻辑流的输入参数
					Object[] paramsAdds = new Object[sizeAdds];
					paramsAdds[0] = wxdata.get("FromUserName");
					try {
						resultAdds = logicComponentAdds.invoke(operationNameAdds, paramsAdds);
					}catch (Throwable e) {
						e.printStackTrace();
					}
					System.out.println("消息："+(String)resultAdds[0]);
					System.out.println("服务号："+(String)resultAdds[1]);
					
					String numberService = (String)resultAdds[1];
	            	int serviceNumber = Integer.parseInt( numberService );
	            	String msgOut = (String)resultAdds[0];
	            	System.out.println(serviceNumber+"---"+msgOut);
	            	//创建回复
	            	XMLMessage xmlTextMessage = new XMLTextMessage(
	                    wxdata.get("FromUserName"),
	                    wxdata.get("ToUserName"),
	                    msgOut);
	                //回复
	            	xmlTextMessage.outputStreamWrite(outputStream);
	            	WechatLogicTool.addWechatUserInfo(wxdata.get("FromUserName"),serviceNumber);//添加用户信息
	            	return;
	            }else if( judgeType.equals("userNotAttention") ){//用户取消关注的事件处理
	            	WechatLogicTool.addWechatUserNotAttentionTime(wxdata.get("FromUserName"),wxdata.get("CreateTime"));//用户取消关注时间
	            }else if( judgeType.equals("storeCodeNotAttentionUser") ){//未关注的用户扫描二维码关注公众号的事件处理
	            	System.out.println("未关注的用户扫描二维码关注公众号");
	            	String str = wxdata.get("EventKey");
	            	
	            	/* HashMap tempMap = WechatLogicTool.queryWechatUserMarke(wxdata.get("FromUserName"));//查询出服务号
	            	int serviceNumber = Integer.parseInt(tempMap.get("serviceNumber").toString());
	            	String strArray[] = str.split("_");
					int storeId = Integer.valueOf(strArray[1]);
	            	WechatLogicTool.addWechatUserInfo(wxdata.get("FromUserName"),serviceNumber,storeId);//添加用户信息
	            	
	            	HashMap tempStoreMap = WechatLogicTool.queryWechatUserMarke(wxdata.get("FromUserName"));//查询出服务号
	            	String msgOut = tempStoreMap.get("msgOut").toString(); */
	            	
	            	//获取服务号，切换门店
	            	Object resultAddOne[]=null;
					// 逻辑构件名称
					String addDateOne = "com.hsapi.wechat.autoServiceSys.weChatUsers";
					// 逻辑流名称
					String operationNameAddOne = "queryWechatUserMarke";
					ILogicComponent logicComponentAddOne = LogicComponentFactory
							.create(addDateOne);
					int sizeAddOne= 1;
					// 逻辑流的输入参数
					Object[] paramsAddOne = new Object[sizeAddOne];
					paramsAddOne[0] = wxdata.get("FromUserName");
					try {
						resultAddOne = logicComponentAddOne.invoke(operationNameAddOne, paramsAddOne);
					}catch (Throwable e) {
						e.printStackTrace();
					}
					System.out.println("服务号One："+(String)resultAddOne[1]);
					String numberServiceOne = (String)resultAddOne[1];
	            	int serviceNumberOne = Integer.parseInt( numberServiceOne );
	            	//门店id获取
	            	String strArray[] = str.split("_");
					int storeId = Integer.valueOf(strArray[1]);
	            	WechatLogicTool.addWechatUserInfo(wxdata.get("FromUserName"),serviceNumberOne,storeId);//添加用户信息
	            	
	            	//重新查询出门店的回复消息
	            	Object resultAddTwo[]=null;
					// 逻辑构件名称
					String addDateTwo = "com.hsapi.wechat.autoServiceSys.weChatUsers";
					// 逻辑流名称
					String operationNameAddTwo = "queryWechatUserMarke";
					ILogicComponent logicComponentAddTwo = LogicComponentFactory
							.create(addDateTwo);
					int sizeAddTwo= 1;
					// 逻辑流的输入参数
					Object[] paramsAddTwo = new Object[sizeAddTwo];
					paramsAddTwo[0] = wxdata.get("FromUserName");
					try {
						resultAddTwo = logicComponentAddTwo.invoke(operationNameAddTwo, paramsAddTwo);
					}catch (Throwable e) {
						e.printStackTrace();
					}
					System.out.println("消息Two："+(String)resultAddTwo[0]);
					System.out.println("服务号Two："+(String)resultAddTwo[1]);
	            	String msgOutTwo = (String)resultAddTwo[0];
	            	
	            	//创建回复
	            	XMLMessage xmlTextMessage = new XMLTextMessage(
	                    wxdata.get("FromUserName"),
	                    wxdata.get("ToUserName"),
	                    msgOutTwo);
	                //回复
	            	xmlTextMessage.outputStreamWrite(outputStream);
	            	return;
	            }else if( judgeType.equals("storeCodeAttentionUser") ){//已关注的用户扫描二维码关注公众号的事件处理
	            	System.out.println("已关注的用户扫描二维码关注公众号");
	            	String str = wxdata.get("EventKey");
					int storeId = Integer.valueOf(str);
					System.out.println("切换的门店"+storeId);
					WechatLogicTool.updateWechatCodeUserStore(wxdata.get("FromUserName"),storeId);//切换门店
					System.out.println("切换结束");
	            	/* HashMap tempMap = WechatLogicTool.queryWechatUserMarke(wxdata.get("FromUserName"));//查询出服务号
	            	int serviceNumber = Integer.parseInt(tempMap.get("serviceNumber").toString());
	            	String msgOut = tempMap.get("msgOut").toString(); */
	            	System.out.println("开始");
	            	//查询出服务号
	            	Object resultAddTwo[]=null;
					// 逻辑构件名称
					String addDateTwo = "com.hsapi.wechat.autoServiceSys.weChatUsers";
					// 逻辑流名称
					String operationNameAddTwo = "queryWechatUserMarke";
					ILogicComponent logicComponentAddTwo = LogicComponentFactory
							.create(addDateTwo);
					int sizeAddTwo= 1;
					// 逻辑流的输入参数
					Object[] paramsAddTwo = new Object[sizeAddTwo];
					paramsAddTwo[0] = wxdata.get("FromUserName");
					System.out.println("参数："+paramsAddTwo[0]);
					try {
						resultAddTwo = logicComponentAddTwo.invoke(operationNameAddTwo, paramsAddTwo);
					}catch (Throwable e) {
						e.printStackTrace();
					}
					System.out.println("结束"+resultAddTwo);
					System.out.println("消息eTwo："+(String)resultAddTwo[0]);
					System.out.println("服务号eTwo："+(String)resultAddTwo[1]);
					System.out.println("返回："+resultAddTwo[2]);
					
	            	String msgOutTwo = (String)resultAddTwo[0];
	            	String numberServiceTwo = (String)resultAddTwo[1];
	            	int serviceNumberTwo = Integer.parseInt( numberServiceTwo );
	            	
	            	
	            	//创建回复
	            	XMLMessage xmlTextMessage = new XMLTextMessage(
	                    wxdata.get("FromUserName"),
	                    wxdata.get("ToUserName"),
	                    msgOutTwo);
	                //回复
	            	xmlTextMessage.outputStreamWrite(outputStream);
	            	return;
	            }
            }
            
        }
        
      WechatIncidentTool.outputStreamWrite(outputStream,"");//回复空
       //创建回复
		/*  XMLMessage xmlTextMessage = new XMLTextMessage(
	        wxdata.get("FromUserName"),
	        wxdata.get("ToUserName"),
	        "");
	    //回复
		xmlTextMessage.outputStreamWrite(outputStream,""); */
 %>