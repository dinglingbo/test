package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserFriendApplyEntity;
import com.chedao.websocket.webserver.user.model.UserMessageEntity;
import com.chedao.websocket.webserver.user.model.UserMessageTEntity;
import com.chedao.websocket.webserver.user.service.UserFriendApplyService;
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
    private UserFriendApplyService userFriendApplyServiceImpl;

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
    public Object applyFriend(@RequestBody UserFriendApplyEntity friend) {
        try{
            friend.setStatus(0);
            Map map = userFriendApplyServiceImpl.applyFriend(friend);
            return map;
        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "添加好友申请异常", 0, null);
        }
    }

    /**
     * 列表
     */
    @RequestMapping(value = "/friendApplySettle", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object agree(@RequestBody Map<String, Object> params) {
        Long uid = Long.parseLong(params.get("uid").toString()); //对方用户ID
        Long id = Long.parseLong(params.get("id").toString());  //我的用户ID
        Long keyId = Long.parseLong(params.get("keyId").toString());  //主键ID
        String type = params.get("type").toString();
        Map<String, Object> map;
        if(type.equals("agree")) {
            Long from_group = Long.parseLong(params.get("from_group").toString()); //对方分组ID
            Long group = Long.parseLong(params.get("group").toString());  //我的分组ID
            map = userFriendApplyServiceImpl.agreeFriend(uid, from_group, group, id, keyId);
            return putMsgToJsonString(Constants.WebSite.SUCCESS, map.get("msg").toString(), 0, null);
        }else if(type.equals("refuse")){
            map = userFriendApplyServiceImpl.refuseFriend(uid, id, keyId);
            return putMsgToJsonString(Constants.WebSite.SUCCESS, map.get("msg").toString(), 0, null);
        }else{
            return putMsgToJsonString(Constants.WebSite.ERROR, "好友申请处理失败", 0, null);
        }
    }
}
