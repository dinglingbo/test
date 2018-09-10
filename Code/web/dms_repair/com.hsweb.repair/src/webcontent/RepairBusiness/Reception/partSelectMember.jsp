<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>

<html>
<!-- 
  - Author(s): Administrator 
  - Date: 2018-01-25 14:17:08
  - Description:  
-->
 
<head> 
  <title>选择领料人</title>  
  <style type="text/css">

  .tbtext{
      float: right;
  }
  .tbCtrl{
    width: 350px;
}
</style>

</head>

<body>
    <div style="height: 10px;"></div>
    <table  style=" left:0;right:0;margin: 0 auto;"> 

        <tr>
            <td class="tbtext">领料人：</td>
            <td class="tbCtrl" >
                <input name="mtAdvisorId"
                id="mtAdvisorId"
                style="width:100%"
                class="nui-combobox width1"
                textField="empName"
                valueField="empId"
                emptyText="请选择..."
                url=""
                allowInput="true"
                showNullItem="false"
                valueFromSelect="true"
                nullItemText="请选择..."/>

            </td>
        </tr> 
        <tr>
            <td style="height: 10px;"></td>
            </tr> 
        <tr>
            <td class="tbtext">备注:</td>
            <td class="tbCtrl">
                <input class="nui-textarea tabwidth" name="" id="" style="width:100%;height: 100px;"/>
            </td>

        </tr> 
    </table>
    <div align="center" style="margin-top:45px;">
        <a class="nui-button" iconCls="" plain="false" onclick="onOk">
            <span class="fa fa-check fa-lg"></span>&nbsp;确定
        </a>
        <a class="nui-button" iconCls="" plain="false" onclick="onCancel" style="margin-left: 20px;">
            <span class="fa fa-remove fa-lg"></span>&nbsp;取消
        </a>
    </div>
    <script type="text/javascript">
        nui.parse();

        var mtAdvisorIdEl = null;
        mtAdvisorIdEl = nui.get("mtAdvisorId");

        initMember("mtAdvisorId",function(){
            memList = mtAdvisorIdEl.getData();
        });

        mtAdvisorIdEl.on("valueChanged",function(e){
            var text = mtAdvisorIdEl.getText();
            nui.get("mtAdvisor").setValue(text);
        });


function onOk(){ 
        closeWindow("ok");
}


    function onCancel() {
       closeWindow("cancel");
    }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>

</body>

</html>