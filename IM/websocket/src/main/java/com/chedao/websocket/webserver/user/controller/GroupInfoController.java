package com.chedao.websocket.webserver.user.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.service.impl.GroupInfoServiceImpl;
import org.directwebremoting.json.types.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("GroupInfo")
public class GroupInfoController extends BaseController {
    @Autowired
    private GroupInfoServiceImpl groupInfoServiceImpl;

    /**
     * 创建群聊
     */
    @ResponseBody
    @RequestMapping(value = "/addGroupInfo", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public String addGroupInfo(@RequestBody Map<String,Object> params){
        StringBuilder errCode= new StringBuilder();

        List<HashMap> userList = (List<HashMap>)params.get("groupInfo");
        GroupUserEntity groupManager = (GroupUserEntity) params.get("groupManager");
        String name = (String) params.get("name");
        GroupInfoEntity groupInfo = new GroupInfoEntity();
        groupInfo.setGroupNum("111");
        groupInfo.setGroupName(name);
        groupInfo.setGroupManId(groupManager.getUserId());
        groupInfo.setGroupMan(groupManager.getUserName());
        groupInfo.setRecorderId(groupManager.getUserId());
        groupInfo.setRecorder(groupManager.getUserName());
        groupInfo.setModifierId(groupManager.getUserId());
        groupInfo.setModifier(groupManager.getUserName());
        try{
           groupInfoServiceImpl.addGroupInfo(groupInfo);
        }catch (Exception e){
            errCode.append("E");
        }
        errCode.append("S");
        return errCode.toString();
    }
}
