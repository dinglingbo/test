package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserFriendEntity;
import com.chedao.websocket.webserver.user.service.impl.UserFriendServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/userfriend")
public class UserFriendController extends BaseController {
    @Autowired
   private UserFriendServiceImpl userFriendServiceImpl;


    //添加好友，新增两条数据,添加好友时，要确定是在那个分组下的好友
    @RequestMapping(value="/save", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody UserFriendEntity userFriend){

        StringBuilder errCode = new StringBuilder();
        try{
            for (int i = 0;i<2;i++){
                if(n==0){
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
    /@RequestMapping(value="/delet", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object delet(@RequestBody UserFriendEntity userFriend){
        System.out.print(id);
        StringBuilder errCode = new StringBuilder();
        try{
            userFriendServiceImpl.delete(id);
        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
        // return "pppp";
    }

}
