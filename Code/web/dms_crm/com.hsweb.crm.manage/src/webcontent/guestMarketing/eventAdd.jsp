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
    <div id="tabs1" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="true">
        <div title="现场活动" >
    <div class="nui-fit">
 <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
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
        <td class="tbtext"><label>门店：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>活动开始时间：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>活动名称：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>活动结束时间：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>总人数：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>获奖对象：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>活动编码：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>是否签到：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>活动地址：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>是否抽奖：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>经度：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>纬度：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>是否收费：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
        <td class="tbtext"><label>收费项目：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>简介：</label></td>
        <td colspan="3">
            <div style="height: 100px;width: 130px;float: left;border: 1px solid #ccc">图片上传</div>
            <div style="height: 80px;width: calc(100% - 152px);float: left;margin-left:20px;">
               <input class="nui-textarea tbinput" name="" style="width: 100%;height:100%;">
               <span>尺寸大小：宽1280px，高720px(建议等比缩放)</span>
           </div>

       </td>
   </tr >
   <tr  style="height: 200px;">
    <td class="tbtext"><label>活动描述：</label></td>
    <td colspan="3">

       <div name="editor" id="editor1" rows="1000" cols="80" style="width:100%;height:200px;"></div>

   </td>
</tr>

</table>
</div>
</div>
        </div>

        <div title="大转盘"  >

<div class="nui-fit">
               <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
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
            <td class="tbtext"><label>门店：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动开始时间：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>活动名称：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动结束时间：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>抽奖次数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>每人中奖次数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>活动总人数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动编码：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>简介：</label></td>
            <td colspan="3">
                <div style="height: 100px;width: 130px;float: left;border: 1px solid #ccc">图片上传</div>
                <div style="height: 80px;width: calc(100% - 152px);float: left;margin-left:20px;">
                   <input class="nui-textarea tbinput" name="" style="width: 100%;height:100%;">
                   <span>尺寸大小：宽1280px，高720px(建议等比缩放)</span>
               </div>

           </td>
       </tr >
       <tr  style="height: 200px;">
        <td class="tbtext"><label>活动描述：</label></td>
        <td colspan="3">

           <div name="editor" id="editor2" rows="1000" cols="80" style="width:100%;height:200px;"></div>

       </td>
   </tr>

</table>
</div>
</div>



        </div>
        <div title="刮刮乐"  >


<div class="nui-fit">
               <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
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
            <td class="tbtext"><label>门店：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动开始时间：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>活动名称：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动结束时间：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>抽奖次数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>每人中奖次数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>活动总人数：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
            <td class="tbtext"><label>活动编码：</label></td>
            <td><input class="nui-combobox tbinput" name="" style=""></td>
        </tr>
        <tr>
            <td class="tbtext"><label>简介：</label></td>
            <td colspan="3">
                <div style="height: 100px;width: 130px;float: left;border: 1px solid #ccc">图片上传</div>
                <div style="height: 80px;width: calc(100% - 152px);float: left;margin-left:20px;">
                   <input class="nui-textarea tbinput" name="" style="width: 100%;height:100%;">
                   <span>尺寸大小：宽1280px，高720px(建议等比缩放)</span>
               </div>

           </td>
       </tr >
       <tr  style="height: 200px;">
        <td class="tbtext"><label>活动描述：</label></td>
        <td colspan="3">

           <div name="editor" id="editor3" rows="1000" cols="80" style="width:100%;height:200px;"></div>

       </td>
   </tr>

</table>
</div>
</div>


        </div>

    </div>
    <script type="text/javascript">
     nui.parse();
 var editor1 = KindEditor.create('#editor1');
 var editor2 = KindEditor.create('#editor2');
 var editor3 = KindEditor.create('#editor3');
 </script>
</body>
</html>