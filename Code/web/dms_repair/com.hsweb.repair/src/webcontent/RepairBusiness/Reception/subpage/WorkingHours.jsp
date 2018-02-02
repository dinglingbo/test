<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 15:41:15
  - Description:
-->
<head>
<title>标准工时</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-fit" >
		<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
		      pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPage="false" 
			  showPageSize="false" showReloadButton="false" showPagerButtonIcon="false"
			  allowSortColumn="true" showFooter="false" frozenStartColumn="0" frozenEndColumn="2">
			<div property="columns">
				<div type="indexcolumn" width="35px">序号</div>
				<div header="项目基本信息" headerAlign="center" >
					<div property="columns" >
						<div field="" width="70px" headerAlign="center" allowSort="true">
							工时编码
						</div>
						<div field="" width="180px" headerAlign="center" allowSort="true">
							项目名称
						</div>
					</div>
				</div>
				<div header="标准工时" headerAlign="center">
					<div property="columns">
						<div field="" width="100px" headerAlign="center" allowSort="true">
							时间（h）/（副）
						</div>
					</div>
				</div>
				<div header="工时费" headerAlign="center">
					<div property="columns">
						<div field="" width="60px" headerAlign="center" allowSort="true">
							工时金额
						</div>
						<div field="" width="60px" headerAlign="center" allowSort="true">
							市场金额
						</div>
					</div>
				</div>
				<div header="" headerAlign="center">
					<div property="columns">
						<div field="" width="40px" headerAlign="center" allowSort="true">
							工种
						</div>
						<div field="" width="120px" headerAlign="center" allowSort="true">
							车型
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
							项目类型
						</div>
						<div field="" width="150px" headerAlign="center" allowSort="true">
							参考名称
						</div>
						<div field="" width="70px" headerAlign="center" allowSort="true">
							使用频率
						</div>
					</div>
				</div>
			</div>	  
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>