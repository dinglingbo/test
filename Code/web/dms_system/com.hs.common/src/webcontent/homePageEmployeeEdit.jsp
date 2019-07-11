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
    <script src="<%=webPath + contextPath%>/common/js/homePageEmployeeEdit.js?v=1.1.0" type="text/javascript"></script>
    <style type="text/css">
    .table-text-width{
        width:18%;
    }
    .table-textbox-width{
        width:32%;
    }
    .textboxWidth{
        width:100%;
    }
    #cover{ 
        position:absolute;left:0px;top:0px;
        background:rgba(0, 0, 0, 1.4);
        width:100%;  /*宽度设置为100%，这样才能使隐藏背景层覆盖原页面*/
        height:100%;
        filter:alpha(opacity=80);  /*设置透明度为70%*/
        opacity:0.8;  /*非IE浏览器下设置透明度为70%*/
        display:none; 
        z-Index:999;  
        /* display: flex; */
        align-items: center;
        justify-content:center;
    }
    .code-style{
        width:180px;
        height:180px;
        left:37%;
    }
    #tip{
        position: absolute;
        left: 10;
        color: white;
        font-size: 16px;
        text-shadow: 0px 0px 8px #fff;
    }
    </style>
</head>

<body>
    <div class="nui-fit">
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span
                                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" onclick="Oncancel()" plain="true" style="width: 60px;"><span
                                class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    </td>
                    <!--  <td align="right">
                        	 <a class="nui-button" onclick="updatePassWord()" plain="true"  style="width: 100px;align: right;"><span class="fa fa-pencil-square-o fa-lg"></span>&nbsp;修改密码</a>
                        </td> -->
                </tr>
            </table>
        </div>
        <div class="nui-fit" id="basicInfoForm">
            <input class="mini-hidden" id="empid" name="empid" />

            <table style="font-size: 12px;line-height: 30px;">
                <tr>
                    <td align="right" class="table-text-width">显示个人单据：</td>
                    <td class="table-textbox-width">
                        <input class="nui-combobox textboxWidth" required="false" id="isShowOwnBill" name="isShowOwnBill"
                            textField="name" value="0" valueField="id" />
                        <input class="nui-textbox textboxWidth" required="false" id="empid" name="empid" vtype="int"
                            onvalidation="onempid" visible="false" emptyText="系统自动分配" />
                    </td>
                    <td align="right" class="table-text-width">允许消息通知：</td>
                    <td class="table-textbox-width">
                        <input class="nui-combobox textboxWidth" required="false" id="isAllowRemind" name="isAllowRemind"
                            textField="name" value="0" valueField="id" /></td>
                </tr>

                <tr>
                    <td align="right">手机号码：</td>
                    <td><input class="mini-textbox textboxWidth" id="tel" name="tel" required="true"
                            onvalidation="onMobileValidation" /></td>
                    <td align="right">生日：</td>
                    <td><input class="nui-datepicker textboxWidth" id="birthday" name="birthday" /></td>

                </tr>

                <tr>
                    <td align="right">紧急联系人：<span></span></td>
                    <td><input class="nui-textbox textboxWidth" name="urgencyPerson" id="urgencyPerson" vtype="maxLength:20" /></td>
                    <td align="right">紧急联系人电话：</td>
                    <td colspan="2"><input class="nui-textbox textboxWidth" name="urgencyPersonPhone" id="urgencyPersonPhone"
                            onvalidation="onMobileValidation" /></td>

                </tr>

                <tr>
                    <td align="right">微信/QQ号：<span></span></td>
                    <td colspan="1"><input class="nui-textbox textboxWidth" name="wechat" id="wechat" vtype="maxLength:50" /></td>
                    <td align="right">微信OpenId：<span></span></td>
                    <td colspan="1">
                        <input class="nui-textbox " name="openId" id="openId" enabled="false" />
                        <a class="nui-button" onclick="showCode()" plain="false" >绑定</a>
                    </td>
                </tr>

            </table>
        </div>
        <div id="cover" onclick="hideCode()">
            <div id="tip">
                <p>1、绑定服务号</p>
                <p>2、绑定微信号</p>
            </div>
            <img id="wechatServiceCode" class="code-style" title="绑定服务号"/>
            <img id="wechatCode" class="code-style" title="绑定微信号" style="margin-left:50px;"/>
        </div>
    </div>
    <script type="text/javascript">
        nui.parse();
    </script>
</body>

</html>