package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserFriendDao;
import com.chedao.websocket.webserver.user.dao.UserTypeDao;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("userFriendServiceImpl")
public class UserFriendServiceImpl implements UserFriendService {
    @Resource
    private UserFriendDao userFriendDao;
    @Resource
    private UserTypeDao  userTypeDao;


    @Override
    public void save(UserFriendEntity userFriend) {
        userFriendDao.save(userFriend);
    }

    @Override
    public int update(UserFriendEntity userFriend) {
        return userFriendDao.update(userFriend);
    }

    @Override
    public int delete(Long id) {
        return userFriendDao.delete(id);
    }


    @Override
    public int delete(UserFriendEntity userFriend) {
        return userFriendDao.delete(userFriend);
    }

    public int isFriend(String userId, String friendId){
        return userFriendDao.isFriend(userId,friendId);
    }

    //查找我的好友，包括分组信息，需要用到分组实体
    @Override
    public List<ImFriendUserData> queryFriend(UserInfoEntity user) {
        List<UserTypeEntity> type = new ArrayList<UserTypeEntity>();
        List<ImFriendUserData> friend = new ArrayList<ImFriendUserData>();
        UserTypeEntity temp = new UserTypeEntity();
        //查找分组
        type = userTypeDao.queryList(user.getUid());
        if(type.size()>0){
            for (int i = 0;i<type.size();i++){
                 ImFriendUserData imData = new ImFriendUserData();
                 temp = type.get(i);
                 imData.setId(temp.getId());
                 imData.setGroupname(temp.getName());
                 List<ImFriendUserInfoData > list =  userFriendDao.queryListUser(temp.getId());
                 imData.setList(list);
                 friend.add(imData);
            }
        }
        return friend;
    }
}
