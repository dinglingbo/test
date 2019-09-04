<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): dlb
  - Date: 2019-09-02 11:25:02
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>
<div class="nui-fit">
	
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
						<a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;反结算</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		
		<table style="width:100%;">
			<tr id="out">
				<td style="width:100%" colspan="2">备注:<input required="false"  class="nui-textarea" id="remark" name="remark" type="text" width="90%"></td>
			</tr>
			
		</table>
	</div>
	</div>
</body>
<script type="text/javascript">
	var json = {};
	
	
	function setData(row) {
		json = {
			billMainId:row.billMainId,
			billServiceId:row.billServiceId,
			billTypeId:row.billTypeId,
			token: token
		}
		nui.get("remark").focus();
	}

	function onOk() {
		var remark = nui.get("remark").getValue();
		if(remark == null || remark == "") {
			showMsg("请填写备注","W");
			return;
		}
		json.remark = remark;
	
		nui.mask({
	        el : document.body,
		    cls : 'mini-mask-loading',
		    html : '处理中...'
	    });
		nui.ajax({
			url : apiPath + frmApi + "/com.hsapi.frm.frmService.rpinterface.reverseAccount.biz.ext" ,
			type : "post",
			data : json,
			success : function(data) {
				 nui.unmask(document.body);
				if(data.errCode=="S"){
					showMsg("反结算成功","S");
					CloseWindow('ok');
				}else{
					showMsg(data.errMsg,"W");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}
	
	function CloseWindow(action)
	{
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			window.close();
	}
    

</script>
</html>