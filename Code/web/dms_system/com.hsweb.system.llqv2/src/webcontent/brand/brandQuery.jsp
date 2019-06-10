<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-02-18 23:25:58
  - Description:
-->
    <style>
        .search-result-list-item-content-img{
            width: 180px;
            height: 108px;
            border: 1px solid #d8d8d8;
            margin-right: 10px;
        }
        .search-result-list-item-title-color{
            color: #f35a12;
        }

        body .mini-grid-row-selected{
            background:#89c3d6 !important; 
        }
    </style>
<head>
<title>车型查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon2.jsp" %>
    <link href="<%=contextPath%>/llqv2/brand/css/cloud.css?v=1.3" rel="stylesheet" type="text/css" />
    <script src="<%=contextPath%>/llqv2/common/llqCommon.js?v=1.4" type="text/javascript"></script>
    <script src="<%=contextPath%>/llqv2/brand/js/brandQuery.js?v=1.08" type="text/javascript"></script>
    <script src="<%=contextPath%>/llqv2/brand/js/brandInfos.js?v=1.02" type="text/javascript"></script>
</head>
<body>
    <div class="nui-fit"> 
        <div id="tabs" class="mini-tabs" activeIndex="0" style="width:100%;height:100%;" plain="false">
            <!--型号-->
            <div title="型号" name="brand" visible="true" headerStyle="display:none;">    
                <%@include file="/llqv2/brand/brandLevel.jsp" %>
            </div>
            <!--主组-->
            <div title="主组" name="group" visible="true" headerStyle="display:none;">    
                <%@include file="/llqv2/brand/brandInfos.jsp" %>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
	var initBrand = "<b:write property="brand"/>";
	nui.parse();
</script>
</html>