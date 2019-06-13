package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserDepartmentEntity;
import com.chedao.websocket.webserver.user.service.UserDepartmentService;
import com.chedao.websocket.webserver.util.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 部门
 * 
 * @author im
 * @email 1044053532@qq.com
 * @date 2017-11-27 14:56:08
 */
@Controller
@RequestMapping("userdepartment")
public class UserDepartmentController extends BaseController {
	@Autowired
	private UserDepartmentService userDepartmentServiceImpl;
	
	/**
	 * 页面
	 */
	@RequestMapping("/page")
	public String page(@RequestParam Map<String, Object> params){
		return "userdepartment";
	}
	/**
	 * 列表
	 */
	@RequestMapping(value="/list", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object list(@RequestParam Map<String, Object> params){
	    Query query = new Query(params);
		List<UserDepartmentEntity> userDepartmentList = userDepartmentServiceImpl.queryList(query);
		int total = userDepartmentServiceImpl.queryTotal(query);
		return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userDepartmentList);
	}
	
	
	/**
	 * 信息
	 */
	@RequestMapping(value="/info/{id}", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object info(@PathVariable("id") Long id){
		UserDepartmentEntity userDepartment = userDepartmentServiceImpl.queryObject(id);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userDepartment);
	}
	
	/**
	 * 保存
	 */
	@RequestMapping(value="/save", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object save(@ModelAttribute UserDepartmentEntity userDepartment){
		userDepartmentServiceImpl.save(userDepartment);
		return putMsgToJsonString(Constants.WebSite.SUCCESS,"",0,userDepartment);
	}
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/update", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object update(@ModelAttribute UserDepartmentEntity userDepartment){
		int result = userDepartmentServiceImpl.update(userDepartment);
		return putMsgToJsonString(result,"",0,"");
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete", produces="text/html;charset=UTF-8", method = RequestMethod.POST)
	@ResponseBody
	public Object delete(@RequestParam Long[] ids){
		int result = userDepartmentServiceImpl.deleteBatch(ids);
		return putMsgToJsonString(result,"",0,"");
	}
	
}
