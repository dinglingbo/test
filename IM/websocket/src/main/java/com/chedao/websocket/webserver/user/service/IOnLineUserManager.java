package com.chedao.websocket.webserver.user.service;

import java.util.Map;

public interface IOnLineUserManager {

    void addUser(String userId);

    void removeUser(String userId);

    Map getOnLineUsers();

    void clearOnLineUsers();
}
