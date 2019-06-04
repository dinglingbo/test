package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.constant.Constants;
import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.ImFriendUserData;
import com.chedao.websocket.webserver.user.model.ImFriendUserInfoData;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;
import com.chedao.websocket.webserver.user.service.UserTypeService;
import com.chedao.websocket.webserver.user.service.impl.UserFriendServiceImpl;
import com.chedao.websocket.webserver.user.service.impl.UserTypeServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/usertype")
public class UserTypeController extends BaseController {

    @Autowired
    private UserTypeService userTypeServiceImpl;

    @Autowired
    private UserFriendServiceImpl userFriendServiceImpl;
    /**, produces="text/html;charset=UTF-8", method = RequestMethod.POST
     * 保存@RequestParam("name") UserTypeEntity userType,这种请求需要每个属性都写出来,name表示属性，表示只接受name这个参数，如果不写@RequestParam("")这个注解，则传什么属性，接受什么属性
     * @RequestBody UserTypeEntity userType，这种请求是表示接受json格式的，或者接收的是键值对格式，参数不写在URL后面
     * @RequestBody Long id :这种写法是错误的，@RequestBody 后面一般跟的实体类型
     */
    @RequestMapping(value="/save", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object save(@RequestBody UserTypeEntity userType){
        String userId = userType.getUserid().toString();
        if(StringUtils.isEmpty(userId)){
            return putMsgToJsonString(Constants.WebSite.ERROR, "用户ID不能为空", 0, null);
        }
        userType.setBuildtime(new Date());

        try{
            userType = userTypeServiceImpl.save(userType);
        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "保存分组信息失败", 0, null);
        }

        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, userType);

    }

    @RequestMapping(value="/update", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody UserTypeEntity userType){
        StringBuilder errCode = new StringBuilder();
        String userId = userType.getUserid().toString();
        if(StringUtils.isEmpty(userId)){
            return putMsgToJsonString(Constants.WebSite.ERROR, "用户ID不能为空", 0, null);
        }
        try{
            userTypeServiceImpl.update(userType);
        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "保存分组信息失败", 0, userType);
        }
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "", 0, userType);
    }

    @RequestMapping(value="/delet/{id}/{userId}", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object delet(@PathVariable("id")  Long id, @PathVariable("userId")String userId){

        StringBuilder errCode = new StringBuilder();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("id",id.toString());
        try{
            //需要判断该组下面有没有成员，接下来处理
            List<ImFriendUserInfoData> list = userFriendServiceImpl.queryListUser(id);
            if(list.size()>0) {
                return putMsgToJsonString(Constants.WebSite.ERROR, "分组下面有好友，不能删除", 0, map);
            }
            map.put("userid",userId);
            List<UserTypeEntity> userType = userTypeServiceImpl.queryList(map);
            if(userType==null){

            }else {
                if(userType.size()<=0) {
                    return putMsgToJsonString(Constants.WebSite.ERROR, "此分组不能删除", 0, map);
                }else {
                    userTypeServiceImpl.delete(id, userId);
                }
            }


        }catch (Exception e){
            return putMsgToJsonString(Constants.WebSite.ERROR, "删除分组信息失败", 0, null);
        }
        return putMsgToJsonString(Constants.WebSite.SUCCESS, "删除分组信息成功", 0, map);
    }



    @RequestMapping("/test")
    @ResponseBody
    public String test(){
        return "pppp";
    }
}
