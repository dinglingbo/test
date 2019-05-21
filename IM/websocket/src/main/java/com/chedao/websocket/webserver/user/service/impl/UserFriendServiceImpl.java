package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserFriendDao;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userFriendServiceImpl")
public class UserFriendServiceImpl implements UserFriendService<UserFriendEntity> {
    @Resource
    private UserFriendDao userFriendDao;

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
}
