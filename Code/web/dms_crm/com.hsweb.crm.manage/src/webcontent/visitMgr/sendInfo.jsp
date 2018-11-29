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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />

</script>

</head>
<body>
  <div class="nui-fit" id="form1">
      <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">

                    <a class="nui-button" onclick="save()" plain="true" style="width: ;"><span class="fa fa-commenting fa-lg"></span>&nbsp;发送</a>
                     <a class="nui-button" onclick="" plain="true" style="width: ;"><span class="fa fa-navicon fa-lg"></span>&nbsp;选择短信模板</a>
                    <a class="nui-button" onclick="onClose()" plain="true"  style="width: ;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <input class="nui-hidden" name="visitId" id="visitId"/>
    <input class="nui-hidden" name="id" id="id"/>
    <table class="tmargin" style="table-layout: fixed;width:100%">
        <!-- <tr class="htr">
            <td  style="width: 70px;">选择模板：</td>
            <td style="width: 100px;">
                <input id="visitMode" name="visitMode" class="nui-combobox textboxWidth" dataField="" valueField="customid" textField="name">
            </td>
        
            <td style="width: "></td>
        </tr>  -->
        <tr class="htr">
           
            <td  colspan="6">
                <input id="visitContent" name="visitContent" class="nui-textarea textboxWidth" style="width: 100%;height:200px;"
                emptyText="请输入短信内容" required="true">
            </td>
        </tr> 
        
    </table>
</div>



<script type="text/javascript">
   nui.parse();
var form1 = new nui.Form("#form1");

function save(){
    //验证
    if(!formValidate(form1)){
      showMsg("请输入短信内容!","W");
      return ;
  }

}



function selectModel() {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.crm.basic.smsTpl.flow?token="+token,
        title: "选择短信模板", width: 855, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            
        }
    });
}


   function CloseWindow(action) {
    if (action == "close") {
    } else if (window.CloseOwnerWindow)
    return window.CloseOwnerWindow(action);
    else
        return window.close();
}

function onClose(){
    window.CloseOwnerWindow();  
}
</script>
</body>
</html>