package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import com.chedao.websocket.webserver.user.service.UserFriendService;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import com.chedao.websocket.webserver.util.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 用户信息表
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-27 14:56:08
 */
@Controller
@RequestMapping("/userinfo")
public class UserInfoController extends BaseController {
	@Autowired
	private UserInfoService userInfoServiceImpl;
	@Autowired
	private UserFriendService userFriendServiceImpl;
	@Autowired
	private GroupInfoService groupInfoService;
	
	/**
	 * 页面
	 */
	@RequestMapping("/page")
	public String page(@RequestParam Map<String, Object> params){
		return "userinfo";
	}
	/**
	 * 列表
	 */
	@RequestMapping(value="/list", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object list(@RequestParam Map<String, Object> params){
	    Query query = new Query(params);
		List<UserInfoEntity> userInfoList = userInfoServiceImpl.queryList(query);
		int total = userInfoServiceImpl.queryTotal(query);
		return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userInfoList);
	}

	@RequestMapping(value = "/queryByUid/{uid}", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object queryByUid(@PathVariable("uid") Long uid) {
		UserInfoEntity userInfo = userInfoServiceImpl.queryByUid(uid);
		return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, userInfo);
	}
	
	/**
	 * 信息
	 */
	@RequestMapping(value="/info/{id}", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object info(@PathVariable("id") Long id){
		UserInfoEntity userInfo = userInfoServiceImpl.queryObject(id);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userInfo);
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value="/save", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object save(@ModelAttribute UserInfoEntity userInfo){
		userInfoServiceImpl.save(userInfo);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userInfo);
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/update", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object update(@RequestBody UserInfoEntity userInfo){
		SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String str = sdf.format(new Date());
		userInfo.setUpdatedate(str);
		int result = 0;
		try {
			result = userInfoServiceImpl.update(userInfo);
		}catch (Exception e){

			return putMsgToJsonString(Constants.WebSite.ERROR, "操作异常", 0, userInfo);
		}
		return putMsgToJsonString(Constants.WebSite.SUCCESS, "操作成功", 0, userInfo);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object delete(@RequestParam Long[] ids){
		int result = userInfoServiceImpl.deleteBatch(ids);
		return putMsgToJsonString(result,"",0,"");
	}

	/**
	 * 添加好友查询
	 */
	@ResponseBody
	@RequestMapping("/queryUserinfo")
	public Map<String,Object> fdf(@RequestParam("name") String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<UserInfoEntity> userInfo = userInfoServiceImpl.queryUserInfo(name);
		//int countx = userInfoDao.queryAllCountxx();
		map.put("data", userInfo);
		//map.put("ct", countx);
		return map;
	}

	//查找好友
	@RequestMapping(value="/queryUserFriendList", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object queryUserFriendList(@RequestBody Map<String,Object> params) {
		String userId =(String)params.get("userId");
		Long uid = Long.parseLong(userId);
		List<UserFriendTEntity> userFriendList = userFriendServiceImpl.queryUserFriendList(userId);

		List<GroupInfoTEntity> userGroupList = groupInfoService.queryUserGroupList(params);

		UserInfoEntity userInfo = userInfoServiceImpl.queryByUid(uid);
		ImFriendUserInfoData userWrapper = new ImFriendUserInfoData();
		userWrapper.setId(userInfo.getUid());
		userWrapper.setStatus("online");
		userWrapper.setAvatar(userInfo.getProfilephoto());
		userWrapper.setSign(userInfo.getSignature());
		userWrapper.setUsername(userInfo.getNickname());

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mine",userWrapper);
		map.put("friend",userFriendList);
		map.put("group",userGroupList);

		return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, map);
	}
}
