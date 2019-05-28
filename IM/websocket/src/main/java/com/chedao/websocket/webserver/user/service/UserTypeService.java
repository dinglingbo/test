package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.ImFriendUserInfoData;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;

import java.util.List;
import java.util.Map;

public interface UserTypeService {


    UserTypeEntity save(UserTypeEntity userMessage);

    int update(UserTypeEntity userMessage);

    int delete(Long id, String userId);

    List<UserTypeEntity> queryList(Map<String, Object> map);

}
