package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;

import java.util.Map;

public interface GroupInfoDao extends BaseDao<GroupInfoEntity> {

    int addGroupInfo(GroupInfoEntity groupInfo);
}
