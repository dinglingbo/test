package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.MessageInfoEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;

import java.util.List;
import java.util.Map;

/**
 * 
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-23 10:47:47
 */
public interface UserMessageService {
	
	UserMessageEntity queryObject(Long id);
	
	List<UserMessageEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	void save(UserMessageEntity userMessage);
	
	int update(UserMessageEntity userMessage);
	
	int delete(Long id);
	
	int deleteBatch(Long[] ids);
	/**
	 * 获取历史记录
	 * @param map
	 * @return
	 */
	List<UserMessageEntity> getHistoryMessageList(Map<String, Object> map);
	/**
	 * 获取离线消息
	 * @param map
	 * @return
	 */
	List<MessageInfoEntity> getOfflineMessageList(Map<String, Object> map);

	/**
	 * 获取群的离线消息
	 * @param map
	 * @return
	 */
	List<MessageInfoEntity> getOfflineGroupMessageList(Map<String, Object> map);
	/**
	 * 获取历史记录总条数
	 * @param map
	 * @return
	 */
	int getHistoryMessageCount(Map<String, Object> map);

	/**
	 * 获取当前人的消息盒子内容
	 * @param map
	 * @return
	 */
	List<UserMessageTEntity> queryBoxList(Map<String, Object> map);

	int queryBoxTotal(Map<String, Object> map);

	List<MessageInfoEntity> getIMHistoryMessageList(Map<String, Object> map);

	int updateuserdate(Map<String, Object> map);
}
