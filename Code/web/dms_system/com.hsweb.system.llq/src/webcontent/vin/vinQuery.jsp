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
    
    <script src="<%=sysDomain%>/llq/common/llqCommon.js?v=1.0" type="text/javascript"></script>
    <script src="<%=sysDomain%>/llq/vin/js/vinQuery.js?v=1.2" type="text/javascript"></script>    
</head>
<body>
    <div class="nui-fit">
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
        
        
        <div class="nui-fit" id="gridContent" style="display:none;">
            <table style="width:100%;height:100%" border=0>
                <tr>
                    <td style="width:40%;">
                        <div class="nui-fit">
                        <div id="gridMain" 
                            class="nui-datagrid" 
                            style="width:100%;height:100%;"
                            showColumns="false"
                            showPager="false">
                            <div property="columns">
                                <div type="name"></div>                    
                            </div>
                        </div>
                        </div>
                    </td>
                    <td>
                        <div id="gridSub" 
                            class="nui-datagrid" 
                            style="width:100%;height:100%;"
                            showColumns="false"
                            showPager="false">
                            <div property="columns">
                                <div type="indexcolumn"></div>                
                                <div field="field1" width="80" headerAlign="center" allowSort="true"></div>    
                                <div field="field2" width="150" headerAlign="center" allowSort="true"></div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
	<script type="text/javascript">
    	nui.parse();
    	//searchVins();
    </script>
</body>
</html>