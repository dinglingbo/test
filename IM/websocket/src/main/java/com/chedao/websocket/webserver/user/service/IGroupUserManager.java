package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;

import java.util.List;

public interface IGroupUserManager {

    boolean saveGroupMemeberIds(String groupId, List<String> userIds);

    boolean saveGroupMemeberList(String groupId, List<UserInfoExtendEntity> userIds);

    List<String> getGroupMembers(String groupId);

    List<UserInfoExtendEntity> getGroupMemberList(String groupId);
}
