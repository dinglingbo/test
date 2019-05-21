package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import com.chedao.websocket.webserver.util.Query;
import com.github.pagehelper.PageHelper;
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
		StringBuilder errCode = new StringBuilder();
		try {
			result = userInfoServiceImpl.update(userInfo);
		}catch (Exception e){

			//return putMsgToJsonString(result,"",0,"");
			return errCode.append("E");
		}
		//int result = userInfoServiceImpl.update(userInfo);
		//return putMsgToJsonString(result,"",0,"");
		return errCode.append("S");
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
	 * 好友查询
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
}
