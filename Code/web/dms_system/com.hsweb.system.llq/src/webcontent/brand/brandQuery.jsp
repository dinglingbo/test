<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
<head>
<title>车型查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/brand/js/brandQuery.js?v=32" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/brand/js/brandInfos.js?v=2" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit"> 
        <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false">
            <!--型号-->
            <div title="型号" name="brand" visible="true">    
                <%@include file="/llq/brand/brandLevel.jsp" %>
            </div>
            <!--主组-->
            <div title="主组" name="group" visible="true">    
                <%@include file="/llq/brand/brandInfos.jsp" %>
            </div>
        </div>
    </div>
</body>
</html>