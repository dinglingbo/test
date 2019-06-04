package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.GroupInfoEntity;
import com.chedao.websocket.webserver.user.model.GroupUserEntity;
import com.chedao.websocket.webserver.user.model.UserInfoEntity;
import com.chedao.websocket.webserver.user.service.GroupInfoService;
import com.chedao.websocket.webserver.user.service.GroupUserService;
import com.chedao.websocket.webserver.user.service.impl.GroupInfoServiceImpl;
import com.chedao.websocket.webserver.user.service.impl.GroupUserServiceImpl;
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
@RequestMapping("GroupUser")
public class GroupUserController extends BaseController {
    @Autowired
    private GroupUserService groupUserServiceImpl;
    @Autowired
    private GroupInfoService groupInfoService;
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

    /**
     * c查询群聊
     */
    @ResponseBody
    @RequestMapping(value = "/queryGroupInfo", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Map<String,Object> queryGroupInfo(@RequestBody Map<String,Object> params){
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder errCode= new StringBuilder();
        String id1 = (String) params.get("userId");
        id1=id1.replace("\"", "");
        Integer userId = Integer.valueOf(id1);

        try{
            List<GroupUserEntity> groupUserEntity =  groupUserServiceImpl.queryGroupInfo(userId);
/*           String userIdStr = "";
            for(int i=0;i<groupUserEntity.size();i++) {
                if(i<(groupUserEntity.size()-1)){
                    GroupUserEntity gu  =  groupUserEntity.get(i);
                    userIdStr += gu.getGroupId()+",";
                }else{
                    GroupUserEntity gu  =  groupUserEntity.get(i);
                    userIdStr += gu.getGroupId();
                }

            }*/
/*            List<GroupUserEntity> userIds = new ArrayList<GroupUserEntity>();
            for(int i=0;i<groupUserEntity.size();i++) {
                GroupUserEntity gu  =  groupUserEntity.get(i);
                userIds.add(gu);

            }*/
            List<GroupInfoEntity> groupInfoEntityList =  groupInfoService.queryGroupInfo(groupUserEntity);
            map.put("data", groupInfoEntityList);
        }catch (Exception e){
            errCode.append("E");
            map.put("errCode", errCode);
        }
        errCode.append("S");
        map.put("errCode", errCode);
        return map;
    }

    /**
     * c查询群聊昵称
     */
    @ResponseBody
    @RequestMapping(value = "/queryGroupName", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Map<String,Object> queryGroupName(@RequestBody Map<String,Object> params){
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder errCode= new StringBuilder();
        String userId = (String) params.get("userId");
        userId=userId.replace("\"", "");
        String groupId = (String) params.get("groupId");
        groupId=groupId.replace("\"", "");
        try{
            List<GroupUserEntity> groupUserEntityList =  groupUserServiceImpl.queryGroupName(userId,groupId);
            map.put("name", groupUserEntityList.get(0).getUserName());
        }catch (Exception e){
            errCode.append("E");
            map.put("errCode", errCode);
        }
        errCode.append("S");
        map.put("errCode", errCode);
        return map;
    }

    /**
     * 修改群聊昵称
     */
    @ResponseBody
    @RequestMapping(value = "/updateGroupName", produces = "application/json;charset=UTF-8", method = RequestMethod.POST)
    public Object updateGroupName(@RequestBody Map<String,Object> params){
        Map<String, Object> map = new HashMap<String, Object>();
        StringBuilder errCode= new StringBuilder();
        String userId = (String) params.get("userId");
        userId=userId.replace("\"", "");
        String groupId = (String) params.get("groupId");
        groupId=groupId.replace("\"", "");
        String name = (String) params.get("name");
        try{
              groupUserServiceImpl.updateGroupName(userId,groupId,name);
        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "修改失败", 0, null);
        }
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "修改成功", 0, params);
    }
}
