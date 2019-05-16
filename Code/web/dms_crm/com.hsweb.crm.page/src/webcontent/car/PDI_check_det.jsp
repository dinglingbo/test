<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
--> 
<head>  
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;  
        overflow: hidden;
        font-family: "微软雅黑";
    }
    .textboxWidth{
        width: 100%;
    }
    .tbText{
        text-align: right;
    }
</style> 
</head>
<body>
   
    <div class="nui-fit" id="form1">
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick=""><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                   </td>
               </tr>
           </table>
       </div>
       <table style="font-size: 9pt; padding-left: 10px">
            <tr>
                <td class="td_title">项目编号：
                </td>
                <td>
                    <input id="ItemId_input" class="nui-textbox" type="text" style="width: 150px" value="自动编号" disabled="disabled" />
                </td>
                <td class="td_title">拼音码：
                </td>
                <td>
                    <input id="ItemCode_input" class="nui-textbox" type="text" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">项目名称：
                </td>
                <td colspan="3">
                    <input id="ItemName_input" class="nui-textbox" type="text" style="width: 285px"  />
                    <select id="ItemSort_combobox" class="nui-combobox" name="state" editable="false"
                        style="width: 55px;" data-options="panelHeight:50">
                        <option value="勾选">勾选</option>
                        <option value="描述">描述</option>
                    </select>
                </td>
            </tr>
        </table>
</div>
<script type="text/javascript">
    nui.parse();
   




function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}

</script>
</body>
</html>