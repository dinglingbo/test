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
    <script src="<%=sysDomain%>/llq/vin/js/vinQuery.js?v=1.0" type="text/javascript"></script>    
</head>
<body>
    <%
        String system_api_domain = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
    %>
    <center>
        <br/>
        全部品牌 >
        <div id="vin" 
            class="nui-autocomplete" 
            style="width:350px;"
            popupWidth="400" 
            textField="vin" 
            valueField="vin" 
            url="<%=sysDomain%>/com.hsweb.system.llq.vin.vin.searchHistory.biz.ext" 
            onvaluechanged="" 
            dataField="data"
            searchField="vin"
            enterQuery="true">     
            <div property="columns">
                <div header="vin" field="vin" width="50"></div>
                <div header="品牌" field="brandname"></div>
            </div>
        </div>
        <a class="nui-button" onclick="queryVin();">查&nbsp;&nbsp;询</a>
        <br/><br/>
    </center>
    
    
    <div class="nui-fit">
        <div class="nui-splitter" style="width:100%; height:100%;" id="panel">
            <div size="40%" showCollapseButton="false">
                <div class="nui-fit">
                    <div id="gridMain" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true">
                        <div property="columns">
                            <div type="indexcolumn" width="20" headerAlign="center">序号</div>
                            <div field="auth" width="80" visible="false" allowSort="false"></div>
                            <div field="name" width="80" headerAlign="center" allowSort="false">主组名称</div>                  
                        </div>
                    </div>
                </div>
            </div>
            <div size="60%" showCollapseButton="false">
                <div class="nui-fit">            
                    <div id="gridSub" 
                        class="nui-datagrid" 
                        style="width:100%;height:100%;"
                        showColumns="true"
                        showPager="false"
                        allowcellwrap="true">
                        <div property="columns">                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>