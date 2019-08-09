<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="com.eos.foundation.eoscommon.BusinessDictUtil"%>

<%@page import="com.huasheng.usersWechat.WeChatImageTextMessAge"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>

<% // 上传文件的保存路径  

        request.setCharacterEncoding("UTF-8");  
        response.setContentType("text/html;charset=UTF-8");  
        
        DiskFileItemFactory factory = new DiskFileItemFactory();  
        ServletFileUpload upload = new ServletFileUpload(factory);  
        upload.setHeaderEncoding("UTF-8");  
        try  
        {  
            List items = upload.parseRequest(request);
            Iterator itr = items.iterator();  
            String returnData="";
            int index=0;
            while (itr.hasNext()){
                FileItem item = (FileItem) itr.next();  
                String fileName = item.getName();//当前上传图片的名称
                long fileSize = item.getSize();//当前上传图片的大小
                
                if (!item.isFormField()){
                    String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase(); //当前上传图片的格式
                    System.out.println("当前上传图片的格式："+fileExt);
                    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
                    String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;//当前的时间+顺机数字+文件格式=文件
                    System.out.println("当前上传文件名称："+newFileName);
                    try{
                    	//微信-新增临时素材的接口
                        JSONObject resjson = WeChatImageTextMessAge.UploadMeida("image",item.getInputStream(),newFileName);
                        
                        if(index == 0){
                        	returnData=resjson.toJSONString();
                        }else{
                        	returnData+=(","+resjson.toJSONString());
                        }
                        index++;
                    }catch (Exception e){
                        e.printStackTrace();  
                    }
                    
                }else{  
                    returnData="上传失败";
                }
                
            }
            if( index > 1 ){
            	returnData = "["+returnData+"]";
            }
            response.getWriter().write(returnData);//返回没有url的路径到前端给数据库储存
        }catch (FileUploadException e){  
            e.printStackTrace();  
        }  
        
        out.flush();  
        out=pageContext.pushBody();
        
 %>