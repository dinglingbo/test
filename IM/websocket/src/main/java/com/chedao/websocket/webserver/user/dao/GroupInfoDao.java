package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.GroupInfoTEntity;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface GroupInfoDao extends BaseDao<GroupInfoEntity> {

    int addGroupInfo(GroupInfoEntity groupInfo);

    int updateGroup(GroupInfoEntity groupInfo);

    List<GroupInfoEntity> queryGroupInfo(@Param("groupIds") List groupIds);

    List<GroupInfoTEntity> queryUserGroupList(Map<String, Object> map);

}
