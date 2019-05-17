package com.chedao.websocket.webserver.user.service;

import java.util.List;

public interface IGroupUserManager {

    boolean saveGroupMemeberIds(String groupId, List<String> userIds);

    List<String> getGroupMembers(String groupId);

}
