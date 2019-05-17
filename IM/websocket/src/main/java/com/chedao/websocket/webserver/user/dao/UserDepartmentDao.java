package com.chedao.websocket.webserver.user.dao;

import com.chedao.websocket.webserver.base.dao.BaseDao;
import com.chedao.websocket.webserver.user.model.ImFriendUserData;
import com.chedao.websocket.webserver.user.model.UserDepartmentEntity;

import java.util.List;

/**
 * 部门
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-27 09:38:52
 */

public interface UserDepartmentDao extends BaseDao<UserDepartmentEntity> {
	
	public List<ImFriendUserData> queryGroupAndUser();
}
