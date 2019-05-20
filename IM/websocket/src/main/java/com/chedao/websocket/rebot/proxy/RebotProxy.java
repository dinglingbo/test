/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.rebot.proxy;

import com.chedao.websocket.server.model.MessageWrapper;

public  interface  RebotProxy {
	/**
	 * 机器人回复
	 * @param user  用于区分回复谁，机器人接口短暂记忆
	 * @param content
	 * @return
	 */
	 MessageWrapper botMessageReply(String user, String content);
}
