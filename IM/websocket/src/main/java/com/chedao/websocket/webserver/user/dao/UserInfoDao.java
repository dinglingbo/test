package com.chedao.websocket.webserver.user.dao;
import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.model.UserInfoExtendEntity;

import java.util.List;
import java.util.Map;

/**
 * 用户信息表
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-27 09:38:52
 */

public interface UserInfoDao extends BaseDao<UserInfoEntity> {
    List<UserInfoEntity> queryByUid(Map<String, Object> map);

    Map queryByUid(Long uid);

    List<UserInfoExtendEntity> queryBoxUserInfoByUid(Map<String, Object> map);
    public List<UserInfoEntity> queryUserInfo(String name);
}
