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
<title>查看保养提醒</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="/default/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%= request.getContextPath() %>/manage/js/maintainRemMain/checkMtRemind.js?v=1.1" type="text/javascript"></script> 
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

		<input id="visitMode" style="display :none;" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
		
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
            <div property="columns">
            		<div type="indexcolumn" width="30">序号</div>
                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
	                <!-- <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
	                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div> -->
                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
	                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
                    
            </div>
        </div>



	<script type="text/javascript">
    	nui.parse();
    	
    </script>
</body>
</html>