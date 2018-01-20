<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-09-02 14:46:08
  - Description:
-->
<head>
<title>ConfirmWin</title>
<script>
	var params;
	var ret = new Array(2);
	function init(){
	    //取得主页面传过来的参数
        params = window["dialogArguments"];
        //FIXME:Firefox不支持InnerText需要用textContent代替		
		if(document.all){
			obj('message').innerText = params[0];
		}else{
			obj('message').textContent = params[0] ;	
		}
	}

	function closeConfirm(retValue){
        //定义窗口关闭时的返回值
        ret[0]=retValue;
        ret[1]=params;
        window['returnValue'] = ret;
        window.close();
    }
</script>
</head>
<html>
	<body onload="init()">
		 <table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center"> 
					 <div style="margin-top:10px;margin-left:5px;height:50px">
					 	<span id="message">
							 
						</span>
					 </div>
					 
					 <div style="margin-top:10px; margin-left:5px;">
					 	<button class="button" id="submit" onclick="closeConfirm('Y')"><b:message key="confirm_win_jsp.ok"/></button>&nbsp;&nbsp;<%-- 确定 --%>
						<button class="button" id="cancel" onclick="closeConfirm('N');"><b:message key="confirm_win_jsp.cancel"/></button><%-- 取消 --%>
					 </div>
					</td>
				</tr>
		 </table>
	</body>
</html>