package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.ImFriendUserInfoData;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import com.chedao.websocket.webserver.user.model.UserFriendTEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserFriendDao<T> extends BaseDao<UserFriendEntity> {
    //判断是否是好友
    int isFriend(@Param("userId")String userId, @Param("friendId")String friendId);
    //查询好友
    List<ImFriendUserInfoData> queryListUser(Long typeid);
    //查找用户好友列表
    List<UserFriendTEntity> queryUserFriendList(@Param("userId")String userId);
}
