package com.chedao.websocket.webserver.user.service;

import com.chedao.websocket.webserver.user.model.*;

import java.util.List;
import java.util.Map;

public interface GroupInfoService {
    GroupInfoEntity queryObject(Long id);
    int addGroupInfo(GroupInfoEntity groupInfo);
    int updateGroup(GroupInfoEntity groupInfo);
    List<GroupInfoEntity> queryGroupInfo(List groupIds);
    List<GroupInfoTEntity> queryUserGroupList(Map<String,Object> map);
}
