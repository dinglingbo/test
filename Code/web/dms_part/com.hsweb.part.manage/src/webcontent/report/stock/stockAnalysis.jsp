<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<script type="text/javascript" src="<%=webPath + contextPath%>/common/nui/echarts.min.js"></script>
<html>

<head>
<title>库存分析</title>
<script src="<%=webPath + contextPath%>/report/js/stock/stockAnalysis.js?v=1.0.0"></script>
</head>

<body>
  
  
    <div class="nui-fit">
        <div id="mainQty" style="float:left;height:50%;width:50%;" title="库存数量"></div>
        <div id = "mainAmt" style="float:left;height:50%;width:50%;" title="库存金额"></div>
    </div>

  
</body>
</html>