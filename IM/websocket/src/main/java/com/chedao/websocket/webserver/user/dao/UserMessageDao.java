package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
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

public interface UserMessageDao extends BaseDao<UserMessageEntity> {
	/**
	 * 获取历史记录
	 * @param map
	 * @return
	 */
	List<UserMessageEntity> getHistoryMessageList(Map<String, Object> map);
	/**
	 * 获取历史记录总条数
	 * @param map
	 * @return
	 */
	int getHistoryMessageCount(Map<String, Object> map);
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
	 * 修改消息为已读状态
	 * @param map
	 * @return
	 */
	int updatemsgstate(Map<String, Object> map);

	/**
	 * 查询未处理的好友申请消息
	 */

	/**
	 * 查询消息盒子内容
	 * @param map
	 * @return
	 */
	List<UserMessageTEntity> queryBoxList(Map<String, Object> map);

	/**
	 * 查询消息盒子总条数
	 * @param map
	 * @return
	 */
	int queryBoxTotal(Map<String, Object> map);

	/**
	 * 查询聊天记录
	 * @param map
	 * @return
	 */
	List<MessageInfoEntity> getIMHistoryMessageList(Map<String, Object> map);

	/**
	 * 更新用户的最近上线时间/离线时间
	 * @param map
	 * @return
	 */
	int updateuserdate(Map<String, Object> map);
}
