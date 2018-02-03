<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 15:23:28
  - Description:
-->
<head>
<title>标准套餐</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-fit" >
		<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
		      multiSelect="true" sshowReloadButton="false" showPager="false" allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div header="基本信息" headerAlign="center">
					<div property="columns" >
						<div field="" width="180px" headerAlign="center" allowSort="true">
							套餐名称
						</div>
					</div>
				</div>
				<div header="价格信息" headerAlign="center">
					<div property="columns">
						<div field="" width="100px" headerAlign="center" allowSort="true">
							套餐金额
						</div>
						<div field="" width="100px" headerAlign="center" allowSort="true">
							市场金额
						</div>
					</div>
				</div>
				<div header="其他信息" headerAlign="center">
					<div property="columns">
						<div field="" width="50px" headerAlign="center" allowSort="true">
							品牌
						</div>
						<div field="" width="50px" headerAlign="center" allowSort="true">
							车系
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
							车型等级
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
							车型
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
							技术工艺
						</div>
						<div field="" width="150px" headerAlign="center" allowSort="true">
							备注
						</div>
						<div field="" width="60px" headerAlign="center" allowSort="true">
							类型
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
							套餐编码
						</div>
						<div field="" width="60px" headerAlign="center" allowSort="true">
							幅数
						</div>
						<div field="" width="80px" headerAlign="center" allowSort="true">
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