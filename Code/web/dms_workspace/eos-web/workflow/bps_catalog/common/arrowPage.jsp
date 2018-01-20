<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<html>
<head>
<script language="javascript">
	function middle_left_onclick(){    
		var parentFrameSetObj = parent.document.getElementById("framesetMain")
	    if(parentFrameSetObj.cols!="200,10,*"){
			parentFrameSetObj.cols="200,10,*";
			$id("arrowImg").src = "<%=request.getContextPath() %>/images/leftBar/arrow_left.gif";
		}else{
			parentFrameSetObj.cols="0,10,*";
			$id("arrowImg").src = "<%=request.getContextPath() %>/images/leftBar/arrow_right.gif";
		}
     }
</script>
</head>
<body style="background:#FFFFFF;margin-left:0px;margin-bottom:0px;background:url(<%=request.getContextPath()%>/images/leftBar/MainFrameBg.gif) repeat-x">
<table height="100%" cellSpacing=0 cellPadding=0 width="11%" border=0>
  <tr>
    <td valign=center align="left"><A href="javascript:void middle_left_onclick()"><img id="arrowImg" src="<%=request.getContextPath()%>/images/leftBar/arrow_left.gif" border="0"></a></td>
  </tr>
</table>
</body>
</html>
