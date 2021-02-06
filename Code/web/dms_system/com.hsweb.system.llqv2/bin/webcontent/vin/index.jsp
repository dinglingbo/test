<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-03-23 16:12:23
  - Description:
-->
<head>
<title>车架号查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon2.jsp" %>
    <link rel="stylesheet" href="./css/index.css">
    <script data-main="./js/main.js" src="https://cdn.bootcss.com/require.js/2.1.5/require.js"></script>
  </head>
<body>
    
    <div class="header j_serach">
      <div class="header-main">
        <form class="form-serach text-center j_serach-form" autocomplete="off">
          <label class="" for="exampleInputAmount">车架号搜索：</label>
          <div class="header-serach-input">
            <input type="text" class="form-control j_serach-input" id="exampleInputAmount" placeholder="Amount">
            <ul class="form-search-info j_search-info" style="display:none"></ul>
          </div>
          <button type="submit" class="j_search-btn btn btn-primary">查询</button>
        </form>
      </div>
    </div>
    <div id="container"></div>
</body>
</html>