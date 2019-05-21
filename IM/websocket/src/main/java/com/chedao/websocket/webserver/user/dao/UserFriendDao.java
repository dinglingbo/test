package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserFriendDao<T> extends BaseDao<UserFriendEntity> {
    //判断是否是好友
    int isFriend(@Param("userId")String userId, @Param("friendId")String friendId);
}
