<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
 <%@ include file="/common/sysCommon.jsp"%>
<%@page import="com.primeton.cap.AppUserManager"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-05-27 15:11:00 
  - Description:
-->
<head> 
    <title>添加员工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/js/homePageEmployeeEdit.js?v=1.0.9" type="text/javascript"></script>
    <style type="text/css">
</style>
</head>
<body>
    <div class="nui-fit"> 
    	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                           
                        </td>
                        <td align="right">
                        	 <a class="nui-button" onclick="updatePassWord()" plain="true"  style="width: 100px;align: right;"><span class="fa fa-pencil-square-o fa-lg"></span>&nbsp;修改密码</a>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="form" style="width:90%;height:90%;left:0;right:0;margin: 0 auto;" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />
            <fieldset id="fd1" style="width:600px;">
                <legend><span>基本信息</span></legend>
                <table >
                    <tr>
                        <td align="right">显示个人单据：</td>
                        <td>
                       		 <input class="nui-combobox"  required="false" id="isShowOwnBill" name="isShowOwnBill" textField="name"  value="0" valueField="id" />
                       		 <input class="nui-textbox" required="false" id="empid" name="empid" vtype="int" onvalidation="onempid" visible="false" emptyText="系统自动分配"/>
                        </td>
                        <td align="right">允许消息通知：</td>
                        <td><input class="nui-combobox"  required="false" id="isAllowRemind" name="isAllowRemind" textField="name"  value="0" valueField="id" /></td>
                    </tr>

                    <tr>
                        <td align="right" >手机号码：</td>
                    	<td><input class="mini-textbox" id="tel" name="tel" required="true" onvalidation="onMobileValidation" /></td>
                    	<td align="right" >生日：</td>
                		<td><input class="nui-datepicker" id="birthday" name="birthday"/></td>

                </tr>
               
            <tr>
                <td align="right">紧急联系人：<span></span></td>
                <td ><input class="nui-textbox" name="urgencyPerson" id="urgencyPerson" vtype="maxLength:20"/></td>
                <td align="right">紧急联系人电话：</td>
                <td colspan="2"><input class="nui-textbox" name="urgencyPersonPhone" id="urgencyPersonPhone" onvalidation="onMobileValidation" /></td>

            </tr> 

            <tr>
                <td align="right">微信/QQ号：<span></span></td>
                <td colspan="2"><input class="nui-textbox" name="wechat" id="wechat" vtype="maxLength:50"/></td>
            </tr>

        </table>
    </fieldset>

</div>
</div>
<script type="text/javascript">
  nui.parse();

</script>
</body>
</html>