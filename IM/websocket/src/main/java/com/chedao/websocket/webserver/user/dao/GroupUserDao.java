package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;

import java.util.List;
import java.util.Map;

public interface GroupUserDao {
    int addGroupUser(List groupUser);
    int deleteGroup(Integer groupId,Integer userId);
    List<GroupUserEntity> queryGroupUsers(int groupId);
}
