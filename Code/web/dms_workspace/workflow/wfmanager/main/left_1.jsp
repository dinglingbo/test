<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script language="javascript">
	function middle_left_onclick(){    
		var parentFrameSetObj = parent.document.getElementById("middleMain")
	    if(parentFrameSetObj.cols!="200,10,*"){
			parentFrameSetObj.cols="200,10,*";
			//FIXME:document.getElementById --> $id
			$id("arrowImg").src = "<%=request.getContextPath() %>/workflow/wfmanager/images/left.gif";
		}else{
			parentFrameSetObj.cols="0,10,*";
			$id("arrowImg").src = "<%=request.getContextPath() %>/workflow/wfmanager/images/right.gif";
		}
     }
</script>
</head>
<body style="background:#FFFFFF;margin-left:0px;margin-bottom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) repeat-x">
<table height="100%" cellSpacing=0 cellPadding=0 width="11%" border=0>
  <tr>
    <td valign=center align="left"><A href="javascript:void middle_left_onclick()"><img id="arrowImg" src="<%=request.getContextPath()%>/workflow/wfmanager/images/left.gif" border="0"></a></td>
  </tr>
</table>
</body>
</html>
