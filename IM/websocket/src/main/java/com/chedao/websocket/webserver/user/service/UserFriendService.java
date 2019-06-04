package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.*;

import java.util.List;
import java.util.Map;

public interface UserFriendService {
    void saveBatch(List<UserFriendEntity> list);

    void save(UserFriendEntity userFriend);

    int update(UserFriendEntity userFriend);

    int delete(Long id);

    int delete(UserFriendEntity t);

    int isFriend(String userId, String friendId);

    //查找我的好友
    //List<ImFriendUserData> queryListUser(UserInfoEntity user);
    List<ImFriendUserData> queryFriend(UserInfoEntity user);

    //查找用户好友列表
    List<UserFriendTEntity> queryUserFriendList(String userId);

    boolean refreshUserFriendListCache(String userId);

    //根据分组ID查询好友
    List<ImFriendUserInfoData> queryListUser(Long typeId);

    UserInfoEntity queryUserFriend(Map<String, Object> map);
}
