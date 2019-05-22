/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.webserver.dwrmanage.connertor;

import com.chedao.websocket.server.model.MessageWrapper;
import org.directwebremoting.ScriptSession;

public interface DwrConnertor {
	 
	 
	 void close(ScriptSession scriptSession);
 
	 void connect(ScriptSession scriptSession, String sessionid) ;
	 /**
	  * 发送消息
	  * @param sessionId  发送人
	  * @param wrapper   发送内容
	  * @throws RuntimeException
	  */
	 void pushMessage(String sessionId, MessageWrapper wrapper) throws RuntimeException;
	 
}
