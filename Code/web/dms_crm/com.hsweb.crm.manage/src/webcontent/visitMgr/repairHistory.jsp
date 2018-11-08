<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-25 15:22:42
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
</style> 
</head>
<body>


        <div id="mainGrid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="50"
            totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick="" allowCellSelect="true" url="">
            <div property="columns">
                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
	                <div field="guestFullName" name="guestFullName" width="55" headerAlign="center" header="客户姓名"></div>
	                <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div>
	                <div field="contactName" name="contactName" width="65" headerAlign="center" header="送修人姓名"></div>
                  	<div field="contactMobile" name="contactMobile" width="80" headerAlign="center" header="送修人手机"></div>
                  	<div field="mtAdvisor" name="mtAdvisor" width="70" headerAlign="center" header="服务顾问"></div>
	                <div field="serviceCode" name="serviceCode" width="120" headerAlign="center" header="工单号"></div>
                    <div field="recordDate" name="recordDate" width="110" headerAlign="center" header="开单日期" dateFormat="yyyy-MM-dd hh:MM"></div>
                    <div field="balaAmt" name="balaAmt" width="60" headerAlign="center" header="金额"></div>
                    
            </div>
        </div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>