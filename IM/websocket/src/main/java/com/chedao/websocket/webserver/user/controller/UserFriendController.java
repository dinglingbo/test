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


}
