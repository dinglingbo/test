<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-22 16:31:04
  - Description:
-->
<head>
<title>自定义分类标签</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />   
    <script src="<%=request.getContextPath()%>/common/js/classTabShow.js?v=1.0.1"></script>
   <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    
    .addyytime a.ztedit{ height:18px; display:inline-block; background:url(../images/sjde.png) 40px -1px no-repeat; padding-right:22px; color:#888; text-decoration:none;}
    .addyytime a.hui{padding-left: 5px;padding-right: 5px;height:;line-height:24px;border:1px #a6e0f5 solid;display:block;float:left;text-decoration:none;
        text-align:center;color:#00b4f6;border-radius:4px;margin:0 5px 5px 0;}
    .addyytime a.hui{border:1px #e6e6e6 solid;color:#555555;background:#ccc;}
    .addyytime a.xz{ font-size: 13px; color: #555555 !important; background:#5ab1ef !important;}
    .addyytime a:link, a:visited { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px; color: #555555; text-decoration: none; }
    .addyytime a.hui:hover { font-family: 微软雅黑, Arial, Helvetica, sans-serif; font-size: 13px;background-color: #9fe6b8 ; color: #FFF; text-decoration: none; }
    .addyytime a .hui{text-decoration:none;transition:all .4s ease;}
    .addyytime a.backRed{border:1px #e6e6e6 solid;color:#555555;background:#f17171 ;}
   </style> 
</head>
<body>
      <div class="nui-fit">
            <div class="nui-toolbar" style="padding:2px;">
		        <table style="width:100%;">
		            <tr>
		                <td style="width:100%;">
		                    <a class="nui-button" iconCls="" plain="true" onclick="onOk()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
		                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel()" id="auditBtn1"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
		                </td>
		            </tr>
		        </table>
           </div>
             <div class="addyytime" style="display:''" id="showHot" >
                     <table style="width:100%;height:50px;">
                     	<tr>
		                    <td >产品线分类:</td>   
                       </tr>
                        <tr>
		                    <td id="addAEl"> </td>		                   
                       </tr>
                        <tr>
		                    <td>维修性质分类:</td>
                       </tr>
                        <tr>
                    		<td id="addAEl2"></td>
                       </tr>
                 </table>
              </div>
     </div>
   
 
</body>
</html>