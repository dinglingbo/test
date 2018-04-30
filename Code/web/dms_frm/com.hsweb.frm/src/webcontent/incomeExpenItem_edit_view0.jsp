<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): 
  - Date: 2017-07-26 14:23:17
  - Description:
-->
<head>
	<title>收支项目设置</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="<%=webPath + frmDomain%>/frm/js/setting/incomeExpenItem_edit.js?v=1.1" type="text/javascript"></script>
    <link href="<%=webPath + sysDomain%>/css/style1/style_form_edit.css?v=1.1" rel="stylesheet" type="text/css" />
	
</head>
<body>

	<form id="form1" method="post">
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
                <input class="nui-hidden" name="id"/>
                <table>
                    <tr id="parenNode" style="display:none;">
                        <td class="title required">上级项目名称：</td>
                        <td style="width:150px;">    
                            <input id="parentName" name="parentName" class="nui-textbox" enabled=false/>
                            <input class="nui-hidden" name="parentId"/>
                        </td>                          
                    </tr>
                    <tr>
                        <td class="title required">项目名称：</td>
                        <td style="width:150px;">    
                            <input id="name" name="name" class="nui-textbox" required="true"/>
                        </td>                          
                    </tr>
                    <tr>
                        <td class="title required">助记码：</td>
                        <td >                        
                            <input id="code" name="code" class="nui-textbox" required="true"/>
                        </td>                            
                    </tr>
                    <tr>
                        <td class="title required">收支类型：</td>
                        <td >    
                            <div id="itemTypeId" name="itemTypeId" class="nui-radiobuttonlist" 
                            repeatItems="2" repeatLayout="table" repeatDirection="horizontal" textField="name" 
                            valueField="customid" required="true">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="title required">是否主营业务项目：</td>
                        <td >    
                            <div id="isPrimaryBusiness" name="isPrimaryBusiness" class="nui-radiobuttonlist" 
                            repeatItems="2" repeatLayout="flow" repeatDirection="horizontal" textField="text" 
                            valueField="value" data="const_yesno" required="true">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;">
            <a id="save" class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
            <!--
            <a id="save" class="nui-button" onclick="onOkAdd" style="width:90px;margin-right:20px;">保存并新增</a>
            -->
            <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
        </div>
    </form>
</body>
</html>
