package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.server.connertor.ImConnertor;
import com.chedao.websocket.webserver.user.dao.GroupUserDao;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.service.GroupUserService;
import com.chedao.websocket.webserver.user.service.IGroupUserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("GroupUserServiceImpl")
public class GroupUserServiceImpl implements GroupUserService {
    @Resource
    private GroupUserDao groupUserDao;

    @Autowired
    private GroupInfoServiceImpl groupInfoServiceImpl;
    @Autowired
    private IGroupUserManager groupUserManager;

    /**
     * 群聊创建成功后，需要更新在线成员的群聊数据
     * @param groupUser
     * @return
     */
    @Override
    public int addGroupUser(List<Map<String, Object>> groupUser) {
        int i = groupUserDao.addGroupUser(groupUser);
        for(int j=0; j<groupUser.size(); j++) {
            Map<String, Object> user = groupUser.get(j);
            groupInfoServiceImpl.refreshUserGroupCache(Integer.parseInt(user.get("userId").toString()));
        }
        return i;
    }

    @Override
    public int deleteGroup(Integer userId,Integer groupId) {
        groupUserDao.deleteGroup(userId,groupId);
        groupInfoServiceImpl.refreshUserGroupCache(userId);
        groupUserManager.refreshGroupMemberListCache(groupId.toString());
        groupUserManager.refreshGroupMemberCache(groupId.toString(), userId.toString());
        groupUserManager.refreshGroupMembersCache(groupId.toString());
        return 0;
    }

    @Override
    public List<GroupUserEntity> queryGroupUsers(int groupId ) {

        return groupUserDao.queryGroupUsers(groupId);
    }
    @Override
    public List<GroupUserEntity> queryGroupInfo(int userId ) {

        return groupUserDao.queryGroupInfo(userId);
    }

    @Override
    public List<GroupUserEntity> queryGroupName(String userId, String groupId) {

        return groupUserDao.queryGroupName(userId,groupId);
    }

    /**
     * 更新完我在本群昵称后，需要更新群ID对应的缓存；需要更新群ID + uid对应的缓存
     * @param userId
     * @param groupId
     * @param name
     * @return
     */
    @Override
    public int updateGroupName(String userId, String groupId, String name) {
        int i = groupUserDao.updateGroupName(userId,groupId,name);
        if(i>0){
            groupUserManager.refreshGroupMemberListCache(groupId);
            groupUserManager.refreshGroupMemberCache(groupId, userId);
        }
        return i;
    }
}
