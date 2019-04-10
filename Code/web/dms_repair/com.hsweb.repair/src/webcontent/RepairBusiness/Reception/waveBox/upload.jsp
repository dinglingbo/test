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
            <script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/waveBox/js/upload.js?v=1.09" type="text/javascript"></script>
            <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
            <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
            <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
            <script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
            <script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
            <script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>
            <style type="text/css">
                .div-a {
                    float: left;
                    width: 49%;
                    border: 1px solid #000;
                    height:100%;
                }
                
                .div-b {
                    float: right;
                    width: 49%;
                    border: 1px solid #000;
                    height:100%;
                }
            </style>
        </head>

        <body>
            <input class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%" />
            <input class="nui-hidden" name="serviceCode" id="serviceCode" enabled="false" width="100%" />
            <input class="nui-hidden" name="state" id="state" enabled="false" width="100%" />
            <div style="with:100%;height:95%">
                <div class="div-a">
                    <h2><strong>&nbsp;维修前</strong></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody id="tbodyId">
                        </tbody>
                    </table>
                </div>
                <div class="div-b">
                    <h2><strong>&nbsp;维修后</strong></h2>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tbody id="tbodyId1">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="page-header" id="btn-uploader" align="center">
                <small>
			        <button class="btn btn-link" id="faker" >
			                <span class="glyphicon  glyphicon-upload" aria-hidden="true">点击上传图片</span>
			        </button>
			    </small>
            </div>

            <script type="text/javascript">
                nui.parse();
                var arr = [];
                var brr = [];

                function SetData(serviceId, serviceCode, state) {
                    nui.get("serviceId").setValue(serviceId);
                    nui.get("serviceCode").setValue(serviceCode);
                    nui.get("state").setValue(state); //1维修前  2维修后

                }
            </script>
        </body>

        </html>