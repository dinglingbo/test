package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.ImFriendUserInfoData;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;

import java.util.List;
import java.util.Map;

public interface UserTypeDao extends BaseDao<UserTypeEntity> {
    List<UserTypeEntity> queryListById(Map<String, Object> map);
}
