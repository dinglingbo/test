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
<% // 上传文件的保存路径  

        request.setCharacterEncoding("UTF-8");  
        response.setContentType("text/html;charset=UTF-8");  
        
        //构建文件保存目录路径  
        String configPath = "hsWechatImager/";
        String rootpath = request.getSession().getServletContext().getRealPath("");
        String savePath = rootpath+"/"+ configPath;
        savePath = savePath.replaceAll("\\\\", "/");
        
        
        //构建文件上传成功后的访问路径
        String rooturl="http://127.0.0.1:8080/default";
        String picpath = rooturl+"/"+ configPath;
        
        
        // 临时文件目录  
        String dirTemp = "hsWechatImagerTemp/";
        String tempPath = request.getContextPath()+"/"+ dirTemp;
        
        //获取当前上传时间的年月
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        String ymd = sdf.format(new Date()); 
        
        picpath += ymd;//访问路径添加上传时间的年月
        
        // 创建文件夹 
        savePath += ymd;//上传路径添加上传时间的年月
        File dirFile = new File(savePath);
        if (!dirFile.exists()){  //判断此路径的文件夹是否存在
            dirFile.mkdirs();//创建文件夹
        }  
       
        // 创建临时文件夹  
        tempPath += ymd;//临时路径添加上传时间的年月
        File dirTempFile = new File(tempPath);
        if (!dirTempFile.exists()){ //判断此路径的文件夹是否存在 
            dirTempFile.mkdirs();  
        }
        
        //开始上传
        DiskFileItemFactory factory = new DiskFileItemFactory();  
        factory.setSizeThreshold(20 * 1024 * 1024); // 设定使用内存超过5M时，将产生临时文件并存储于临时目录中。  
        factory.setRepository(new File(tempPath)); // 设定存储临时文件的目录。  
        
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
                    /* String newFileName = fileName; */
                    String fullFilePath = savePath+"/"+newFileName;//上传路径+文件
                    try{  
                        File uploadedFile = new File(fullFilePath);  
                        OutputStream os = new FileOutputStream(uploadedFile);  
                        InputStream is = item.getInputStream();  
                        byte buf[] = new byte[1024];// 可以修改 1024 以提高读取速度  
                        int length = 0;  
                        while ((length = is.read(buf)) > 0){  //开始上传
                            os.write(buf, 0, length);  
                        }  
                        // 关闭流  
                        os.flush();  
                        os.close();  
                        is.close();
                        /* 上传完成 */
                        
                        System.out.println("上传成功！本地路径：" + savePath + "/" + newFileName);  
                        String updata = picpath + "/" + newFileName;
                        System.out.println("url访问路径："+updata);
                        //fileName+""+configPath+ymd+ "/" + newFileName+"-"+fileExt+"-"+fileSize
                        String pictureUrl=configPath+ymd+ "/" + newFileName;
                        if(index == 0){
                        	returnData+="{'pictureName':'"+fileName+"','pictureUrl':'/"+pictureUrl+"','pictureType':'"+fileExt+"','pictureSize':"+fileSize+"}";
                        }else{
                        	returnData+=",{'pictureName':'"+fileName+"','pictureUrl':'/"+pictureUrl+"','pictureType':'"+fileExt+"','pictureSize':"+fileSize+"}";
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