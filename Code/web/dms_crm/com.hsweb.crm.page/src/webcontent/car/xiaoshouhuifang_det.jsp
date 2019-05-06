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
       <table>
            <tr>
                <td>单据编号
                </td>
                <td>
                    <input id="txtFollowDocumentId" class="nui-textbox" style="width: 100px" disabled
                        value="自动编号" />
                </td>
                <td>跟踪时间
                </td>
                <td>
                    <input id="txtFollowTime" class="nui-datepicker" style="width: 145px" />
                </td>
            </tr>
            <tr>
                <td>业务员
                </td>
                <td>
                    <input id="txtFollowBusinessMan" class="nui-combobox" validtype="equals" style="width: 100px" />
                </td>
                <td>跟踪方式
                </td>
                <td>
                    <input id="txtFollowWay" class="nui-combobox" style="width: 145px" />
                </td>
            </tr>
            <tr>
                <td>跟踪内容
                </td>
                <td colspan="3">
                    <input id="txtFollowContent" class="nui-textarea" style="width: 300px; height: 80px"
                        multiline="true" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <input id="Checkbox1" name="empfun" type="checkbox" style="vertical-align: middle"
                        checked="checked" /><label for="Checkbox1">在</label>
                </td>
                <td colspan="5">
                    <input id="txtVisiFollowTime" class="nui-datepicker" style="width: 100px" />
                    进行下次回访
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