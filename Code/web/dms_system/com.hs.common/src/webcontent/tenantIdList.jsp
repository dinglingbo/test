<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-18 09:52:30
  - Description:
-->
<head>
<title>租户列表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@ include file="/common/sysCommon.jsp"%>
     <script src="<%=webPath + contextPath%>/common/js/tenantIdList.js?v=1.0.7" type="text/javascript"></script> 
    
</head>
<body>
	    <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
	        <table style="width:100%;">
	            <tr>
	                <td style="width:100%;">
	                    <a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
	                    <a class="nui-button" onclick="Oncancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
	                </td>
	            </tr>
	        </table>
	    </div>
	<div class="nui-fit">
		<div id="datagrid1" 
			dataField="rs" 
			class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url=""
			showModified="false" onrowdblclick="edit()"
			pageSize="500" showPageInfo="true" multiSelect="true"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count"  
			allowSortColumn="true">

			<div property="columns">			
				<div type="checkcolumn" width="20"></div>
				<div id="tenantName" field="tenantName" headerAlign="center" allowSort="true" visible="true" width="60px">租户名称</div>
				<div id="tenantId" field="tenantId" headerAlign="center" allowSort="true" visible="true" width="60px">tenantId</div>
				<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="100px" dateFormat="yyyy-MM-dd HH:mm">建档日期</div>							
		
				
			</div>
		</div>
	</div>


	<script type="text/javascript">

    </script>
</body>
</html>