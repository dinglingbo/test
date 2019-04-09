<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
    <%@include file="/common/commonRepair.jsp"%>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>
        <!-- 
  - Author(s): Administrator
  - Date: 2019-04-03 10:32:17
  - Description:
-->

        <head>
            <title>上传</title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            <script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/waveBox/js/upload.js?v=1" type="text/javascript"></script>3
            <script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
		 	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
	  	    <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
		 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
		  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
		 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>
		 	<style type="text/css">
		 		.div1{

					float: left;
					
					height: 120px;
					
					width: 120px;
					position:relative;
					
				}
		 	</style>  
        </head>

        <body>
        <div class="page-header" id="btn-uploader">
           <div class="div1" id="faker" onchange="xmTanUploadImg(this)">
				<img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg		(this)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
				<div id="xmTanDiv"></div>
			</div>
		</div>
			<input  class="nui-textbox" id="logoImg" name="logoImg"  style="display:none" >




            <script type="text/javascript">
                nui.parse();
            </script>
        </body>

        </html>