<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div id="gridSubGroup" 
    class="nui-datagrid" 
    style="width:100%;height:100%;display:none;"
    showColumns="true"
    showPager="false"
    allowcellwrap="true"
    showSummaryRow="true">
    <div property="columns"> 
        <div field="auth" width="80" visible="false" allowSort="false"></div>
        <div type="indexcolumn" width="20" summaryType="count">序号</div>
        <div field="num" width="30" headerAlign="center" allowSort=false>主组</div>
        <div field="subgroup" width="30" headerAlign="center" allowSort=false>分组</div>
        <div field="mid" width="60" headerAlign="center" allowSort=false>图号</div>
        <div field="subgroupname" width="150" headerAlign="center" allowSort=false>名称</div>
        <div field="description" width="150" headerAlign="center" allowSort=false>备注</div>
        <div field="model" width="100" headerAlign="center" allowSort=false>型号</div>                      
    </div>
</div>