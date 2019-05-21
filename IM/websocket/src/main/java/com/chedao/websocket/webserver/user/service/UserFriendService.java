package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserFriendEntity;

import java.util.List;

public interface UserFriendService<T> {
    void save(UserFriendEntity userFriend);

    int update(UserFriendEntity userFriend);

    int delete(Long id);

    int delete(T t);

    int isFriend(String userId, String friendId);
}
