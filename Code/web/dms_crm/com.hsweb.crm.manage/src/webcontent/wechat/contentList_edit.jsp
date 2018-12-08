<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-12-03 18:34:32
  - Description:
-->
<head>
    <title>添加活动</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
        <script src="http://kindeditor.net/ke4/kindeditor-all-min.js?t=20160331.js" type="text/javascript"></script>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .tbtext {
        float: right;
        width: 90px;
        text-align: right;
    }
    .tbinput{
        width: 100%
    }
</style>
</head>
<body>

 <div class="nui-toolbar" style="padding:0px;">
    <table style="width:80%;">
        <tr>
            <td style="width:80%;">
                <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
  <table style="width:100%;">
    <tr>
        <td class="tbtext"><label>文章分类：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>文章标题：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>简单描述：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
        <td class="tbtext"><label>URL地址：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>上传图片：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
        <td class="tbtext"><label>预览：</label></td>
        <td></td>
    </tr>
    <tr>
        <td class="tbtext"><label>排序：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
    </tr>
   <tr  style="height: 200px;">
    <td class="tbtext"><label>文章分享：</label></td>
    <td colspan="3">

       <div name="editor" id="editor1" rows="1000" cols="80" style="width:100%;height:200px;"></div>

   </td>
</tr>

</table>
</div>

    <script type="text/javascript">
     nui.parse();
 var editor1 = KindEditor.create('#editor1');
 </script>
</body>
</html>