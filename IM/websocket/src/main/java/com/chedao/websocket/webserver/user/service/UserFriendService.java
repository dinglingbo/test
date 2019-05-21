package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.ImFriendUserData;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;

import java.util.List;

public interface UserFriendService {
    void save(UserFriendEntity userFriend);

    int update(UserFriendEntity userFriend);

    int delete(Long id);

    int delete(UserFriendEntity t);

    int isFriend(String userId, String friendId);

    //查找我的好友
    //List<ImFriendUserData> queryListUser(UserInfoEntity user);
    List<ImFriendUserData> queryFriend(UserInfoEntity user);
}
