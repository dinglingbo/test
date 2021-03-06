<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-18 12:13:16
  - Description:
-->
<head>
    <title>发送短信</title>
    <script src="<%=request.getContextPath()%>/manage/js/visitMgr/sendInfoGuest.js?v=1.0.5"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
        .tbText{
            text-align:right;
            width:40px;
        }
        .textboxWidth{
            width:100%
        }
        #wechatTag1{
            color:#ccc;
    }
    #wechatTag{
        color:#62b900;
    }
    </style>
</head>
<body>
  <div class="nui-fit" id="form1">
      <div class="nui-toolbar" style="padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">

                    <a class="nui-button" onclick="save()" id="save" plain="true" style="width: ;"><span class="fa fa-commenting fa-lg"></span>&nbsp;发送</a>
                    <a class="nui-button" onclick="selectModel()" plain="true" style="width: ;"><span class="fa fa-navicon fa-lg"></span>&nbsp;选择短信模板</a>
                    <a class="nui-button" onclick="onClear()" plain="true" style="width: ;"><span class="fa fa-trash fa-lg"></span>&nbsp;清空内容</a>
                    <a class="nui-button" onclick="onClose()" plain="true"  style="width: ;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <input class="nui-hidden" name="visitId" id="visitId"/>
    <input class="nui-hidden" name="id" id="id"/>
    <table class="tmargin" style="width:100%">
        <!-- <tr class="htr">
            <td  style="width: 70px;">选择模板：</td>
            <td style="width: 100px;">
                <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="" valueField="customid" textField="name">
            </td>
        
            <td style="width: "></td>
        </tr>  -->
                    <tr class="htr">
                <td  class="tbText">联系人：</td>
                <td style="width: 135px;">
                    <input id="contactorId" name="contactorId" class="nui-combobox textboxWidth" dataField="data.contacter" valueField="id" textField="name"
                    onvaluechanged="contactorChange" >
                </td>
                <td class="tbText">手机号码：</td> 
                <td style="width: 135px;">
                    <!-- <input id="mobile" name="mobile" class="nui-textbox textboxWidth" dataField="data" valueField="customid" textField="name" > -->
                    <div id="mobile"></div>
                </td>
            </tr>
            <tr class="htr">
                <td class="tbText">备注：</td>
                <td colspan="3">
                    <input id="remark" name="remark" class="nui-textarea textboxWidth" style="width: 100%;height:50px;" enabled="false">
                </td>
            </tr>
        <tr class="htr">
            <td class="tbText">内容：</td>
            <td  colspan="3">
                <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:200px;"
                emptyText="请输入短信内容" required="true">
            </td>
        </tr> 
        
    </table>
</div>



<script type="text/javascript">
   // nui.parse();

</script>
</body>
</html>