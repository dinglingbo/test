/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.server.proxy.impl;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.rebot.proxy.RebotProxy;
import com.chedao.websocket.server.model.MessageWrapper;
import com.chedao.websocket.server.model.proto.MessageBodyProto;
import com.chedao.websocket.server.model.proto.MessageProto;
import com.chedao.websocket.server.proxy.MessageProxy;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.service.UserMessageService;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service("proxy")
public class MessageProxyImpl implements MessageProxy {
	private final static Logger log = LoggerFactory.getLogger(MessageProxyImpl.class);

	private RebotProxy rebotProxy;
	@Autowired
	private UserMessageService userMessageServiceImpl;

	@Override
    public MessageWrapper convertToMessageWrapper(String sessionId , MessageProto.Model message) {
    	
        
        switch (message.getCmd()) {
			case Constants.CmdType.BIND:
				 try {
		            	return new MessageWrapper(MessageWrapper.MessageProtocol.CONNECT, message.getSender(), null,message);
		            } catch (Exception e) {
		                e.printStackTrace();
		            }
				break;
			case Constants.CmdType.HEARTBEAT:
				try {
	                 return new MessageWrapper(MessageWrapper.MessageProtocol.HEART_BEAT, sessionId,null, null);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
				break;
			case Constants.CmdType.ONLINE:
				
				break;
			case Constants.CmdType.OFFLINE:
				
				break;
			case Constants.CmdType.MESSAGE:
					try {
						  MessageProto.Model.Builder  result = MessageProto.Model.newBuilder(message);
						  result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
						  result.setSender(sessionId);//存入发送人sessionId
						  message =  MessageProto.Model.parseFrom(result.build().toByteArray());
						  //判断消息是否有接收人
						  if(StringUtils.isNotEmpty(message.getReceiver())){
							  //判断是否发消息给机器人
							  if(message.getReceiver().equals(Constants.ImserverConfig.REBOT_SESSIONID)){
								  MessageBodyProto.MessageBody  msg =  MessageBodyProto.MessageBody.parseFrom(message.getContent());
								  return  rebotProxy.botMessageReply(sessionId, msg.getContent());
							  }else{
								  return new MessageWrapper(MessageWrapper.MessageProtocol.REPLY, sessionId,message.getReceiver(), message);
							  }
						  }else if(StringUtils.isNotEmpty(message.getGroupId())){
							  return new MessageWrapper(MessageWrapper.MessageProtocol.GROUP, sessionId, null,message);
						  }else {
							  return new MessageWrapper(MessageWrapper.MessageProtocol.SEND, sessionId, null,message);
						  }
		            } catch (Exception e) {
		                e.printStackTrace();
		            }
				break;  
		} 
        return null;
    }

    
 
    @Override
	public void saveOnlineMessageToDB(MessageWrapper message, Integer type) {
    	try{
    		UserMessageEntity  userMessage = convertMessageWrapperToBean(message);
    		if(userMessage!=null){
    			userMessage.setIsread(1);
    			userMessage.setType(type);
            	userMessageServiceImpl.save(userMessage);
    		}
    	}catch(Exception e){
    		 log.error("MessageProxyImpl  user "+message.getSessionId()+" send msg to "+message.getReSessionId()+" error");
    		 throw new RuntimeException(e.getCause());
    	}
	}

	@Override
	public  void  updateUserDate(Map<String, Object> map) {
		Integer type = Integer.parseInt(map.get("type").toString());
		//上线
		if(type == 1) {
			map.put("lastondate", 1);
		}
		//下线
		if(type == 0) {
			map.put("lastoffdate", 1);
		}
		userMessageServiceImpl.updateuserdate(map);
	}
    
    @Override
	public void saveOfflineMessageToDB(MessageWrapper message, Integer type) {
    	try{
    		 
    		UserMessageEntity userMessage = convertMessageWrapperToBean(message);
    		if(userMessage!=null){
    			userMessage.setIsread(0);
    			userMessage.setType(type);
            	userMessageServiceImpl.save(userMessage);
    		}
    	}catch(Exception e){
    		 log.error("MessageProxyImpl  user "+message.getSessionId()+" send msg to "+message.getReSessionId()+" error");
    		 throw new RuntimeException(e.getCause());
    	} 
	}
    
    
    private UserMessageEntity convertMessageWrapperToBean(MessageWrapper message){
    	try{
    		//保存非机器人消息
    		if(!message.getSessionId().equals(Constants.ImserverConfig.REBOT_SESSIONID)){
    			MessageProto.Model  msg =  (MessageProto.Model)message.getBody();
            	MessageBodyProto.MessageBody  msgConten =  MessageBodyProto.MessageBody.parseFrom(msg.getContent());
            	UserMessageEntity  userMessage = new UserMessageEntity();
            	userMessage.setSenduser(message.getSessionId());
            	userMessage.setReceiveuser(message.getReSessionId());
            	userMessage.setContent(msgConten.getContent());
            	userMessage.setGroupid(msg.getGroupId());
            	userMessage.setCreatedate(msg.getTimeStamp());
            	userMessage.setIsread(1);
            	return userMessage;
    		}
    	}catch(Exception e){
    		 throw new RuntimeException(e.getCause());
    	} 
    	return null;
    }

	public void setRebotProxy(RebotProxy rebotProxy) {
		this.rebotProxy = rebotProxy;
	}



	@Override
	public MessageProto.Model getOnLineStateMsg(String sessionId) {
		MessageProto.Model.Builder  result = MessageProto.Model.newBuilder();
		result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		result.setSender(sessionId);//存入发送人sessionId
		result.setCmd(Constants.CmdType.ONLINE);
		return result.build();
	}


	@Override
	public MessageProto.Model getOffLineStateMsg(String sessionId) {
		MessageProto.Model.Builder  result = MessageProto.Model.newBuilder();
		result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		result.setSender(sessionId);//存入发送人sessionId
		result.setCmd(Constants.CmdType.OFFLINE);
		return result.build();
	}



	@Override
	public MessageWrapper getReConnectionStateMsg(String sessionId) {
		 MessageProto.Model.Builder  result = MessageProto.Model.newBuilder();
		 result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		 result.setSender(sessionId);//存入发送人sessionId
		 result.setCmd(Constants.CmdType.RECON);
		 return  new MessageWrapper(MessageWrapper.MessageProtocol.SEND, sessionId, null,result.build());
	}


	@Override
	public MessageWrapper  getFriendApplyMsg(String sessionId, String reSessionId, String content) {
		MessageProto.Model.Builder  result = MessageProto.Model.newBuilder();
		result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		result.setSender(sessionId);
		result.setReceiver(reSessionId);//存入接收人sessionId
		result.setCmd(Constants.CmdType.FRIENDMESSAGE);

		MessageBodyProto.MessageBody.Builder  msg =  MessageBodyProto.MessageBody.newBuilder();
		msg.setContent(content);
		result.setContent(msg.build().toByteString());
		return  new MessageWrapper(MessageWrapper.MessageProtocol.SEND, sessionId, reSessionId, result.build());
	}

	@Override
	public MessageWrapper  getCreateGroupMsg(String sessionId, String reSessionId, String content) {
		MessageProto.Model.Builder  result = MessageProto.Model.newBuilder();
		result.setTimeStamp(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		result.setSender(sessionId);
		result.setReceiver(reSessionId);//存入接收人sessionId
		result.setCmd(Constants.CmdType.CREATEGROUPMESSAGE);

		MessageBodyProto.MessageBody.Builder  msg =  MessageBodyProto.MessageBody.newBuilder();
		msg.setContent(content);
		result.setContent(msg.build().toByteString());
		return  new MessageWrapper(MessageWrapper.MessageProtocol.SEND, sessionId, reSessionId, result.build());
	}
    
    
}
