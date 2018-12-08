<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-26 10:16:08
  - Description:
-->
<head>
    <title>短信模板-编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=webPath + crmDomain%>/basic/js/smsTpl_edit.js?v=1.1.1" type="text/javascript"></script>
    <link href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1" rel="stylesheet" type="text/css" />
    <style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        /**overflow:hidden;**/
    }
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:0px;" id="queryForm">
    <table style="width:100%;">
        <tr>
        	<td>
                     <a class="nui-button" iconCls="" plain="true" onclick="onOk" id="select" enabled="true"><span class="fa fa-check fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')" id="cancel" enabled="true"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
             </td>
        </tr>
    </table>
    </div>
    <form id="form1" method="post">
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="id"/>
                    <table>
                        <tr>
                            <td><span class="title title-width1 required">短信类别：</span></td>
                            <td><input name="typeId"
                                id="typeId"
                                required="true"
                                class="nui-combobox width2"
                                textField="name"
                                valueField="customid"
                                emptyText="请选择..."
                                url=""
                                allowInput="false"
                                valueFromSelect="true"
                                showNullItem="false"
                                nullItemText="请选择..."/></td>
                               <td><span class="title title-width1 required">短信来源：</span></td>
                               <td><input id="source" name="source" class="nui-textbox width2" required="true"/></td>
                           </tr>

                           <tr>
                            <td><span class="title title-width1 required">短信内容：</span></td>
                            <td colspan="3"><textarea id="content" 
                                name="content" 
                                class="nui-textarea " 
                                onValuechanged="setCharCount()"
                                onKeyup="content.doValueChanged()"
                                style="height: 160px;width: 100%;" 
                                emptyText="请输入短信内容"
                                required="true">
                            </textarea></td>
                        </tr>

                        <tr>
                            <td><span class="title title-width1">字数：</span></td>
                            <td colspan="3"> <input id="charCount" name="charCount" class="nui-textbox " style="width:100%" enabled=false /></td>
                        </tr>

                        <tr style="display:none;">
                            <td><span class="title title-width1">建档人：</span></td>
                            <td><input id="recorder" name="recorder" enabled=false class="nui-textbox width2"/></td>
                            <td><span class="title title-width1">建档日期：</span></td>
                            <td><input id="recordDate" 
                                name="recordDate" 
                                class="nui-datepicker width2" 
                                dateFormat="yyyy-MM-dd hh:MM" 
                                enabled="false" emptyText="请选择日期" alwaysView="true"/></td>
                            </tr>


                            <tr style="display:none;">
                               <td><span class="title title-width1">修改人：</span></td>
                               <td><input  id="modifier" name="modifier" enabled=false class="nui-textbox width2" value="<b:write property='userName'/>"/></td>
                               <td><span class="title title-width1">修改日期：</span></td>
                               <td><input id="modifyDate" 
                                name="modifyDate" 
                                class="nui-datepicker width2" 
                                dateFormat="yyyy-MM-dd hh:MM" 
                                enabled="false" emptyText="请选择日期" alwaysView="true"/></td>
                            </tr>

                        </table>
                    </div>
                </div>
            </fieldset>
            <!-- <div style="text-align:center;padding:10px;">
                <a id="save" class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
                <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
            </div> -->
        </form>
    </body>
    </html>