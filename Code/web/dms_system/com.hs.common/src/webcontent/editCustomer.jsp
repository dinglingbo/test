<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-17 15:39:20
  - Description:
-->
<head>
<title>客服信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@ include file="/common/sysCommon.jsp"%>	
    <script src="<%=webPath + contextPath%>/common/js/editCustomer.js?v=1.0.5" type="text/javascript"></script> 
  	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
    	.fwidthb{
		    width: 150px;
		}
	</style>
</head>
<body>
    <div class="nui-fit"> 
    	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
                <table >
<%--                 	 <tr >
			                <td align="right">头像：<span class="spanwidth"></span> </td>
			                <td  colspan="5" class="tabwidth" >
			                <div class="page-header" id="btn-uploader">
				                	<div class="div1" id="faker" onchange="xmTanUploadImg(this)">
							            <img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg(this)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
							            <div id="xmTanDiv"></div>
							        </div>
						        </div>
							<input  class="nui-textbox" id="headPortrait" name="headPortrait"  style="display:none" >
		                </td>
				
           			</tr> --%>

                    <tr>
                    	<input class="nui-hidden" id="id" name="id" />
                        <td align="right"><font color="red">姓名：</font></td>
                        <td><input class="nui-textbox"  id="name" name="name"  required="true" /></td>
                        <td align="right">性别：</td>
                        <td>
                            <div id="sex" name="sex" class="nui-radiobuttonlist" repeatItems="1" repeatLayout="table" repeatDirection="vertical"
                            textField="name" valueField="id" value="1"
                            url="" >
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" ><font >手机号码：</font></td>
                    <td><input class="mini-textbox" id="mobile" name="mobile"   /></td>
	                <td align="right" >生日：</td>
	                <td><input class="nui-datepicker" id="birthday" name="birthday"/></td>
              </tr>

            <tr>
                <td align="right"> <font>QQ：</fpont></td>
                <td ><input class="nui-textbox"  id="qq" name="qq"   /></td>
                <td align="right">微信号：<span></span></td>
                <td ><input class="nui-textbox" name="wechat" id="wechat" /></td>
            </tr>
             <tr>
                <td align="right"> <font >邮箱：</fpont></td>
                <td ><input class="nui-textbox"  id="email" name="email"  /></td>
                <td align="right">签名：<span></span></td>
                <td ><input class="nui-textbox" name="sign" id="sign" /></td>
            </tr>           
        </table>

</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>