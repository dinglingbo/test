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
<title>车架号查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/vinMain.js" type="text/javascript"></script>    
</head>
<body>

	<%
        String system_api_domain = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
    %>
    全部品牌 >
	<div id="brand" class="mini-autocomplete" style="width:250px;"  popupWidth="400" textField="vin" valueField="vin" 
	    url="<%=sysDomain%>/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext" 
        onvaluechanged="setSearchBox" 
        dataField="data"
        searchField="vin">     
	    <div property="columns">
	        <div header="vin" field="vin" width="50"></div>
	        <div header="品牌" field="brandname"></div>
	    </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	//searchVins();
    </script>
</body>
</html>