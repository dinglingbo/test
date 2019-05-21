package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.GroupUserEntity;

import javax.validation.constraints.Null;
import java.util.List;
import java.util.Map;

public interface GroupUserService {
     int addGroupUser(List groupUser);
    int deleteGroup(Integer userId,Integer groupId);
    List<GroupUserEntity> queryGroupUsers(int groupId);
    List<GroupUserEntity> queryGroupInfo(int userId);
}
