package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.service.impl.GroupUserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("GroupUser")
public class GroupUserController extends BaseController {
    @Autowired
    private GroupUserServiceImpl groupUserServiceImpl;

    /**
     * 删除群聊
     */
    @ResponseBody
    @RequestMapping(value = "/deleteGroup", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public String deleteGroup(@RequestBody Map<String,Object> params){
        StringBuilder errCode= new StringBuilder();

        String id1 = (String) params.get("userId");
        id1=id1.replace("\"", "");
        Integer userId = Integer.valueOf(id1);
        String id2 = (String) params.get("groupId");
        id2=id2.replace("\"", "");
        Integer groupId = Integer.valueOf(id2);
        try{
              groupUserServiceImpl.deleteGroup( userId, groupId );
        }catch (Exception e){
            errCode.append("E");
            return errCode.toString();
        }
        errCode.append("S");
        return errCode.toString();
    }
}
