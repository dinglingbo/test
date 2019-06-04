/**
 ***************************************************************************************
 *  @Author     1044053532@qq.com   
 *  @License    http://www.apache.org/licenses/LICENSE-2.0
 ***************************************************************************************
 */
package com.chedao.websocket.server.proxy;

import com.chedao.websocket.server.model.MessageWrapper;
import com.chedao.websocket.server.model.proto.MessageProto;

import java.util.Map;

public interface MessageProxy {

    MessageWrapper convertToMessageWrapper(String sessionId, MessageProto.Model message);
    /**
     * 保存在线消息
     * @param message
     */
    void  saveOnlineMessageToDB(MessageWrapper message, Integer type);
    /**
     * 保存离线消息
     * @param message
     */
    void  saveOfflineMessageToDB(MessageWrapper message, Integer type);
    /**
     * 获取上线状态消息
     * @param sessionId
     * @return
     */
    MessageProto.Model  getOnLineStateMsg(String sessionId);
    /**
     * 重连状态消息
     * @param sessionId
     * @return
     */
    MessageWrapper  getReConnectionStateMsg(String sessionId);
    
    /**
     * 获取下线状态消息
     * @param sessionId
     * @return
     */
    MessageProto.Model  getOffLineStateMsg(String sessionId);

    /**
     * 更新用户最近离线时间/上线时间
     * @param map
     */
    void updateUserDate(Map<String, Object> map);

    /**
     * 获取好友申请同意/拒绝后的消息
     * @param sessionId
     * @return
     */
    MessageWrapper  getFriendApplyMsg(String sessionId, String reSessionId, String content);

    /**
     * 获取创建群聊后的消息
     * @param sessionId
     * @param reSessionId
     * @param content
     * @return
     */
    MessageWrapper  getCreateGroupMsg(String sessionId, String reSessionId, String content);
}

