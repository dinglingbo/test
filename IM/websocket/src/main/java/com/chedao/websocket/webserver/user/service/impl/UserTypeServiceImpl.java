package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserTypeDao;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;
import com.chedao.websocket.webserver.user.service.UserTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("userTypeServiceImpl")
public class UserTypeServiceImpl implements UserTypeService {
    @Resource
    private UserTypeDao userTypeDao;

    @Override
    public void save(UserTypeEntity userType) {
         userTypeDao.save(userType);
    }

    @Override
    public int update(UserTypeEntity userType) {
        return userTypeDao.update(userType);
    }

    @Override
    public int delete(Long id) {
        return userTypeDao.delete(id);
    }

    @Override
    public List<UserTypeEntity> queryList(Map<String, Object> map) {
        return userTypeDao.queryList(map);
    }


}
