<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-27 09:25:58
  - Description:
-->
<head>
<title>零件详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/partDetail.js?v=2" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-fit">
        <%--<h1 style="color:black" align="center">零件详情</h1> --%>
	   
	   <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
		     onactivechanged="changeTabs" >
            <%@include file="/llq/vin/partDetail_basic.jsp" %>
            <%@include file="/llq/vin/partDetail_price.jsp" %>
            <%@include file="/llq/vin/partDetail_replace.jsp" %>
            <%@include file="/llq/vin/partDetail_compt.jsp" %>
        </div>
    </div>
</body>
</html>