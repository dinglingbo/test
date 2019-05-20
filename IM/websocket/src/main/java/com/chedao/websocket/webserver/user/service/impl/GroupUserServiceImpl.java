package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupUserDao;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.service.GroupUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("GroupUserServiceImpl")
public class GroupUserServiceImpl implements GroupUserService {
    @Resource
    private GroupUserDao groupUserDao;

    @Override
    public int addGroupUser(List groupUser) {
        return groupUserDao.addGroupUser(groupUser);
    }

    @Override
    public int deleteGroup(Integer userId,Integer groupId) {
        return groupUserDao.deleteGroup(userId,groupId);
    }

    @Override
    public List<GroupUserEntity> queryGroupUsers(int groupId ) {
        return groupUserDao.queryGroupUsers(groupId);
    }
}
