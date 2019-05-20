package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;

public interface UserFriendDao extends BaseDao<UserFriendEntity> {
    int delete(T t);
}
