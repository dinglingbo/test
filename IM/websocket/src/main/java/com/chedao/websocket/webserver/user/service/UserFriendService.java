package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.UserFriendEntity;

public interface UserFriendService {
    void save(UserFriendEntity userFriend);

    int update(UserFriendEntity userFriend);

    int delete(Long id);

    int delete(T t);
}
