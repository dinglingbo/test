<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00
  - Description:
-->
<head>
    <title>用户反馈管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
    <script src="<%=webPath + contextPath%>/common/js/feedbackLDetail.js?v=1.1.12" type="text/javascript"></script>       
</head>
 <style type="text/css"> 
 
 	.max_img{
		display: none;
		position: absolute;
		bottom: 0;
		left: 0; 
		width:1000px;
		height:800px;
	}
   a.optbtn {
        width: 60px; 
        /* height: 26px; */
        border: 1px #d2d2d2 solid;
        background: #f2f6f9;
        text-align: center;
        display: inline-block;    
        /* line-height: 26px; */
        margin: 0 4px;
        color: #000000;
        text-decoration: none;
        border-radius: 5px; 
    }
    		.pay_top  {
			font-size: 16px;
			line-height: 38px;
		}
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;
    }
    
    .addyytime a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
    .addyytime a.hui{padding-left: 5px;padding-right: 5px;height:;line-height:24px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;
        text-align:center;color:#00b4f6;border-radius:4px;margin:0 5px 5px 0;}
    .addyytime a.hui{border:1px #e6e6e6 solid;color:#555555;background:#5ab1ef;}
    .addyytime a.xz{ font-size: 13px; color: #555555 !important; background:#5ab1ef !important;}
    .addyytime a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px; color: #555555; text-decoration: none; }
    .addyytime a .hui{text-decoration:none;transition:all .4s ease;}
    .addyytime a.backRed{border:1px #e6e6e6 solid;color:#555555;background:#5ab1ef ;}  
 
   
 </style>
<body >
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;" >
		<table id="form" style="width:100%;">
			 <tr>
			 <td >
			   <a class="mini-button" iconCls="" onclick="updFinish()" plain="true" id="updFinish" ><span class="fa fa-save fa-lg"></span>标记为已解决</a>
		       <a class="nui-button" iconCls="" plain="true" onclick="Oncancel" id="Oncancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		    </td>
	  	    </tr>
		</table>
	</div> 
		<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;" >
		<legend>用户信息</legend> 
		<div id="dataform1" style="padding-top: 5px;" >
			<table>
			<tr>
			    <td class="title required" width="200" height="28">
			    	手机号：
					<span style="padding-top: 2px;"  id="recordMobile" name="recordMobile"></span>
                </td>
                <td class="title required" width="200" height="28">
			    	用户名：
					<span style="padding-top: 2px;"  id="recorder" name="recorder"></span>
                </td>
                <td class="title required" width="200" height="28">
			    	公司：
					<span style="padding-top: 2px;"  id="orgname" name="orgname"></span>
                </td>
		   </tr>
		   </table>
		</div>
	</fieldset>
	
     
    <fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;" >
		<legend>问题描述</legend> 
		 <div class="addyytime" style="display:''" id="showHot" >
              <table style="width:100%;height:50px;">
              	<tr>
	              	<td class="title required" width="100" height="28">
				    	来源：
						<span style="padding-top: 2px;padding-right: 200px;"  id="questionSource" name="questionSource"></span>
						反馈日期：
						<span style="padding-top: 2px;"  id="recordDate" name="recordDate"></span>
	                </td>
              	</tr>
              	<tr>
	              	<td class="title required" width="100" height="28">
				    	功能标题：
						<span style="padding-top: 2px;padding-right: 150px;display:none"  id="funcName" name="funcName"></span>
						功能路径：
						<span style="padding-top: 2px;display:none"  id="funcAction" name="funcAction"></span>
	                </td>
              	</tr>
                <tr>
                    <td id="addAEl">
                     
                    </td>
               </tr>
            </table>
        </div>
	</fieldset>
	 <fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend>反馈图片</legend> 
		 <div style="padding-top: 2px;padding-left:30px; width:620px;height:250px">
		 <img src="" width="620px" height="250px" text-align="center" id="imgShow" onclick="changeShow();"/>
	    </div>
	    
	</fieldset>
	<!-- <div style="padding-top: 10px;padding-left:30px; width:620px;height:250px">
		
	</div> -->
	<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend>处理情况</legend> 
		<div id="dataform2" style="padding-top: 5px;" >
			<table>
			<tr>
                <td class="title required" width="200" height="28">
			    	处理人：
					<span style="padding-top: 2px;"  id="settlor" name="settlor"></span>
                </td>
                <td class="title required" width="200" height="28">
			    	处理日期：
					<span style="padding-top: 2px;"  id="settleDate" name="settleDate"></span>
                </td>
		   </tr> 
		   </table>
		</div>
		<div style="padding-top: 0px;">
		<font>回复：</font>
		<input class="nui-TextArea" name="settleContent" id="settleContent" style="width: 93%; height: 100px;" />
	    </div>
	</fieldset>
	   <div class="max_img" style=" width:100%;height:100%;margin:0 auto">
			<img src="" id="maxImgShow" onclick="changeHide();" width="100%" height="100%" />
	   </div>
	
	
</body>
</html>