package com.chedao.websocket.webserver.user.service.impl;

import com.chedao.websocket.webserver.user.dao.UserMessageDao;
import com.chedao.websocket.webserver.user.model.MessageInfoEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;
import com.chedao.websocket.webserver.user.service.UserMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Service("userMessageServiceImpl")
public class UserMessageServiceImpl implements UserMessageService {

	@Resource
	private UserMessageDao userMessageDao;
	
	@Override
	public UserMessageEntity queryObject(Long id){
		return userMessageDao.queryObject(id);
	}
	
	@Override
	public List<UserMessageEntity> queryList(Map<String, Object> map){
		return userMessageDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return userMessageDao.queryTotal(map);
	}
	
	@Override
	public void save(UserMessageEntity userMessage){
		userMessageDao.save(userMessage);
	}
	
	@Override
	public int update(UserMessageEntity userMessage){
		return userMessageDao.update(userMessage);
	}
	
	@Override
	public int delete(Long id){
		return userMessageDao.delete(id);
	}
	
	@Override
	public int deleteBatch(Long[] ids){
		return userMessageDao.deleteBatch(ids);
	}

	@Override
	public List<UserMessageEntity> getHistoryMessageList(Map<String, Object> map) {
		return userMessageDao.getHistoryMessageList(map);
	}

	@Override
	public int getHistoryMessageCount(Map<String, Object> map) {
		return userMessageDao.getHistoryMessageCount(map);
	}

	@Override
	public List<MessageInfoEntity> getOfflineMessageList(Map<String, Object> map) {
		 List<MessageInfoEntity> result = userMessageDao.getOfflineMessageList(map);
		 //更新状态为已读状态
		 userMessageDao.updatemsgstate(map);
		 return result;
	}

	@Override
	public List<MessageInfoEntity> getOfflineGroupMessageList(Map<String, Object> map) {
		return userMessageDao.getOfflineGroupMessageList(map);
	}

	@Override
	public List<UserMessageTEntity> queryBoxList(Map<String, Object> map) {
		return userMessageDao.queryBoxList(map);
	}

	@Override
	public int queryBoxTotal(Map<String, Object> map) { return userMessageDao.queryBoxTotal(map);}

	@Override
	public List<MessageInfoEntity> getIMHistoryMessageList(Map<String, Object> map) {
		return userMessageDao.getIMHistoryMessageList(map);
	}

	@Override
	public int updateuserdate(Map<String, Object> map) {
		return userMessageDao.updateuserdate(map);
	}

    @Override
    public List<MessageInfoEntity> getGroupHistoryMessageList(Map<String, Object> map) {
	    //groupid   jointime
        return userMessageDao.getGroupHistoryMessageList(map);
    }

    @Override
    public int getGroupHistoryMessageCount(Map<String, Object> map) {
        return userMessageDao.getGroupHistoryMessageCount(map);
    }

}
