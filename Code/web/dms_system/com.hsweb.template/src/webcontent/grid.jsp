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
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.1" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/vinQuery.js?v=1.3" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel">
            <div size="40%" showCollapseButton="false">
                <div class="nui-fit">
                    <div id="gridMain" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true">
                        <div property="columns">
                            <div type="indexcolumn"></div>
                            <div field="name" width="80" headerAlign="center" allowSort="false"></div>                  
                        </div>
                    </div>
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <div id="gridSub" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="false"
                        showPager="false"
                        allowcellwrap="true">
                        <div property="columns">
                            <div type="indexcolumn"></div>                
                            <div field="field1" width="80" headerAlign="center" allowSort="true"></div>    
                            <div field="field2" width="150" headerAlign="center" allowSort="true"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
	<script type="text/javascript">
    	nui.parse();
        var panel = nui.get("panel");
    </script>
</body>
</html>