<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 16:53:34
  - Description:
-->
<head>
<title>出车报告</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table style="margin: 0; height: 100%; width: 100%;">
		<tr>
			<td>
				<a class="nui-button"  iconCls="icon-ok" onclick="onChoice()" >选择</a>
		        <a class="nui-button"  iconCls="icon-remove" onclick="onClean()" >清空</a>
			</td>
		</tr>
		<tr>
			<td>
				<input class="nui-textarea" name=""  style="width: 100%; height: 100%" />
			</td>
		</tr>
	</table>
	


	<script type="text/javascript">
    	nui.parse();
    	
    	function onChoice(){
    		nui.open({
    			url:"../../common/subpage/OutCarDetail.jsp",
    			title:"出车报告",width:1200,height:690,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"choice"};
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