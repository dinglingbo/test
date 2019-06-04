package com.chedao.websocket.webserver.user.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.server.connertor.ImConnertor;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import com.chedao.websocket.webserver.user.service.GroupUserService;
import com.chedao.websocket.webserver.user.service.impl.GroupInfoServiceImpl;
import com.chedao.websocket.webserver.user.service.impl.GroupUserServiceImpl;
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

import static com.alibaba.fastjson.JSONObject.*;

@Controller
@RequestMapping("GroupInfo")
public class GroupInfoController extends BaseController {
    @Autowired
    private GroupInfoService groupInfoServiceImpl;
    @Autowired
    private GroupUserService groupUserServiceImpl;
    @Autowired
    private ImConnertor connertor;
    /**
     * 创建群聊
     */
    @ResponseBody
    @RequestMapping(value = "/addGroupInfo", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Object addGroupInfo(@RequestBody Map<String,Object> params){
        StringBuilder errCode= new StringBuilder();

        List<Map<String,Object>> userList = (ArrayList<Map<String,Object>>)params.get("groupUser");
        Map<String,Object> groupManager = (Map<String, Object>) params.get("groupManager");
        String groupMan  = (String) groupManager.get("userName");
        String id = (String) groupManager.get("userId");
        id=id.replace("\"", "");
        Integer groupManId = Integer.valueOf(id);

        String name = (String) params.get("name");
        GroupInfoEntity groupInfo = new GroupInfoEntity();
        groupManager.get("userId");
        groupInfo.setGroupNum("111");
        groupInfo.setGroupName(name);
        groupInfo.setGroupManId(groupManId);
        groupInfo.setGroupMan(groupMan);
        groupInfo.setRecorderId(groupManId);
        groupInfo.setRecorder(groupMan);
        groupInfo.setModifierId(groupManId);
        groupInfo.setModifier(groupMan);
        try{
            Integer groupInfoId =  groupInfoServiceImpl.addGroupInfo(groupInfo);
            List<String> reSessionIdList = new ArrayList<String>();
            for(int i=0;i<userList.size();i++) {
                Map<String, Object> map = userList.get(i);
                String uid = map.get("userId").toString();
                if(!uid.equals(id)) {
                    reSessionIdList.add(uid);
                }
                map.put("groupId", groupInfoId);
            }
            groupUserServiceImpl.addGroupUser(userList);
            groupInfo.setId(groupInfoId);

            connertor.pushCreateGroupMessage(id, reSessionIdList, JSONObject.toJSONString(groupInfo));

        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "创建群聊失败", 0, null);
        }
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "创建群聊成功", 0, groupInfo);
    }

    /**
     * 修改
     */
    @ResponseBody
    @RequestMapping(value = "/updataGroupInfo", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public String updataGroupInfo(@RequestBody Map<String,Object> params){
        StringBuilder errCode= new StringBuilder();

        Map<String,Object> group = (Map<String, Object>) params.get("groupInfo");
        String id1 = (String) group.get("userId");
        id1=id1.replace("\"", "");
        Integer userId = Integer.valueOf(id1);
        String id2 = (String) group.get("id");
        id2=id2.replace("\"", "");
        Integer groupId = Integer.valueOf(id2);

        GroupInfoEntity groupInfo = new GroupInfoEntity();
        groupInfo.setId(groupId);
        groupInfo.setGroupName((String) group.get("groupName"));
        groupInfo.setAvatar((String) group.get("avatar"));
        groupInfo.setRemark((String) group.get("remark"));
        groupInfo.setModifierId(userId);
        groupInfo.setModifier((String) group.get("userName"));
        try{
            groupInfoServiceImpl.updateGroup(groupInfo);
        }catch (Exception e){
            errCode.append("E");
            return errCode.toString();
        }
        errCode.append("S");
        return errCode.toString();
    }


}
