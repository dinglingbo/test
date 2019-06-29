<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-20 15:13:12
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="http://apps.bdimg.com/libs/ueditor/1.4.3.1/ueditor.config.js" type="text/javascript"></script>
    <script src="http://apps.bdimg.com/libs/ueditor/1.4.3.1/ueditor.all.min.js" type="text/javascript"></script>
</head>
<body>
	<div class="nui-fit">
		<div class="nui-toolbar">
			<a class="nui-button" onclick="save()" plain="true" enabled="">
				<span class="fa fa-save fa-lg"></span>&nbsp;发布</a>
		</div>
		<div class="nui-fit">
			<input name="id" class="nui-hidden" id="id"/>
			<table style="margin-left: 30px;border-collapse: separate;border-spacing: 0px 27px;" >
				<tr>
					<td colspan="4" style="" >
						<textarea id="container" name="content" style="width:1100px;height:60%;"></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	var ue = UE.getEditor('container');

	    function getContent() {
	        var arr = ue.getContent();
	        alert(arr);
	    };
	    function setContent() {
	        ue.setContent('MiniUI - 专业WebUI控件库');
	    };
	    function setDisabled() {
	
	        ue.setDisabled('fullscreen');
	
	    };
	    function setEnabled() {
	        ue.setEnabled();
	    }
	    
	    function save() {
	    	var updateLog = {
	    		id: nui.get("id").getValue(),
	    		content: ue.getContent()
	    	};
	    	var json = {
	    		updateLog: updateLog,
	    		token: token
	    	};
	    	
	    	nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '数据处理中...'
	        });
	    	nui.ajax({
				url: apiPath + sysApi + "/com.hsapi.system.employee.slog.saveSysUpdateLog.biz.ext",
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					nui.unmask(document.body);
					if(text.errCode == "S"){
						var updateLog = text.updateLog;
						nui.get("id").setValue(updateLog.id);
						showMsg("发布成功","S");
					}else{
						showMsg("发布失败","E");
					}
				}
			});
	    }
	    
    </script>
</body>
</html>