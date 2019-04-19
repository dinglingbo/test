<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<% String webcssPath = webPath + wechatDomain; %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-02-12 16:16:24
  - Description:
-->
<head>
<title>维修前后图片上传</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  	<script src="<%=webPath + contextPath%>/repair/RepairBusiness/Reception/waveBox/js/maintenancePicture.js?v=1.0.7" type="text/javascript"></script>
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	    <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
    	  	    .imgA{
	    	height: 150px;
    		width: 140px;
    		display: table-cell;
    		text-align: center;
    		vertical-align: middle;
    		border: 1px solid #DFDFDF;
   			background: url(<%=webcssPath %>/autoServiceSys/images/bg.png) no-repeat scroll center 0px transparent;
	    }
	    .divImg{
	    	width: 120px;
    		margin: auto;
	    }
	    .imgStyle{
	    	border: none;
		    max-width: 100%;
		    height: auto;
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
		    height: 500px;
		    width: 315px;
		    padding: 10px;
	    }
	    .imgListA{
	    	display: flex;
	    	border-bottom: 2px solid #f2f5f7;
	    	cursor: pointer;
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
    		margin-bottom: -100px;
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
	    label{
	    	font-size: 14px;
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
	    	font-size: 12px;
	    }
    </style>
</head>
<body>
	

	<div class="nui-fit">
	
		<div class="nui-toolbar" style="padding:0px;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                	<input class="nui-hidden" name="serviceId" id="serviceId" enabled="false" width="100%" />
            			<input class="nui-hidden" name="serviceCode" id="serviceCode" enabled="false" width="100%" />
	                    <a class="nui-button" onclick="save()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                    <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
	                </td>
	            </tr>
	        </table>
    	</div>
    	
    	<div class="form" id="basicInfoForm" name="basicInfoForm" style="height:95%;left:0;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 10px;float: left;">
    		
    		<div style="display:flew;" >
				<div style="text-align: center;" >
					<label><font size="4" color="red">维修前</font>(建议尺寸：414像素*519像素)</label>
				</div>
	    		<div class="imgList" >
					<div class="before" >

						<div id="btn-uploader" >
							<a href="javascript:;" id="faker" class="addImage tc sub-add-btn" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;height: 25px;text-align: center;text-decoration: none;">
								<div class="vm dib sub-add-icon" style="background: url(<%=webPath + contextPath%>/repair/prototype/images/add.png);height: 18px;margin-right: 5px;width: 18px;9px;;margin-left: 36%;background-size: 18px;"></div>
								添加图片
							</a>
						</div>

					</div>
	    		</div>
			</div>
					
		</div>
     	<div class="form" id="basicInfoForm1" name="basicInfoForm1" style="height:95%;right:0;margin: 0 auto;display: flex;padding-top: 10px;padding-left: 30px;float: left;">
    		
    		<div style="display:flew;" >
				<div style="text-align: center;" > 
					<label><font size="4" color="red">维修后</font>(建议尺寸：414像素*519像素)</label>
				</div>
	    		<div class="imgList" >
					<div class="after" style="display: block;padding: 4px;">
						<div id="btnuploader" >
							<a href="javascript:;" id="faker1" class="addImage tc sub-add-btn" style="display: flex;border: 2px dotted #B8B8B8;border-radius: 5px 5px 5px 5px;color: #222222;height: 25px;text-align: center;text-decoration: none;">
								<div class="vm dib sub-add-icon" style="background: url(<%=webPath + contextPath%>/repair/prototype/images/add.png);height: 18px;margin-right: 5px;width: 18px;9px;;margin-left: 36%;background-size: 18px;"></div>
								添加图片
							</a>
						</div>
					</div>
	    		</div>
			</div>
					
		</div>   	
    	
    	
	</div>


</body>
</html>