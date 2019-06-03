package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;

import java.util.List;
import java.util.Map;

public interface UserFriendApplyService {

    UserFriendApplyEntity queryObject(Long id);

    List<UserFriendApplyEntity> queryList(Map< String, Object > map);

    int queryTotal(Map<String, Object> map);

    void save(UserFriendApplyEntity userMessage);

    int update(UserFriendApplyEntity userMessage);

    int delete(Long id);

    int deleteBatch(Long[] ids);
    /**
     * 获取历史记录
     * @param map
     * @return
     */
    List<UserFriendApplyEntity> getHistoryMessageList(Map<String, Object> map);
    /**
     * 获取历史记录总条数
     * @param map
     * @return
     */
    int getHistoryMessageCount(Map<String, Object> map);

    List<UserFriendApplyEntity> getUserFriendApplyList(int uid);

    List<UserMessageTEntity> queryBoxList(Map<String, Object> map);

    Map<String, Object> applyFriend(UserFriendApplyEntity friend);

    /**
     * 同意好友申请，需要更新好友申请数据，插入两条好友数据，并发消息给对方
     * @param
     * @return
     */
    Map<String, Object> agreeFriend(Long friendUid, Long from_group, Long group, Long uid, Long keyId);

    /**
     * 拒绝好友申请，需要更新好友申请数据，并发消息给对方
     * @param
     * @return
     */
    Map<String, Object> refuseFriend(Long friendUid, Long uid, Long keyId);
}
