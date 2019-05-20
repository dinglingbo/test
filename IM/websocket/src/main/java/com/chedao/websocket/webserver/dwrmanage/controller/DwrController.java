package com.chedao.websocket.webserver.dwrmanage.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.server.connertor.ImConnertor;
import com.chedao.websocket.server.model.MessageWrapper;
import com.chedao.websocket.server.model.proto.MessageBodyProto;
import com.chedao.websocket.server.model.proto.MessageProto;
import com.chedao.websocket.server.proxy.MessageProxy;
import com.chedao.websocket.webserver.dwrmanage.connertor.DwrConnertor;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.annotations.RemoteMethod;
import org.directwebremoting.annotations.RemoteProxy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
@RemoteProxy(name = "Imwebserver")  
public class DwrController {
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private DwrConnertor dwrConnertorImpl;
	@Autowired
	private ImConnertor connertor;
	@Autowired
	private MessageProxy proxy;
	/**
	 * 创建连接
	 * @param id
	 */
    @RemoteMethod  
    public void serverconnect() {  
    	  WebContext wct = WebContextFactory.get();
    	  ScriptSession   session  = wct.getScriptSession();
    	  dwrConnertorImpl.connect(session, (String)session.getAttribute(Constants.SessionConfig.SESSION_KEY));
    }
    
    /**
	 * 关闭连接
	 * @param id
	 */
    @RemoteMethod  
    public void closeconnect() {  
    	  WebContext wct = WebContextFactory.get();
    	  ScriptSession   session  = wct.getScriptSession();
    	  dwrConnertorImpl.close(session); 
    }
    
    /**
   	 * 发送消息
   	 * @param id
   	 */
       @RemoteMethod  
       public void sendMsg(String receiver,String msg) {  
    	   WebContext wct = WebContextFactory.get();
    	   ScriptSession   session  = wct.getScriptSession();
    	   MessageProto.Model.Builder  message = MessageProto.Model.newBuilder();
    	   message.setCmd(Constants.CmdType.MESSAGE);
    	   message.setReceiver(receiver);
   		   MessageBodyProto.MessageBody.Builder  msgbody =  MessageBodyProto.MessageBody.newBuilder();
   		   msgbody.setContent(msg); 
   		   message.setContent(msgbody.build().toByteString());
   		   String sessionId = (String)session.getAttribute(Constants.SessionConfig.SESSION_KEY);
   		   MessageWrapper wrapper = proxy.convertToMessageWrapper(sessionId, message.build());
   		   connertor.pushMessage(wrapper.getSessionId(), wrapper);
       }
       
       /**
      	 * 发送群消息
      	 * @param id
      	 */
          @RemoteMethod  
          public void sendGroupMsg(String groupid,String msg) {  
       	  
       	   
       	   WebContext wct = WebContextFactory.get();
       	   ScriptSession   session  = wct.getScriptSession();
       	   MessageProto.Model.Builder  message = MessageProto.Model.newBuilder();
       	   message.setCmd(Constants.CmdType.MESSAGE);
       	   message.setGroupId(groupid);
  		   MessageBodyProto.MessageBody.Builder  msgbody =  MessageBodyProto.MessageBody.newBuilder();
  		   msgbody.setContent(msg); 
  		   message.setContent(msgbody.build().toByteString());
  		   String sessionId = (String)session.getAttribute(Constants.SessionConfig.SESSION_KEY);
  		   MessageWrapper  wrapper = proxy.convertToMessageWrapper(sessionId, message.build());
  		   connertor.pushGroupMessage(wrapper);
       }
    
}
