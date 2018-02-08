<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 10:40:25
  - Description:
-->
<head>
<title>发送短信</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table>
		<tr style="display: block; margin:-2px 0 0 5px">
			<td>
				<label>手机号码：</label>
			</td>
			<td>
				<input class="nui-textbox" width="200px" value="13"/>
				<a class="nui-button" width="72px" style="margin-left: 5px" onclick="modeSMS()">短信模板</a>
			</td>
		</tr>
		<tr style="display: block; margin:-5px 0 0 5px">
			<td>
				<label>温馨提示：短信发送成功后，会自动在短信末尾加上【XX公司】</label></br>
				<label>&emsp;&emsp;&emsp;&emsp;&emsp;请不要在短信末尾添加类似【XX公司】的后缀，以免重复。
				</label>
			</td>
		</tr>
		<tr style="display: block; margin:-5px 0 0 5px">
			<td>
				<label>发送内容：</label>
			</td>
		</tr>
		<tr style="display: block; margin:-5px 0 0 5px">
			<td>
				<input class="nui-textarea" style="width: 440px;height: 130px;margin-left: 5px"/>
			</td>
		</tr>
		<tr style="display: block; margin:-5px 0 -7px 5px">
			<td>
				<label>短信发送支持长短信，每条短信70字，短信费用按发送条数收取，当前字数0</br>
						短信条数（1）
				</label>
			</td>
		</tr>
		<tr style="margin:-5px 0 0 0;text-align:center;width: 100%">
			<td>
				<a class="nui-button" onclick="onSend" style="margin-right:10px;" width="60px">发送</a>       
				<a class="nui-button" onclick="onCancel" width="60px">返回</a>  
			</td>
		</tr>
	</table>


	<script type="text/javascript">
    	nui.parse();
    	
    	function modeSMS(){
    		nui.open({
    			url:"../../common/ModeSMS.jsp",
    			title:"短信模板",width:800,height:600,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"split"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    </script>
</body>
</html>