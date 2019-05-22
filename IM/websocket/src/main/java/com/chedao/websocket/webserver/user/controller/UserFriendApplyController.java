package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;
import com.chedao.websocket.webserver.user.service.impl.UserFriendApplyServiceImpl;
import com.chedao.websocket.webserver.util.PageBean;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("userfriendapply")
public class UserFriendApplyController extends BaseController {
    @Autowired
    private UserFriendApplyServiceImpl userFriendApplyServiceImpl;

    /**
     * 列表
     */
    @RequestMapping(value = "/list", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object list(@RequestBody Map<String, Object> params) {
        Integer uid = Integer.parseInt(params.get("uid").toString());
        PageHelper.startPage(Integer.parseInt(params.get("page").toString()), 10);
        List < UserFriendApplyEntity > userFriendApplyList = userFriendApplyServiceImpl.getUserFriendApplyList(uid);
        int total = userFriendApplyServiceImpl.queryTotal(params);
        //PageBean<UserMessageEntity> page = new PageBean<UserMessageEntity>(Integer.parseInt(params.get("page").toString()), 10, total);
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userFriendApplyList);
        //return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userMessageList);
    }

    @RequestMapping(value = "/boxlist", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object boxlist(@RequestBody Map<String, Object> params) {
        Integer pageIndex = Integer.parseInt(params.get("page").toString());
        PageHelper.startPage(pageIndex, 10);
        List <UserMessageTEntity> userFriendApplyList = userFriendApplyServiceImpl.queryBoxList(params);
        int total = userFriendApplyServiceImpl.queryTotal(params);
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userFriendApplyList);
    }

    /**
     * 好友申请
     */
    @ResponseBody
    @RequestMapping(value = "/applyFriend", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public String applyFriend(@RequestBody UserFriendApplyEntity friend) {
        StringBuilder errCode= new StringBuilder();
        try{
            userFriendApplyServiceImpl.applyFriend(friend);
        }catch (Exception e){
            errCode.append("E");
        }
        errCode.append("S");
        return errCode.toString();
    }
}
