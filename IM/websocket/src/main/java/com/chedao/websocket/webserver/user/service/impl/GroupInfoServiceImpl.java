package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.GroupInfoDao;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("GroupInfoServiceImpl")
public class GroupInfoServiceImpl implements GroupInfoService {
    @Resource
    private GroupInfoDao groupInfoDao;
    @Override
    public int addGroupInfo(GroupInfoEntity groupInfo) {
        groupInfoDao.addGroupInfo(groupInfo);
       return  groupInfo.getId();
    }
    @Override
    public int updateGroup(GroupInfoEntity groupInfo) {
       return groupInfoDao.updateGroup(groupInfo);
    }
    @Override
    public List<GroupInfoEntity> queryGroupInfo(String groupIds){
        return groupInfoDao.queryGroupInfo(groupIds);
    }

}
