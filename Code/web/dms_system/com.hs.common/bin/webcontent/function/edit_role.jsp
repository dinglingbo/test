<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-05-04 14:17:55
  - Description:
-->
<head>    
    <title>新增角色</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
     <%@include file="/common/sysCommon.jsp"%>

    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }

    .mini-grid-headerCell, .mini-grid-topRightCell
    {
        font-weight:bold;
    }
.mini-panel-border {
    border-radius: 0px;
}
    .tbtext{
        width: 90px;
        text-align: right;
    }
</style>
</head>
<body>
 <div class="nui-fit">
<div class="nui-toolbar" style="padding:0px;border-bottom:0;" id="showSave">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" onclick="onCancel" plain="true" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
  <div id="form1" class="nui-form" style="width:100%;height:auto;left:0;right:0;">
      <table style="margin-top:2px;">
           <tr>
              <td class="tbtext">租户ID：</td>
			  <td><input class="nui-textbox" style="width:250px" name="tenantId"  id="tenantId" /></td>
	       </tr>
	        <tr>
              <td class="tbtext">角色ID：</td>
			  <td><input class="nui-textbox" style="width:100%" name="roleId"  id="roleId" /></td>
	       </tr>
	        <tr>
              <td class="tbtext">角色编码：</td>
			  <td><input class="nui-textbox" style="width:100%" name="roleCode"  id="roleCode" /></td>
	       </tr>
	        <tr>
              <td class="tbtext">角色名称：</td>
			  <td><input class="nui-textbox" style="width:100%" name="roleName"  id="roleName" /></td>
	       </tr>
	       <tr>
              <td class="tbtext">角色描述：</td>
			  <td><!-- <input class="nui-textbox" style="width:100%" name="roleDesc"  id="roleDesc" /> -->
			     
			     <input class="nui-TextArea" name="roleDesc" style="width: 100%; height: 50px;" />
			     
			  </td>
	       </tr>
        </table> 
    </div>
</div >
<script type="text/javascript">
  nui.parse();
  var form = null;
  $(document).ready(function(v) {
	form = new nui.Form("#form1");
	
	});
function SetInitData(data) {
    form.setData(data);   
}
var baseUrl = apiPath + sysApi + "/";
var saveUrl=baseUrl + "com.hsapi.system.tenant.role.saveRole.biz.ext";
function onOk(){
     var capRole=form.getData();
	 nui.ajax({
        url: saveUrl,
        type: 'post',
        data: nui.encode({
        	capRole:capRole,
        	tenantId:capRole.tenantId
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
           	   showMsg("保存成功","S");
           	   closeWindow("ok");
             }else {
            showMsg(data.errMsg,"E");
                /* nui.alert("失败！"); */
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel() {
    CloseWindow("cancel");
}

</script>
</body>
</html>