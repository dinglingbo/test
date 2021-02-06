<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-11 15:47:34
  - Description:
-->
<head>
<title>查车图片上传</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%=request.getContextPath()%>/repair/RepairBusiness/Reception/js/checkPicture.js?v=1.0.8"></script>
    <script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script> 
    <style type="text/css">

	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
	    	width:150px;
	    	height:100px;
/* 		    max-width: 100%;
		    height: auto; */
		    vertical-align: middle;
	    }
	    .windowsss{
	    	z-index: 100;
	    	margin: auto;
	    	position: absolute;
	    	top: 0;
	    	left: 0;
	    	right: 0;
	    	bottom: 0;
	    }
	    .imgList{
	    	overflow: auto;
	    	border: 1px solid #B8B8B8;
		    border-radius: 5%;
		    height: 380px;
		    width: 315px;
		    padding: 10px;
	    }
	    .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    	cursor: pointer;
	    	width:150px;
	    	height: 100px;
	    	display:inline-block;
	    }
	    .imgListOneDiv{
	    	background: none repeat scroll 0 0 rgba(229, 229, 229, 0.85);
    		position: absolute;
    		width: 278px;
    		
    		height: 182px;
    		padding-top: 50px;
	    }
	    .imgListone{
		    width: 28px;
    		height: 28px;
    		position: relative;
    		margin-bottom: -90px;
    		margin-left: 35%;
    		cursor: pointer;
	    }
	    .imgListtwo{
		   	width: 28px;
    		height: 28px;
    		position: relative;
    		margin-bottom: 100px;
    		margin-left: 50%;
    		cursor: pointer;
	    }

	    body .mini-tabs-plain .mini-tabs-scrollCt{
	    	background-color: DEEDF7;
	    }
	    .mini-tabs-position-top .mini-tabs-plain .mini-tabs-header{
	    	margin-top: 4px;
	    }
	    .mini-checkboxlist{
	    	padding-top:2px;
	    }
	    table{
	    	font-size: 12px !important;
	    }
    </style>
</head>
<body>
                <div class="nui-fit">
                    <div class="nui-toolbar" style="">
                        <table style="width:100%;">
                            <tr>
                                <td >
                                    <input class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%" />
                                    <input class="nui-hidden" name="serviceCode" id="serviceCode" enabled="false" width="100%" />
                                    <a class="nui-button" onclick="addCarListPhoto()" plain="true" style="width: 60px;">
                                        <span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                    <a class="nui-button" onclick="onCancel()" plain="true" style="width: 60px;">
                                        <span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="form" id="" class="imgList" name="basicInfoForm" style="height:100%;left:0;right:0;margin: 0 auto;padding-top: 10px;padding-left: 10px;float: left;">

                                <div id="photos" class="photos" style="width:300px; display:block;word-break: break-all;word-wrap: break-word;">



                                </div>
                                    <div id="btn-uploader">
                                        <a href="javascript:;" id="faker4" class="addImage tc sub-add-btn" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;height: 80px;width:80px;text-align: center;text-decoration: none;">
                                            <div class="vm dib sub-add-icon" style="height: 80px;margin-right: 5px;width: 80px;9px;;margin-left: 0%;background-size: 18px;">
                                            	<img alt="" style="height: 80px;width: 80px;" src="<%=webPath + contextPath%>/repair/prototype/images/add1.png">
                                            	
                                            </div>
                                        </a>
                                    </div>
                    </div>

                </div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>