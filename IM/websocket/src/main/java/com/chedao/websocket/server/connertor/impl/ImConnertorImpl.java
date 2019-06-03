/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.server.connertor.impl;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.server.connertor.ImConnertor;
import com.chedao.websocket.server.exception.PushException;
import com.chedao.websocket.server.group.ImChannelGroup;
import com.chedao.websocket.server.model.MessageWrapper;
import com.chedao.websocket.server.model.Session;
import com.chedao.websocket.server.model.proto.MessageProto;
import com.chedao.websocket.server.proxy.MessageProxy;
import com.chedao.websocket.server.session.SessionManager;
import com.chedao.websocket.server.session.impl.SessionManagerImpl;
import com.chedao.websocket.webserver.user.service.impl.GroupUserManager;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("connertor")
public class ImConnertorImpl implements ImConnertor {
	private final static Logger log = LoggerFactory.getLogger(ImConnertorImpl.class);

	@Autowired
    private SessionManager sessionManager;
	@Autowired
    private MessageProxy proxy;
	@Autowired
	private GroupUserManager groupUserManager;

	public void setSessionManager(SessionManagerImpl sessionManager) {
		this.sessionManager = sessionManager;
	}
	public void setProxy(MessageProxy proxy) {
		this.proxy = proxy;
	}


	@Override
	public void heartbeatToClient(ChannelHandlerContext hander, MessageWrapper wrapper) {
		//设置心跳响应时间
		hander.channel().attr(Constants.SessionConfig.SERVER_SESSION_HEARBEAT).set(System.currentTimeMillis());
	}

	@Override
	public void pushGroupMessage(MessageWrapper wrapper)
			throws RuntimeException {
	    //这里判断群组ID 是否存在 并且该用户是否在群组内
        MessageProto.Model message = (MessageProto.Model)wrapper.getBody();
        //获取群组，得到群组里面的所有成员，并取出在线成员的sessionId
        String groupId = message.getGroupId();
        String senduser = message.getSender();

        //群聊，需要遍历该群组里的所有人
        //第一次从缓存中取userId，否则，从数据库中取在存到缓存中
        List<String> users =  groupUserManager.getGroupMembers(groupId);
        if(users == null) {
            users = new ArrayList<>();
            users.add("3");
            users.add("9");
            users.add("10");
            //return;
        }
        for (String userid : users) {
            //遍历发送消息 自己过滤，不给自己发送(发送人id和群成员内的某个id相同)
            if (!senduser.equals(userid)) {
                ///取得接收人 给接收人写入消息
                Session responseSession = sessionManager.getSession(userid);
                if (responseSession != null && responseSession.isConnected() ) {
                    boolean result = responseSession.write(wrapper.getBody());
                }
            }
        }

		/*  Session[] session = sessionManager.getSessions();
		  for(int i=0; i<session.length; i++) {
		  	Session se = session[i];
		  	String uid = se.getAccount();
		  	pushMessage(uid, wrapper);
		  }*/

		  //ImChannelGroup.broadcast(wrapper.getBody());
		  //DwrUtil.sedMessageToAll((MessageProto.Model)wrapper.getBody());
		  proxy.saveOnlineMessageToDB(wrapper,Constants.MessageType.GROUP);
	}

	@Override  
	public void pushMessage(MessageWrapper wrapper) throws RuntimeException {
        try {
        	//sessionManager.send(wrapper.getSessionId(), wrapper.getBody());
        	Session session = sessionManager.getSession(wrapper.getSessionId());
      		/*
      		 * 服务器集群时，可以在此
      		 * 判断当前session是否连接于本台服务器，如果是，继续往下走，如果不是，将此消息发往当前session连接的服务器并 return
      		 * if(session!=null&&!session.isLocalhost()){//判断当前session是否连接于本台服务器，如不是
      		 * //发往目标服务器处理
      		 * return; 
      		 * }
      		 */ 
      		if (session != null) {
      			boolean result = session.write(wrapper.getBody());
      			return ;
      		}
        } catch (Exception e) {
        	log.error("connector pushMessage  Exception.", e);
            throw new RuntimeException(e.getCause());
        }
    }

	@Override
	public void pushFriendSettleMessage(String sessionId, String reSessionId, String content, Integer saveSign) throws RuntimeException {
		try {
            ///取得接收人 给接收人写入消息
            MessageWrapper wrapper = proxy.getFriendApplyMsg(sessionId, reSessionId, content);
            Session responseSession = sessionManager.getSession(wrapper.getReSessionId());
            if (responseSession != null && responseSession.isConnected() ) {
                boolean result = responseSession.write(wrapper.getBody());
                if(saveSign==-1) {
                    return;
                }
                if(result){
                    proxy.saveOnlineMessageToDB(wrapper,Constants.MessageType.APPLY);
                }else{
                    proxy.saveOfflineMessageToDB(wrapper,Constants.MessageType.APPLY);
                }
                return;
            }else{
                if(saveSign==-1) {
                    return;
                }
                proxy.saveOfflineMessageToDB(wrapper,Constants.MessageType.APPLY);
            }
        } catch (PushException e) {
            log.error("connector send occur PushFriendSettleException.", e);

            throw new RuntimeException(e.getCause());
        } catch (Exception e) {
            log.error("connector send occur Exception.", e);
            throw new RuntimeException(e.getCause());
        }
    }
    
