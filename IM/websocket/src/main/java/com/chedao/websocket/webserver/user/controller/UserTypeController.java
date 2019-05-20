package com.chedao.websocket.webserver.user.controller;

import com.chedao.websocket.webserver.base.controller.BaseController;
import com.chedao.websocket.webserver.user.model.UserTypeEntity;
import com.chedao.websocket.webserver.user.service.impl.UserTypeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Controller
@RequestMapping("/usertype")
public class UserTypeController extends BaseController {

    @Autowired
    private UserTypeServiceImpl userTypeServiceImpl;
    /**, produces="text/html;charset=UTF-8", method = RequestMethod.POST
     * 保存@RequestParam("name") UserTypeEntity userType,这种请求需要每个属性都写出来,name表示属性，表示只接受name这个参数，如果不写@RequestParam("")这个注解，则传什么属性，接受什么属性
     * @RequestBody UserTypeEntity userType，这种请求是表示接受json格式的，或者接收的是键值对格式，参数不写在URL后面
     * @RequestBody Long id :这种写法是错误的，@RequestBody 后面一般跟的实体类型
     */
    @RequestMapping(value="/save", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object save(@RequestBody UserTypeEntity userType){

        userType.setBuildtime(new Date());
        StringBuilder errCode = new StringBuilder();
       // String errCode = "1";
        try{
            userTypeServiceImpl.save(userType);
        }catch (Exception e){
           errCode.append("E");
           // errCode = "2";
            return errCode;
        }
        errCode.append("S");
        return errCode;

       // return "pppp";
    }

    @RequestMapping(value="/update", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody UserTypeEntity userType){
        System.out.print(userType);
        StringBuilder errCode = new StringBuilder();
        try{
            userTypeServiceImpl.update(userType);
        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
        // return "pppp";
    }

    @RequestMapping(value="/delet/{id}", produces="application/json;charset=UTF-8", method = RequestMethod.POST)
    @ResponseBody
    public Object delet(@PathVariable("id")  Long id){
        System.out.print(id);
        StringBuilder errCode = new StringBuilder();
        try{
            userTypeServiceImpl.delete(id);
        }catch (Exception e){
            errCode.append("E");
            return errCode;
        }
        errCode.append("S");
        return errCode;
        // return "pppp";
    }



    @RequestMapping("/test")
    @ResponseBody
    public String test(){
        return "pppp";
    }
}
