package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;

public interface GroupInfoService {
    int addGroupInfo(GroupInfoEntity groupInfo);
    int updateGroup(GroupInfoEntity groupInfo);
}
