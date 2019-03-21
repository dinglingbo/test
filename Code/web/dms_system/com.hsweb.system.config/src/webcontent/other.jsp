<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-15 14:06:57
  - Description:
-->
<head>
<title>其他</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
   	<script src="<%=webPath + contextPath%>/config/js/other.js?v=1.0.3" type="text/javascript"></script>
    <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
    	.pic { /* 页面logo图片 */
			background-image: ;
			background-repeat: no-repeat;
			background-size: 100% 100%;
			border-radius: 4px;
		}
		.div1{
			float: left;
			height: 120px;
			width: 120px;
			position:relative;
		}



		.inputstyle{
		    width: 120px;
		    height: 120px;
		    cursor: pointer;
		    font-size: 30px;
		    outline: medium none;
		    position: absolute;
		    filter:alpha(opacity=0);
		    -moz-opacity:0;
		    opacity:0; 
		    left:0px;
		    top: 0px;
		}
    </style>
</head>
<body>
	       
        <div id="basicInfoForm" class="form" contenteditable="false" >     
           <table  >


            <tr >
                <td align="right">系统LOGO图片：</br>(LOGO最佳大小：80px*50px)<span class="spanwidth"></span>   </td>
                <td  colspan="5" class="tabwidth" >
                <div class="page-header" id="btn-uploader">
	                	<div class="div1" id="faker" onchange="xmTanUploadImg(this)">
				            <img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg(this)" src="<%=webPath + contextPath%>/common/images/logo.jpg"/>
				            <div id="xmTanDiv"></div>
				        </div>
			        </div>


						 <input  class="nui-textbox" id="systemImg" name="systemImg"  style="display:none" >
                </td>
                
				
            </tr> 
            <tr >
                <td align="right">系统名称：<span class="spanwidth"></span>   </td>
                <td  colspan="5" class="tabwidth" >
                		 <input  class="nui-textbox"  id="systemName" name="systemName">              	
                </td>
				
            </tr> 
             <tr>
                <td class="tbtext"></td>
                <td class="tbCtrl" >
                    <a class="nui-button" onclick="save()"   plain="false" >保存</a>
                </td>
            </tr>
            </table>
          </div>

</body>
</html>