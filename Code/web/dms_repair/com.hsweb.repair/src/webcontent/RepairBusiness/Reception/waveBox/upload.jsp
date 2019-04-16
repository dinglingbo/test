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
            <script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/waveBox/js/upload.js?v=1.0102" type="text/javascript"></script>
            <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
            <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
            <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
            <script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
            <script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
            <script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>
            <style type="text/css">
            	body {
	                margin: 0;
	                padding: 0;
	                border: 0;
	                width: 100%;
	                height: 100%;
	                overflow: hidden;
           		 }
                .div-a {
                    float: left;
                    width: 49%;
                    border: 1px solid #000;
                    height: 100%;
                }
                
                .div-b {
                    float: right;
                    width: 49%;
                    border: 1px solid #000;
                    height: 100%;
                }
                
                .max_img{
					display: none;
					position: absolute;
					bottom: 0;
					left: 0; 
					width:1000px;
					height:800px;
				}
            </style>
        </head>

        <body>
            <input class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%" />
            <input class="nui-hidden" name="serviceCode" id="serviceCode" enabled="false" width="100%" />
            <input class="nui-hidden" name="state" id="state" enabled="false" width="100%" />
            <div style="with:100%;height:92%">
                <div class="div-a">
                    <h2><strong>&nbsp;维修前</strong></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table1">
                        <tbody id="tbodyId">
                        </tbody>
                    </table>
                </div>
                <div class="div-b" id="div-b">
                    <h2><strong>&nbsp;维修后</strong></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="table2">
                        <tbody id="tbodyId1">
                        </tbody>
                    </table>
                </div>
            </div>
	            <div class="page-header" id="btn-uploader" align="center">
	                <button class="btn btn-link" id="faker">
				                <span class="glyphicon  glyphicon-upload" aria-hidden="true">点击上传图片</span>
	                </button>
	                <button class="btn btn-link" id="faker">
	                    <span aria-hidden="true" onclick="ok()">保存</span>
	                </button>
	            </div>
	            <div class="max_img" style=" width:100%;height:100%;margin:0 auto">
					<img src="" id="maxImgShow" onclick="changeHide();" width="100%" height="100%" />
		   		</div>
            <script type="text/javascript">
                nui.parse();
                var arr = [];
                var brr = [];

                

            </script>
        </body>

        </html>