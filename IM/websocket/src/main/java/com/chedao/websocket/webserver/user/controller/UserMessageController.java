package com.chedao.websocket.webserver.user.controller;

import com.alibaba.fastjson.JSONArray;
import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.UserInfoService;
import com.chedao.websocket.webserver.user.service.UserMessageService;
import com.chedao.websocket.webserver.user.service.impl.GroupUserManager;
import com.chedao.websocket.webserver.user.service.impl.UserFriendApplyServiceImpl;
import com.chedao.websocket.webserver.util.PageBean;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.crypto.MacSpi;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author qiqiim
 * @email 1044053532@qq.com
 * @date 2017-11-23 10:47:47
 */
@Controller
@RequestMapping("usermessage")
public class UserMessageController extends BaseController {
    @Autowired
    private UserMessageService userMessageServiceImpl;
    @Autowired
    private GroupUserManager groupUserManager;
    @Autowired
    private UserFriendApplyServiceImpl userFriendApplyServiceImpl;
    @Autowired
    private UserInfoService userInfoServiceImpl;
    /**
     * 页面
     */
    @RequestMapping("/page")
    public String page(@RequestParam Map<String, Object> params) {
        return "user/usermessage";
    }

    /**
     * 列表
     */
    @RequestMapping(value = "/list", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object list(@RequestBody Map<String, Object> params) {
        //Query query = new Query(params);
        String typeList = params.get("typeList").toString();
        if(typeList != null && typeList != ""){
            String [] typeArr= typeList.split(",");
            params.put("typeList",typeArr);
        }
        PageHelper.startPage(Integer.parseInt(params.get("page").toString()), 10);
        List<UserMessageEntity> userMessageList = userMessageServiceImpl.queryList(params);
        int total = userMessageServiceImpl.queryTotal(params);
        PageBean<UserMessageEntity> page = new PageBean<UserMessageEntity>(Integer.parseInt(params.get("page").toString()), 10, total);
        return putPageMsgToJsonString(Constants.WebSite.SUCCESS, "", page, userMessageList);
        //return putMsgToJsonString(Constants.WebSite.SUCCESS, "", total, userMessageList);
    }

    /**
     * 消息盒子内容
     */
    @RequestMapping(value = "/boxlist", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object boxlist(@RequestBody Map<String, Object> params) {
        List<UserMessageTEntity> messageList = new ArrayList<UserMessageTEntity>();
        String typeList = params.get("typeList").toString();
        if(typeList != null && typeList != ""){
            String [] typeArr= typeList.split(",");
            params.put("typeList",typeArr);
        }
        Integer pageIndex = Integer.parseInt(params.get("page").toString());
        PageHelper.startPage(pageIndex, 10);
        List<UserMessageTEntity> userMessageList = userMessageServiceImpl.queryBoxList(params);
        if(pageIndex == 1) {
            params.put("status",0);
            List <UserMessageTEntity> userFriendApplyList = userFriendApplyServiceImpl.queryBoxList(params);

            messageList.addAll(userFriendApplyList);
        }
        messageList.addAll(userMessageList);

        int total = userMessageServiceImpl.queryBoxTotal(params);
        PageBean<UserMessageEntity> page = new PageBean<UserMessageEntity>(Integer.parseInt(params.get("page").toString()), 10, total);

        return putPageMsgToJsonString(Constants.WebSite.SUCCESS, "", page, messageList);
    }

    /**
     * 聊天记录
     */
    @RequestMapping(value = "/chatlist", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object chatlist(@RequestBody Map<String, Object> params) {
        Integer pageIndex = Integer.parseInt(params.get("page").toString());
        PageHelper.startPage(pageIndex, 10);
        List<MessageInfoEntity> chatList = userMessageServiceImpl.getIMHistoryMessageList(params);
        int total = userMessageServiceImpl.getHistoryMessageCount(params);
        PageBean<UserMessageEntity> page = new PageBean<UserMessageEntity>(Integer.parseInt(params.get("page").toString()), 10, total);
        return putPageMsgToJsonString(Constants.WebSite.SUCCESS, "", page, chatList);
    }

    /**
     * 首页提醒消息数量：
     *        1、统计未读的好友申请的反馈结果（判断条件isread=0）；
     *        2、统计最近一周未读的系统消息（
     *                    if(lastoffdate=null)  查询最近一周的系统消息
     *                    else 查询 lastoffdate 到现在 的数据）
     * 消息盒子内容
     */
    @RequestMapping(value = "/offlist", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object offlist(@RequestBody Map<String, Object> params) {
        UserInfoEntity userInfoEntity = userInfoServiceImpl.queryByUid(Long.parseLong(params.get("receiveuser").toString()));
        params.put("isread",0);
        params.put("type",2);
        int i = userMessageServiceImpl.queryTotal(params); //1、统计未读的好友申请的反馈结果（判断条件isread=0）；
        String lastoffdate = userInfoEntity.getLastoffdate();
        params.remove("isread");
        params.remove("receiveuser");
        params.put("type",3);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String day = dateFormat.format(new Date());
        if(lastoffdate==null || lastoffdate=="") {
            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.DATE, - 7);
            Date d = c.getTime();
            params.put("screatedate",dateFormat.format(d));
            params.put("ecreatedate",day);
        }else {
            params.put("screatedate",lastoffdate);
            params.put("ecreatedate",day);
        }
        int j = userMessageServiceImpl.queryTotal(params);

        List<MessageInfoEntity> list = userMessageServiceImpl.getOfflineMessageList(params);
        List<MessageInfoEntity> grouplist = userMessageServiceImpl.getOfflineGroupMessageList(params);
        list.addAll(grouplist);
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", i + j, list);
        //return JSONArray.toJSON(list);
    }

    /**
     * 信息
     */
    @RequestMapping(value = "/info/{id}", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object info(@PathVariable("id") Long id) {
        UserMessageEntity userMessage = userMessageServiceImpl.queryObject(id);
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, userMessage);
    }

    /**
     * 保存
     */
    @RequestMapping(value = "/save", produces = "text/html;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object save(@RequestBody UserMessageEntity userMessage) {
        userMessageServiceImpl.save(userMessage);
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, userMessage);
    }

    /**
     * 修改
     */
    @RequestMapping(value = "/update", produces = "text/html;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody UserMessageEntity userMessage) {
        int result = userMessageServiceImpl.update(userMessage);
        return putMsgToJsonString(result, "", 0, "");
    }

    /**
     * 删除
     */
    @RequestMapping(value = "/delete", produces = "text/html;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object delete(@RequestBody Long[] ids) {
        int result = userMessageServiceImpl.deleteBatch(ids);
        return putMsgToJsonString(result, "", 0, "");
    }
    /**
     * 查询所有成员信息
     */
    @ResponseBody
    @RequestMapping(value = "/queryGroupUserinfoList", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Map<String,Object> queryGroupUserinfoList(@RequestBody Map<String,Object> params){
        StringBuilder errCode= new StringBuilder();
        Map<String, Object> map = new HashMap<String, Object>();
        String groupId = (String) params.get("groupId");
        groupId=groupId.replace("\"", "");
        try{
            List<UserInfoExtendEntity> userInfoExtendEntityList =  groupUserManager.getGroupMemberList(groupId);
            map.put("data", userInfoExtendEntityList);
        }catch (Exception e){
            errCode.append("E");
            map.put("errCode", "E");
            return map;
        }
        errCode.append("S");
        map.put("errCode", "S");
        return map;
    }
}
