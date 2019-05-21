package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.GroupUserEntity;

import java.util.List;

public interface GroupUserService {
     int addGroupUser(List groupUser);
    int deleteGroup(Integer userId,Integer groupId);
    List<GroupUserEntity> queryGroupUsers(int groupId);
    List<GroupUserEntity> queryGroupInfo(int userId);
    List<GroupUserEntity> queryGroupName(String  userId, String groupId);
    int updateGroupName(String  userId, String groupId,String name);
}
