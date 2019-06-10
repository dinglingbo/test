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
    
    <script src="<%=contextPath%>/epc/common/llqCommon.js?v=1.0.2" type="text/javascript"></script>
    <script src="<%=contextPath%>/epc/vin/js/partDetail.js?v=1.24" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit">
        <%--<h1 style="color:black" align="center">零件详情</h1> --%>
	   
        <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
		     onactivechanged="changeTabs" >
            <!--基础信息-->
            <%@include file="/epc/vin/partDetail_basic.jsp" %>
            <!--渠道价格-->
            <%@include file="/epc/vin/partDetail_price.jsp" %>
            <!--替换件-->
            <%@include file="/epc/vin/PartDetail_replace_2.jsp" %>
            <!--品牌件-->
            <%@include file="/epc/vin/partDetail_article.jsp" %>
            <!--组件-->
            <%@include file="/epc/vin/partDetail_compt.jsp" %>
            <!--技术信息-->
            <%@include file="/epc/vin/partDetail_baseinfo.jsp" %>
            <!--适用车型-->
            <%@include file="/epc/vin/partDetail_compatible.jsp" %>
            <!--库存分布-->
            <%@include file="/epc/vin/partChainStock.jsp" %>
        </div>
    </div>
</body>
</html>
<script>
    var pid = '<b:write property="pid"/>';
    var brand = '<b:write property="brand"/>';
</script>