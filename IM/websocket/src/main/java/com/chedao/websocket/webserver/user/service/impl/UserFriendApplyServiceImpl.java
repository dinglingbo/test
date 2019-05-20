package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserFriendApplyDao;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;
import com.chedao.websocket.webserver.user.service.UserFriendApplyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("userFriendApplyServiceImpl")
public class UserFriendApplyServiceImpl implements UserFriendApplyService {

    @Resource
    private UserFriendApplyDao userFriendApplyDao;

    @Override
    public UserFriendApplyEntity queryObject(Long id){
        return userFriendApplyDao.queryObject(id);
    }

    @Override
    public List<UserFriendApplyEntity> queryList(Map<String, Object> map){
        return userFriendApplyDao.queryList(map);
    }

    @Override
    public int queryTotal(Map<String, Object> map){
        return userFriendApplyDao.queryTotal(map);
    }

    @Override
    public void save(UserFriendApplyEntity userInfo){
        userFriendApplyDao.save(userInfo);
    }

    @Override
    public int update(UserFriendApplyEntity userInfo){
        return userFriendApplyDao.update(userInfo);
    }

    @Override
    public int delete(Long id){
        return userFriendApplyDao.delete(id);
    }

    @Override
    public int deleteBatch(Long[] ids){
        return userFriendApplyDao.deleteBatch(ids);
    }

    @Override
    public List<UserFriendApplyEntity> getHistoryMessageList(Map<String, Object> map) {
        return userFriendApplyDao.getHistoryMessageList(map);
    }

    @Override
    public int getHistoryMessageCount(Map<String, Object> map) {
        return userFriendApplyDao.getHistoryMessageCount(map);
    }

    @Override
    public List<UserFriendApplyEntity> getUserFriendApplyList(int uid) {
        return userFriendApplyDao.getUserFriendApplyList(uid);
    }

    @Override
    public List<UserMessageTEntity> queryBoxList(Map<String, Object> map) {
        return userFriendApplyDao.queryBoxList(map);
    }

    @Override
    public int applyFriend(UserFriendApplyEntity friend) {
        return userFriendApplyDao.applyFriend(friend);
    }

}
