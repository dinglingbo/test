package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.GroupInfoTEntity;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;

import java.util.List;
import java.util.Map;

public interface GroupInfoService {
    int addGroupInfo(GroupInfoEntity groupInfo);
    int updateGroup(GroupInfoEntity groupInfo);
    List<GroupInfoEntity> queryGroupInfo(List groupIds);
    List<GroupInfoTEntity> queryUserGroupList(Map<String,Object> map);
}
