package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupInfoDao;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("GroupInfoServiceImpl")
public class GroupInfoServiceImpl implements GroupInfoService {
    @Resource
    private GroupInfoDao groupInfoDao;
    @Override
    public int addGroupInfo(GroupInfoEntity groupInfo) {
        return groupInfoDao.addGroupInfo(groupInfo);
    }

}
