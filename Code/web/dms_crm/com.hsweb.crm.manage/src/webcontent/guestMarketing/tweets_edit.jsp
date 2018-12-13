<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-05 14:49:04
  - Description:
-->
<head>
    <title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .tbtext {

        width: 90px;
        text-align: right;
    }
    .tbinput{
        width: 100%
    }

</style>
</head>
<body>
  <div id="tabs1" class="mini-tabs" activeIndex="1" style="width:100%;height:100%;" plain="true">
    <div title="文本消息" >

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
      <table style="width:100%;line-height: 30px;">



        <tr>
            <td class="tbtext"><label>文本内容：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>

        </tr>

        <tr>
            <td class="tbtext"><label>回复内容：</label></td>
            <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
        </tr>
    </table>
</div>

</div>

<div title="图片消息" >


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
  <table style="width:100%;line-height: 30px;">



    <tr>
        <td class="tbtext"><label>文本内容：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>

    </tr>

    <tr>
        <td class="tbtext"><label>上传图片：</label></td>
        <td >            
            <!-- <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;上传</a> -->
            <input id="upload" name="upload" class="nui-buttonedit" emptyText="请选择文件"  
            selectOnFocus="true" style="width:400px;" />
        <input type="file" style="padding:0;display: none;" name="file0" id="file0" multiple="multiple" />
        </td>
    </tr>
        <tr >
        <td class="tbtext"><label>预览：</label></td>
        <td ><img src="" id="img0"  style="max-width: 400px;max-height: 200px;"></td>
    </tr>
</table>
</div>



</div>

<div title="图文消息" >
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
      <table style="width:100%;line-height: 30px;">



        <tr>
            <td class="tbtext"><label>标题：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>

        </tr>
        <tr>
            <td class="tbtext"><label>封面图片上传：</label></td>
            <td>  <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;上传</a></td>

        </tr>

        <tr>
            <td class="tbtext"><label>摘要：</label></td>
            <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
        </tr>

        <tr>
            <td class="tbtext"><label>内容来源：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>
            
        </tr>

        <tr>
            <td class="tbtext"><label>文章选择：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>
            
        </tr>

        <tr>
            <td class="tbtext"><label>链接地址：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>
            
        </tr>
    </table>
</div>






</div>

<div title="活动消息" >

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
      <table style="width:100%;line-height: 30px;">



        <tr>
            <td class="tbtext"><label>活动选择：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>

        </tr>



        <tr>
            <td class="tbtext"><label>标题：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>

        </tr>

        <tr>
            <td class="tbtext"><label>摘要：</label></td>
            <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
        </tr>

        <tr>
            <td class="tbtext"><label>内容来源：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>
            
        </tr>

        <tr>
            <td class="tbtext"><label>链接地址：</label></td>
            <td><input class="nui-textbox tbinput" name="" style=""></td>
            
        </tr>
    </table>
</div>



</div>
</div>

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
  <table style="width:100%;line-height: 30px;">

    <tr>
        <td class="tbtext"><label>意向级别：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>跟踪时间：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
    </tr>

    <tr>
        <td class="tbtext"><label>计划购买：</label></td>
        <td><input class="nui-textbox tbinput" name="" style=""></td>
        <td class="tbtext"><label>销售顾问：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>

    <tr>
        <td class="tbtext"><label>评价内容：</label></td>
        <td colspan="3"><input class="nui-textarea tbinput" name="" style="width:100%;height:100px;"></td>
    </tr>
</table>
</div>

<script type="text/javascript">
   nui.parse();





$("#file0").change(function(){
    var file1 = this.files[0];
    nui.get("upload").setText(file1.name);
    var objUrl = getObjectURL(file1) ;
    console.log("objUrl = "+objUrl) ;
    if (objUrl) {
        $("#img0").attr("src", objUrl) ;
    }
}) ;

//建立一個可存取到該file的url
function getObjectURL(file) {
    var url = null ; 
    if (window.createObjectURL!=undefined) { // basic
        url = window.createObjectURL(file) ;
    } else if (window.URL!=undefined) { // mozilla(firefox)
        url = window.URL.createObjectURL(file) ;
    } else if (window.webkitURL!=undefined) { // webkit or chrome
        url = window.webkitURL.createObjectURL(file) ;
    }
    return url ;
}

    $('#upload').click(function(){
    $('#file0').click();
    });


function onOk(){

}

function onCancel(){ 

}
</script>
</body>
</html>