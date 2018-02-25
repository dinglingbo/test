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
    <div class="nui-fit">
        <div id="gridMain" 
            class="nui-datagrid" 
            style="width:700px;height:250px;"
            url="">
            <div property="columns">
                <div type="indexcolumn"></div>                
                <div field="loginname" width="120" headerAlign="center" allowSort="true">员工帐号</div>    
                <div field="name" width="120" headerAlign="center" allowSort="true">姓名</div>    
                <div header="工作信息">
                    <div property="columns">
                        <div field="dept_name" width="120">所属部门</div>
                        <div field="position_name" width="100">职位</div>
                        <div field="salary" width="100" allowSort="true">薪资</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<script type="text/javascript">
    	nui.parse();
    	//searchVins();
    </script>
</body>
</html>