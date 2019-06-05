package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;

import java.util.List;

public interface IGroupUserManager {

    boolean saveGroupMemeberIds(String groupId, List<String> userIds);

    boolean saveGroupMemeberList(String groupId, List<UserInfoExtendEntity> userIds);

    boolean saveGroupMemeber(String groupId, String userId, UserInfoExtendEntity groupUser);

    List<String> getGroupMembers(String groupId);

    List<UserInfoExtendEntity> getGroupMemberList(String groupId);

    UserInfoExtendEntity getGroupMember(String groupId, String userId);

    void refreshGroupMemberListCache(String groupId);

    void refreshGroupMemberCache(String groupId, String userId);

    void refreshGroupMembersCache(String groupId);
}
