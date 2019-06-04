package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.server.connertor.ImConnertor;
import com.chedao.websocket.server.proxy.impl.MessageProxyImpl;
import com.chedao.websocket.webserver.user.dao.UserFriendApplyDao;
import com.chedao.websocket.webserver.user.dao.UserFriendDao;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;
import com.chedao.websocket.webserver.user.service.UserFriendApplyService;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;

@Service("userFriendApplyServiceImpl")
public class UserFriendApplyServiceImpl implements UserFriendApplyService {

    @Resource
    private UserFriendApplyDao userFriendApplyDao;

    @Autowired
    private UserFriendService userFriendServiceImpl;
    @Autowired
    private UserInfoService userInfoServiceImpl;
    @Autowired
    private ImConnertor connertor;

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
    public Map<String, Object> applyFriend(UserFriendApplyEntity friend) {
        Map<String, Object> map = new HashMap<>();
        try {

            //1、需要先判断是否为自己的好友，如果为好友直接返回
            int count = userFriendServiceImpl.isFriend(friend.getFrom().toString(), friend.getUid().toString());
            if (count > 0) {
                map.put("code", -1);
                map.put("msg", "你和对方已经是好友");
                return map;
            }
            //2、查询好友申请列表中有没有未处理的申请（status = 0），如果没有就插入，有就直接返回
            //需要判断是否已经申请  需要有申请人的名称，被申请人的备注名称
            map.put("uid", friend.getUid());
            map.put("fromId", friend.getFrom());
            map.put("status", 0);
            List<UserFriendApplyEntity> list = userFriendApplyDao.getUserFriendApply(map);
            if (list.size() > 0) {
                map.put("code", -1);
                map.put("msg", "已经提交好友申请，请等待对方回复");
                return map;
            }
            //UserInfoEntity user = userInfoServiceImpl.queryByUid(friend.getUid());
            //UserInfoEntity userFriend = userInfoServiceImpl.queryByUid(friend.getFrom());

            //friend.setUsername();
            //friend.setFrom_name();

            int i = userFriendApplyDao.applyFriend(friend);
            if (i == 1) {
                map.put("code", 0);
                map.put("msg", "申请成功，等待对方同意");
            }
            //4、发消息
            String content = friend.getFrom_name() + "申请添加您为好友";
            //connertor.pushFriendSettleMessage(friend.getFrom().toString(), friend.getUid().toString(), content, 0);
            return map;
        }catch (Exception e){
            System.out.println(e);
            return map;
        }
    }

    /**
     * 同意好友申请，需要更新好友申请数据，插入两条好友数据，并发消息给对方
     * friendUid申请人用户ID，friendName申请人昵称，from_group 申请人分组
     * group我的分组，uid我的用户ID， username我的昵称（这个是申请人备注的名称）
     * @param
     * @return
     */
    @Transactional
    @Override
    public Map<String, Object> agreeFriend(Long friendUid, Long from_group, Long group, Long uid, Long keyId) {
        //查询如果是好友，更新申请状态（暂不考虑此种情况）
        //1、查询好友申请表的状态
        Map<String,Object> map = new HashMap<>();
        map.put("uid",uid);
        map.put("fromId",friendUid);
        UserFriendApplyEntity userFriendApplyEntity = userFriendApplyDao.queryObject(keyId);
        if(userFriendApplyEntity != null) {
            int status = userFriendApplyEntity.getStatus();
            if(status != 0) {
                map.put("code", -1);
                map.put("msg", "此信息已经处理");
                return map;
            }
            String friendName = userFriendApplyEntity.getFrom_name();
            String username = userFriendApplyEntity.getUsername();

            //2、向好友表中插入两条数据;更新好友列表缓存
            List<UserFriendEntity> friendList = new ArrayList<UserFriendEntity>();

            //此条是向申请人的好友表添加好友数据
            UserFriendEntity friend1 = new UserFriendEntity();
            friend1.setUserid(friendUid);
            friend1.setUsername(friendName);
            friend1.setFriendid(uid);
            friend1.setFriendname(username);
            friend1.setType(from_group);
            friendList.add(friend1);

            //此条是向我的好友表添加好友数据
            UserFriendEntity friend2 = new UserFriendEntity();
            friend2.setUserid(uid);
            friend2.setUsername(username);
            friend2.setFriendid(friendUid);
            friend2.setFriendname(friendName);
            friend2.setType(group);
            friendList.add(friend2);

            userFriendServiceImpl.saveBatch(friendList);

            //3、更新好友申请表的状态
            UserFriendApplyEntity applyEntity = new UserFriendApplyEntity();
            applyEntity.setId(userFriendApplyEntity.getId());
            applyEntity.setStatus(1);
            applyEntity.setUpdateDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
            userFriendApplyDao.update(applyEntity);

            //4、发消息
            String content = username + "已经同意了您的好友申请";
            connertor.pushFriendSettleMessage(uid.toString(), friendUid.toString(), content, 0);

            map.put("code", 0);
            map.put("msg", "好友申请通过");
            return map;
        }else {
            map.put("code", -1);
            map.put("msg", "好友申请信息有误");
            return map;
        }
    }

    /**
     * 拒绝好友申请，需要更新好友申请数据，并发消息给对方
     * @param
     * @return
     */
    @Override
    public Map<String, Object> refuseFriend(Long friendUid, Long uid, Long keyId){
        //1、查询好友申请表的状态
        Map<String,Object> map = new HashMap<>();
        map.put("uid",uid);
        map.put("fromId",friendUid);
        UserFriendApplyEntity userFriendApplyEntity = userFriendApplyDao.queryObject(keyId);
        if(userFriendApplyEntity != null) {
            int status = userFriendApplyEntity.getStatus();
            if(status != 0) {
                map.put("code", -1);
                map.put("msg", "此好友申请信息已处理");
                return map;
            }
            String username = userFriendApplyEntity.getUsername();

            //2、更新好友申请表的状态
            UserFriendApplyEntity applyEntity = new UserFriendApplyEntity();
            applyEntity.setId(userFriendApplyEntity.getId());
            applyEntity.setStatus(2);
            applyEntity.setUpdateDate(DateFormatUtils.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
            userFriendApplyDao.update(applyEntity);

            //3、发消息
            String content = username + "已经拒绝了您的好友申请";
            connertor.pushFriendSettleMessage(uid.toString(), friendUid.toString(), content, 0);

            map.put("code", 0);
            map.put("msg", "好友申请拒绝");
            return map;
        }else {
            map.put("code", -1);
            map.put("msg", "好友申请信息有误");
            return map;
        }
    }
}
