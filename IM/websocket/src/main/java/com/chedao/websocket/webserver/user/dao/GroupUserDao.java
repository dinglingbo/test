package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;

import java.util.List;
import java.util.Map;

public interface GroupUserDao {
    int addGroupUser(List groupUser);
    int deleteGroup(Integer userId,Integer groupId);
    List<GroupUserEntity> queryGroupUsers(int groupId);
}