	@Override    
	public void pushMessage(String sessionId,MessageWrapper wrapper) throws RuntimeException{
		//判断是不是无效用户回复    
		if(!sessionId.equals(Constants.ImserverConfig.REBOT_SESSIONID)){//判断非机器人回复时验证
			Session session = sessionManager.getSession(sessionId);
	        if (session == null) {
	        	 throw new RuntimeException(String.format("session %s is not exist.", sessionId));
	        } 
		}
	   try {
	    	///取得接收人 给接收人写入消息
	    	Session responseSession = sessionManager.getSession(wrapper.getReSessionId());
	  		if (responseSession != null && responseSession.isConnected() ) {
	  			boolean result = responseSession.write(wrapper.getBody());
	  			if(result){
	  				proxy.saveOnlineMessageToDB(wrapper,Constants.MessageType.SINGLE);
	  			}else{
	  				proxy.saveOfflineMessageToDB(wrapper,Constants.MessageType.SINGLE);
	  			}
	  			return;
	  		}else{
	  			proxy.saveOfflineMessageToDB(wrapper,Constants.MessageType.SINGLE);
	  		}
	    } catch (PushException e) {
	    	log.error("connector send occur PushException.", e);
	       
	        throw new RuntimeException(e.getCause());
	    } catch (Exception e) {
	    	log.error("connector send occur Exception.", e);
	        throw new RuntimeException(e.getCause());
	    }  
	    
	}
	@Override  
    public boolean validateSession(MessageWrapper wrapper) throws RuntimeException {
        try {
            return sessionManager.exist(wrapper.getSessionId());
        } catch (Exception e) {
        	log.error("connector validateSession Exception!", e);
            throw new RuntimeException(e.getCause());
        }
    }

	@Override
	public void close(ChannelHandlerContext hander,MessageWrapper wrapper) {
		String sessionId = getChannelSessionId(hander);
        if (StringUtils.isNotBlank(sessionId)) {
        	close(hander); 
            log.warn("connector close channel sessionId -> " + sessionId + ", ctx -> " + hander.toString());
        }
	}
	
	@Override
	public void close(ChannelHandlerContext hander) {
		   String sessionId = getChannelSessionId(hander);
		   try {
			    String nid = hander.channel().id().asShortText();
	        	Session session = sessionManager.getSession(sessionId);
	      		if (session != null) {
	      			sessionManager.removeSession(sessionId,nid); 
	      			ImChannelGroup.remove(hander.channel());
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("type",0);
					map.put("uid",session.getAccount());
					proxy.updateUserDate(map);
	      		    log.info("connector close sessionId -> " + sessionId + " success " );
	      		}
	        } catch (Exception e) {
	        	log.error("connector close sessionId -->"+sessionId+"  Exception.", e);
	            throw new RuntimeException(e.getCause());
	        }
	}
	
	@Override
	public void close(String sessionId) {
		 try {
        	 Session session = sessionManager.getSession(sessionId);
      		 if (session != null) {
      			sessionManager.removeSession(sessionId); 
      			List<Channel> list = session.getSessionAll();
      			for(Channel ch:list){
      				ImChannelGroup.remove(ch);
      			} 
      		    log.info("connector close sessionId -> " + sessionId + " success " );
      		 }
	     } catch (Exception e) {
        	log.error("connector close sessionId -->"+sessionId+"  Exception.", e);
            throw new RuntimeException(e.getCause());
	     }
	}
	
    @Override
    public void connect(ChannelHandlerContext ctx, MessageWrapper wrapper) {
        try {
        	  String sessionId = wrapper.getSessionId();
        	  String sessionId0 = getChannelSessionId(ctx);
        	  //当sessionID存在或者相等  视为同一用户重新连接
              if (StringUtils.isNotEmpty(sessionId0) || sessionId.equals(sessionId0)) {
                  log.info("connector reconnect sessionId -> " + sessionId + ", ctx -> " + ctx.toString());
                  pushMessage(proxy.getReConnectionStateMsg(sessionId0));
              } else {
                  log.info("connector connect sessionId -> " + sessionId + ", sessionId0 -> " + sessionId0 + ", ctx -> " + ctx.toString());
                  sessionManager.createSession(wrapper, ctx);
                  setChannelSessionId(ctx, sessionId);
				  Map<String, Object> map = new HashMap<String, Object>();
				  map.put("type",1);
				  map.put("uid",wrapper.getSessionId());
                  proxy.updateUserDate(map);
                  log.info("create channel attr sessionId " + sessionId + " successful, ctx -> " + ctx.toString());
              }
        } catch (Exception e) {
        	log.error("connector connect  Exception.", e);
        }
    }
     
	@Override
	public boolean exist(String sessionId) throws Exception {
		return sessionManager.exist(sessionId);
	} 
	@Override  
    public String getChannelSessionId(ChannelHandlerContext ctx) {
        return ctx.channel().attr(Constants.SessionConfig.SERVER_SESSION_ID).get();
    }

    private void setChannelSessionId(ChannelHandlerContext ctx, String sessionId) {
        ctx.channel().attr(Constants.SessionConfig.SERVER_SESSION_ID).set(sessionId);
    }


}
