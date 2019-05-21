package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface GroupUserDao {
    int addGroupUser(List groupUser);
    int deleteGroup(@Param("userId") Integer userId, @Param("groupId") Integer groupId);
    List<GroupUserEntity> queryGroupUsers(int groupId);
    List<GroupUserEntity> queryGroupInfo(int UserId);
}
