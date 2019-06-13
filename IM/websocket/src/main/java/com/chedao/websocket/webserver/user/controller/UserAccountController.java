package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserAccountEntity;
import com.chedao.websocket.webserver.user.service.UserAccountService;
import com.chedao.websocket.webserver.util.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 用户帐号
 * 
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-27 14:56:08
 */
@Controller
@RequestMapping("useraccount")
public class UserAccountController extends BaseController {
	@Autowired
	private UserAccountService userAccountServiceImpl;
	
	/**
	 * 页面
	 */
	@RequestMapping("/page")
	public String page(@RequestParam Map<String, Object> params){
		return "useraccount";
	}
	/**
	 * 列表
	 */
	@RequestMapping(value="/list", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object list(@RequestParam Map<String, Object> params){
	    Query query = new Query(params);
		List<UserAccountEntity> userAccountList = userAccountServiceImpl.queryList(query);
		int total = userAccountServiceImpl.queryTotal(query);
		return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userAccountList);
	}
	
	
	/**
	 * 信息
	 */
	@RequestMapping(value="/info/{id}", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object info(@PathVariable("id") Long id){
		UserAccountEntity userAccount = userAccountServiceImpl.queryObject(id);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userAccount);
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value="/save", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object save(@ModelAttribute UserAccountEntity userAccount){
		userAccount.setDisablestate(0);
		userAccount.setIsdel(0);
		userAccountServiceImpl.save(userAccount);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userAccount);
	}

	/**
	 * 保存
	 */
	@RequestMapping(value="/ins", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object ins(@RequestBody UserAccountEntity userAccount){
		userAccount.setDisablestate(0);
		userAccount.setIsdel(0);
		userAccountServiceImpl.save(userAccount);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userAccount);
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/update", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object update(@ModelAttribute UserAccountEntity userAccount){
		int result = userAccountServiceImpl.update(userAccount);
		return putMsgToJsonString(result,"",0,"");
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object delete(@RequestParam Long[] ids){
		int result = userAccountServiceImpl.deleteBatch(ids);
		return putMsgToJsonString(result,"",0,"");
	}
	
}
