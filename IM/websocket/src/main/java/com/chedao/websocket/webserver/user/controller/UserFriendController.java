package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.*;
import com.chedao.websocket.webserver.user.service.impl.GroupInfoServiceImpl;
import com.chedao.websocket.webserver.user.service.impl.UserFriendServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/userfriend")
public class UserFriendController extends BaseController {
    @Autowired
    private UserFriendServiceImpl userFriendServiceImpl;


    //添加好友，新增两条数据,添加好友时，要确定是在那个分组下的好友
    @RequestMapping(value="/save", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object save(@RequestBody UserFriendEntity userFriend){

        StringBuilder errCode = new StringBuilder();
        try{
            for (int i = 0;i<2;i++){
                if(i==0){
                    userFriendServiceImpl.save(userFriend);
                }else{
                   UserFriendEntity userf = new UserFriendEntity();
                   userf.setFriendid(userFriend.getUserid());
                   userf.setFriendname(userFriend.getUsername());
                   userf.setUserid(userFriend.getFriendid());
                   userf.setUsername(userFriend.getFriendname());
                    userFriendServiceImpl.save(userf);
                }
            }

        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
    }

    //更换分组
    @RequestMapping(value="/update", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody UserFriendEntity userFriend){

        StringBuilder errCode = new StringBuilder();
        try{
            userFriendServiceImpl.update(userFriend);
        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
    }

    //删除好友，删除两条数据
    @RequestMapping(value="/delet", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object delet(@RequestBody UserFriendEntity userFriend){

        StringBuilder errCode = new StringBuilder();
        try{
            userFriendServiceImpl.delete(userFriend);
        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
        // return "pppp";
    }
    /**
     * 判断是否为好友
     */
    @ResponseBody
    @RequestMapping(value = "/isFriend", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Map<String,Object> checkIsFriend(@RequestBody Map<String,Object> params){
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder errCode= new StringBuilder();
        String userId = (String) params.get("userId");
        userId=userId.replace("\"", "");
        String friendId = (String) params.get("friendId");
        friendId=friendId.replace("\"", "");
        try{
            Integer count = userFriendServiceImpl.isFriend(userId,friendId);
            if(count>0){
                map.put("isFriend", true);
            }else{
                map.put("isFriend", false);
            }
        }catch (Exception e){
            errCode.append("E");
            map.put("errCode", errCode);
        }
        errCode.append("S");
        map.put("errCode", errCode);
        return map;
    }



}
