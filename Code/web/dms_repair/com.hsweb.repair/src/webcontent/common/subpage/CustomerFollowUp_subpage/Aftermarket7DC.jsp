<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 15:39:08
  - Description:
-->
<head>
<title>售后7DC回访</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;height: 100%;width: 100%">
	<div class="nui-fit">
		<div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
		    <div property="columns">
		    	<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
		    	<div header="客户信息" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="90px" headerAlign="center" allowSort="true">客户名称</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">维修顾问</div>
		    			<div field="" width="60px" headerAlign="center" allowSort="true">车牌号</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">品牌</div>
		    			<div field="" width="80px" headerAlign="center" allowSort="true">车型</div>
		    			<div field="" width="110px" headerAlign="center" allowSort="true">底盘号</div>
		    			<div field="" width="110px" headerAlign="center" allowSort="true">工单号</div>
		    		</div>
		    	</div>
		    	<div header="S1.是否亲自到店进行维修/保养" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="80px" headerAlign="center" allowSort="true">是/否</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="S3.车型、车牌号是否匹配" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="150px" headerAlign="center" allowSort="true">相符/不相符</div>
		    		</div>
		    	</div>
		    	<div header="经销店灵活安排您希望的保养/维修时间" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="服务顾问礼貌待客" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">建议</div>
		    		</div>
		    	</div>
		    	<div header="服务顾问详细解释保养/维修内容和收费情况" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="150px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="接车过程及时/高效程度" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="交车过程及时/高效程度" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="保养维修后的车干净且车况良好程度" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="意见和建议" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="100px" headerAlign="center" allowSort="true">评分</div>
		    			<div field="" width="120px" headerAlign="center" allowSort="true">描述</div>
		    		</div>
		    	</div>
		    	<div header="备注" headerAlign="center">
		    		<div property="columns">
		    			<div field="" width="150px" headerAlign="center" allowSort="true">备注</div>
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