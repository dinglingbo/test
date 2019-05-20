package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.UserAccountEntity;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;

import java.util.List;
import java.util.Map;

public interface UserFriendApplyDao extends BaseDao<UserFriendApplyEntity> {

    List<UserFriendApplyEntity> queryByUid(Map<String, Object> map);

    /**
     * 查询历史好友申请记录
     * @param map
     * @return
     */
    List<UserFriendApplyEntity> getHistoryMessageList(Map<String, Object> map);

    /**
     * 获取历史记录条数
     * @param map
     * @return
     */
    int getHistoryMessageCount(Map<String, Object> map);
    /**
     * 查询好友申请
     * @param
     * @return
     */
    List<UserFriendApplyEntity> getUserFriendApplyList(int uid);

    List<UserMessageTEntity> queryBoxList(Map<String, Object> map);

    /**
     * 好友申请
     * @param
     * @return
     */
    int applyFriend(UserFriendApplyEntity friend);
}
